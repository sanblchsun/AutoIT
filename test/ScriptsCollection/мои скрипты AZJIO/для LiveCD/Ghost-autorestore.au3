;  @AZJIO
#NoTrayIcon

FileChangeDir(@ScriptDir)

Global $Ini = @ScriptDir & '\ghost_auto.ini', $sWinTitleRE = '[CLASS:GhostScreen]'

If FileExists('B:\ghost_auto.ini') Then $Ini = 'B:\ghost_auto.ini'

If Not FileExists($Ini) And MsgBox(4, "���������", "������ ������� ����������� ghost_auto.ini ��� ����������� �������� ���������?") = 6 Then IniWriteSection($Ini, "Ghost", 'dsk="1:1"' & @LF & 'gho="1:2"' & @LF & 'Path2="\SYS\ImageHDD\myhdd.gho"')

$dsk = IniRead($Ini, "Ghost", "dsk", "1:1")
$gho = IniRead($Ini, "Ghost", "gho", "1:2")
$Path5 = IniRead($Ini, "Ghost", "Path2", "\SYS\ImageHDD\myhdd.gho")

GUICreate("!!! - ������ - !!!", 600, 400)

GUISetFont(12, 300)
$Attention = GUICtrlCreateLabel("��������!", 260, 8, 320, 22)
GUICtrlSetColor(-1, 0xff0000)
GUICtrlSetFont(-1, 15)
$read = GUICtrlCreateLabel("     ���� ��� �� ������������ � ������� �������������� ��� �������� ���������� ��� �� �������� ��������� ���� ������, �� �������� ��� ����. ��� ������� ������ �������������� � ��� ������� ������������� ������ ��� �������������� ��������� ����������� ����������� ������ �� ���� C: � ������ ������������ ������ �� ����� C:." & @CRLF & "     ���� �� ������� ������������ ������������ ������� �� ������, �� ����� ��������������� ����� ��������� ������ ����� �� ����� �: � ��������� �� �� ���� D:, ������ ����� ����� ������ ������ ��������������." & @CRLF & "     ��� ������� �������������� �������� ������ ��������� ����������� ������, �� ��������� �������� ���������� ���� � �������� Reset (�������������) � Continue (����������), �������� Reset � ����������� � ��������������� ������������ �������." & @CRLF & "     ��� ����������� ������ ������ ��������� ������ �������������. �������������� ������ �������������� - ������� ����� � ��������� ����������, ������������ �������������� ��������� �������� �� ����� C:.", 10, 35, 580, 282)
$iContMenu = GUICtrlCreateContextMenu($read)
$iGhost_Auto_ini = GUICtrlCreateMenuItem("���������� ghost_auto.ini", $iContMenu)
$iReadme = GUICtrlCreateMenuItem("��������� � ��������������", $iContMenu)
$iStartGhost = GUICtrlCreateMenuItem("����� Ghost32", $iContMenu)

$iRestore = GUICtrlCreateButton("�������������� Windows XP �� ������", 135, 325, 330, 45)
GUICtrlSetTip(-1, "!!! ������ !!! ������������������" & @LF & "�� ������ � ����-�������� ����� D" & @LF & "��������� � ghost_auto.ini")
GUICtrlSetFont(-1, 13)

GUISetState()
While 1
	Switch GUIGetMsg()
		Case $iRestore
			ShellExecute(@ScriptDir & '\ghost32.exe', '-clone,mode=pload,src=' & $gho & $Path5 & ':1,dst=' & $dsk & ' -sure', '', '', @SW_HIDE)
		Case $iGhost_Auto_ini
			ShellExecute($Ini, "", @ScriptDir, "")
		Case $iReadme
			ShellExecute(@ScriptDir & '\autoreadme.txt', "", @ScriptDir, "")
		Case $iStartGhost
			If WinExists($sWinTitleRE) Then ; ���� ���� ����������, ��
				WinActivate($sWinTitleRE) ; ���������� ����
			Else ; �����
				Run(@ScriptDir & '\ghost32.exe -SPLIT=2048', '', @SW_HIDE) ; ��������� Ghost32
				$hWnd = WinWait($sWinTitleRE, '', 5) ; ������� ���� (������ ���������)
				If Not $hWnd Then
					MsgBox(4096, '���������', '�� ������� ��������� Ghost32, ��������� ������ �������')
					Exit
				EndIf
				If WinWaitActive($hWnd) Then ; ���� ���������, ��� ���� ��������, ��
					Send("{Enter}") ; �������� ������� ������
					Send("{RIGHT}")
					Send("{DOWN}")
					Send("{RIGHT}")
					Send("{DOWN}")
				EndIf
			EndIf
		Case -3
			Exit
	EndSwitch
WEnd