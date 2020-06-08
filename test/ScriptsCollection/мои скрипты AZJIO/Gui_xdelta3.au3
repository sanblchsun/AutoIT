#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=Gui_xdelta3.exe
#AutoIt3Wrapper_icon=Gui_xdelta3.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=Gui_xdelta3.exe
#AutoIt3Wrapper_Res_Fileversion=0.2.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#AutoIt3Wrapper_Res_Field=Version|0.2
#AutoIt3Wrapper_Res_Field=Build|2012.02.17
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#NoTrayIcon

#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <Constants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

If Not FileExists(@ScriptDir&'\xdelta3.exe') Then
	MsgBox(0, '������', '�� ������ ���� xdelta3.exe � ������� ��������.'&@CRLF&'��������� ��������� ������.')
	Exit
EndIf

$ini = @ScriptDir & '\Gui_xdelta3.ini'
$Trf=0

If Not FileExists($ini) And DriveStatus(StringLeft(@ScriptDir, 1)) <> 'NOTREADY' Then
	$file = FileOpen($ini, 2)
	FileWrite($file, '[Set]' & @CRLF & _
			'PathOld=' & @CRLF & _
			'PathNew=' & @CRLF & _
			'PathDelta=' & @CRLF & _
			'Title=' & @CRLF & _
			'icon=' & @CRLF & _
			'Comm_Patch=' & @CRLF & _
			'Comm_Create=' & @CRLF & _
			'Compressing=' & @CRLF & _
			'ButtonCreateHide=' & @CRLF & _
			'ButtonPatchHide=' & @CRLF & _
			'ComboCompressHide=')
	FileClose($file)
EndIf
$sPathOld = IniRead($ini, 'Set', 'PathOld', '')
If $sPathOld And Not StringInStr($sPathOld, ':') Then $sPathOld=@ScriptDir&'\'&$sPathOld
$sPathNew = IniRead($ini, 'Set', 'PathNew', '')
If $sPathNew And Not StringInStr($sPathNew, ':') Then $sPathNew=@ScriptDir&'\'&$sPathNew
$sPathDelta = IniRead($ini, 'Set', 'PathDelta', '')
If $sPathDelta And Not StringInStr($sPathDelta, ':') Then $sPathDelta=@ScriptDir&'\'&$sPathDelta
$sTitle = IniRead($ini, 'Set', 'Title', 'Gui ��� xdelta3.exe')
If Not $sTitle Then $sTitle='Gui ��� xdelta3.exe'
$sIcon = IniRead($ini, 'Set', 'icon', '')
$sComm_Patch = IniRead($ini, 'Set', 'Comm_Patch', '')
$sComm_Create = IniRead($ini, 'Set', 'Comm_Create', '')
If $sComm_Patch Then $sComm_Patch=' '&$sComm_Patch
If $sComm_Create Then $sComm_Create=' '&$sComm_Create
$Compressing = Number(IniRead($ini, 'Set', 'Compressing', ''))
$ButtonCreateHide = Number(IniRead($ini, 'Set', 'ButtonCreateHide', 0))
$ButtonPatchHide = Number(IniRead($ini, 'Set', 'ButtonPatchHide', 0))
$ComboCompressHide = Number(IniRead($ini, 'Set', 'ComboCompressHide', 0))

$Gui = GUICreate($sTitle,  436, 210, -1, -1, -1, $WS_EX_ACCEPTFILES)
If $sIcon Then
	$sIcon=StringRegExp($sIcon, '(^.+?)(?:,\s*(\d+))?$', 3)
	If FileExists(@ScriptDir&'\'&$sIcon[0]) Then $sIcon[0]=@ScriptDir&'\'&$sIcon[0]
	Switch UBound($sIcon)
		Case 1
			GUISetIcon($sIcon[0])
		Case 2
			GUISetIcon($sIcon[0], -Number($sIcon[1]))
	EndSwitch
EndIf

; $CatchDrop = GUICtrlCreateLabel("", 0, 0, 436, 40)
; GUICtrlSetState(-1, $GUI_DISABLE + $GUI_DROPACCEPTED)

$StatusBar=GUICtrlCreateLabel ("����������� drag-and-drop", 3,190,430,17)

$restart=GUICtrlCreateButton ("R", 436-20,4,18,18)

$Label1 = GUICtrlCreateLabel("���� � ������� �����", 5, 10, 186, 17)
$Input1 = GUICtrlCreateInput('', 5, 27, 405, 21)
GUICtrlSetData(-1, $sPathOld)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)
$folder1 = GUICtrlCreateButton("...", 410, 27, 21, 21, $BS_ICON)
GUICtrlSetImage(-1, @SystemDir & '\shell32.dll', 4, 0)

$Label2 = GUICtrlCreateLabel("���� � ������ �����", 5, 60, 186, 17)
$Input2 = GUICtrlCreateInput('', 5, 77, 405, 21)
GUICtrlSetData(-1, $sPathNew)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)
$folder2 = GUICtrlCreateButton("...", 410, 77, 21, 21, $BS_ICON)
GUICtrlSetImage(-1, @SystemDir & '\shell32.dll', 4, 0)

$Label3 = GUICtrlCreateLabel("���� � ����-�����", 5, 110, 186, 17)
$Input3 = GUICtrlCreateInput('', 5, 127, 405, 21)
GUICtrlSetData(-1, $sPathDelta)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)
$folder3 = GUICtrlCreateButton("...", 410, 127, 21, 21, $BS_ICON)
GUICtrlSetImage(-1, @SystemDir & '\shell32.dll', 4, 0)

If Not($Compressing='' Or StringRegExp($Compressing, '[0-9]')) Then $Compressing=''
$Combo = GUICtrlCreateCombo("", 436-200, 163, 40, 23, $CBS_DROPDOWNLIST)
GUICtrlSetData(-1, "||0|1|2|3|4|5|6|7|8|9", $Compressing) ; �� ��������� 3-5
GUICtrlSetTip(-1, '������� ������ ������������ �����')
GUICtrlCreateLabel("������", 436-250, 165, 50, 17)
GUICtrlSetTip(-1, '������� ������ ������������ �����')
If $ComboCompressHide=1 Then
	GUICtrlSetState(-1, $GUI_HIDE)
	GUICtrlSetState($Combo, $GUI_HIDE)
EndIf

$iPos=436-150
$Patch = GUICtrlCreateButton("����", 436-75, 160, 70, 28)
GUICtrlSetTip(-1, '��������� ���������� ������� ����� ��������� ����-����')
If $ButtonPatchHide=1 Then
	GUICtrlSetState(-1, $GUI_HIDE)
	$iPos=436-75
EndIf

$Create = GUICtrlCreateButton("��������", $iPos, 160, 70, 28)
GUICtrlSetTip(-1, '������� ���� �� ������ ������� ���� ������')
If $ButtonCreateHide=1 Then GUICtrlSetState(-1, $GUI_HIDE)

; $Edit=GUICtrlCreateEdit('', 10, 230, 400, 160, $ES_AUTOVSCROLL + $WS_VSCROLL + $ES_NOHIDESEL+$ES_WANTRETURN)

GUISetState ()

While 1
	Switch GUIGetMsg()
		Case $Create
			GUICtrlSetState($Create, $GUI_DISABLE)
			GUICtrlSetState($Patch, $GUI_DISABLE)
			GUICtrlSetData($StatusBar,'�����������...')
			$cz=GUICtrlRead($Combo)
			$sPathOld=GUICtrlRead($Input1)
			$sPathNew=GUICtrlRead($Input2)
			$sPathDelta=GUICtrlRead($Input3)
			If Not FileExists($sPathOld) Then
				GUICtrlSetData($StatusBar, '������ ������� ������')
				MsgBox(0, '������', '�� ������ ��� �� ���������� ������ ���� / ����')
				_Enable()
				ContinueLoop
			EndIf
			If Not FileExists($sPathNew) Then
				GUICtrlSetData($StatusBar, '������ ������� ������')
				MsgBox(0, '������', '�� ������ ��� �� ���������� ����� ���� / ����')
				_Enable()
				ContinueLoop
			EndIf
			$tmp=StringRegExp($sPathDelta, '(^.+)\\(.+)$', 3)
			If Not(UBound($tmp)=2 And FileExists($tmp[0])) Then
				GUICtrlSetData($StatusBar, '������ ������� ������')
				MsgBox(0, '������', '�� ������ ��� �� ���������� ������� ��� ����� � ��� �����')
				_Enable()
				ContinueLoop
			EndIf
			If $sPathOld=$sPathNew Then
				GUICtrlSetData($StatusBar, '������ ������� ������')
				MsgBox(0, '������', '���� � ������� � ������ ����� ������ ���� �������')
				_Enable()
				ContinueLoop
			EndIf
			If Not StringInStr($sComm_Create, ' -f') And FileExists($sPathDelta) Then
				If MsgBox(4, '���������', '������������ ��� ������������ ����?' &@CRLF&@CRLF& _
				'����� �������������� ������������� ��������' &@CRLF& _
				'���� -f � �������� Comm_Create � Gui_xdelta3.ini')=6 Then
					$Trf=1
					$sComm_Create &= ' -f'
				Else
					GUICtrlSetData($StatusBar, '������')
					_Enable()
					ContinueLoop
				EndIf
			EndIf
			If StringLen($cz) Then $cz=' -'&$cz
			; MsgBox(0, '���������', @ComSpec & ' /c "'&@ScriptDir&'\xdelta3.exe" -e -s "' & $sPathOld & '" "' & $sPathNew & '" "' & $sPathDelta & '"')
			; ContinueLoop
			; $iPID = Run(@ComSpec & ' /c "'&@ScriptDir&'\xdelta3.exe" -e -s "' & $sPathOld & '" "' & $sPathNew & '" "' & $sPathDelta & '"', @ScriptDir, @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
			; $iPID = Run(@ScriptDir&'\xdelta3.exe -e -s "' & $sPathOld & '" "' & $sPathNew & '" "' & $sPathDelta & '"', @ScriptDir, @SW_HIDE, $STDOUT_CHILD)
			$iReturn = RunWait(@ScriptDir&'\xdelta3.exe -e'&$cz&$sComm_Create&' -s "' & $sPathOld & '" "' & $sPathNew & '" "' & $sPathDelta & '"', @ScriptDir, @SW_HIDE)
			If $iReturn Then
				GUICtrlSetData($StatusBar, '��������, ��� ������ = '&$iReturn)
			Else
				GUICtrlSetData($StatusBar, '��������� �������')
			EndIf
			If $Trf Then
				$Trf=0
				$sComm_Create = StringReplace($sComm_Create, ' -f', '')
			EndIf
			_Enable()
			; While 1
				; $sOut &= StdoutRead($iPID, False, True)
				; If @error Then ExitLoop
			; Wend
			; While 1
				; $sOut = StdoutRead($iPID)
				; If @error Then ExitLoop
				; If $sOut Then
					; GUICtrlSetData($Edit, $sOut, 1)
					; _GUICtrlEdit_Scroll($Edit, $SB_BOTTOM)
				; EndIf
			; WEnd

		Case $Patch
			GUICtrlSetState($Create, $GUI_DISABLE)
			GUICtrlSetState($Patch, $GUI_DISABLE)
			GUICtrlSetData($StatusBar,'�����������...')
			$sPathOld=GUICtrlRead($Input1)
			$sPathNew=GUICtrlRead($Input2)
			$sPathDelta=GUICtrlRead($Input3)
			If Not FileExists($sPathOld) Then
				GUICtrlSetData($StatusBar, '������ ������� ������')
				MsgBox(0, '������', '�� ������ ��� �� ���������� ������ ���� / ����')
				_Enable()
				ContinueLoop
			EndIf
			If Not FileExists($sPathDelta) Then
				GUICtrlSetData($StatusBar, '������ ������� ������')
				MsgBox(0, '������', '�� ������ ��� �� ���������� ���� �����')
				_Enable()
				ContinueLoop
			EndIf
			$tmp=StringRegExp($sPathNew, '(^.+)\\(.+)$', 3)
			If Not(UBound($tmp)=2 And FileExists($tmp[0])) Then
				GUICtrlSetData($StatusBar, '������ ������� ������')
				MsgBox(0, '������', '�� ������ ��� �� ���������� ������� ��� ������ ����� ��� ��� ���')
				_Enable()
				ContinueLoop
			EndIf
			If $sPathOld=$sPathNew Then
				GUICtrlSetData($StatusBar, '������ ������� ������')
				MsgBox(0, '������', '���� � ������� � ������ ����� ������ ���� �������')
				_Enable()
				ContinueLoop
			EndIf
			; $iPID = Run(@ScriptDir&'\xdelta3.exe -d -c -s "' & $sPathOld & '" "' & $sPathDelta & '" "' & $sPathNew & '"', @ScriptDir, @SW_HIDE, $STDOUT_CHILD)
			If Not StringInStr($sComm_Patch, ' -f') And FileExists($sPathNew) Then
				If MsgBox(4, '���������', '������������ ��� ������������ ����?' &@CRLF&@CRLF& _
				'����� �������������� ������������� ��������' &@CRLF& _
				'���� -f � �������� Comm_Patch � Gui_xdelta3.ini')=6 Then
					$Trf=1
					$sComm_Patch &= ' -f'
				Else
					GUICtrlSetData($StatusBar, '������')
					_Enable()
					ContinueLoop
				EndIf
			EndIf
			$iReturn = RunWait(@ScriptDir&'\xdelta3.exe -d'&$sComm_Patch&' -s "' & $sPathOld & '" "' & $sPathDelta & '" "' & $sPathNew & '"', @ScriptDir, @SW_HIDE)
			If $iReturn Then
				GUICtrlSetData($StatusBar, '��������, ��� ������ = '&$iReturn)
			Else
				GUICtrlSetData($StatusBar, '��������� �������')
			EndIf
			If $Trf Then
				$Trf=0
				$sComm_Patch = StringReplace($sComm_Patch, ' -f', '')
			EndIf
			_Enable()
			; While 1
				; $sOut = StdoutRead($iPID)
				; If @error Then ExitLoop
				; If $sOut Then
					; GUICtrlSetData($Edit, $sOut, 1)
					; _GUICtrlEdit_Scroll($Edit, $SB_BOTTOM)
				; EndIf
			; WEnd

		Case $GUI_EVENT_DROPPED  ;������� ������������ �� drag-and-drop (-13)
			If @GUI_DropID=$Input1 Then
				GUICtrlSetData($Input1, @GUI_DRAGFILE)
				If GUICtrlRead($Input2)='' Then GUICtrlSetData($Input2, @GUI_DRAGFILE)
			EndIf
			If @GUI_DropID=$Input2 Then GUICtrlSetData($Input2, @GUI_DRAGFILE)
			If @GUI_DropID=$Input3 Then GUICtrlSetData($Input3, @GUI_DRAGFILE)
			; If @GUI_DropID=$CatchDrop Then MsgBox(0,"� ������� drag-and-drop ����� ����", @GUI_DRAGFILE)
			; ������ �����
		Case $folder1
			$folder01 = FileOpenDialog("������� ����", @WorkingDir & "", "����� (*.*)", 1 + 2, '', $Gui)
			If @error Then ContinueLoop
			GUICtrlSetData($Input1, $folder01)
			If GUICtrlRead($Input2)='' Then GUICtrlSetData($Input2, $folder01)
		Case $folder2
			$folder02 = FileOpenDialog("������� ����", @WorkingDir & "", "����� (*.*)", 1 + 2, '', $Gui)
			If @error Then ContinueLoop
			GUICtrlSetData($Input2, $folder02)
		Case $folder3
			$folder03 = FileOpenDialog("������� ����", @WorkingDir & "", "����� (*.*)", 1 + 2, '', $Gui)
			If @error Then ContinueLoop
			GUICtrlSetData($Input3, $folder03)
		Case $restart
			_Restart()
		Case $GUI_EVENT_CLOSE ; ������� (-3)
			Exit
	EndSwitch
WEnd

Func _Enable()
	GUICtrlSetState($Create, $GUI_ENABLE)
	GUICtrlSetState($Patch, $GUI_ENABLE)
EndFunc

Func _Restart()
    Local $sAutoIt_File = @TempDir & "\~Au3_ScriptRestart_TempFile.au3"
    Local $sRunLine, $sScript_Content, $hFile

    $sRunLine = @ScriptFullPath
    If Not @Compiled Then $sRunLine = @AutoItExe & ' /AutoIt3ExecuteScript ""' & $sRunLine & '""'
    If $CmdLine[0] > 0 Then $sRunLine &= ' ' & $CmdLineRaw

    $sScript_Content &= '#NoTrayIcon' & @CRLF & _
    'While ProcessExists(' & @AutoItPID & ')' & @CRLF & _
    '   Sleep(10)' & @CRLF & _
    'WEnd' & @CRLF & _
    'Run("' & $sRunLine & '")' & @CRLF & _
    'FileDelete(@ScriptFullPath)' & @CRLF

    $hFile = FileOpen($sAutoIt_File, 2)
    FileWrite($hFile, $sScript_Content)
    FileClose($hFile)

    Run(@AutoItExe & ' /AutoIt3ExecuteScript "' & $sAutoIt_File & '"', @ScriptDir, @SW_HIDE)
    Sleep(1000)
    Exit
EndFunc