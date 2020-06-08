#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=repackwim.exe
#AutoIt3Wrapper_Icon=repackwim.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=
#AutoIt3Wrapper_Res_Description=repackwim.exe
#AutoIt3Wrapper_Res_Fileversion=3.9.0.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 23.01.2011			AutoIt3 v3.2.12.1

#NoTrayIcon

; En
$LngTitle = 'Repack boot.wim v3.9'
$LngAbout = 'About'
$LngVer = 'Version'
$LngSite = 'Site'
$LngCopy='Copy'
$LngMsg1 = 'Message'
$LngMsg2 = 'You want to create necessary rewim.ini?'
$LngMsg3 = 'Install the driver wimfltr.sys?'
$LngDad = 'drag-and-drop'
$LngPathW = 'Path wim'
$LngPathA = 'Path Update'
$LngTmp = 'Path Tmp'
$LngTmpH = 'To avoid exceeding the allowable' & @CRLF & 'length of symbols in the path it is recommended' & @CRLF & 'to specify a folder in the root'
$LngPs = 'pause before completing'
$LngPsH = 'A pause gives the opportunity to make changes manually'
$LngSv = 'Save settings'
$LngNR = 'Do not mount the registry hives'
$LngNRH = 'If you want to preserve the original registry'
$LngBt = 'Boot'
$LngBtH = 'For repacking programs'
$LngUpd = 'Update'
$LngSb = 'Statusbar'
$LngErr = 'Error'
$LngMsg4 = 'Missing file'
$LngMsg5 = 'Missing folder'
$LngMsg6 = 'The wim-file label is not found. Without a label' & @CRLF & 'it is impossible to extract a wim-file.'
$LngMsg7 = 'Can not open file.'
$LngSb1 = 'Delete the temporary folder "tmp"'
$LngSb2 = 'Extraction'
$LngSb3 = 'to a temporary folder "tmp"'
$LngSb4 = 'Copy the update files from a folder "root"'
$LngSb5 = 'Formed base5.reg'
$LngMsg8 = 'not mount'
$LngMsg9 = 'mount'
$LngMsg10 = 'Pause for manual editing before packing.' & @CRLF & @CRLF & '"Continue" - packing.' & @CRLF & '"Repeat" - mount the registry hives, if not mounts.' & @CRLF & '"Cancel" - Exit.'
$LngMsg11 = 'Pause for manual editing before packing.' & @CRLF & @CRLF & '"Yes" - packing.' & @CRLF & '"No" - Exit.'
$LngMsg12 = 'Missing folder "tools".'
$LngSb6 = 'Formed base4.reg'
$LngSb7 = 'Mount the registry hives'
$LngSb8 = 'The opening of full access to the registry hive'
$LngSb9 = 'Adding data to the registry LiveCD.'
$LngSb10 = 'Disable registry hives'
$LngSb11 = 'Runs packing in'
$LngSb12 = 'Wait for the implementation.'
$LngSb13 = 'Done! Size:'
$LngSb14 = '����-��������� - modify.cmd'
$LngSbMb = 'Mb'
$LngOpD1 = 'Choice wim'
$LngOpD2 = 'boot-wim'
$LngOpF = 'Choice a folder with updatings'
$LngOFT = 'Choice temporary folder'
$LngMsg13 = '- file not found.'
$LngScrollAbt = 'The tool is designed' & @CRLF & _
'for repacking the boot.wim using the update.' & @CRLF & @CRLF & _
'The update contains three directories: ' & @CRLF & _
'1. root - the contents of this directory copied to ' & _
'the root boot.wim with replacement ' & @CRLF & _
'2. reg - contains the reg-files imported into the ' & _
'registry LiveCD ' & @CRLF & _
'3. del - contains two types of lists removal of ' & _
'boot.wim. ' & @CRLF & @CRLF & _
'Repacking process can be seen in the status ' & _
'bar. Recommended to pause during ' & _
'repacking, to make sure mounted registry ' & _
'hives.' & @CRLF & @CRLF & _
'The utility is written in AutoIt3' & @CRLF & _
'autoitscript.com'

$Lang_dll = DllOpen("kernel32.dll")
$UserIntLang=DllCall ( $Lang_dll, "int", "GetUserDefaultUILanguage" )
If Not @error Then $UserIntLang=Hex($UserIntLang[0],4)
DllClose($Lang_dll)

; Ru
; ���� ������� �����������, �� ������� ����
If $UserIntLang = 0419 Then
	$LngTitle = 'Repack boot.wim v3.9'
	$LngAbout = '� ���������'
	$LngVer = '������'
	$LngSite = '����'
	$LngCopy='����������'
	$LngMsg1 = '���������'
	$LngMsg2 = '������ ������� ����������� rewim.ini'&@CRLF&'��� ���������� �������� ����������?'
	$LngMsg3 = '���������� ������� wimfltr.sys?'
	$LngDad = '����������� drag-and-drop'
	$LngPathW = '���� � ������������ wim-�����'
	$LngPathA = '���� � ����� � ������������'
	$LngTmp = '��������� �������'
	$LngTmpH = "�� ��������� ���������� ����������" & @CRLF & "������ �������� � ���� �������������" & @CRLF & "������� ����� � ����� �����"
	$LngPs = '������� ����� ����� ������������� �������'
	$LngPsH = "����� ��� �����������" & @CRLF & "������ ��������� �������"
	$LngSv = '��������� ���������'
	$LngNR = '�� ���������� ����� �������'
	$LngNRH = "���� ��������� ��������� �������� �������," & @CRLF & "�������� � �����."
	$LngBt = '�����������'
	$LngBtH = '����� ����� ��� ����������� ��������.'
	$LngUpd = '��������'
	$LngSb = '������ ���������'
	$LngErr = '������ ������'
	$LngMsg4 = '����������� ����'
	$LngMsg5 = '����������� �����'
	$LngMsg6 = '�� ������� ����� wim-�����.' & @CRLF & '��� ����� ������� wim-���� ����������.'
	$LngMsg7 = '�� �������� ������� ����.'
	$LngSb1 = '�������� ��������� ����� tmp'
	$LngSb2 = '����������'
	$LngSb3 = '�� ��������� ����� tmp'
	$LngSb4 = '�������� ����� ���������� �� ����� root'
	$LngSb5 = '����������� base5.reg'
	$LngMsg8 = '�� ���������'
	$LngMsg9 = '���������'
	$LngMsg10 = '����� ��� ������ ������ ����� ���������.' & @CRLF & @CRLF & '"����������" - ��������.' & @CRLF & '"���������" - ���������� ������, ���� �� ���������.' & @CRLF & '"������" - ������� ���������.'
	$LngMsg11 = '����� ��� ������ ������ ����� ���������.' & @CRLF & @CRLF & '"��" - ��������.' & @CRLF & '"���" - ������� ���������.'
	$LngMsg12 = '����������� ������� tools.'
	$LngSb6 = '����������� base4.reg'
	$LngSb7 = '���������� ����� �������'
	$LngSb8 = '�������� ������� ������� � ������ �������'
	$LngSb9 = '���������� ������ � ������ LiveCD.'
	$LngSb10 = '��������� ����� �������'
	$LngSb11 = '����������� �������� �'
	$LngSb12 = '��������� ����������.'
	$LngSb13 = '������ !!! ������:'
	$LngSb14 = '����-��������� - modify.cmd'
	$LngSbMb = '��'
	$LngOpD1 = '����� wim-�����'
	$LngOpD2 = '����������� �����'
	$LngOpF = '������� ����� � ������������'
	$LngOFT = '������� ��������� �����'
	$LngMsg13 = '- ���� �� ������, ��� �������� ���������� ��������.'
	$LngScrollAbt = '������� �������������' & @CRLF & _
	'��� ����������� ����������� boot.wim ' & _
	'������ � �������������� �������.' & @CRLF & @CRLF & _
	'������ �������� ��� ��������: ' & @CRLF & _
	'1. root - ���������� ����� �������� ' & _
	'���������� � ������ boot.wim � ������� ' & @CRLF & _
	'2. reg - �������� reg-����� ' & _
	'������������� � ������ LiveCD ' & @CRLF & _
	'3. del - �������� ��� ���� ������� ' & _
	'�������� �� boot.wim. ' & @CRLF & @CRLF & _
	'������� ����������� ����� ������ � ' & _
	'������ ���������. ������������� ' & _
	'������������ ����� �� ����� ' & _
	'�����������, ��� ����������� ' & _
	'����������� ������ �������.' & @CRLF & @CRLF & _
	'������� �������� �� AutoIt3' & @CRLF & _
	'autoitscript.com'
EndIf

$i386Win7 = ''
$sizewim = ''
Global $Stack[50], $Stack1[50], $aDel
Global $Ini = @ScriptDir & '\rewim.ini' ; ���� � rewim.ini

; �������� ������������� ������-������
$tools=@ScriptDir & '\tools'
$aTools=StringSplit('imagex.exe|msvcirt.dll|subinacl.exe|wimfltr.inf|wimfltr.sys|wimgapi.dll', '|')
$err=0
For $i = 1 to $aTools[0]
	If Not FileExists($tools&'\'&$aTools[$i]) Then
		$err=$i
		ExitLoop
	EndIf
Next
If $err>0 Then MsgBox(0, $LngMsg1, $aTools[$err]&' '&$LngMsg13)



;�������� ������������� rewim.ini
If Not FileExists($Ini) And MsgBox(4, $LngMsg1, $LngMsg2) = "6" Then IniWriteSection($Ini, "path", 'path1=' & @LF & 'path2=' & @LF & 'path3=' & @LF & 'check=0' & @LF & 'save=1' & @LF & 'reestr=0' & @LF & 'boot=1') ;  & @LF & 'Win7=0'
;��������� rewim.ini
$path1 = IniRead($Ini, "path", "path1", "")
$path2 = IniRead($Ini, "path", "path2", "")
$path3 = IniRead($Ini, "path", "path3", "")
$check = IniRead($Ini, "path", "check", "0")
$save = IniRead($Ini, "path", "save", "1")
$reestr = IniRead($Ini, "path", "reestr", "0")
$boot = IniRead($Ini, "path", "boot", "1")
; $Win7= IniRead ($Ini, "path", "Win7", "0")

; ��������� ��������, ���� �����������
If Not FileExists(@WindowsDir & '\system32\drivers\WimFltr.sys') And MsgBox(4, $LngMsg1, $LngMsg3)= "6" Then RunWait(@ComSpec & ' /C ' & @WindowsDir & '\system32\rundll32.exe setupapi,InstallHinfSection DefaultInstall 132 ' & $tools & '\wimfltr.inf', '', @SW_HIDE)

$Gui = GUICreate($LngTitle, 500, 348, -1, -1, -1, 0x00000010) ; ������ ����
$About = GUICtrlCreateButton("@", 500 - 21, 2, 18, 20)
$tab = GUICtrlCreateTab(0, 2, 500, 324) ; ������ �������
$hTab = GUICtrlGetHandle($tab) ; (1) ������ ����������� ������� �������� (����)

GUICtrlCreateLabel($LngDad, 250, 3, 160, 18)

$tab3 = GUICtrlCreateTabItem("Update") ; ��� �������

GUICtrlCreateLabel($LngPathW, 20, 38, 300, 17)
$inputwim = GUICtrlCreateInput("", 20, 55, 436, 22)
GUICtrlSetState(-1, 8)
$filewim = GUICtrlCreateButton("...", 455, 55, 26, 23)
GUICtrlSetFont(-1, 16)
If $path1 <> '' Then GUICtrlSetData($inputwim, $path1)

GUICtrlCreateLabel($LngPathA, 20, 93, 300, 17)
$inputzip = GUICtrlCreateInput("", 20, 110, 436, 22)
GUICtrlSetState(-1, 8)
$filezip = GUICtrlCreateButton("...", 455, 110, 26, 23)
GUICtrlSetFont(-1, 16)
If FileExists(@ScriptDir & '\Update') And $path2 = '' Then GUICtrlSetData($inputzip, @ScriptDir & '\Update')
If $path2 <> '' Then GUICtrlSetData($inputzip, $path2)

GUICtrlCreateLabel($LngTmp, 20, 148, 300, 17)
$inputtmp = GUICtrlCreateInput("", 20, 165, 436, 22)
GUICtrlSetState(-1, 8)
GUICtrlSetTip(-1, $LngTmpH)
If $path3 = '' Then
	GUICtrlSetData($inputtmp, @ScriptDir)
Else
	GUICtrlSetData($inputtmp, $path3)
EndIf
$filetmp = GUICtrlCreateButton("...", 455, 165, 26, 23)
GUICtrlSetFont(-1, 16)

; ��������
$checkpause = GUICtrlCreateCheckbox($LngPs, 20, 195, 255, 20)
GUICtrlSetTip(-1, $LngPsH)
If $check = '1' Then GUICtrlSetState($checkpause, 1)
$checksave = GUICtrlCreateCheckbox($LngSv, 20, 215, 255, 20)
If $save = '1' Then GUICtrlSetState($checksave, 1)
$checkre = GUICtrlCreateCheckbox($LngNR, 290, 195, 190, 20)
GUICtrlSetTip(-1, $LngNRH)
If $reestr = '1' Then GUICtrlSetState($checkre, 1)
$checkboot = GUICtrlCreateCheckbox($LngBt, 290, 215, 190, 20)
GUICtrlSetTip(-1, $LngBtH)
If $boot = '1' Then GUICtrlSetState($checkboot, 1)
; $checkWin7=GUICtrlCreateCheckbox ("Win7", 290,235,190,20)
; GUICtrlSetTip(-1, "Win7=Windows, XP=i386.")
; If $Win7='1' Then GuiCtrlSetState($checkWin7, 1)


$Upd = GUICtrlCreateButton($LngUpd, 390, 280, 87, 25)
$Label000 = GUICtrlCreateLabel($LngSb, 10, 330, 380, 20, 0xC)
$LabelMb = GUICtrlCreateLabel('', 392, 326, 80, 20, 0xC)
GUICtrlSetFont(-1, 15)

GUICtrlCreateTabItem("") ; ����� �������

; (2) ���������� ������� ����������
$Color = _WinAPI_GetThemeColor($hTab, 'TAB', 10, 1, 0x0EED)
If Not @error Then
	; ������������ ���������, ��� ������� ����� ��������� �������� �����
	GUICtrlSetBkColor($checkpause, $Color)
	GUICtrlSetBkColor($checksave, $Color)
	GUICtrlSetBkColor($checkre, $Color)
	GUICtrlSetBkColor($checkboot, $Color)
	; GUICtrlSetBkColor($checkWin7, $Color)
EndIf

GUISetState()

While 1
	$msg = GUIGetMsg()
	Select
		Case $msg = $About
			_About()
		Case $msg = -13 ;������� ������������ �� drag-and-drop
			If @GUI_DropId = $inputwim Then GUICtrlSetData($inputwim, @GUI_DragFile)
			If @GUI_DropId = $inputzip Then GUICtrlSetData($inputzip, @GUI_DragFile)
			If @GUI_DropId = $inputtmp Then GUICtrlSetData($inputtmp, @GUI_DragFile)
		Case $msg = $Upd
			$Time1=@MIN&':'&@SEC
			$Time = TimerInit()
			GUICtrlSetData($LabelMb, '')
			GUICtrlSetColor($LabelMb, 0x000000)
			$inputwim0 = GUICtrlRead($inputwim)
			If Not FileExists($inputwim0) Then
				MsgBox(0, $LngErr, $LngMsg4 & ' ' & $inputwim0)
				ContinueLoop
			EndIf
			$inputzip0 = GUICtrlRead($inputzip)
			If Not FileExists($inputzip0) Then
				MsgBox(0, $LngErr, $LngMsg5 & ' ' & $inputzip0)
				ContinueLoop
			EndIf
			$inputtmp0 = GUICtrlRead($inputtmp)
			If Not FileExists($inputtmp0) Then
				MsgBox(0, $LngErr, $LngMsg5 & ' ' & $inputtmp0)
				ContinueLoop
			EndIf
			GUICtrlSetState($Upd, 128)
			If GUICtrlRead($checkpause) = 1 Then
				$iniw = 1
			Else
				$iniw = 0
			EndIf
			If GUICtrlRead($checkre) = 1 Then
				$reestr0 = 1
			Else
				$reestr0 = 0
			EndIf
			If GUICtrlRead($checkboot) = 1 Then
				$boot0 = 1
			Else
				$boot0 = 0
			EndIf
			; If GUICtrlRead ($checkWin7)=1 Then
			; $Win70=1
			; $i386Win7='Windows'
			; Else
			; $Win70=0
			; $i386Win7='i386'
			; EndIf
			;���������� �������� � ini
			If GUICtrlRead($checksave) = 1 Then
				IniWrite($Ini, "path", "path1", $inputwim0)
				IniWrite($Ini, "path", "path2", $inputzip0)
				IniWrite($Ini, "path", "path3", $inputtmp0)
				IniWrite($Ini, "path", "check", $iniw)
				IniWrite($Ini, "path", "reestr", $reestr0)
				; IniWrite($Ini, "path", "boot", $boot0)
				; IniWrite($Ini, "path", "Win7", $Win70)
				IniWrite($Ini, "path", "save", '1')
			Else
				IniWrite($Ini, "path", "path1", '')
				IniWrite($Ini, "path", "path2", '')
				IniWrite($Ini, "path", "path3", '')
				IniWrite($Ini, "path", "check", '')
				IniWrite($Ini, "path", "boot", '')
				IniWrite($Ini, "path", "reestr", '')
				; IniWrite($Ini, "path", "Win7", '')
				IniWrite($Ini, "path", "save", '0')
			EndIf
			If $inputtmp0 = '' Or Not FileExists($inputtmp0) Then $inputtmp0 = @TempDir
			GUICtrlSetData($Label000, $LngSb1)
			If FileExists($inputtmp0 & '\tmp') Then DirRemove($inputtmp0 & '\tmp', 1)
			DirCreate($inputtmp0 & '\tmp\base_wim')
			Sleep(900)

			If Not FileExists($tools) Then
				MsgBox(0, $LngErr, $LngMsg12)
				GUICtrlSetState($Upd, 64)
				ContinueLoop
			EndIf
			
			; ����������� ����� WIM-�����
			$rnim = Run($tools & '\imagex.exe "' & $inputwim0 & '" /info', '', @SW_HIDE, 2)
			$labelwim0 = ''
			; Sleep(100)
			While 1
				$line1 = StdoutRead($rnim)
				If @error Then ExitLoop
				$labelwim0 &= $line1
			WEnd
			$labelwim0 = StringRegExpReplace($labelwim0, "(?s).*<NAME>(.*)</NAME>.*", "\1")
			If $labelwim0 = '' Then
				MsgBox(0, $LngErr, $LngMsg6)
				GUICtrlSetData($Label000, '')
				; ProcessClose($rnim)
				GUICtrlSetState($Upd, 64)
				ContinueLoop
			EndIf
			; ����� - ����������� ����� WIM-�����

			$aPathwim = StringRegExp($inputwim0, "(^.*)\\(.*)$", 3)
			GUICtrlSetData($Label000, $LngSb2 & ' ' & $aPathwim[1] & ' ' & $LngSb3)
			; ������� ���������� WIM-�����
			ShellExecuteWait($tools & '\imagex.exe', '/apply "' & $inputwim0 & '" "' & $labelwim0 & '" "' & $inputtmp0 & '\tmp\base_wim"', '', '', @SW_HIDE)


			If Not FileExists($inputtmp0 & '\tmp\base_wim\i386\system32\config\software') And FileExists($inputtmp0 & '\tmp\base_wim\Windows\system32\config\software') Then
				$i386Win7 = 'Windows'
			Else
				$i386Win7 = 'i386'
			EndIf


			; ��������� ������ �������� ������
			If FileExists($inputzip0 & '\Del') Then
				FileFindNextFirst($inputzip0 & '\Del')
				While 1
					$tempname = FileFindNext()
					If $tempname = "" Then ExitLoop
					If StringRight($tempname, 12) = "_delfile.txt" Then
						_FileReadToArray($tempname, $aDel)
						For $i = 1 To $aDel[0]
							; ��������� �������� ����������� � �����
							If $aDel[$i] <> '' And FileExists($inputtmp0 & '\tmp\base_wim\' & $aDel[$i]) Then FileDelete($inputtmp0 & '\tmp\base_wim\' & $aDel[$i])
						Next
					EndIf
				WEnd
			EndIf

			; ��������� ������ �������� �����
			If FileExists($inputzip0 & '\Del') Then
				FileFindNextFirst($inputzip0 & '\Del')
				While 1
					$tempname = FileFindNext()
					If $tempname = "" Then ExitLoop
					If StringRight($tempname, 11) = "_deldir.txt" Then
						_FileReadToArray($tempname, $aDel)
						For $i = 1 To $aDel[0]
							; ��������� �������� ����������� � �����
							If $aDel[$i] <> '' And FileExists($inputtmp0 & '\tmp\base_wim\' & $aDel[$i]) Then DirRemove($inputtmp0 & '\tmp\base_wim\' & $aDel[$i], 1)
						Next
					EndIf
				WEnd
			EndIf

			GUICtrlSetData($Label000, $LngSb4)
			If FileExists($inputzip0 & '\root') Then DirCopy($inputzip0 & '\root', $inputtmp0 & '\tmp\base_wim', 1)

			; �� ���������� ����� �������
			If GUICtrlRead($checkre) = 4 Then


				; ��������� ���� base5.reg
				GUICtrlSetData($Label000, $LngSb5)
				If FileExists($inputzip0 & '\reg') Then
					FileFindNextFirst($inputzip0 & '\reg')
					$filereg = FileOpen($inputtmp0 & '\tmp\base5.reg', 1)
					; �������� �������� ����� ��� ������ ������
					If $filereg = -1 Then
						MsgBox(0, $LngErr, $LngMsg7)
						Exit
					EndIf
					FileWrite($filereg, 'Windows Registry Editor Version 5.00' & @CRLF & @CRLF)
					While 1
						$tempname = FileFindNext()
						If $tempname = "" Then ExitLoop
						If StringRight($tempname, 3) = "reg" Then
							; ����������� reg-���� ��� ������ �����
							$search1 = FileOpen($tempname, 0)
							$search2 = FileRead($search1)
							$regline = FileReadLine($search1, 1)
							If FileReadLine($search1, 1) = 'Windows Registry Editor Version 5.00' Then
								$SR1 = StringReplace($search2, "HKEY_CURRENT_USER", "HKEY_LOCAL_MACHINE\PE_CU_DF")
								$SR1 = StringReplace($SR1, "HKEY_LOCAL_MACHINE\SOFTWARE", "HKEY_LOCAL_MACHINE\PE_LM_SW")
								$SR1 = StringReplace($SR1, "HKEY_LOCAL_MACHINE\SYSTEM", "HKEY_LOCAL_MACHINE\PE_SY_HI")
								$SR1 = StringReplace($SR1, "CurrentControlSet", "ControlSet001")
								$SR1 = StringReplace($SR1, "HKEY_CLASSES_ROOT", "HKEY_LOCAL_MACHINE\PE_LM_SW\Classes")
								$SR1 = StringReplace($SR1, "Windows Registry Editor Version 5.00", '# ' & StringRegExpReplace($tempname, "^.*\\", ""))
								; ���������� ���������, �������� ������ � reg-����� �� ��������������� ��� ��������� �������
								$SR1 = StringRegExpReplace($SR1, "(?s)\[HKEY_(USERS|CURRENT_CONFIG|LOCAL_MACHINE\\HARDWARE|LOCAL_MACHINE\\SAM|LOCAL_MACHINE\\SECURITY).*?([^\[]*)", "")
								FileWrite($filereg, $SR1 & @CRLF & @CRLF)
								FileClose($tempname)
							EndIf
						EndIf
					WEnd
					FileWrite($filereg, @CRLF)
					FileClose($filereg)
				EndIf
				; ����� - ��������� ���� base5.reg

				; ��������� ���� base4.reg
				GUICtrlSetData($Label000, $LngSb6)
				If FileExists($inputzip0 & '\reg') Then
					FileFindNextFirst($inputzip0 & '\reg')
					$filereg = FileOpen($inputtmp0 & '\tmp\base4.reg', 1)
					; �������� �������� ����� ��� ������ ������
					If $filereg = -1 Then
						MsgBox(0, $LngErr, $LngMsg7)
						Exit
					EndIf
					FileWrite($filereg, 'REGEDIT4' & @CRLF & @CRLF)
					While 1
						$tempname = FileFindNext()
						If $tempname = "" Then ExitLoop
						If StringRight($tempname, 3) = "reg" Then
							; ����������� reg-���� ��� ������ �����
							$search1 = FileOpen($tempname, 0)
							$search2 = FileRead($search1)
							$regline = FileReadLine($search1, 1)
							If FileReadLine($search1, 1) = 'REGEDIT4' Then
								$SR1 = StringReplace($search2, "HKEY_CURRENT_USER", "HKEY_LOCAL_MACHINE\PE_CU_DF")
								$SR1 = StringReplace($SR1, "HKEY_LOCAL_MACHINE\SOFTWARE", "HKEY_LOCAL_MACHINE\PE_LM_SW")
								$SR1 = StringReplace($SR1, "HKEY_LOCAL_MACHINE\SYSTEM", "HKEY_LOCAL_MACHINE\PE_SY_HI")
								$SR1 = StringReplace($SR1, "CurrentControlSet", "ControlSet001")
								$SR1 = StringReplace($SR1, "HKEY_CLASSES_ROOT", "HKEY_LOCAL_MACHINE\PE_LM_SW\Classes")
								$SR1 = StringReplace($SR1, "REGEDIT4", '# ' & StringRegExpReplace($tempname, "^.*\\", ""))
								; ���������� ���������, �������� ������ � reg-����� �� ��������������� ��� ��������� �������
								$SR1 = StringRegExpReplace($SR1, "(?s)\[HKEY_(USERS|CURRENT_CONFIG|LOCAL_MACHINE\\HARDWARE|LOCAL_MACHINE\\SAM|LOCAL_MACHINE\\SECURITY).*?([^\[]*)", "")
								FileWrite($filereg, $SR1 & @CRLF & @CRLF)
								FileClose($tempname)
							EndIf
						EndIf
					WEnd
					FileWrite($filereg, @CRLF)
					FileClose($filereg)
				EndIf
				; ����� - ��������� ���� base4.reg

				; ����� ������� software, default � system ������������
				GUICtrlSetData($Label000, $LngSb7)
				Run(@ComSpec & ' /C REG LOAD HKLM\PE_LM_SW "' & $inputtmp0 & '\tmp\base_wim\' & $i386Win7 & '\system32\config\software"', '', @SW_HIDE)
				Run(@ComSpec & ' /C REG LOAD HKLM\PE_CU_DF "' & $inputtmp0 & '\tmp\base_wim\' & $i386Win7 & '\system32\config\default"', '', @SW_HIDE)
				Run(@ComSpec & ' /C REG LOAD HKLM\PE_SY_HI "' & $inputtmp0 & '\tmp\base_wim\' & $i386Win7 & '\system32\setupreg.hiv"', '', @SW_HIDE)
				GUICtrlSetData($Label000, $LngSb8)
				; ������ ������ � ������������ ������
				ShellExecuteWait($tools & '\subinacl.exe', '/subkeyreg HKEY_LOCAL_MACHINE\PE_LM_SW /grant=���=F', '', '', @SW_HIDE)
				ShellExecuteWait($tools & '\subinacl.exe', '/subkeyreg HKEY_LOCAL_MACHINE\PE_CU_DF /grant=���=F', '', '', @SW_HIDE)
				ShellExecuteWait($tools & '\subinacl.exe', '/subkeyreg HKEY_LOCAL_MACHINE\PE_SY_HI /grant=���=F', '', '', @SW_HIDE)
				GUICtrlSetData($Label000, $LngSb9)
				RunWait(@ComSpec & ' /C regedit /s "' & $inputtmp0 & '\tmp\base4.reg"', '', @SW_HIDE)
				RunWait(@ComSpec & ' /C regedit /s "' & $inputtmp0 & '\tmp\base5.reg"', '', @SW_HIDE)

				;����������� �������� ����������� ������ �������
				$pe_lm_sw = RegRead("HKEY_LOCAL_MACHINE\PE_LM_SW", "")
				If @error = 1 Then
					$pe_lm_sw = $LngMsg8
					Run(@ComSpec & ' /C REG LOAD HKLM\PE_LM_SW ' & $inputtmp0 & '\tmp\base_wim\' & $i386Win7 & '\system32\config\software', '', @SW_HIDE)
					RunWait(@ComSpec & ' /C ' & $tools & '\subinacl.exe /subkeyreg HKEY_LOCAL_MACHINE\PE_LM_SW /grant=���=F', '', @SW_HIDE)
				Else
					$pe_lm_sw = $LngMsg9
				EndIf
				$pe_cu_df = RegRead("HKEY_LOCAL_MACHINE\PE_CU_DF", "")
				If @error = 1 Then
					$pe_cu_df = $LngMsg8
					Run(@ComSpec & ' /C REG LOAD HKLM\PE_CU_DF ' & $inputtmp0 & '\tmp\base_wim\' & $i386Win7 & '\system32\config\default', '', @SW_HIDE)
					RunWait(@ComSpec & ' /C ' & $tools & '\subinacl.exe /subkeyreg HKEY_LOCAL_MACHINE\PE_CU_DF /grant=���=F', '', @SW_HIDE)
				Else
					$pe_cu_df = $LngMsg9
				EndIf
				$pe_sy_hi = RegRead("HKEY_LOCAL_MACHINE\PE_SY_HI", "")
				If @error = 1 Then
					$pe_sy_hi = $LngMsg8
					Run(@ComSpec & ' /C REG LOAD HKLM\PE_SY_HI ' & $inputtmp0 & '\tmp\base_wim\' & $i386Win7 & '\system32\setupreg.hiv', '', @SW_HIDE)
					RunWait(@ComSpec & ' /C ' & $tools & '\subinacl.exe /subkeyreg HKEY_LOCAL_MACHINE\PE_SY_HI /grant=���=F', '', @SW_HIDE)
				Else
					$pe_sy_hi = $LngMsg9
				EndIf

				; ��������� �������� � ����� � ������������ �������������� ����� �������
				If GUICtrlRead($checkpause) = 1 Then
					While 1
						$pe_lm_sw = RegRead("HKEY_LOCAL_MACHINE\PE_LM_SW", "")
						If @error = 1 Then
							$pe_lm_sw = $LngMsg8
							Run(@ComSpec & ' /C REG LOAD HKLM\PE_LM_SW "' & $inputtmp0 & '\tmp\base_wim\' & $i386Win7 & '\system32\config\software"', '', @SW_HIDE)
							ShellExecuteWait($tools & '\subinacl.exe', '/subkeyreg HKEY_LOCAL_MACHINE\PE_LM_SW /grant=���=F', '', '', @SW_HIDE)
						Else
							$pe_lm_sw = $LngMsg9
						EndIf
						$pe_cu_df = RegRead("HKEY_LOCAL_MACHINE\PE_CU_DF", "")
						If @error = 1 Then
							$pe_cu_df = $LngMsg8
							Run(@ComSpec & ' /C REG LOAD HKLM\PE_CU_DF "' & $inputtmp0 & '\tmp\base_wim\' & $i386Win7 & '\system32\config\default"', '', @SW_HIDE)
							ShellExecuteWait($tools & '\subinacl.exe', '/subkeyreg HKEY_LOCAL_MACHINE\PE_CU_DF /grant=���=F', '', '', @SW_HIDE)
						Else
							$pe_cu_df = $LngMsg9
						EndIf
						$pe_sy_hi = RegRead("HKEY_LOCAL_MACHINE\PE_SY_HI", "")
						If @error = 1 Then
							$pe_sy_hi = $LngMsg8
							Run(@ComSpec & ' /C REG LOAD HKLM\PE_SY_HI "' & $inputtmp0 & '\tmp\base_wim\' & $i386Win7 & '\system32\setupreg.hiv"', '', @SW_HIDE)
							ShellExecuteWait($tools & '\subinacl.exe', '/subkeyreg HKEY_LOCAL_MACHINE\PE_SY_HI /grant=���=F', '', '', @SW_HIDE)
						Else
							$pe_sy_hi = $LngMsg9
						EndIf
						RunWait(@ComSpec & ' /C regedit /s "' & $inputtmp0 & '\tmp\base4.reg"', '', @SW_HIDE)
						RunWait(@ComSpec & ' /C regedit /s "' & $inputtmp0 & '\tmp\base5.reg"', '', @SW_HIDE)
						$rger = MsgBox(6, $LngMsg1, $LngMsg10 & @CRLF & @CRLF & 'software       - ' & $pe_lm_sw & @CRLF & 'default          - ' & $pe_cu_df & @CRLF & 'setupreg.hiv - ' & $pe_sy_hi)

						If $rger = 11 Then ExitLoop
						If $rger = 2 Then
							; ���������� ������ �������
							RunWait(@ComSpec & ' /C REG UNLOAD HKLM\PE_LM_SW', '', @SW_HIDE)
							RunWait(@ComSpec & ' /C REG UNLOAD HKLM\PE_CU_DF', '', @SW_HIDE)
							RunWait(@ComSpec & ' /C REG UNLOAD HKLM\PE_SY_HI', '', @SW_HIDE)
							Exit
						EndIf
					WEnd
				EndIf
				GUICtrlSetData($Label000, $LngSb10)
				; ���������� ������ �������
				RunWait(@ComSpec & ' /C REG UNLOAD HKLM\PE_LM_SW', '', @SW_HIDE)
				RunWait(@ComSpec & ' /C REG UNLOAD HKLM\PE_CU_DF', '', @SW_HIDE)
				RunWait(@ComSpec & ' /C REG UNLOAD HKLM\PE_SY_HI', '', @SW_HIDE)
			Else
				; �����
				If GUICtrlRead($checkpause) = 1 Then
					$rger = MsgBox(4, $LngMsg1, $LngMsg11)
					If $rger = 7 Then Exit
				EndIf
			EndIf

			GUICtrlSetData($Label000, $LngSb14)
			If FileExists($inputtmp0 & '\modify.cmd') Then RunWait($inputtmp0 & '\modify.cmd')

			$namewimpe = StringTrimRight($aPathwim[1], 4)
			GUICtrlSetData($Label000, $LngSb11 & ' ' & $namewimpe & '_New.wim. ' & $LngSb12)

			; �������� wim � ��������-�����
			$ProgressBar = GUICtrlCreateProgress(110, 283, 200, 18, 0x00000008)
			GUICtrlSetColor(-1, 32250); ���� ��� ������������ ����
			GUICtrlSetBkColor(-1,0xffffff)

			$boot1 = ' /boot '
			If GUICtrlRead($checkboot) = 4 Then $boot1 = ' '
			$iPos = 0
			$iPID = Run($tools & '\imagex.exe /capture' & $boot1 & '"' & $inputtmp0 & '\tmp\base_wim" "' & $inputtmp0 & '\' & $namewimpe & '_New.wim" "' & $labelwim0 & '" /compress maximum', '', @SW_HIDE)
			$sizewim = ''
			$swTmp = ''
			While ProcessExists($iPID)
				Sleep(50)
				If FileExists($inputtmp0 & '\' & $namewimpe & '_New.wim') Then $sizewim = Ceiling(FileGetSize($inputtmp0 & '\' & $namewimpe & '_New.wim')/1048576)
				If $swTmp<>$sizewim Then GUICtrlSetData($LabelMb, $sizewim & ' ' & $LngSbMb)
				$swTmp=$sizewim
				$iPos += 1
				GUICtrlSetData($ProgressBar, $iPos)
				Sleep(60)
				If $iPos > 100 Then $iPos = 0
			WEnd
			If FileExists($inputtmp0 & '\' & $namewimpe & '_New.wim') Then $sizewim = Ceiling(FileGetSize($inputtmp0 & '\' & $namewimpe & '_New.wim')/1048576)
			GUICtrlSetData($LabelMb, $sizewim & ' ' & $LngSbMb)
			GUICtrlSetColor($LabelMb, 0xEE0000) ; Red
			GUICtrlDelete($ProgressBar)
			; �����: �������� wim � ��������-�����

			GUICtrlSetData($Label000, $LngSb13 & ' ' & $sizewim & ' ' & $LngSbMb & '. Start: '&$Time1&', End: '&@MIN&':'&@SEC&', Total: '&Round(TimerDiff($Time) / 60000, 1) & " m")

			Run('Explorer.exe /select,"' & $inputtmp0 & '\' & $namewimpe & '_New.wim"')
			GUICtrlSetState($Upd, 64)

			; ������ "�����"
		Case $msg = $filewim
			$tmpwim = FileOpenDialog($LngOpD1, @WorkingDir, $LngOpD2 & " (*.wim)", 3, '', $Gui)
			If @error Then ContinueLoop
			GUICtrlSetData($inputwim, $tmpwim)
		Case $msg = $filezip
			$tmpzip = FileSelectFolder($LngOpF, '', '', @WorkingDir, $Gui)
			If @error Then ContinueLoop
			GUICtrlSetData($inputzip, $tmpzip)
		Case $msg = $filetmp
			$tmpbartpe = FileSelectFolder($LngOFT, '', '', @WorkingDir, $Gui)
			If @error Then ContinueLoop
			GUICtrlSetData($inputtmp, $tmpbartpe)
		Case $msg = -3
			ExitLoop
	EndSelect
WEnd



; ������� ������ ���� ������ � ��������
Func FileFindNextFirst($FindCat)
	$Stack[0] = 1
	$Stack1[1] = $FindCat
	$Stack[$Stack[0]] = FileFindFirstFile($Stack1[$Stack[0]] & "\*.*")
	Return $Stack[$Stack[0]]
EndFunc   ;==>FileFindNextFirst

Func FileFindNext()
	While 1
		$file = FileFindNextFile($Stack[$Stack[0]])
		If @error Then
			FileClose($Stack[$Stack[0]])
			If $Stack[0] = 1 Then
				Return ""
			Else
				$Stack[0] -= 1
				ContinueLoop
			EndIf
		Else
			If StringInStr(FileGetAttrib($Stack1[$Stack[0]] & "\" & $file), "D") > 0 Then
				$Stack[0] += 1
				$Stack1[$Stack[0]] = $Stack1[$Stack[0] - 1] & "\" & $file
				$Stack[$Stack[0]] = FileFindFirstFile($Stack1[$Stack[0]] & "\*.*")
				ContinueLoop
			Else
				Return $Stack1[$Stack[0]] & "\" & $file
			EndIf
		EndIf
	WEnd
EndFunc   ;==>FileFindNext

; (3) ���������� ������� ����������
Func _WinAPI_GetThemeColor($hWnd, $sClass, $iPart, $iState, $iProp)
	Local $hTheme = DllCall('uxtheme.dll', 'ptr', 'OpenThemeData', 'hwnd', $hWnd, 'wstr', $sClass)
	Local $Ret = DllCall('uxtheme.dll', 'lresult', 'GetThemeColor', 'ptr', $hTheme[0], 'int', $iPart, 'int', $iState, 'int', $iProp, 'dword*', 0)

	If (@error) Or ($Ret[0] < 0) Then
		$Ret = -1
	EndIf
	DllCall('uxtheme.dll', 'lresult', 'CloseThemeData', 'ptr', $hTheme[0])
	If $Ret = -1 Then
		Return SetError(1, 0, -1)
	EndIf
	Return SetError(0, 0, BitOR(BitAND($Ret[5], 0x00FF00), BitShift(BitAND($Ret[5], 0x0000FF), -16), BitShift(BitAND($Ret[5], 0xFF0000), 16)))
EndFunc   ;==>_WinAPI_GetThemeColor

;#include <File.au3>
Func _FileReadToArray($sFilePath, ByRef $aArray)
	Local $hFile = FileOpen($sFilePath, 0)
	If $hFile = -1 Then Return SetError(1, 0, 0)
	Local $aFile = FileRead($hFile, FileGetSize($sFilePath))
	If StringRight($aFile, 1) = @LF Then $aFile = StringTrimRight($aFile, 1)
	If StringRight($aFile, 1) = @CR Then $aFile = StringTrimRight($aFile, 1)
	FileClose($hFile)
	If StringInStr($aFile, @LF) Then
		$aArray = StringSplit(StringStripCR($aFile), @LF)
	ElseIf StringInStr($aFile, @CR) Then
		$aArray = StringSplit($aFile, @CR)
	Else
		If StringLen($aFile) Then
			Dim $aArray[2] = [1, $aFile]
		Else
			Return SetError(2, 0, 0)
		EndIf
	EndIf
	Return 1
EndFunc

Func _About()
Global $iScroll_Pos, $Gui1, $nLAbt, $hAbt, $wAbtBt
If Not IsDeclared('LngTitle') Then $LngTitle='New Program'
If Not IsDeclared('LngAbout') Then $LngAbout='About'
If Not IsDeclared('LngVer') Then $LngVer='Version'
If Not IsDeclared('LngSite') Then $LngSite='Site'
If Not IsDeclared('LngCopy') Then $LngCopy='Copy'
	$wAbt=270
	$hAbt=180
	$wAbtBt=20
	$wA=$wAbt/2-80
	$wB=$hAbt/3*2
	$iScroll_Pos = -$hAbt
	$TrAbt1 = 0
	$TrAbt2 = 0
	$BkCol1=0xf8c848
	$BkCol2=0
	$GuiPos = WinGetPos($Gui)
	GUISetState(@SW_DISABLE, $Gui)
	$font="Arial"
	
    $Gui1 = GUICreate($LngAbout, $wAbt, $hAbt,$GuiPos[0]+$GuiPos[2]/2-$wAbt/2, $GuiPos[1]+$GuiPos[3]/2-$hAbt/2, -1, 0x00000080, $Gui)
	GUISetBkColor ($BkCol1)
	GUISetFont (-1, -1, -1, $font)
	$vk1=GUICtrlCreateButton (ChrW('0x25BC'), 0, $hAbt-20, $wAbtBt, 20)
		
	GUICtrlCreateTab ($wAbtBt,0, $wAbt-$wAbtBt,$hAbt+35,0x0100+0x0004+0x0002)
	$tabAbt0=GUICtrlCreateTabitem ("0")

	GUICtrlCreateLabel('', $wAbtBt, 0, $wAbt-$wAbtBt, $hAbt)
	GUICtrlSetState(-1, 128) 
	GUICtrlSetBkColor (-1, $BkCol1)


	GUICtrlCreateLabel($LngTitle, 0, 0, $wAbt, $hAbt/3, 0x01+0x0200)
	GUICtrlSetFont (-1,15, 600, -1, $font)
	GUICtrlSetColor(-1,0xa21a10)
	GUICtrlSetBkColor (-1, 0xfbe13f)
	GUICtrlCreateLabel ("-", 2,$hAbt/3, $wAbt-2,1,0x10)
	
	GUISetFont (9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer&' 3.9  23.01.2011', $wA, $wB-30, 210, 17)
	GUICtrlCreateLabel($LngSite&':', $wA, $wB-15, 40, 17)
	$url=GUICtrlCreateLabel('http://azjio.ucoz.ru', $wA+37, $wB-15, 170, 17)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney:', $wA, $wB, 85, 17)
	$WbMn=GUICtrlCreateLabel('R939163939152', $wA+75, $wB, 125, 17)
	GUICtrlSetColor(-1,0xa21a10)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel('Copyright AZJIO � 2010', $wA, $wB+15, 210, 17)

	$tabAbt1=GUICtrlCreateTabitem ("1")

	GUICtrlCreateLabel('', $wAbtBt, 0, $wAbt-$wAbtBt, $hAbt)
	GUICtrlSetState(-1, 128) 
	GUICtrlSetBkColor (-1, 0x000000)

$StopPlay= GUICtrlCreateButton(ChrW('0x25A0'), 0, $hAbt-41, $wAbtBt, 20)
GUICtrlSetState(-1,32)

$nLAbt = GUICtrlCreateLabel($LngScrollAbt, $wAbtBt, $hAbt, $wAbt-$wAbtBt, 360, 0x1) ; �����
GUICtrlSetFont(-1, 9, 400, 2, $font)
GUICtrlSetColor(-1, 0xFFD800)
GUICtrlSetBkColor(-1, -2) ; ����������
GUICtrlCreateTabitem ('')
GUISetState(@SW_SHOW, $Gui1)

$msg = $Gui1
	While 1
	  $msg = GUIGetMsg()
	  Select
		Case $msg =$vk1
			If $TrAbt1 = 0 Then
				GUICtrlSetState($tabAbt1,16)
				GUICtrlSetState($nLAbt,16)
				GUICtrlSetState($StopPlay,16)
				GUICtrlSetData($vk1, ChrW('0x25B2'))
				GUISetBkColor ($BkCol2)
				If $TrAbt2 = 0 Then AdlibEnable('_ScrollAbtText', 40)
				$TrAbt1 = 1
			Else
				GUICtrlSetState($tabAbt0,16)
				GUICtrlSetState($nLAbt,32)
				GUICtrlSetState($StopPlay,32)
				GUICtrlSetData($vk1, ChrW('0x25BC'))
				GUISetBkColor ($BkCol1)
				AdlibDisable()
				$TrAbt1 = 0
			EndIf
		Case $msg = $StopPlay
			If $TrAbt2 = 0 Then
				AdlibDisable()
				GUICtrlSetData($StopPlay, ChrW('0x25BA'))
				$TrAbt2 = 1
			Else
				AdlibEnable('_ScrollAbtText', 40)
				GUICtrlSetData($StopPlay, ChrW('0x25A0'))
				$TrAbt2 = 0
			EndIf
		Case $msg = $url
			ShellExecute ('http://azjio.ucoz.ru')
		Case $msg = $WbMn
			ClipPut('R939163939152')
		Case $msg = -3
			AdlibDisable()
			$msg = $Gui
			GUISetState(@SW_ENABLE, $Gui)
			GUIDelete($Gui1)
			ExitLoop
		EndSelect
    WEnd
EndFunc

Func _ScrollAbtText()
    $iScroll_Pos += 1
    ControlMove($Gui1, "", $nLAbt, $wAbtBt, -$iScroll_Pos)
    If $iScroll_Pos > 360 Then $iScroll_Pos = -$hAbt
EndFunc