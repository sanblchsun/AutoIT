;  @AZJIO 9.04.2009, ���������  30.04.2010
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=TweakerXP.exe
#AutoIt3Wrapper_Icon=TweakerXP.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=TweakerXP.exe
#AutoIt3Wrapper_Res_Fileversion=0.8.2.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Field=Version|0.8.2
#AutoIt3Wrapper_Res_Field=Build|2011.08.2
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/SOI
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <GuiComboBox.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>

$sIcoPath=@WindowsDir &'\Resources\Icons'
If Not FileExists($sIcoPath) Then DirCreate($sIcoPath)
FileInstall('Drive.dll', $sIcoPath&'\Drive.dll')

Switch @OSVersion
	Case 'WIN_2000', 'WIN_XP', 'WIN_2003'
		$OSVersion = 1
	Case Else
		$OSVersion = 0
EndSwitch

#NoTrayIcon
Global $Ini = @ScriptDir & '\TweakerXP.ini' ; ���� � TweakerXP.ini
;�������� ������������� TweakerXP.ini
If Not FileExists($Ini) Then
	FileWrite($Ini, '[url]' & @CRLF & _
			'http://google.ru' & @CRLF & _
			'http://forum.oszone.net/index.php?' & @CRLF & _
			'http://forum.ru-board.com' & @CRLF & _
			'http://autoit-script.ru/index.php?action=forum' & @CRLF & _
			'http://topdownloads.ru/search.php' & @CRLF & _
			'[general]' & @CRLF & _
			'notepad=notepad.exe' & @CRLF & _
			'Place0=C:\' & @CRLF & _
			'Place1=D:\' & @CRLF & _
			'Place2=' & @MyDocumentsDir & @CRLF & _
			'Place3=' & @MyDocumentsDir & '\��� �������' & @CRLF & _
			'Place4=' & @MyDocumentsDir & '\��� ������' & @CRLF & _
			'crtex=Readme')
EndIf
;��������� TweakerXP.ini
$notepad = IniRead($Ini, "general", "notepad", "notepad.exe")

$Inigpl0 = IniRead($Ini, "general", "Place0", "C:\")
$Inigpl1 = IniRead($Ini, "general", "Place1", "D:\")
$Inigpl2 = IniRead($Ini, "general", "Place2", @MyDocumentsDir)
$Inigpl3 = IniRead($Ini, "general", "Place3", @MyDocumentsDir & '\��� �������')
$Inigpl4 = IniRead($Ini, "general", "Place4", @MyDocumentsDir & '\��� ������')

$crtext = IniRead($Ini, "general", "crtext", "Readme")

GUICreate("TweakerXP v0.8.1", 500, 320) ; ������ ����
;GUISetFont(9, 300)
$restart = GUICtrlCreateButton("R", 479, 4, 18, 18)
GUICtrlSetTip(-1, "���������� �������")
$openini = GUICtrlCreateButton("ini", 450, 4, 24, 18)
GUICtrlSetTip(-1, "������� ���� ���������")
$tab = GUICtrlCreateTab(0, 2, 500, 318) ; ������ �������
$hTab = GUICtrlGetHandle($tab) ; (1) ������ ����������� ������� �������� (����), � ���� ��� �� ��������, �� ���������� ������� � �������

;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
$tab0 = GUICtrlCreateTabItem("�����") ; ��� �������

Global $aCheck0[11]

GUICtrlCreateLabel("������������ � TweakerXP.ini.", 30, 40, 450, 20)
$aCheck0[1] = GUICtrlCreateCheckbox("����� ""��������"" ������������� � Notepad (txt, reg, htm, cmd, bat)", 20, 60, 450, 20)
GUICtrlSetTip(-1, "���� � ������ �������� ������� � TweakerXP.ini")
$aCheck0[2] = GUICtrlCreateCheckbox("����� � �������� ""�������� HTML-����"" - �������� � Notepad", 20, 80, 450, 20)
GUICtrlSetTip(-1, "���� � ������ �������� ������� � TweakerXP.ini")

$aCheck0[3] = GUICtrlCreateCheckbox("��� �������� ������� ������ � ����� ""����� ���""", 20, 100, 467, 20)
$tweak = RegRead("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer", "link")
If $tweak <> '0x00000000' Then GUICtrlSetState(-1, 1)

$aCheck0[4] = GUICtrlCreateCheckbox('����� � ����������� ���� - "������� � ����� ����"', 20, 120, 370, 20)
$tweak = RegRead("HKCR\Folder\shell\opennew", "")
If $OSVersion And $tweak <> '������� � ����� ����' Then GUICtrlSetState(-1, 1)
GUICtrlSetTip(-1, "���� ����� ����������� ��� Ctrl+Enter")
$tabBut04 = GUICtrlCreateButton("< �������.", 400, 120, 80, 20)
GUICtrlSetTip(-1, "������� ���� ����� �� ������������ ����")

$aCheck0[5] = GUICtrlCreateCheckbox("��a���� ����� �e�� ���� ""B�xo� �� c�c�e��""", 20, 140, 450, 20)
$tweak = RegRead("HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer", "StartmenuLogoff")
If $OSVersion And $tweak <> '1' Then GUICtrlSetState(-1, 1)

$URL = StringRegExpReplace(FileRead($Ini) & @CRLF & '[', "(?s).*\[url\]\r?\n(.*?)(?:\r?\n\[.*)", "\1")
$aCheck0[6] = GUICtrlCreateCheckbox("���������� ������ � �������������� ������ �������� IE", 20, 160, 450, 20)
GUICtrlSetTip(-1, $URL)
$URL = StringSplit($URL, @CRLF, 1)

$aCheck0[7] = GUICtrlCreateCheckbox("���������� ���� ""��������� ���..."" - ��������� ����� ������", 20, 180, 370, 20)
GUICtrlSetTip(-1, "��������� ����� � ����������� ��������" & @LF & "��� �������� ����� ��� ����������.")
$tabBut07 = GUICtrlCreateButton("< �������.", 400, 180, 80, 20)
GUICtrlSetTip(-1, "������������ �� ���������")

$aCheck0[8] = GUICtrlCreateCheckbox("������� � ����������� ���� ����� ""������""", 20, 200, 450, 20)
GUICtrlSetTip(-1, "����� �� ��� ����������� ��" & @LF & "������������ �� ������������ ����?")

$aCheck0[9] = GUICtrlCreateCheckbox("��������� �������� HDD ��� ������ WindowsXP", 20, 220, 370, 20)
GUICtrlSetTip(-1, "���� ���� �������� �������� �����" & @LF & "�� ������ ����� �� ���������� �����")
$tabBut09 = GUICtrlCreateButton("< �������.", 400, 220, 80, 20)
GUICtrlSetTip(-1, "������������ �� ���������")

$aCheck0[10] = GUICtrlCreateCheckbox("�������� ���������� �����", 20, 241, 190, 20)
GUICtrlSetTip(-1, '����� ������������ ���� "�������"' & @LF & '����� ����������, ���� ���������' & @LF & '����������� ���� ��� ����.')
$crtextfl = GUICtrlCreateCombo("", 210, 240, 155, 18)
GUICtrlSetData(-1, $crtext & '|Readme|���������|������|��������� ��������|�����', $crtext)

$checkall0 = GUICtrlCreateCheckbox("���/���� ���", 20, 280, 111, 22)
GUICtrlSetTip(-1, "������/��������� �������" & @CRLF & "�� ���� �������")
$vkladka01 = GUICtrlCreateButton("���������", 390, 280, 93, 24)

;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
$tab5 = GUICtrlCreateTabItem("User") ; ��� �������
GUICtrlCreateLabel("��������� ���� � ������ ������������", 30, 40, 250, 20)
$UserButRm = GUICtrlCreateButton("Readme (����������� ������)", 280, 40, 190, 20)

$Label02 = GUICtrlCreateLabel("����� HDD-�����:", 20, 62, 120, 20)
$bykva = GUICtrlCreateCombo("", 140, 60, 45, 18, $CBS_DROPDOWNLIST + $WS_VSCROLL)
GUICtrlSetFont(-1, Default, Default, 0, 'Lucida Console')
_GUICtrlComboBox_SetDroppedWidth($bykva, 340)
_ComboBox_SetDrive($bykva, 'd')

$Label03 = GUICtrlCreateLabel("��� ������������:", 20, 92, 120, 20)
$usersprofiles = GUICtrlCreateCombo("", 140, 90, 115, 18)
GUICtrlSetData(-1, 'user1|user|usersprofiles1|usersprofiles', 'user1')
$checkCN501 = GUICtrlCreateCheckbox("������� ����������� ����� � ������ � ������ � ������ �������� �������", 20, 120, 460, 20)
GUICtrlSetTip(-1, "������� ����� Games, �������," & @CRLF & "������, ������ �� ��������� �����")

$vkladka011 = GUICtrlCreateButton("���������", 390, 280, 93, 24)

;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
$tab6 = GUICtrlCreateTabItem("LNK") ; ��� �������
GUICtrlCreateLabel("�������� �������", 30, 40, 250, 20)

$checkCN601 = GUICtrlCreateCheckbox("������� �� ������� ����� ������ ���������� � ������������", 20, 62, 390, 20)
$checkCN602 = GUICtrlCreateCheckbox("������� �� ������� ����� ����� ������� Temp", 20, 82, 390, 20)

GUICtrlCreateLabel('������� ����� � ����� ��' & @CRLF & '������ �������� �������', 20, 110, 145, 34)
$bykvaLNK = GUICtrlCreateCombo('', 165, 115, 45, 23)
GUICtrlSetData(-1, '|A|B|C|D|E|F|X|cd1|cd2|fsh', '')
$btnLNK = GUICtrlCreateButton('�����', 215, 115, 50, 23)

$vkladka601 = GUICtrlCreateButton("���������", 390, 280, 93, 24)

;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
$tab1 = GUICtrlCreateTabItem("New *.*") ; ��� �������
GUICtrlCreateLabel("������� ������ � ����������� ���� ""�������"" ��� ��������� ����� ������.", 20, 35, 450, 20)
GUICtrlSetTip(-1, "���� ����� ����� ���� ""��������� ��������"", �� ����� ��� ������ �� ������ � �������� ������")

$i = 1
$typeall = ''
While 1
	$i += 1
	$Tmp = RegEnumKey('HKCR', $i)
	If Not @error And StringLeft($Tmp, 1) = '.' Then
		RegRead('HKCR\' & $Tmp & '\ShellNew', 'NullFile')
		If @error Then
			RegRead('HKCR\' & $Tmp & '\ShellNew', 'FileName')
			If Not @error Then $typeall &= StringTrimLeft($Tmp, 1) & '|'
		Else
			$typeall &= StringTrimLeft($Tmp, 1) & '|'
		EndIf
	Else
		ExitLoop
	EndIf
WEnd
RegRead('HKCR\.doc\Word.Document\ShellNew', 'NullFile')
If Not @error Then $typeall &= 'doc0|'
RegRead('HKCR\.doc\Word.Document.1\ShellNew', 'NullFile')
If Not @error Then $typeall &= 'doc1|'
RegRead('HKCR\.doc\Word.Document.6\ShellNew', 'NullFile')
If Not @error Then $typeall &= 'doc6|'
RegRead('HKCR\.doc\Word.Document.8\ShellNew', 'NullFile')
If Not @error Then $typeall &= 'doc8|'
RegRead('HKCR\.docx\Word.Document.12\ShellNew', 'NullFile')
If Not @error Then $typeall &= 'docx|'
RegRead('HKCR\.ppt\PowerPoint.Show.4\ShellNew', 'NullFile')
If Not @error Then $typeall &= 'ppt4|'
RegRead('HKCR\.ppt\PowerPoint.Show.8\ShellNew', 'NullFile')
If Not @error Then $typeall &= 'ppt8|'
RegRead('HKCR\.pptx\PowerPoint.Show.12\ShellNew', 'NullFile')
If Not @error Then $typeall &= 'pptx|'
RegRead('HKCR\.xls\Excel.Sheet.5\ShellNew', 'NullFile')
If Not @error Then $typeall &= 'xls5|'
RegRead('HKCR\.xls\Excel.Sheet.8\ShellNew', 'NullFile')
If Not @error Then $typeall &= 'xls8|'
RegRead('HKCR\.xlsx\Excel.Sheet.12\ShellNew', 'NullFile')
If Not @error Then $typeall &= 'xlsx|'
$typeall = StringTrimRight($typeall, 1)

; $typeall="3dg|ais|au3|bmp|doc|docx|egc|fxp|ppt|pptx|psd|rar|rsnp|rtf|slg|tpp|wav|xls|xlsx|zip|bfc|cmd|reg|ini"
$aType = StringSplit($typeall, "|")
Dim $a2Type[ $aType[0]+1 ][2] = [[ $aType[0] ]]
For $i = 1 To $aType[0]
	Switch $i
		Case 1 To 10
			$pos = $i * 20 + 40
			$pos_L = 10
		Case 11 To 20
			$pos_L = 90
			$pos = $i * 20 - 160
		Case 21 To 30
			$pos_L = 170
			$pos = $i * 20 - 360
		Case 31 To 40
			$pos_L = 250
			$pos = $i * 20 - 560
	EndSwitch
	$a2Type[$i][0] = $aType[$i]
	$a2Type[$i][1] = GUICtrlCreateCheckbox($aType[$i], $pos_L, $pos, 70, 20)
	If $aType[$i]<>'txt' Then GUICtrlSetState(-1, 1) ; ���������� �����
Next

GUICtrlCreateLabel("�������" & @CRLF & "�������������" & @CRLF & "����������", 390, 120, 99, 56)
$Ltype = GUICtrlCreateInput("", 390, 170, 44, 20)

$checkall1 = GUICtrlCreateCheckbox("���/���� ���", 390, 220, 99, 22)
GUICtrlSetTip(-1, "������/��������� �������" & @CRLF & "�� ���� �������")
$vkladka02Cr = GUICtrlCreateButton("�������", 390, 250, 93, 24)
GUICtrlSetTip(-1, '������� ��������� � ���� �����'&@CRLF&'�� ��� ���� ����� ����������'&@CRLF&'� ������ ������ ����� �����')
$vkladka02 = GUICtrlCreateButton("�������", 390, 280, 93, 24)
GUICtrlSetTip(-1, "������� ����������")

;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
$tab2 = GUICtrlCreateTabItem("������") ; ��� �������
GUICtrlCreateLabel("������ �����", 30, 40, 450, 20)
$checkCN101 = GUICtrlCreateRadio("Autorun.inf - ��� ������������ (hdd/cd - ��������)", 20, 60, 450, 20)
GUICtrlSetState(-1, 1)
$checkCN102 = GUICtrlCreateRadio("Autorun.inf - �������� ��", 20, 80, 450, 20)
$checkCN103 = GUICtrlCreateRadio("Autorun.inf - ��������� ��", 20, 100, 450, 20)
$vkladka03 = GUICtrlCreateButton("���������", 390, 280, 93, 24)

;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
$tab3 = GUICtrlCreateTabItem("    ?") ; ��� �������
GUICtrlCreateLabel("� TweakerXP.ini ����� ������� ��������� (url, ��������� ���...)", 30, 40, 450, 20)

GUICtrlCreateLabel("AZJIO 24.8.2009", 380, 280, 97, 22)

GUICtrlCreateTabItem("") ; ����� �������
;===========================================================
; (2) ���������� ������� ���������� (���� ���������), �������� OS, ��� ��������� ������� �������
Switch @OSVersion
	Case 'WIN_2000', 'WIN_XP', 'WIN_2003'
		$Part = 10
	Case Else
		$Part = 11
EndSwitch
$Color = _WinAPI_GetThemeColor($hTab, 'TAB', $Part, 1, 0x0EED)
If Not @error Then
	For $i = 1 To $a2Type[0][0]
		GUICtrlSetBkColor($a2Type[$i][1], $Color)
	Next
	For $i = 1 To 10
		GUICtrlSetBkColor($aCheck0[$i], $Color)
	Next
	GUICtrlSetBkColor($checkall0, $Color)
	GUICtrlSetBkColor($checkall1, $Color)
	GUICtrlSetBkColor($checkCN101, $Color)
	GUICtrlSetBkColor($checkCN102, $Color)
	GUICtrlSetBkColor($checkCN103, $Color)
	GUICtrlSetBkColor($checkCN501, $Color)
	GUICtrlSetBkColor($checkCN601, $Color)
	GUICtrlSetBkColor($checkCN602, $Color)
EndIf
;===========================================================
GUISetState()

While 1
	Switch GUIGetMsg()
		Case $restart
			_restart()
		Case $openini
			ShellExecute($Ini)
		Case $vkladka01
			;�������� ��������� � ���������� ������ �� ������� 1
			If GUICtrlRead($aCheck0[1]) = 1 Then
				RegWrite("HKCR\batfile\shell\edit\command", "", "REG_SZ", $notepad & ' %1')
				RegWrite("HKCR\cmdfile\shell\edit\command", "", "REG_SZ", $notepad & ' %1')
				RegWrite("HKCR\htmlfile\shell\Edit\command", "", "REG_SZ", $notepad & ' %1')
				RegWrite("HKCR\regfile\shell\edit\command", "", "REG_SZ", $notepad & ' %1')
				RegWrite("HKCR\txtfile\shell\edit\command", "", "REG_SZ", $notepad & ' %1')
				GUICtrlSetState($aCheck0[1], 132)
			EndIf
			If GUICtrlRead($aCheck0[2]) = 1 Then
				RegWrite("HKLM\SOFTWARE\Microsoft\Internet Explorer\View Source Editor\Editor Name", "", "REG_SZ", $notepad)
				GUICtrlSetState($aCheck0[2], 132)
			EndIf
			If GUICtrlRead($aCheck0[3]) = 1 Then
				RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer", "link", "REG_BINARY", 0x00000000)
				GUICtrlSetState($aCheck0[3], 132)
			EndIf
			If GUICtrlRead($aCheck0[4]) = 1 Then
				RegWrite("HKCR\Folder\shell\opennew", "", "REG_SZ", '������� � ����� ����')
				RegWrite("HKCR\Folder\shell\opennew", "BrowserFlags", "REG_DWORD", '10')
				RegWrite("HKCR\Folder\shell\opennew", "ExplorerFlags", "REG_DWORD", '33')
				RegWrite("HKCR\Folder\shell\opennew\command", "", "REG_EXPAND_SZ", '%SystemRoot%\Explorer.exe /idlist,%I,%L" & @lf & "')
				RegWrite("HKCR\Folder\shell\opennew\ddeexec", "", "REG_SZ", '[ViewFolder("%l", %I, %S)]')
				RegWrite("HKCR\Folder\shell\opennew\ddeexec", "NoActivateHandler", "REG_SZ", '')
				RegWrite("HKCR\Folder\shell\opennew\ddeexec\application", "", "REG_SZ", 'Folders')
				RegWrite("HKCR\Folder\shell\opennew\ddeexec\ifexec", "", "REG_SZ", '[]')
				RegWrite("HKCR\Folder\shell\opennew\ddeexec\topic", "", "REG_SZ", 'AppProperties')
				GUICtrlSetState($aCheck0[4], 132)
			EndIf
			If GUICtrlRead($aCheck0[5]) = 1 Then
				RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer", "StartmenuLogoff", "REG_DWORD", '1')
				GUICtrlSetState($aCheck0[5], 132)
			EndIf
			If GUICtrlRead($aCheck0[6]) = 1 Then
				For $i = 1 To $URL[0]
					RegWrite("HKCU\Software\Microsoft\Internet Explorer\TypedURLs", "url" & $i, "REG_SZ", $URL[$i])
				Next
				GUICtrlSetState($aCheck0[6], 132)
			EndIf
			If GUICtrlRead($aCheck0[7]) = 1 Then
				$PlacesBar = "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\comdlg32\PlacesBar"
				RegWrite($PlacesBar, "Place0", "REG_SZ", $Inigpl0)
				RegWrite($PlacesBar, "Place1", "REG_SZ", $Inigpl1)
				RegWrite($PlacesBar, "Place2", "REG_SZ", $Inigpl2)
				RegWrite($PlacesBar, "Place3", "REG_SZ", $Inigpl3)
				RegWrite($PlacesBar, "Place4", "REG_SZ", $Inigpl4)
				GUICtrlSetState($aCheck0[7], 132)
			EndIf
			If GUICtrlRead($aCheck0[8]) = 1 Then
				$aPrint = StringSplit("reg|txt|log|cmd|bat|fon|inf|ini", "|")
				For $i = 1 To $aPrint[0]
					RegDelete('HKCR\' & $aPrint[$i] & 'file\shell\print')
				Next
				GUICtrlSetState($aCheck0[8], 132)
			EndIf
			If GUICtrlRead($aCheck0[9]) = 1 Then
				RegWrite("HKLM\SYSTEM\CurrentControlSet\Control\Session Manager", "BootExecute", "REG_EXPAND_SZ", 'autocheck autochk /K:CDEFGHIJKLMNOPQRSTUVWXYZ *')
				GUICtrlSetState($aCheck0[9], 132)
			EndIf
			If GUICtrlRead($aCheck0[10]) = 1 Then
				RegWrite("HKCU\Software\Microsoft\Windows\ShellNoRoam\MUICache", "@C:\WINDOWS\system32\notepad.exe,-469", "REG_SZ", GUICtrlRead($crtextfl))
				GUICtrlSetState($aCheck0[10], 132)
			EndIf

			; ��������/�������� ��������� ���� �� ������� 1 - �����
		Case $checkall0
				$p = GUICtrlRead($checkall0)
			For $i = 1 To 10
				GUICtrlSetState($aCheck0[$i], $p)
			Next
		Case $tabBut04
			RegDelete("HKCR\Folder\shell\opennew")
		Case $tabBut07
			RegDelete("HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\comdlg32\PlacesBar")
		Case $tabBut09
			RegWrite("HKLM\SYSTEM\CurrentControlSet\Control\Session Manager", "BootExecute", "REG_EXPAND_SZ", 'autocheck autochk *')

			; �������� � ��� "�������" ��������� ����� ������ �� ������� New *.*
		Case $vkladka02
			For $i = 1 To $a2Type[0][0]
				If GUICtrlRead($a2Type[$i][1]) = 1 Then
					Switch $a2Type[$i][0]
						Case 'doc', 'doc0', 'doc1', 'doc6', 'doc8'
							RegDelete("HKCR\.doc\Word.Document.8\ShellNew")
							RegDelete("HKCR\.doc\Word.Document.6\ShellNew")
							RegDelete("HKCR\.doc\Word.Document.1\ShellNew")
							RegDelete("HKCR\.doc\WordDocument\ShellNew")
							RegDelete('HKCR\.doc\ShellNew')
						Case 'docx'
							RegDelete("HKCR\.docx\Word.Document.12\ShellNew")
						Case 'ppt', 'ppt4', 'ppt8'
							RegDelete("HKCR\.ppt\PowerPoint.Show.4\ShellNew")
							RegDelete("HKCR\.ppt\PowerPoint.Show.8\ShellNew")
						Case 'pptx'
							RegDelete("HKCR\.pptx\PowerPoint.Show.12\ShellNew")
						Case 'xls', 'xls5', 'xls8'
							RegDelete("HKCR\.xls\Excel.Sheet.5\ShellNew")
							RegDelete("HKCR\.xls\Excel.Sheet.8\ShellNew")
							RegDelete("HKCR\.xls\ExcelWorksheet\ShellNew")
						Case 'xlsx'
							RegDelete("HKCR\.xlsx\Excel.Sheet.12\ShellNew")
						Case Else
							RegDelete('HKCR\.' & $a2Type[$i][0] & '\ShellNew')
					EndSwitch
					GUICtrlSetState($a2Type[$i][1], $GUI_UNCHECKED+$GUI_DISABLE)
				EndIf
			Next
			$tmp = GUICtrlRead($Ltype)
			If $tmp Then RegDelete('HKCR\.' & $tmp & '\ShellNew')

			;�������������� � ��� "�������" ��������� ����� ������ �� ������� New *.*
		Case $vkladka02Cr
			$tmp = GUICtrlRead($Ltype)
			If Not $tmp Then ContinueLoop
			RegRead('HKCR\.' & $tmp, '')
			If @error Then
				MsgBox(0, "���������", '��� ����� ' & $tmp & ' �� ���������������')
				ContinueLoop
			Else
				Switch $tmp
					Case 'doc'
						RegWrite('HKCR\.doc\Word.Document.8\ShellNew', 'NullFile', 'REG_SZ', '')
						RegWrite('HKCR\.doc\Word.Document.6\ShellNew', 'NullFile', 'REG_SZ', '')
						RegWrite('HKCR\.doc\Word.Document.1\ShellNew', 'NullFile', 'REG_SZ', '')
						RegWrite('HKCR\.doc\WordDocument\ShellNew', 'NullFile', 'REG_SZ', '')
						RegWrite('HKCR\.doc\ShellNew')
					Case 'docx'
						RegWrite('HKCR\.docx\Word.Document.12\ShellNew', 'NullFile', 'REG_SZ', '')
					Case 'ppt'
						RegWrite('HKCR\.ppt\PowerPoint.Show.4\ShellNew', 'NullFile', 'REG_SZ', '')
						RegWrite('HKCR\.ppt\PowerPoint.Show.8\ShellNew', 'NullFile', 'REG_SZ', '')
					Case 'pptx'
						RegWrite('HKCR\.pptx\PowerPoint.Show.12\ShellNew', 'NullFile', 'REG_SZ', '')
					Case 'xls'
						RegWrite('HKCR\.xls\Excel.Sheet.5\ShellNew', 'NullFile', 'REG_SZ', '')
						RegWrite('HKCR\.xls\Excel.Sheet.8\ShellNew', 'NullFile', 'REG_SZ', '')
						RegWrite('HKCR\.xls\ExcelWorksheet\ShellNew', 'NullFile', 'REG_SZ', '')
					Case 'xlsx'
						RegWrite('HKCR\.xlsx\Excel.Sheet.12\ShellNew', 'NullFile', 'REG_SZ', '')
					Case Else
						RegWrite('HKCR\.' & $tmp & '\ShellNew', 'NullFile', 'REG_SZ', '')
				EndSwitch
			EndIf

			; ��������/�������� ��������� ���� �� ������� "New *.*"
		Case $checkall1
			$p = GUICtrlRead($checkall1)
			For $i = 1 To $a2Type[0][0]
				GUICtrlSetState($a2Type[$i][1], $p)
			Next

			; ������� "������"
		Case $vkladka03
			If GUICtrlRead($checkCN101) = 1 Then
				RegWrite("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\Explorer", "NoDriveTypeAutoRun", "REG_DWORD", '245')
				RegDelete("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\CancelAutoplay\Files", "*.*")
				RegDelete("HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\IniFileMapping\Autorun.inf", "")
				RegWrite("HKLM\SYSTEM\CurrentControlSet\Services\Cdrom", "AutoRun", "REG_DWORD", '1')
				RegWrite("HKLM\SYSTEM\ControlSet001\Services\Cdrom", "AutoRun", "REG_DWORD", '1')
			EndIf
			; �������� ��� ��������
			If GUICtrlRead($checkCN102) = 1 Then
				RegWrite("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\Explorer", "NoDriveTypeAutoRun", "REG_DWORD", '0')
				RegDelete("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\CancelAutoplay\Files", "*.*")
				RegDelete("HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\IniFileMapping\Autorun.inf", "")
				RegWrite("HKLM\SYSTEM\CurrentControlSet\Services\Cdrom", "AutoRun", "REG_DWORD", '1')
				RegWrite("HKLM\SYSTEM\ControlSet001\Services\Cdrom", "AutoRun", "REG_DWORD", '1')
			EndIf
			; ��������� ��� ��������
			If GUICtrlRead($checkCN103) = 1 Then
				RegWrite("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\Explorer", "NoDriveTypeAutoRun", "REG_DWORD", '255')
				RegWrite("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\CancelAutoplay\Files", "*.*", "REG_SZ", '')
				RegWrite("HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\IniFileMapping\Autorun.inf", '', "REG_SZ", '@SYS:DoesNotExist')
				RegWrite("HKLM\SYSTEM\CurrentControlSet\Services\Cdrom", "AutoRun", "REG_DWORD", '1') ; � 0 ������� ������, CD ���� ����� ����� �� ����� ��������� ����������
				RegWrite("HKLM\SYSTEM\ControlSet001\Services\Cdrom", "AutoRun", "REG_DWORD", '1')
			EndIf

			; ������ ������� User
		Case $UserButRm
			$usersprofiles01 = GUICtrlRead($usersprofiles)
			$bykva01 = StringLeft(GUICtrlRead($bykva), 1)
			$PathUP = $bykva01 & ':\MyDocum\Profiles\' & $usersprofiles01
			MsgBox(0, "�������", '����� ���� � ������ ������������ ����� � ������, ���� ��� ���������� ����� �: ������ ����� ��������������, ������� ��� �������������� �������� ���������� ����� �, � ��� ����� � "��� ���������", ����� �� ������� �����, ������ � ����� ���������, Cookies - ����������� �� ������. ����� �� �������� ���� ����� ������ ��������� �������� ������������ �� ������ ���������� ����� D, � ����������� ���� � ������. �������� ��������� �������������' & @LF & '��� ���� � ������� ���������' & @LF & '��� ��������� - ' & $bykva01 & ':\��� ���������' & @LF & 'TEMP � TMP - ' & $PathUP & '\Temp' & @LF & 'Cookies - ' & $PathUP & '\Cookies' & @LF & '������� ���� - ' & $PathUP & '\������� ����' & @LF & '��������� - ' & $PathUP & '\���������' & @LF & 'SendTo - ' & $PathUP & '\SendTo' & @LF & 'Temporary Internet Files - ' & $PathUP & '\Temporary Internet Files' & @LF & 'History - ' & $PathUP & '\History' & @LF & '������� ���� ��� ���� - ' & $PathUP & '\������� ���� 2')
		Case $vkladka011
			$usersprofiles01 = GUICtrlRead($usersprofiles)
			$bykva01 = StringLeft(GUICtrlRead($bykva), 1)
			If Not FileExists($bykva01&':\') Or StringRegExp($usersprofiles01, '[/:*?"<>|]') Then
				MsgBox(0, '���������', '�������� ����� ����� ��� ��� ������� �������� ������������ ������� /:*?"<>|')
				ContinueLoop
			EndIf
			$PathUP = $bykva01 & ':\MyDocum\Profiles\' & $usersprofiles01
			; �������� ���������
			If Not FileExists($bykva01 & ':\��� ���������') Then DirCreate($bykva01 & ':\��� ���������')
			If Not FileExists($PathUP & '\Temp') Then DirCreate($PathUP & '\Temp')
			If Not FileExists($PathUP & '\������� ����') Then DirCreate($PathUP & '\������� ����')
			If Not FileExists($PathUP & '\���������') Then DirCreate($PathUP & '\���������')
			If Not FileExists($PathUP & '\SendTo') Then DirCreate($PathUP & '\SendTo')
			If Not FileExists($PathUP & '\Temporary Internet Files') Then DirCreate($PathUP & '\Temporary Internet Files')
			If Not FileExists($PathUP & '\History') Then DirCreate($PathUP & '\History')
			If Not FileExists($PathUP & '\������� ���� 2') Then DirCreate($PathUP & '\������� ���� 2')
			; �������� ���� � �������
			RegWrite("HKCU\Environment", "TEMP", "REG_EXPAND_SZ", $PathUP & '\Temp')
			RegWrite("HKCU\Environment", "TMP", "REG_EXPAND_SZ", $PathUP & '\Temp')
			RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders", "Personal", "REG_SZ", $bykva01 & ':\��� ���������')
			RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders", "Cookies", "REG_SZ", $PathUP & '\Cookies')
			RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders", "Desktop", "REG_SZ", $PathUP & '\������� ����')
			RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders", "Favorites", "REG_SZ", $PathUP & '\���������')
			RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders", "SendTo", "REG_SZ", $PathUP & '\SendTo')
			RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders", "Cache", "REG_SZ", $PathUP & '\Temporary Internet Files')
			RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders", "History", "REG_SZ", $PathUP & '\History')

			RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders", "Personal", "REG_SZ", $bykva01 & ':\��� ���������')
			RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders", "Desktop", "REG_EXPAND_SZ", $PathUP & '\������� ����')
			RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders", "Favorites", "REG_EXPAND_SZ", $PathUP & '\���������')
			RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders", "SendTo", "REG_EXPAND_SZ", $PathUP & '\SendTo')
			RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders", "Cache", "REG_EXPAND_SZ", $PathUP & '\Temporary Internet Files')
			RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders", "Cookies", "REG_EXPAND_SZ", $PathUP & '\Cookies')
			RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders", "History", "REG_EXPAND_SZ", $PathUP & '\History')
			RegWrite("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders", "Common Desktop", "REG_SZ", $PathUP & '\������� ���� 2')
			RegWrite("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders", "Common Desktop", "REG_SZ", $PathUP & '\������� ���� 2')
			RegWrite("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Cache\Paths", "Directory", "REG_SZ", $PathUP & '\Temporary Internet Files\Content.IE5')
			RegWrite("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Cache\Paths\path1", "CachePath", "REG_SZ", $PathUP & '\Temporary Internet Files\Content.IE5\Cache1')
			RegWrite("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Cache\Paths\path2", "CachePath", "REG_SZ", $PathUP & '\Temporary Internet Files\Content.IE5\Cache2')
			RegWrite("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Cache\Paths\path3", "CachePath", "REG_SZ", $PathUP & '\Temporary Internet Files\Content.IE5\Cache3')
			RegWrite("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\Cache\Paths\path4", "CachePath", "REG_SZ", $PathUP & '\Temporary Internet Files\Content.IE5\Cache4')
			If GUICtrlRead($checkCN501) = 1 Then
				FileCreateShortcut(@WindowsDir & '\explorer.exe', @AppDataDir & '\Microsoft\Internet Explorer\Quick Launch\��� ���������.lnk', @WindowsDir, @MyDocumentsDir, '��� ���������', @SystemDir & '\SHELL32.dll', '', 126)
				If Not FileExists($bykva01 & ':\�������') Then DirCreate($bykva01 & ':\�������')
				If Not FileExists($bykva01 & ':\������') Then DirCreate($bykva01 & ':\������')
				If Not FileExists($bykva01 & ':\������') Then DirCreate($bykva01 & ':\������')
				If Not FileExists($bykva01 & ':\Games') Then DirCreate($bykva01 & ':\Games')
				FileCreateShortcut(@WindowsDir & '\explorer.exe', @AppDataDir & '\Microsoft\Internet Explorer\Quick Launch\�������.lnk', @WindowsDir, $bykva01 & ':\�������', '�������', @SystemDir & '\SHELL32.dll', '', 127)
				FileCreateShortcut(@WindowsDir & '\explorer.exe', @AppDataDir & '\Microsoft\Internet Explorer\Quick Launch\������.lnk', @WindowsDir, $bykva01 & ':\������', '������', @SystemDir & '\SHELL32.dll', '', 128)
				FileCreateShortcut(@WindowsDir & '\explorer.exe', @AppDataDir & '\Microsoft\Internet Explorer\Quick Launch\������.lnk', @WindowsDir, $bykva01 & ':\������', '������', @SystemDir & '\SHELL32.dll', '', 129)
			EndIf
		Case $vkladka601
			; ������� ������� "����", "����������".
			If GUICtrlRead($checkCN601) = 1 Then
				FileCreateShortcut(@SystemDir & '\shutdown.exe', @DesktopDir & '\��������.lnk', @SystemDir, '-r -t 00 -f', '������������ ����������', @SystemDir & '\SHELL32.dll', '', 44)
				FileCreateShortcut(@SystemDir & '\shutdown.exe', @DesktopDir & '\����.lnk', @SystemDir, '-s -t 00 -f', '���������� ����������', @SystemDir & '\SHELL32.dll', '', 27)
				GUICtrlSetState($checkCN601, 4)
			EndIf
			If GUICtrlRead($checkCN602) = 1 Then
				$Path = FileGetLongName(StringRegExpReplace(@TempDir, '(^.*)\\(.*)$', '\1'))
				$TempFile = FileOpen($Path & '\CleanTemp.cmd', 2)
				FileWrite($TempFile, 'cd /d "%temp%" && rd /s /q "."')
				FileClose($TempFile)
				FileCreateShortcut('"' & $Path & '\CleanTemp.cmd"', @DesktopDir & '\�������� Temp.lnk', $Path, '', '�������� ����� Temp, ������ ��������� �����. ��������� ��� �������� ����������', @SystemDir & '\cleanmgr.exe', '', 0)
				GUICtrlSetState($checkCN602, 4)
			EndIf
		Case $btnLNK
			ShellExecute(@AppDataDir & '\Microsoft\Internet Explorer\Quick Launch')
		Case $bykvaLNK
			$b0=GUICtrlRead($bykvaLNK)
			Switch $b0
				Case 'A', 'B', 'C', 'D', 'E', 'F'
					FileCreateShortcut(@WindowsDir & '\explorer.exe', @AppDataDir & '\Microsoft\Internet Explorer\Quick Launch\���� '&$b0&'.lnk', @WindowsDir, $b0&':\', '', $sIcoPath&'\Drive.dll', '', Asc($b0)-65)
				Case 'X'
					FileCreateShortcut(@WindowsDir & '\explorer.exe', @AppDataDir & '\Microsoft\Internet Explorer\Quick Launch\���� '&$b0&'.lnk', @WindowsDir, $b0&':\', '', $sIcoPath&'\Drive.dll', '',6)
				Case 'cd1'
					$value = InputBox("CD,DVD-ROM", "������� ����� �������.", "", " M1", 170, 130)
					If Not @error And StringRegExp($value,'[a-zA-Z]') Then FileCreateShortcut(@WindowsDir & '\explorer.exe', @AppDataDir & '\Microsoft\Internet Explorer\Quick Launch\CD,DVD-ROM, ���� '&StringUpper($value)&'.lnk', @WindowsDir, StringUpper($value)&':\', '', $sIcoPath&'\Drive.dll', '', 7)
				Case 'cd2'
					$value = InputBox("CD,DVD-ROM", "������� ����� �������.", "", " M1", 170, 130)
					If Not @error And StringRegExp($value,'[a-zA-Z]') Then FileCreateShortcut(@WindowsDir & '\explorer.exe', @AppDataDir & '\Microsoft\Internet Explorer\Quick Launch\CD,DVD-ROM, ���� '&StringUpper($value)&'.lnk', @WindowsDir, StringUpper($value)&':\', '', $sIcoPath&'\Drive.dll', '', 8)
				Case 'fsh'
					$value = InputBox("Flash", "������� ����� ������.", "", " M1", 170, 130)
					If Not @error And StringRegExp($value,'[a-zA-Z]') Then FileCreateShortcut(@WindowsDir & '\explorer.exe', @AppDataDir & '\Microsoft\Internet Explorer\Quick Launch\Flash, ���� '&StringUpper($value)&'.lnk', @WindowsDir, StringUpper($value)&':\', '', $sIcoPath&'\Drive.dll', '', 9)
			EndSwitch
		Case -3
			Exit
	EndSwitch
WEnd

Func _restart()
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

; Func _ComboBox_SetDrive($i_ID_Combo, $SelectDrive = 'C')
	; Local $aDrives = DriveGetDrive('all'), $dr = 1, $Type, $i, $list = ''
	; For $i = 1 To $aDrives[0]
		; $Type = DriveGetType($aDrives[$i] & '\')
		; If $Type = 'Removable' Then $Type = 'Rem'
		; If $aDrives[$i] <> 'A:' And $Type <> 'CDROM' Then $list &= '|' & StringUpper($aDrives[$i]) & ' (' & $Type & ')'
		; If $aDrives[$i] = $SelectDrive & ':' Then $dr = StringUpper($aDrives[$i]) & ' (' & $Type & ')'
	; Next
	; GUICtrlSetData($i_ID_Combo, $list, $dr)
; EndFunc

Func _ComboBox_SetDrive($i_ID_Combo, $SelectDrive = 'C')
	Local $aDrives = DriveGetDrive('all'), $Current, $Type, $i, $list = '', $sString
	For $i = 1 To $aDrives[0]
		$Type = DriveGetType($aDrives[$i] & '\')

		If $aDrives[$i] = 'A:' Or  $Type = 'CDROM' Then ContinueLoop
		If $Type = 'Removable' Then $Type = 'Rem'
		$sLabel = DriveGetLabel($aDrives[$i] & '\')
		If StringLen($sLabel)>15 Then $sLabel = StringLeft($sLabel, 12) & '...'

		$sString = StringFormat("%-2s %-5s %-15s %-5s %9.03f Gb", StringUpper($aDrives[$i]), $Type, $sLabel, DriveGetFileSystem($aDrives[$i] & '\'), DriveSpaceTotal($aDrives[$i] & '\') / 1024)
		$list &= '|' & $sString
		If $aDrives[$i] = $SelectDrive & ':' Then $Current = $sString
	Next
	GUICtrlSetData($i_ID_Combo, $list, $Current)
EndFunc

;===========================================================
; (3) ���������� ������� ����������, ������������ ��� (�������� �� �����) �������, ������������� �� WinAPIEx.au3 ("Global $__RGB = True" - ��� �� �����)
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
EndFunc
;===========================================================