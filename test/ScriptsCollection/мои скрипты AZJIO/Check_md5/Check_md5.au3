#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=Check_md5.exe
#AutoIt3Wrapper_Icon=Check_md5.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=Check_md5.exe
#AutoIt3Wrapper_Res_Fileversion=0.7.1.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Field=Version|0.7.1
#AutoIt3Wrapper_Res_Field=Build|2012.10.12
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=CompanyName|AZJIO_Soft
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 2012.10.12

#NoTrayIcon
#include <Crypt.au3>
#include <FileOperations.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>
#include <ListBoxConstants.au3>
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include "Check_md5_Func.au3"

FileChangeDir(@ScriptDir)
Global $AutoPath = ''

If $CmdLine[0] Then _AutoCheck()


$LngTitle='Check_md5'
$LngAbout='� ���������'
$LngVer='������'
$LngCopy='����������'
$LngSite='����'

$iW = 500
$iH = 213

;�������� ��������
$hGui = GUICreate($LngTitle, $iW, $iH, -1, -1, -1, $WS_EX_ACCEPTFILES) ; ������ ����
If Not @Compiled Then GUISetIcon(@ScriptDir & '\Check_md5.ico')
$StatusBar = GUICtrlCreateLabel('������ ���������', 10, 197, 490, 20)
$restart = GUICtrlCreateButton("R", 481, 2, 18, 20)
GUICtrlSetTip(-1, "���������� �������")

$About = GUICtrlCreateButton("@", $iW - 40, 2, 18, 20)
GUICtrlSetTip(-1, "� ���������")

$opencurfol = GUICtrlCreateButton("�������", $iW - 100, 2, 57, 20)
GUICtrlSetTip(-1, "������� ������� ���������")

$tab = GUICtrlCreateTab(0, 2, $iW, $iH - 18) ; ������ �������

GUICtrlCreateLabel("����������� drag-and-drop", $iW - 250, 5, 150, 17)

$tab1 = GUICtrlCreateTabItem("  ����") ; ��� �������
$CatchDrop1 = GUICtrlCreateLabel("", 0, 30, $iW, 70)
GUICtrlSetState(-1, $GUI_DISABLE + $GUI_DROPACCEPTED)
$CatchDrop2 = GUICtrlCreateLabel("", 0, 100, $iW, 100)
GUICtrlSetState(-1, $GUI_DISABLE + $GUI_DROPACCEPTED)

GUICtrlCreateLabel("���� 1:", 10, 34, 50, 17, $SS_LEFTNOWORDWRAP)
$filen_1 = GUICtrlCreateLabel("", 61, 33, $iW - 65, 20)
GUICtrlSetColor(-1, 0x000099)
GUICtrlSetFont(-1, 9, 700)
$file_1 = GUICtrlCreateInput("", 10, 50, $iW - 45, 22)
GUICtrlSetState(-1, 8)
$openfile_1 = GUICtrlCreateButton("...", $iW - 34, 49, 24, 24, $BS_ICON)
GUICtrlSetImage(-1, @SystemDir & '\shell32.dll', -4, 0)
$md5_1 = GUICtrlCreateInput("", 10, 75, $iW - 45, 22)
GUICtrlSetState(-1, 8)
GUICtrlSetFont(-1, 9, 700)
$md5buf_1 = GUICtrlCreateButton("^", $iW - 34, 74, 24, 24, $BS_ICON)
GUICtrlSetImage(-1, @SystemDir & '\netshell.dll', -150, 0)
GUICtrlSetTip(-1, "MD5 � �����")

GUICtrlCreateLabel("���� 2:", 10, 104, 50, 17, $SS_LEFTNOWORDWRAP)
$filen_2 = GUICtrlCreateLabel("", 61, 103, $iW - 65, 20)
GUICtrlSetColor(-1, 0x000099)
GUICtrlSetFont(-1, 9, 700)
$file_2 = GUICtrlCreateInput("", 10, 120, $iW - 45, 22)
GUICtrlSetState(-1, 8)
$openfile_2 = GUICtrlCreateButton("...", $iW - 34, 119, 24, 24, $BS_ICON)
GUICtrlSetImage(-1, @SystemDir & '\shell32.dll', -4, 0)
$md5_2 = GUICtrlCreateInput("", 10, 145, $iW - 45, 22)
GUICtrlSetState(-1, 8)
GUICtrlSetFont(-1, 9, 700)
$md5buf_2 = GUICtrlCreateButton("^", $iW - 34, 144, 24, 24, $BS_ICON)
GUICtrlSetImage(-1, @SystemDir & '\netshell.dll', -150, 0)
GUICtrlSetTip(-1, "MD5 � �����")

$Compare_md5 = GUICtrlCreateButton("MD5", 88, 170, 52, 20)
GUICtrlSetTip(-1, "������� ���� MD5")

$ClearInp = GUICtrlCreateCheckbox("������� ""���� 2"" ��� ������� � ""���� 1""", 190, 171, 230, 17)

$tab2 = GUICtrlCreateTabItem("�������") ; ��� �������

GUICtrlCreateLabel("������� �������", 10, 35, 300, 17)
$folder111 = GUICtrlCreateInput("", 10, 50, $iW - 45, 22)
GUICtrlSetState(-1, 8)
$openfolder = GUICtrlCreateButton("...", $iW - 34, 49, 24, 24, $BS_ICON)
GUICtrlSetImage(-1, @SystemDir & '\shell32.dll', -4, 0)
GUICtrlSetTip(-1, "�����...")
$Clean1 = GUICtrlCreateButton("v ��������", $iW - 100, 33, 65, 17)

GUICtrlCreateLabel("������� ����-���� ����������� ���� md5", 10, 85, 300, 17)
$basefile = GUICtrlCreateInput("", 10, 100, $iW - 45, 22)
GUICtrlSetState(-1, 8)
$openbase = GUICtrlCreateButton("...", $iW - 34, 99, 24, 24, $BS_ICON)
GUICtrlSetImage(-1, @SystemDir & '\shell32.dll', -4, 0)
GUICtrlSetTip(-1, "�����...")
$Clean2 = GUICtrlCreateButton("v ��������", $iW - 100, 83, 65, 17)

GUICtrlCreateLabel("��� �����:", 20, 139, 60, 20)
$iMask = GUICtrlCreateCombo("", 90, 136, 180, 22)
GUICtrlSetData(-1, 'exe|exe;dll|exe;dll;com;scr|exe;dll;com;scr;inf;bat;cmd;vbs', 'exe')

$Check = GUICtrlCreateButton("���������", 410, 135, 72, 26)
GUICtrlSetTip(-1, "��������� ������� �� ������")

$Create = GUICtrlCreateButton("�������", 320, 135, 72, 26)
GUICtrlSetTip(-1, "������ �������� ������")

$tab3 = GUICtrlCreateTabItem("������������") ; ��� �������
$ListBox = GUICtrlCreateList("", 10, 33, 408, 131, BitOR($GUI_SS_DEFAULT_LIST, $LBS_STANDARD, $LBS_NOINTEGRALHEIGHT))
GUICtrlSetState(-1, 8)
GUICtrlSetBkColor(-1, 0xDDEEE8)

$Autostart = GUICtrlCreateCheckbox("������������", 10, 167, 90, 24)
GUICtrlSetTip(-1, "�������� ����� �������� � ������������")
If RegRead("HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run", @ScriptName) Then GUICtrlSetState($Autostart, 1)

$Import = GUICtrlCreateButton("������", 425, 33, 65, 22)
GUICtrlSetTip(-1, "������ ������ ������������" & @CRLF & "�������� ������������")
$Import2 = GUICtrlCreateButton("������", 425, 58, 65, 22)
GUICtrlSetTip(-1, "������ ��������� ������")
$AddOpen = GUICtrlCreateButton("��������", 425, 83, 65, 22)
GUICtrlSetTip(-1, "�������� ���� � ������")
$DelPath = GUICtrlCreateButton("�������", 425, 108, 65, 22)
GUICtrlSetTip(-1, "������� ���� �� ������")
$ClearPath = GUICtrlCreateButton("��������", 425, 133, 65, 22)
GUICtrlSetTip(-1, "������� ������")
$Save = GUICtrlCreateButton("���������", 425, 158, 65, 22)
GUICtrlSetTip(-1, "��������� ������ � ���� AutoCheck.txt")
$CheckCur = GUICtrlCreateButton("���������", 100, 167, 65, 22)
GUICtrlSetTip(-1, "�������� �� ������ AutoCheck.txt")
$OpenAC = GUICtrlCreateButton("�������", 170, 167, 65, 22)
GUICtrlSetTip(-1, "������� AutoCheck.txt � ��������")

$tab4 = GUICtrlCreateTabItem("     ?") ; ��� �������
GUICtrlCreateLabel("     ���� ������� - �������� ����������� ���� ������ ��� �������� ����������� ���������." & @CRLF & "     ""����"" - ������� ��� ��������� ���� ������. " & @CRLF & "     ""�������"" - ��������� � �������� � �������������� ��������� ������-�����. ��������� ��������� -  ��� ������: �����������, ������������� � ������������� ������." & @CRLF & "     ���� �������� ���� ""��� �����"" ������, �� ����������� ��� �����. ���� �� ������ ������������ ���� ����, ���������� ���� ""����-����"" ������. ���� �������� ���� �������� ������, �� ���� �������� �������� � ����-����, � ���� ������� �������, �� ��� ���� ����������� �������� � ������� ����������, �������� � �������. �������� ���-����� ������������ � ������ ��������� � ������. Esc - �����." & @CRLF & "     ""������������"" - �������� ������ ��� ������������.", 10, 30, 480, 150)
GUICtrlCreateLabel("AZJIO 2012.04.11", 408, 177, 90, 17)
GUICtrlCreateTabItem("") ; ����� �������

If FileExists(@ScriptDir & '\AutoCheck.txt') Then
	$AutoPath = FileRead(@ScriptDir & '\AutoCheck.txt')
	$AutoPathW = StringReplace(StringReplace($AutoPath, '|', '   ***  '), @CRLF, '|')
	If StringRight($AutoPathW, 1) = '|' Then $AutoPathW = StringTrimRight($AutoPathW, 1)
	GUICtrlSetData($ListBox, $AutoPathW)
EndIf

GUISetState()
_Crypt_Startup()

While 1
	Switch GUIGetMsg()
		Case $tab
			_ResetFont()
		Case $About
			_ResetFont()
			_About()
			; �������� ��� drag-and-drop �� ���� �������
		Case -13
			GUICtrlSetColor($md5_2, 0x0)
			GUICtrlSetColor($md5_1, 0x0)
			_ResetFont()
			$IsFolder = _IsFolder(@GUI_DragFile)
			GUICtrlSetData($StatusBar, StringRegExpReplace(@GUI_DragFile, '(^.*)\\(.*)$', '\2'))
			Switch @GUI_DropId
				Case $folder111
					If $IsFolder Then
						GUICtrlSetData($folder111, @GUI_DragFile)
					Else
						GUICtrlSetData($folder111, '')
						MsgBox(0, "��������������", '�������������� �������, � �� ����.')
					EndIf
				Case $basefile
					If $IsFolder Then
						GUICtrlSetData($basefile, '')
						MsgBox(0, "��������������", '�������������� ����, � �� �������.')
					Else
						GUICtrlSetData($basefile, @GUI_DragFile)
					EndIf
				Case $file_1, $md5_1, $CatchDrop1
					If Not $IsFolder Then _DropDrag($file_1, $md5_1, $filen_1, @GUI_DragFile)
				Case $file_2, $md5_2, $CatchDrop2
					If Not $IsFolder Then _DropDrag($file_2, $md5_2, $filen_2, @GUI_DragFile)
				Case $ListBox
					If Not $IsFolder Then
						If StringInStr($AutoPath, @GUI_DragFile & '|') Then
							MsgBox(0, "��������������", "����������� ���� ���������� � ������" & @CRLF & "� �� ����� ��������.")
							ContinueLoop
						Else
							$AutoPath &= @GUI_DragFile & '|' & StringTrimLeft(_Crypt_HashFile(@GUI_DragFile, $CALG_MD5), 2) & @CRLF
							_CreateList()
							GUICtrlSetData($StatusBar, '�������� ' & StringRegExpReplace(@GUI_DragFile, '(^.*)\\(.*)$', '\2'))
						EndIf
					EndIf
			EndSwitch

			; ������ ������� ������������
			; ������������
		Case $Autostart
			_ResetFont()
			If GUICtrlRead($Autostart) = 1 Then
				RegWrite("HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run", @ScriptName, "REG_SZ", '"'&@ScriptFullPath& '" /1')
				If RegRead("HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run", @ScriptName) Then
					GUICtrlSetData($StatusBar, '������ � ������ ������� ���������')
				Else
					GUICtrlSetState($Autostart, 4)
					GUICtrlSetData($StatusBar, '������ ������ � ������. ��������� ��������� �� ����� ��������������')
				EndIf
			Else
				RegDelete("HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run", @ScriptName)
				If RegRead("HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run", @ScriptName) Then
					GUICtrlSetState($Autostart, 1)
					GUICtrlSetData($StatusBar, '������ �������� ������ � �������. ��������� ��������� �� ����� ��������������')
				Else
					GUICtrlSetData($StatusBar, '������ �� ������� ������� �������.')
				EndIf
			EndIf
			; ������
		Case $Import
			_ResetFont()
			_implnk(@StartupCommonDir)
			_implnk(@StartupDir)
			If FileExists(@StartupDir & ' (Delayed by AnVir)') Then _implnk(@StartupDir & ' (Delayed by AnVir)')
			_impreg("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run")
			_impreg("HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run")
			_CreateList()
			GUICtrlSetData($StatusBar, '������ ������ ������������ ��������')
		Case $Import2
			_ResetFont()
			$system = StringSplit(@SystemDir & '\svchost.exe|' & @SystemDir & '\winlogon.exe|' & @SystemDir & '\lsass.exe|' & @SystemDir & '\smss.exe|' & @SystemDir & '\spoolsv.exe|' & @SystemDir & '\ctfmon.exe|' & @SystemDir & '\services.exe|', '|')
			For $i = 1 To $system[0]
				If FileExists($system[$i]) And Not StringInStr($AutoPath, $system[$i] & '|') Then $AutoPath &= $system[$i] & '|' & StringTrimLeft(_Crypt_HashFile($system[$i], $CALG_MD5), 2) & @CRLF
			Next
			_CreateList()
			GUICtrlSetData($StatusBar, '������ ��������� ������ ��������')
			; ��������
		Case $AddOpen
			_ResetFont()
			$tmp5 = FileOpenDialog("������� ����", @WorkingDir, "��� ����� (*.*)", 1 + 2, '', $hGui)
			If @error Then ContinueLoop
			If StringInStr($AutoPath, $tmp5 & '|') Then
				MsgBox(0, "��������������", "����������� ���� ���������� � ������" & @CRLF & "� �� ����� ��������.")
				ContinueLoop
			Else
				$AutoPath &= $tmp5 & '|' & StringTrimLeft(_Crypt_HashFile($tmp5, $CALG_MD5), 2) & @CRLF
				_CreateList()
				GUICtrlSetData($StatusBar, '�������� ' & StringRegExpReplace($tmp5, '(^.*)\\(.*)$', '\2'))
			EndIf
			; �������
		Case $DelPath
			_ResetFont()
			$myPath = GUICtrlRead($ListBox)
			If Not $myPath Then
				MsgBox(0, '���������', '�������� ����� ��� ��������')
				ContinueLoop
			EndIf
			$myPath = StringReplace($myPath, '   ***  ', '|')
			GUICtrlSetData($StatusBar, '����� ' & StringRegExpReplace($myPath, '^.*\\(.*?)\|.*$', '\1'))
			$myPath = StringRegExpReplace($myPath, "[][{}()|+.\\^$=#]", "\\$0")
			$AutoPath = StringRegExpReplace($AutoPath, $myPath & '\r\n', '')
			_CreateList()
			; ��������
		Case $ClearPath
			_ResetFont()
			$AutoPath = ''
			GUICtrlSetData($ListBox, '')
			GUICtrlSetData($StatusBar, '�������')
			; ���������
		Case $Save
			If FileExists(@ScriptDir & '\AutoCheck.txt') And MsgBox(4, '���������', '�������� ������������ ���� AutoCheck.txt') =7 Then ContinueLoop
			$file = FileOpen(@ScriptDir & '\AutoCheck.txt', 2)
			FileWrite($file, $AutoPath)
			FileClose($file)
			_ResetFont()
			GUICtrlSetData($StatusBar, '���������')
			; ��������
		Case $CheckCur
			GUICtrlSetData($StatusBar, '�������� ...')
			GUICtrlSetColor($StatusBar, 0x007700)
			_AutoCheck(0)
			GUICtrlSetFont($StatusBar, 9, 700)
			GUICtrlSetData($StatusBar, '�������� ���������')

		Case $OpenAC
			_ResetFont()
			If FileExists(@ScriptDir & '\AutoCheck.txt') Then ShellExecute(@ScriptDir & '\AutoCheck.txt')
			
			; ����� ������� ������������
			; ������ ������� �������

			; �������� ������
		Case $Create
			_ResetFont()
			GUICtrlSetData($StatusBar, '����������� ...')
			; ������ ������, ��������� ������� ���������
			$folder100 = GUICtrlRead($folder111)
			$basefile0 = GUICtrlRead($basefile)
			$sMask0 = GUICtrlRead($iMask)
			If $folder100 = '' Or Not FileExists($folder100) Or StringInStr(FileGetAttrib($folder100), "D") = 0 Then
				$folder100 = FileSelectFolder("������� �������", '', '3', @WorkingDir, $hGui)
				If @error Then
					MsgBox(0, "������ ������", '�� ������ ��� �� ���������� �������.')
					GUICtrlSetData($StatusBar, '�� ������ ��� �� ���������� �������.')
					ContinueLoop
				EndIf
			EndIf
			If $basefile0 = '' Or Not FileExists($basefile0) Or StringInStr(FileGetAttrib($basefile0), "D") > 0 Then
				; ���������� ��� ���������� ��� FileSaveDialog
				$namef = StringRegExpReplace($folder100, '(^.*)\\(.*)$', '\2')
				$namef = StringReplace($namef, ' ', '_')
				$i = 1
				While FileExists($namef & '_' & $i & '.txt')
					$i += 1
				WEnd
				$namef1 = $namef & '_' & $i & '.txt'
				If Not FileExists(@ScriptDir & '\' & $namef & '.txt') Then $namef1 = $namef & '.txt'
				$basefile0 = FileSaveDialog("����� ����� ����������", @ScriptDir & "", "��������� ���� (*.txt)", 24, $namef1, $hGui)
				If @error Then
					GUICtrlSetData($StatusBar, '�� ������ ����.')
					ContinueLoop
				EndIf
				If StringRight($basefile0, 4) <> '.txt' Then $basefile0 = $basefile0 & '.txt'
			EndIf
			$timer = TimerInit() ; �������� �����
			; ���������� ������ ��� ����������
			$FileList = _FO_FileSearch($folder100, _FO_CorrectMask(StringReplace($sMask0, ';', '|')), True, 125, 1, 1, 0)
			If @error Then
				GUICtrlSetData($StatusBar, '������ �� �������.')
				ContinueLoop
			EndIf
			$Size = 0
			For $i = 1 To $FileList[0]
				$Size += FileGetSize($FileList[$i])
			Next

			; �������� � ��������-�����
			$ProgressBar = GUICtrlCreateProgress(150, 170, 200, 16)
			GUICtrlSetColor(-1, 32250); ���� ��� ������������ ����

			; ����� ������
			$filetxt1 = FileOpen($basefile0, 2)
			; �������� �������� ����� ��� ������ ������
			If $filetxt1 = -1 Then
				MsgBox(0, "������", "�� �������� ������� ����.")
				ContinueLoop
			EndIf
			$Tmp = StringLen($folder100) + 1
			$datatext = $folder100 & @CRLF
			$Size1 = 0
			For $i = 1 To $FileList[0]
				GUICtrlSetData($StatusBar, $FileList[0] & ' / ' & $i & ' / ' & StringTrimLeft($FileList[$i], $Tmp))
				$SizeTmp = FileGetSize($FileList[$i])
				If $SizeTmp = 0 Then ContinueLoop ; �������� �������, ��� ��� ���� � ������� �������� �������� � ������ �������
				$MD5 = StringTrimLeft(_Crypt_HashFile($FileList[$i], $CALG_MD5), 2)
				$datatext &= StringTrimLeft($FileList[$i], $Tmp) & '|' & $MD5 & @CRLF
				$Size1 += $SizeTmp
				GUICtrlSetData($ProgressBar, Ceiling($Size1 / $Size * 100))
			Next

			GUICtrlDelete($ProgressBar)
			FileWrite($filetxt1, $datatext)
			FileClose($filetxt1)
			GUICtrlSetData($StatusBar, '��������� !!!  ����� ' & $FileList[0] & ' ������, �� ' & Ceiling(TimerDiff($timer) / 1000) & ' ���')
			GUICtrlSetColor($StatusBar, 0xEE0000)
			GUICtrlSetFont($StatusBar, 8.5, 700)
			$FileList=''

			; �������� �� ������
		Case $Check
			_ResetFont()
			GUICtrlSetData($StatusBar, '����������� ...')
			; ������ ������, ��������� ������� ���������
			$folder100 = GUICtrlRead($folder111)
			$basefile0 = GUICtrlRead($basefile)
			If $basefile0 = '' Or Not FileExists($basefile0) Or StringInStr(FileGetAttrib($basefile0), "D") > 0 Then
				$basefile0 = FileOpenDialog("������� ����-����", @WorkingDir, "��������� ���� (*.txt)", 1 + 2, '', $hGui)
				If @error Then
					MsgBox(0, "������ ������", '�� ������ ��� �� ���������� ������� ����.')
					GUICtrlSetData($StatusBar, '�� ������ ��� �� ���������� ������� ����.')
					ContinueLoop
				EndIf
			EndIf
			If $folder100 <> '' Or FileExists($folder100) Or StringInStr(FileGetAttrib($folder100), "D") > 0 Then
				MsgBox(0, "��������������", '���� ������ �������, �� ���������� ���� ����, � �� �� �������� �����.')
				;������������� ���� � ����
			EndIf

			$timer = TimerInit() ; �������� �����
			$file = FileOpen($basefile0, 0)
			$basetext = FileRead($file)
			FileClose($file)

			;==============================
			;����� ���� �� UDF File.au3 ��� ���������� ������� ��������� � ������
			If StringInStr($basetext, @LF) Then
				$aFiletext = StringSplit(StringStripCR($basetext), @LF)
			ElseIf StringInStr($basetext, @CR) Then
				$aFiletext = StringSplit($basetext, @CR)
			Else ;; unable to split the file
				If StringLen($basetext) Then
					Dim $aFiletext[2] = [1, $basetext]
				Else
					MsgBox(0, "���������", "��� ������")
					ContinueLoop
				EndIf
			EndIf

			If $folder100 <> '' Or FileExists($folder100) Or StringInStr(FileGetAttrib($folder100), "D") > 0 Then $aFiletext[1] = $folder100

			; ���������� ��� ������ ����� � ������� ����� �� ������ ���� ���� ����������
			$Output = @ScriptDir & '\Out_'
			$i = 1
			While FileExists($Output & $i & '_Check.log') Or FileExists($Output & $i & '_No_Check.log') Or FileExists($Output & $i & '_No_File.log')
				$i += 1
			WEnd
			$OutputCh = $Output & $i & '_Check.log'
			$OutputNC = $Output & $i & '_No_Check.log'
			$OutputNF = $Output & $i & '_No_File.log'
			$OutputChText = ''
			$OutputNCText = ''
			$OutputNFText = ''

			;���� ����������
			$Size = 0
			For $i = 2 To UBound($aFiletext) - 1
				If $aFiletext[$i] = '' Then ExitLoop
				$aFile = StringSplit($aFiletext[$i], "|")
				If FileExists($aFiletext[1] & '\' & $aFile[1]) Then $Size += FileGetSize($aFiletext[1] & '\' & $aFile[1])
			Next

			; �������� � ��������-�����
			$ProgressBar = GUICtrlCreateProgress(150, 170, 200, 16)
			GUICtrlSetColor(-1, 32250); ���� ��� ������������ ����
			$Size1 = 0

			; �������� ����� ���������� ������
			$kol = 0
			$kolCh = 0
			$kolNC = 0
			$kolNF = 0
			; ���� ������ md5 �� ����
			$nbf = UBound($aFiletext) - 3
			For $i = 2 To $nbf + 2
				If $aFiletext[$i] = '' Then ExitLoop
				$aFile = StringSplit($aFiletext[$i], "|")
				If FileExists($aFiletext[1] & '\' & $aFile[1]) Then
					$SizeTmp = FileGetSize($aFiletext[1] & '\' & $aFile[1])
					If $SizeTmp = 0 Then
						$OutputNCText &= $aFiletext[1] & '\' & $aFile[1] & @CRLF
						ContinueLoop
					EndIf
					$kol += 1
					GUICtrlSetData($StatusBar, $nbf & ' / ' & $i - 1 & ' / ' & $aFile[1])
					$MD5 = StringTrimLeft(_Crypt_HashFile($aFiletext[1] & '\' & $aFile[1], $CALG_MD5), 2)
					If $MD5 = $aFile[2] Then
						$kolCh += 1
						$OutputChText &= $aFiletext[1] & '\' & $aFile[1] & @CRLF
					Else
						$kolNC += 1
						$OutputNCText &= $aFiletext[1] & '\' & $aFile[1] & @CRLF
					EndIf
					$Size1 += $SizeTmp
				Else
					$kolNF += 1
					$OutputNFText &= $aFiletext[1] & '\' & $aFile[1] & @CRLF
				EndIf
				GUICtrlSetData($ProgressBar, Ceiling($Size1 / $Size * 100))
			Next
			GUICtrlDelete($ProgressBar)

			If $OutputChText <> '' Then
				$file = FileOpen($OutputCh, 2)
				FileWrite($file, '---������ ������ � ���������� ������������ �������, ����� ' & $kolCh & '---' & @CRLF & $OutputChText)
				FileClose($file)
			EndIf

			If $OutputNCText <> '' Then
				$file = FileOpen($OutputNC, 2)
				FileWrite($file, '---������ ������ � ������������ ������������ �������, ����� ' & $kolNC & '---' & @CRLF & $OutputNCText)
				FileClose($file)
			EndIf

			If $OutputNFText <> '' Then
				$file = FileOpen($OutputNF, 2)
				FileWrite($file, '---������ ������������� ������, ����� ' & $kolNF & '---' & @CRLF & $OutputNFText)
				FileClose($file)
			EndIf
			GUICtrlSetData($StatusBar, '��������� !!!  ����� ' & $kol & ' �� ' & $nbf & ' ������ ����, �� ' & Ceiling(TimerDiff($timer) / 1000) & ' ���')
			GUICtrlSetColor($StatusBar, 0xEE0000)
			GUICtrlSetFont($StatusBar, 8.5, 700)
			
			If $OutputNCText <> '' Then _Tabl($OutputNCText)

			; ������ "�������"
		Case $Clean1
			_ResetFont()
			GUICtrlSetData($folder111, '')
		Case $Clean2
			_ResetFont()
			GUICtrlSetData($basefile, '')
			
			; ������ "�����" ������� "�������"
		Case $openfolder
			$tmp1 = FileSelectFolder("������� �������", '', '3', @WorkingDir, $hGui)
			If @error Then ContinueLoop
			_ResetFont()
			GUICtrlSetData($folder111, $tmp1)
		Case $openbase
			$tmp2 = FileOpenDialog("������� ����-����", @WorkingDir, "��������� ���� (*.txt)", 1 + 2, '', $hGui)
			If @error Then ContinueLoop
			_ResetFont()
			GUICtrlSetData($basefile, $tmp2)
			
			; ������ "�����" ������� "����"
		Case $openfile_1
			$tmp3 = FileOpenDialog("������� ����", @WorkingDir, "��� ����� (*.*)", 1 + 2, '', $hGui)
			If @error Then ContinueLoop
			_ResetFont()
			_DropDrag($file_1, $md5_1, $filen_1, $tmp3)
		Case $openfile_2
			$tmp4 = FileOpenDialog("������� ����", @WorkingDir, "��� ����� (*.*)", 1 + 2, '', $hGui)
			If @error Then ContinueLoop
			_ResetFont()
			_DropDrag($file_2, $md5_2, $filen_2, $tmp4)
			
		Case $Compare_md5
			_ResetFont()
			GUICtrlSetData($file_1, '')
			GUICtrlSetData($file_2, '')
			GUICtrlSetData($filen_1, '')
			GUICtrlSetData($filen_2, '')
			If GUICtrlRead($md5_2) <> '' And GUICtrlRead($md5_1) <> '' Then
				_Compare()
			Else
				GUICtrlSetData($StatusBar, '�� ������ md5')
				GUICtrlSetColor($StatusBar, 0x0)
				GUICtrlSetColor($md5_2, 0xAAAAAA)
				GUICtrlSetColor($md5_1, 0xAAAAAA)
			EndIf
			
		Case $md5buf_1
			_ResetFont()
			ClipPut(GUICtrlRead($md5_1))
		Case $md5buf_2
			_ResetFont()
			ClipPut(GUICtrlRead($md5_2))
			
		Case $opencurfol
			_ResetFont()
			Run('Explorer.exe "' & @ScriptDir & '"')
		Case $restart
			_restart()
		Case -3
			_Crypt_Shutdown()
			Exit
	EndSwitch
WEnd

Func _ResetFont()
	GUICtrlSetColor($StatusBar, 0x0)
	GUICtrlSetFont($StatusBar, 8.5, 400)
EndFunc

Func _DropDrag($file_3, $md5_3, $filen_3, $DragFile)
	GUICtrlSetData($file_3, $DragFile)
	GUICtrlSetData($filen_3, StringRegExpReplace($DragFile, '(^.*)\\(.*)$', '\2'))
	$MD5 = StringTrimLeft(_Crypt_HashFile($DragFile, $CALG_MD5), 2)
	GUICtrlSetData($md5_3, $MD5)
	If GUICtrlRead($file_1) = GUICtrlRead($file_2) Then MsgBox(0, '���������', '������ ���� � ��� �� ����.')
	If GUICtrlRead($ClearInp) = 1 And $file_3 = $file_1 Then
		GUICtrlSetData($file_2, '')
		GUICtrlSetData($md5_2, '')
		GUICtrlSetData($filen_2, '')
	EndIf
	_Compare()
EndFunc

Func _Compare()
	$file_10 = GUICtrlRead($file_1)
	$file_20 = GUICtrlRead($file_2)
	$md5_10 = GUICtrlRead($md5_1)
	$md5_20 = GUICtrlRead($md5_2)
	$Size_st = ' '
	
	If FileExists($file_10) And FileExists($file_20) Then
		$Size_10 = FileGetSize($file_10)
		$Size_20 = FileGetSize($file_20)
		If $Size_10 > $Size_20 Then
			$Size_st = ',         ��������� �������� ����� ' & Round($Size_10 / $Size_20, 1) & ' : 1'
		Else
			$Size_st = ',         ��������� �������� ����� 1 : ' & Round($Size_20 / $Size_10, 1)
		EndIf
		If $Size_10 = $Size_20 Then $Size_st = ',         ��������� �������� ����� 1=1'
	EndIf
	
	If $md5_20 And $md5_10 Then
		If $md5_20 = $md5_10 Then
			GUICtrlSetData($StatusBar, '����������' & $Size_st)
			GUICtrlSetColor($StatusBar, 0x007700)
			GUICtrlSetFont($StatusBar, 9, 700)
			GUICtrlSetColor($md5_2, 0x007700)
			GUICtrlSetColor($md5_1, 0x007700)
		Else
			GUICtrlSetData($StatusBar, '�������' & $Size_st)
			GUICtrlSetColor($StatusBar, 0xEE0000)
			GUICtrlSetFont($StatusBar, 9, 700)
			GUICtrlSetColor($md5_2, 0xEE0000)
			GUICtrlSetColor($md5_1, 0xEE0000)
		EndIf
	EndIf
EndFunc

Func _AutoCheck($ex = 1)
	$AC_text = FileRead(@ScriptDir & '\AutoCheck.txt')
	If Not $AC_text Then Return

	$aFiletext = _SplitStringToArray($AC_text)
	; If @error Then Return

	$krit = ''
	$NotFile = ''
	For $i = 1 To UBound($aFiletext) - 1
		$aFile = StringSplit($aFiletext[$i], "|")
		If @error Or $aFile[0]<>2 Then ContinueLoop
		If FileExists($aFile[1]) Then
			$MD5 = StringTrimLeft(_Crypt_HashFile($aFile[1], $CALG_MD5), 2)
			If $MD5 <> $aFile[2] Then
				;$krit&=$aFile[1]&'|'&$aFile[2]&'|'&$MD5&@CRLF
				$krit &= $aFile[1] & @CRLF
			EndIf
		Else
			If Not $ex Then $NotFile &= @CRLF& '���� �� ����������: ' & $aFile[1]
		EndIf
	Next
	$krit &= $NotFile
	If $krit Then ; ���� ���������� �����, ��
		_Tabl($krit) ; �������� � ����
		$file = FileOpen(@ScriptDir & '\AutoCheck.log', 1)
		FileWrite($file, "����: " & @YEAR & "." & @MON & "." & @MDAY & "_" & @HOUR & "." & @MIN & "." & @SEC & @CRLF & $krit & @CRLF)
		FileClose($file)
		If Not $ex Then
			GUICtrlSetColor($StatusBar, 0xEE0000)
			GUICtrlSetFont($StatusBar, 9, 700)
		EndIf
	EndIf
	If $ex Then Exit
EndFunc

Func _Tabl($krit)
	$aTabl = _SplitStringToArray($krit)

	If $aTabl[0] < 20 Then
		$pos = $aTabl[0]
	Else
		$pos = 20
	EndIf

	$kolbyk = 52
	For $i = 1 To $aTabl[0]
		$tmp = StringLen($aTabl[$i])
		If $tmp > $kolbyk Then $kolbyk = $tmp
	Next
	$kolbyk*=6
	If $kolbyk>@DesktopWidth-30 Then $kolbyk=@DesktopWidth-30

	$hGui1 = GUICreate("�������������� md5", $kolbyk, $pos * 17 + 40, -1, -1, $WS_SYSMENU+$WS_SIZEBOX)
	GUICtrlCreateEdit($krit, 0, 0, $kolbyk, $pos * 17 + 40)
	GUICtrlSetResizing(-1, 1)
	GUICtrlSetBkColor(-1, 0xffd7d7)

	GUISetState()
	If WinWaitActive($hGui1, '', 3) Then Send("{DOWN}")

	Do
	Until GUIGetMsg() = -3
	GUIDelete($hGui1)
EndFunc


Func _CreateList()
	Local $tmp = StringReplace(StringReplace($AutoPath, '|', '   ***  '), @CRLF, '|')
	If StringRight($tmp, 1) = '|' Then $tmp = StringTrimRight($tmp, 1)
	GUICtrlSetData($ListBox, '')
	GUICtrlSetData($ListBox, $tmp)
EndFunc

Func _implnk($ImplnkPath) ; ������ ������������ �������
	Local $aLNK, $FileList
	$FileList = _FO_FileSearch($ImplnkPath, '*.lnk')
	If @error Then Return
	For $i = 1 To $FileList[0]
		$aLNK = FileGetShortcut($FileList[$i])
		If FileExists($aLNK[0]) And StringInStr($AutoPath, $aLNK[0] & '|') = 0 Then $AutoPath &= $aLNK[0] & '|' & StringTrimLeft(_Crypt_HashFile($aLNK[0], $CALG_MD5), 2) & @CRLF
	Next
EndFunc

Func _impreg($vetka) ; ������ ������������ �������
	For $i = 1 To 50
		$Val = RegEnumVal($vetka, $i)
		If @error Then Return
		$znach = RegRead($vetka, $Val)
		If @error Then ContinueLoop
		$aPathexe = StringRegExp($znach, "(?i)(^.*)exe(.*)$", 3)
		If @error Then ContinueLoop
		$Pathexe1 = StringReplace($aPathexe[0], '"', '')
		If StringInStr($Pathexe1, '\') = 0 Then
			If FileExists(@SystemDir & '\' & $Pathexe1 & 'exe') Then $Pathexe1 = @SystemDir & '\' & $Pathexe1
		EndIf
		If FileExists($Pathexe1 & 'exe') And StringInStr($AutoPath, $Pathexe1 & 'exe|') = 0 Then $AutoPath &= $Pathexe1 & 'exe|' & StringTrimLeft(_Crypt_HashFile($Pathexe1 & 'exe', $CALG_MD5), 2) & @CRLF
	Next
EndFunc