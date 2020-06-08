#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=create_lnk.exe
#AutoIt3Wrapper_Icon=create_lnk.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=create_lnk.exe
#AutoIt3Wrapper_Res_Fileversion=0.2.0.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Field=Version|0.2
#AutoIt3Wrapper_Res_Field=Build|2012.02.14
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=CompanyName|AZJIO_Soft
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 2012.02.14 3.3.6.1

#NoTrayIcon
#include <File.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <ComboConstants.au3>
#include <FileOperations.au3> ; http://www.autoitscript.com/forum/topic/133224-filesearch-foldersearch/page__fromsearch__1
#include <Array.au3>

Global $aRecords

If $CmdLine[0] Then
	Global $spr = Chr(1) ; ����������� ����������
	$ParamLine = $spr & _ArrayToString($CmdLine, $spr, 1) & $spr
	
	; /f"Path" - ���� � ����� ����
	$aTmp = StringRegExp($ParamLine, '(?i)' & $spr & '[\\/\-]?f(.+?)' & $spr, 3)
	If Not @error And UBound($aTmp) = 1 Then
		$base_backup2 = $aTmp[0]
	Else
		$base_backup2 = @ScriptDir & '\base_lnk.txt'
	EndIf
	
	; /p"Path" - ���� � ����� �������
	$aTmp = StringRegExp($ParamLine, '(?i)' & $spr & '[\\/\-]?p(.+?)' & $spr, 3)
	If Not @error And UBound($aTmp) = 1 Then
		$restore_lnk2 = $aTmp[0]
	Else
		$restore_lnk2 = Default
	EndIf
	_RestoreLNK($base_backup2, $restore_lnk2)
	Exit
EndIf

; En
$LngTitle = 'Creating shortcuts'
$LngFrc = 'icon compulsorily'
$LngFrcH = 'Eliminates the problems with the use of variables in path'
$LngNLk = 'Name shortcut:'
$LngNLkH = 'Name without expansion'
$LngCrL = 'Create a shortcut here:'
$LngCrLH = 'You can specify a direct path to a folder'
$LngWF = 'Working folder:'
$LngWFH = 'The folder which becomes current for the starting program'
$LngFPh = 'Full path to the file: *'
$LngFPhH = 'Path to the file run (Object)'
$LngArg = 'Startup options:'
$LngArgH = 'Argument, key'
$LngDsc = 'Description:'
$LngDscH = 'A detailed description of the program to future ToolTip'
$LngICO = 'Icon shortcut:'
$LngICOH = 'If it is not specified, by default the first icon of the starting file.'
$LngNico = 'Number of icons:'
$LngNicoH = 'Specified for the dll, the default is the first (counting from zero)'
$LngDrgH = 'Drag a file or folder here'
$LngOpL = 'Open'
$LngOpLH = 'Open shortcut to read its data and autocomplete fields'
$LngAdL = 'Add'
$LngAdLH = 'Add a shortcut to the file backup base_lnk.txt'
$LngCLk = 'Create'
$LngCLkH = 'Create shortcut'
$LngGrp1 = 'Creating a backup shortcut (text file)'
$LngL1 = 'Move to the field folder or selected group of shortcut'
$LngL2 = 'Backup path to a text file, by default base_lnk.txt in the script folder'
$LngL2H = 'Move into this field a text file is created automatically'
$LngSv = 'Save'
$LngSvH = 'Save the shortcut in the backup.'
$LngGrp2 = 'Restore from backup shortcut'
$LngL3 = 'The path to a text file, by default base_lnk.txt in the current folder'
$LngL3H = 'Move into this field backup file.'
$LngL4 = 'Path to folder where shortcuts will be created, otherwise path of backup file'
$LngL4H = 'Move to the field folder where you want to create shortcuts.'
$LngCrB = 'Create'
$LngCrBH = 'Creating shortcuts. In the presence of base_lnk.txt in folder fields are not mandatory.'
$LngNOb = 'Create shortcuts to missing objects'
$LngHLP = @TAB & _
		"���������� ���������" & @CRLF & @CRLF & _
		'1. ������� ������ �������.' & @CRLF & _
		'2. ����������� ������� �������������.' & @CRLF & _
		'3. �������� ������� ��� LiveCD ��� ���������� ������� ������.' & @CRLF & @CRLF & @TAB & _
		'�������������� �����������' & @CRLF & @CRLF & _
		'1. �������������� �������� ������� (��������) �� �����-����� ��� �������� LiveCD.' & @CRLF & _
		'2. ���������� ������ (����) � �����-�����.'
$LngFOD1 = 'Select File'
$LngFOD2 = 'All files'
$LngErr = 'Error'
$LngMB1 = 'Minimum settings - is the full path to launch'
$LngMB2 = 'It is not possible to open a file.'
$LngMB4 = 'Error of reading base of shortcuts'
$LngFW = 'The relative path and name shortcut|Object|Working folder|Argument|Description|path to the icon|Number of icons'
$LngC1 = 'Current'
$LngC2 = 'Quick Launch'
$LngC3 = 'Desktop'
$LngC4 = 'SendTo'
$LngC5 = 'Start Menu'
; $LngFN1='Desktop'
; $LngFN2='Start Menu\Programs'
$LngFN4 = 'SendTo'

; Ru
; ���� ������� �����������, �� ������� ����
If @OSLang = 0419 Then
	$LngTitle = '�������� �������'
	$LngFrc = '������ �������������'
	$LngFrcH = "��������� �� ������� ��� �������������" & @CRLF & "���������� � ����� ������"
	$LngNLk = '��� ������:'
	$LngNLkH = '��� ������ ��� ����������'
	$LngCrL = '������� ����� � �����:'
	$LngCrLH = '����� ������� ������ ����'
	$LngWF = '������� �����:'
	$LngWFH = '�����, ������� ���������� �������' & @CRLF & '��� ���������� ���������'
	$LngFPh = '������ ���� � �����: *'
	$LngFPhH = '���� � ����� ������� (������)'
	$LngArg = '��������� �������:'
	$LngArgH = '��������, ����'
	$LngDsc = '�����������:'
	$LngDscH = '��������� �������� � ���������' & @CRLF & '������� ����������� ���������'
	$LngICO = '������ ������:'
	$LngICOH = '���� �� �������, �� �� ���������' & @CRLF & '������ ������ ���������� �����.'
	$LngNico = '����� ������:'
	$LngNicoH = '����������� ��� dll, �� ���������' & @CRLF & '������������ ������ (������ � ����)'
	$LngDrgH = '�������� ���� ���� ��� �����'
	$LngOpL = '�������'
	$LngOpLH = '������� ����� ��� ������ ��� ������' & @CRLF & '� �������������� �����'
	$LngAdL = '��������'
	$LngAdLH = '�������� ����� � ���� ������ base_lnk.txt'
	$LngCLk = '�������'
	$LngCLkH = '������� �����'
	$LngGrp1 = '�������� ������ ������� (��������� ����)'
	$LngL1 = '��������� � ��� ���� ����� ��� ���������� ������ �������'
	$LngL2 = '���� � ���������� �����-�����, �� ��������� base_lnk.txt � ����� �������'
	$LngL2H = '��������� � ��� ���� ��������� ����' & @CRLF & '�������� �������������'
	$LngSv = '���������'
	$LngSvH = '��������� ������ � �����.'
	$LngGrp2 = '�������������� ������� �� ������'
	$LngL3 = '���� � ���������� �����, �� ��������� base_lnk.txt � ������� �����'
	$LngL3H = '��������� � ��� ���� �����-����.'
	$LngL4 = '���� � �����, � ������� ����� ������� ������, ����� ���� �� �����-�����'
	$LngL4H = '��������� � ��� ���� �����,' & @CRLF & '� ������� ����� ������� ������.'
	$LngCrB = '�������'
	$LngCrBH = '�������� �������. ��� �������' & @CRLF & 'base_lnk.txt � ����� �������' & @CRLF & '���� ��������� �� �����������.'
	$LngNOb = 'C�������� ������ ��� ������������� ��������'
	$LngHLP = @TAB & _
			"���������� ���������" & @CRLF & @CRLF & _
			'1. ������� ������ �������.' & @CRLF & _
			'2. ����������� ������� �������������.' & @CRLF & _
			'3. �������� ������� ��� LiveCD ��� ���������� ������� ������.' & @CRLF & @CRLF & @TAB & _
			'�������������� �����������' & @CRLF & @CRLF & _
			'1. �������������� �������� ������� (��������) �� �����-����� ��� �������� LiveCD.' & @CRLF & _
			'2. ���������� ������ (����) � �����-�����.'
	$LngFOD1 = '����� �����'
	$LngFOD2 = '��� �����'
	$LngErr = '������'
	$LngMB1 = '������� ���������� - ��� ������ ���� � ����� �������'
	$LngMB2 = '�� �������� ������� ����.'
	$LngMB4 = '������ ������ ���� �������'
	$LngFW = '���� �� �������� ����� � ��� ������|������|������� �����|��������|�����������|���� � ����� � �������|����� ������'
	$LngC1 = '�������'
	$LngC2 = '������� ������'
	$LngC3 = '������� ����'
	$LngC4 = 'SendTo'
	$LngC5 = '������� ����'
	; $LngFN1='������� ����'
	; $LngFN2='������� ����\���������'
	$LngFN4 = 'SendTo'
	; $Lng=''
EndIf

; ������ �������� ����, �������, ������.
$hGui = GUICreate($LngTitle, 468, 318, -1, -1, -1, $WS_EX_ACCEPTFILES) ; ������ ����
If Not @Compiled Then GUISetIcon(@ScriptDir & '\create_lnk.ico')

$tab = GUICtrlCreateTab(2, 5, 464, 312) ; ������ �������
GUICtrlCreateLabel("����������� drag-and-drop", 170, 5, 140, 18)
$icocheck1 = GUICtrlCreateCheckbox($LngFrc, 320, 5, 140, 18)
GUICtrlSetTip(-1, $LngFrcH)

$tab1 = GUICtrlCreateTabItem("LNK") ; ��� �������
$CatchDrop = GUICtrlCreateLabel("", 1, 1, 460, 310)
GUICtrlSetState(-1, $GUI_DISABLE + $GUI_DROPACCEPTED)

GUICtrlCreateLabel($LngNLk, 20, 38, 125, 22)
GUICtrlSetTip(-1, $LngNLkH)
$NME = GUICtrlCreateInput('', 150, 38, 295, 20)

GUICtrlCreateLabel($LngCrL, 20, 71, 125, 22)
GUICtrlSetTip(-1, $LngCrLH)
$DIR = GUICtrlCreateCombo('', 150, 67, 295, 23, $CBS_DROPDOWNLIST)
GUICtrlSetData(-1, $LngC1 & '|' & $LngC2 & '|' & $LngC3 & '|' & $LngC4 & '|' & $LngC5, $LngC1)

GUICtrlCreateLabel($LngWF, 20, 100, 125, 22)
GUICtrlSetTip(-1, $LngWFH)
$WRK = GUICtrlCreateInput('', 150, 100, 295, 20)

GUICtrlCreateLabel($LngFPh, 20, 130, 125, 22)
GUICtrlSetTip(-1, $LngFPhH)
$EXE = GUICtrlCreateInput('', 150, 130, 295, 20)
GUICtrlSetState(-1, 8)

GUICtrlCreateLabel($LngArg, 20, 160, 125, 22)
GUICtrlSetTip(-1, $LngArgH)
$ARG = GUICtrlCreateInput('', 150, 160, 295, 20)

GUICtrlCreateLabel($LngDsc, 20, 190, 125, 22)
GUICtrlSetTip(-1, $LngDscH)
$DSC = GUICtrlCreateInput('', 150, 190, 295, 20)

GUICtrlCreateLabel($LngICO, 20, 220, 125, 22)
GUICtrlSetTip(-1, $LngICOH)
$ICO = GUICtrlCreateInput('', 150, 220, 295, 20)

GUICtrlCreateLabel($LngNico, 20, 250, 125, 22)
GUICtrlSetTip(-1, $LngNicoH)
$NMR = GUICtrlCreateInput('', 150, 250, 295, 20)

GUICtrlCreateLabel($LngDrgH, 20, 283, 185, 22)
GUICtrlSetColor(-1, 0xff0000) ; Red

$read_lnk = GUICtrlCreateButton($LngOpL, 220, 280, 70, 22)
GUICtrlSetTip(-1, $LngOpLH)
$addbase_lnk = GUICtrlCreateButton($LngAdL, 300, 280, 70, 22)
GUICtrlSetTip(-1, $LngAdLH)
$create_lnk = GUICtrlCreateButton($LngCLk, 380, 280, 70, 22)
GUICtrlSetTip(-1, $LngCLkH)

$tab2 = GUICtrlCreateTabItem("AUTO") ; ��� �������
;GUICtrlSetState(-1,16)

GUICtrlCreateGroup($LngGrp1, 11, 35, 440, 120)

GUICtrlCreateLabel($LngL1, 20, 55, 425, 22)
$lnk_group = GUICtrlCreateInput('', 20, 75, 335, 20)
GUICtrlSetState(-1, 8)

GUICtrlCreateLabel($LngL2, 20, 105, 425, 22)
$save_group1 = GUICtrlCreateInput('', 20, 125, 335, 20)
GUICtrlSetState(-1, 8)
GUICtrlSetTip(-1, $LngL2H)
$save_group = GUICtrlCreateButton($LngSv, 370, 125, 70, 22)
GUICtrlSetTip(-1, $LngSvH)

GUICtrlCreateGroup($LngGrp2, 11, 160, 440, 140)

GUICtrlCreateLabel($LngL3, 20, 180, 425, 22)
$base_backup1 = GUICtrlCreateInput('', 20, 200, 335, 20)
GUICtrlSetState(-1, 8)
GUICtrlSetTip(-1, $LngL3H)

GUICtrlCreateLabel($LngL4, 20, 230, 430, 22)
$restore_lnk = GUICtrlCreateInput('', 20, 250, 335, 20)
GUICtrlSetState(-1, 8)
GUICtrlSetTip(-1, $LngL4H)
$restore_lnk1 = GUICtrlCreateButton($LngCrB, 370, 250, 70, 22)
GUICtrlSetTip(-1, $LngCrBH)

$CheckExists = GUICtrlCreateCheckbox($LngNOb, 40, 275, 280, 22)
; GUICtrlSetState(-1, 1)

$tab2 = GUICtrlCreateTabItem("     ?") ; ��� �������
GUICtrlCreateLabel($LngHLP, 15, 45, 447, 150)
; GUICtrlSetBkColor(-1, 0xffd7d7)
GUICtrlCreateLabel("AZJIO 2010-2012", 190, 290, 110, 32)

GUICtrlCreateTabItem("") ; ����� �������

GUISetState()

While 1
	Switch GUIGetMsg()

		; ������� drag-and-drop
		Case $GUI_EVENT_DROPPED
			Switch GUICtrlRead($tab)
				Case 0
					_FillData(@GUI_DragFile)
				Case 1
					Switch @GUI_DropId
						Case $save_group1, $base_backup1
							If _IsDir(GUICtrlRead(@GUI_DropId)) Then
								GUICtrlSetData(@GUI_DropId, '')
								ContinueLoop
							EndIf
						Case $restore_lnk
							If Not _IsDir(GUICtrlRead(@GUI_DropId)) Then
								GUICtrlSetData($restore_lnk, '')
								ContinueLoop
							EndIf
						Case $lnk_group
							$tmp = GUICtrlRead($lnk_group)
							If Not(StringInStr($tmp, '|') Or _IsDir($tmp)) Then
								GUICtrlSetData($lnk_group, '')
								ContinueLoop
							EndIf
					EndSwitch
			EndSwitch
			

			; ������ "�������"
		Case $read_lnk
			$Tmp = FileOpenDialog($LngFOD1, _ComboReadDIR(), $LngFOD2 & " (*.*)", 1 + 4, '', $hGui)
			If @error Then ContinueLoop
			_FillData($Tmp)

			; ������ "�������"
		Case $create_lnk
			$EXE1 = GUICtrlRead($EXE)
			If StringInStr($EXE1, '\') Then
				$aPath = StringRegExp($EXE1, "(^.*)\\(.*)$", 3)
				$EXENAME = StringTrimRight($aPath[1], 4)
				; ������ ���������� �� ����� �����
				$NME1 = GUICtrlRead($NME)
				If $NME1 = '' Then $NME1 = $EXENAME
				$DIR1 = _ComboReadDIR()
				If StringMid($DIR1, 3, 1) = ':' Then $DIR1 = $DIR
				$WRK1 = GUICtrlRead($WRK)
				If $WRK1 = '' Then $WRK1 = $aPath[0]
				$ARG1 = GUICtrlRead($ARG)
				$DSC1 = GUICtrlRead($DSC)
				$ICO1 = GUICtrlRead($ICO)
				$NMR1 = GUICtrlRead($NMR)
				$LNK1 = $DIR1 & '\' & $NME1
				FileCreateShortcut($EXE1, $LNK1 & '.lnk', $WRK1, $ARG1, $DSC1, $ICO1, '', $NMR1)
			Else
				MsgBox(0, $LngErr, $LngMB1, 0, $hGui)
			EndIf

			; ������ "��������" - �������� ����� � �����-����
		Case $addbase_lnk
			$EXE1 = GUICtrlRead($EXE)
			If $EXE1 <> '' Then
				$aPath = StringRegExp($EXE1, "(^.*)\\(.*)$", 3)
				$EXENAME = StringTrimRight($aPath[1], 4)
				; ������ ���������� �� ����� �����
				$NME1 = GUICtrlRead($NME)
				If $NME1 = '' Then $NME1 = $EXENAME
				$DIR1 = _ComboReadDIR()
				If StringMid($DIR1, 3, 1) = ':' Then $DIR1 = $DIR
				$WRK1 = GUICtrlRead($WRK)
				If $WRK1 = '' Then $WRK1 = $aPath[0]
				$ARG1 = GUICtrlRead($ARG)
				$DSC1 = GUICtrlRead($DSC)
				$ICO1 = GUICtrlRead($ICO)
				$NMR1 = GUICtrlRead($NMR)
				$LNK1 = $DIR1 & '\' & $NME1
				$filebase = FileOpen(@ScriptDir & '\base_lnk.txt', 1)
				; �������� �������� ����� ��� ������ ������
				If $filebase = -1 Then
					MsgBox(0, $LngErr, $LngMB2, 0, $hGui)
					Exit
				EndIf
				If FileGetSize(@ScriptDir & '\base_lnk.txt') = 0 Then
					FileWrite($filebase, $DIR1 & '|||')
					FileWrite($filebase, @CRLF & '; ' & $LngFW)
				EndIf
				FileWrite($filebase, @CRLF & $NME1 & '|' & $EXE1 & '|' & $WRK1 & '|' & $ARG1 & '|' & $DSC1 & '|' & $ICO1 & '|' & $NMR1)
				FileClose($filebase)
			Else
				MsgBox(0, $LngErr, $LngMB1, 0, $hGui)
			EndIf

			; ������� auto
			; �������� ������
		Case $save_group
			$icocheck = GUICtrlRead($icocheck1)
			$lnk_group1 = GUICtrlRead($lnk_group) ; ������ ���� � �������
			$save_group2 = GUICtrlRead($save_group1) ; ������ ���� � ���������� �����
			;���� �� ������ ������� ���� ������, �� �� ��������� base_lnk.txt � ����� �������
			If Not FileExists($save_group2) Then $save_group2 = @ScriptDir & '\base_lnk.txt'

			;���������� ��� ������
			; ���� � ����� LNK ��� �������� ������ "|" �� �� �������� ������� "D" �� ���������� ��� ��������� ����� ��� ������ �������
			If StringRight($lnk_group1, 4) = ".lnk" Or StringInStr($lnk_group1, "|") And Not _IsDir($lnk_group1) Then

				$lnk_group1 = StringSplit($lnk_group1, "|")
				$aDirlnk = StringRegExpReplace($lnk_group1[1], "(^.*)\\.*$", '\1')
				$DirlnkLen = StringLen($aDirlnk) + 1 ; ���������� �������� � ����
				$LnkText = $aDirlnk & '|||' & @CRLF & '; ' & $LngFW
				$k=0
				For $i = 1 To $lnk_group1[0]
					If StringRight($lnk_group1[$i], 4) <> ".lnk" And Not _IsDir($lnk_group1) Then ContinueLoop
					$aLnk = FileGetShortcut($lnk_group1[$i])
					$NAME = StringTrimRight($lnk_group1[$i], 4)
					$NAME = StringTrimLeft($NAME, $DirlnkLen)
					If $icocheck = 1 And $aLnk[4] = '' Then ; �������������� ���������� ������, ���� �� ������� � ������ �������
						$aLnk[4] = $aLnk[0]
						$aLnk[5] = 0
					EndIf
					$LnkText &= @CRLF & $NAME & '|' & $aLnk[0] & '|' & $aLnk[1] & '|' & $aLnk[2] & '|' & $aLnk[3] & '|' & $aLnk[4] & '|' & $aLnk[5]
					$k+=1
				Next
				If $k Then
					$filebase = FileOpen($save_group2, 2)
					If $filebase = -1 Then
						MsgBox(0, $LngErr, $LngMB2, 0, $hGui)
						ContinueLoop
					EndIf
					FileWrite($filebase, $LnkText)
					FileClose($filebase)
				EndIf

				; ���� �������� ������� "D" �� ���������� ��� �������
			ElseIf _IsDir($lnk_group1) Then
				$LnkText = $lnk_group1 & '|||' & @CRLF & '; ' & $LngFW
				$FileList = _FO_FileSearch($lnk_group1, '*.lnk', True, 125, 0)
				If Not @error Then
					For $i = 1 To $FileList[0]
						$aLnk = FileGetShortcut($lnk_group1 & '\' & $FileList[$i])
						$NAME = StringTrimRight($FileList[$i], 4)
						If $icocheck = 1 And $aLnk[4] = '' Then ; �������������� ���������� ������, ���� �� ������� � ������ �������
							$aLnk[4] = $aLnk[0]
							$aLnk[5] = 0
						EndIf
						$LnkText &= @CRLF & $NAME & '|' & $aLnk[0] & '|' & $aLnk[1] & '|' & $aLnk[2] & '|' & $aLnk[3] & '|' & $aLnk[4] & '|' & $aLnk[5]
					Next

					$filebase = FileOpen($save_group2, 2)
					If $filebase = -1 Then
						MsgBox(0, $LngErr, $LngMB2, 0, $hGui)
						ContinueLoop
					EndIf
					FileWrite($filebase, $LnkText)
					FileClose($filebase)
				EndIf
			EndIf

			; �������������� �� ������
		Case $restore_lnk1
			$base_backup2 = GUICtrlRead($base_backup1) ;��������� ����
			$restore_lnk2 = GUICtrlRead($restore_lnk) ; ���� � ����� �������
			$CheckExists2 = GUICtrlRead($CheckExists) ; ���� � ����� �������
			If $CheckExists2 = 1 Then $CheckExists2 = 0
			If Not $base_backup2 Then $base_backup2 = @ScriptDir & '\base_lnk.txt'
			If Not $restore_lnk2 Then $restore_lnk2 = Default
			_RestoreLNK($base_backup2, $restore_lnk2, $CheckExists2)

		Case -3
			ExitLoop
	EndSwitch
WEnd

Func _RestoreLNK($base_backup2, $restore_lnk2, $Exists = 1)
	; ���� �� ������ �����-����, �� ������������ �� ��������� base_lnk.txt, (�������� ���� �� ���������)
	; ������ �����-���� � ������
	If Not _FileReadToArray($base_backup2, $aRecords) Then
		If $CmdLine[0] Then
			Exit 1
		Else
			MsgBox(0, $LngErr & " = " & @error, $LngMB4, 0, $hGui)
			Return
		EndIf
	EndIf
	; � ������� $aRecords ����� ����������� ��� ������ �����...
	; � ������ $aLnk �������� ������ ������� ��������� �� ������ ������
	If $restore_lnk2 = Default Then
		$aSet = StringSplit($aRecords[1], "|")
		$restore_lnk2 = $aSet[1] ; ���� �� ������ ����, ���������� ���� �� ������ � ������ ������
	EndIf
	For $i = 3 To $aRecords[0]
		; ������� �������� ������ �����, ���������� ���� ��� ������ ������
		If $aRecords[$i] Then
			$aLnk = StringSplit($aRecords[$i], "|")
			If $aLnk[0] > 6 Then
				; ��������, ���� ����� �������� "\", �� ��� ���� � ����� ������� �������
				$Tmp = StringInStr($aLnk[1], '\', 0, -1)
				If $Tmp Then
					$Dirlnk = StringLeft($aLnk[1], $Tmp - 1)
					If Not FileExists($restore_lnk2 & '\' & $Dirlnk) Then DirCreate($restore_lnk2 & '\' & $Dirlnk)
				EndIf
				If $Exists Then
					If FileExists($aLnk[2]) Then
						; �������� ������
						FileCreateShortcut($aLnk[2], $restore_lnk2 & '\' & $aLnk[1] & '.lnk', $aLnk[3], $aLnk[4], $aLnk[5], $aLnk[6], '', $aLnk[7])
					EndIf
				Else
					; �������� ������
					FileCreateShortcut($aLnk[2], $restore_lnk2 & '\' & $aLnk[1] & '.lnk', $aLnk[3], $aLnk[4], $aLnk[5], $aLnk[6], '', $aLnk[7])
				EndIf
			EndIf
		EndIf
	Next
EndFunc

Func _ComboReadDIR()
	Local $DIR1 = GUICtrlRead($DIR)
	Switch $DIR1
		Case $LngC1
			$DIR1 = @WorkingDir
		Case $LngC2
			$DIR1 = @AppDataDir & '\Microsoft\Internet Explorer\Quick Launch'
		Case $LngC3
			$DIR1 = @DesktopDir
		Case $LngC4
			$DIR1 = @UserProfileDir & '\' & $LngFN4
		Case $LngC5
			$DIR1 = @ProgramsDir
	EndSwitch
	Return $DIR1
EndFunc

Func _IsDir($sTmp)
	$sTmp = FileGetAttrib($sTmp)
	Return SetError(@error, 0, StringInStr($sTmp, 'D', 2) > 0)
EndFunc

;========================================
; ������� drag-and-drop ��� ������� � exe-������
Func _FillData($gaFiles)
	$icocheck = GUICtrlRead($icocheck1)
	; �������� ���������� ������
	Switch StringRight($gaFiles, 4)
		Case ".lnk"
			$aLnk = FileGetShortcut($gaFiles)
			$aPathLNK = StringRegExp($gaFiles, "(^.*)\\(.*)$", 3)
			$NAME = StringTrimRight($aPathLNK[1], 4)
			GUICtrlSetData($NME, $NAME)
			GUICtrlSetData($WRK, $aLnk[1])
			GUICtrlSetData($ARG, $aLnk[2])
			GUICtrlSetData($DSC, $aLnk[3])
			If $icocheck = 1 And $aLnk[4] = '' Then ; �������������� ���������� ������, ���� �� ������� � ������� �������
				GUICtrlSetData($ICO, $aLnk[0])
				GUICtrlSetData($NMR, '0')
			Else
				GUICtrlSetData($ICO, $aLnk[4])
				GUICtrlSetData($NMR, $aLnk[5])
			EndIf
			GUICtrlSetData($EXE, $aLnk[0])

			; �������� ���������� exe-������
		Case Else
			$aPathLNK = StringRegExp($gaFiles, "(^.*)\\(.*)$", 3)

			; ���� ���� (�� �����), �� �������� ���������� ����� � ����� ������
			$Tmp = StringInStr($aPathLNK[1], '.', 0, -1)
			If $Tmp And Not _IsDir($gaFiles) Then $aPathLNK[1] = StringTrimRight($aPathLNK[1], StringLen(StringTrimLeft($aPathLNK[1], $Tmp)) + 1)
			
			GUICtrlSetData($NME, $aPathLNK[1])
			GUICtrlSetData($WRK, $aPathLNK[0])
			GUICtrlSetData($EXE, $gaFiles)
			If $icocheck = 1 Then ; �������������� ���������� ������, ���� �� ������� � ������� �������
				GUICtrlSetData($ICO, $gaFiles)
				GUICtrlSetData($NMR, '0')
			Else ; ����� �����
				GUICtrlSetData($ICO, '')
				GUICtrlSetData($NMR, '')
			EndIf
			; ����� ����������, ���� ������������ �������������� �� ����������� ������
			GUICtrlSetData($ARG, '')
			GUICtrlSetData($DSC, '')
	EndSwitch
EndFunc