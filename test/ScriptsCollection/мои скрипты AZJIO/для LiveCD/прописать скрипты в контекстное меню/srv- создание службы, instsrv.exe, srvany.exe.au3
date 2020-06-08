;  @AZJIO
; ��� ������ - ��� �����

If Not FileExists(@SystemDir & '\SRVANY.EXE') Or Not FileExists(@SystemDir & '\INSTSRV.EXE') Then
	MsgBox(0, "������", "�������� �������  ������ INSTSRV.EXE � SRVANY.EXE � %SystemRoot%\system32")
	Exit
EndIf
;���������� $sTarget ��������� ������������ ������ � ����������� ����
If Not $CmdLine[0] Then
	$SRV_FILE = FileOpenDialog("����� ����� *.exe, ������� ����� ������� ��� ������.", @ScriptDir & "", "exe-���� (*.exe)", 1 + 4)
	If @error Then Exit
Else
	$SRV_FILE = $CmdLine[1]
EndIf
$srv_naim = StringRegExpReplace($SRV_FILE, "(^.*)\\(.*)\.(.*)$", '\2')
$process = $srv_naim
; ������ ������ ����� ������, ����� ����������������, ����� �� ��������� �� ����� �����.
$srv_naim = InputBox("��� ������", "������ �������� ��� ������, ���� ��� ����������. ��� �������� ��������", $srv_naim, "", 260, 130)
If @error Or $srv_naim = '' Then
	MsgBox(0, "���������", '�������� ������ ��������.', 3)
	Exit
EndIf

$srvn = RegRead('HKLM\SYSTEM\CurrentControlSet\Services\' & $srv_naim, '')
If @error <> 1 Then
	MsgBox(0, "������", "������ � ����� ������ ��� ����������")
	Exit
EndIf
Run(@SystemDir & '\INSTSRV.EXE "' & $srv_naim & '" ' & @SystemDir & '\SRVANY.EXE', '', @SW_HIDE)
ProgressOn("�������� ������", $srv_naim, '', -1, -1, 18)
ProgressSet(50, "������ ������")
;RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\'&$srv_naim,'Type','REG_DWORD','272')
RegWrite('HKLM\SYSTEM\CurrentControlSet\Services\' & $srv_naim & '\Parameters', 'Application', 'REG_SZ', $SRV_FILE)
RegDelete('HKLM\SYSTEM\CurrentControlSet\Services\' & $srv_naim & '\Security')
RunWait(@ComSpec & ' /C NET START "' & $srv_naim & '"', '', @SW_HIDE)
ProgressOff()
If ProcessExists($process & '.exe') Then MsgBox(0, "���������", '������� ' & $process & ' �������.', 3)