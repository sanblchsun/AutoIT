Global $Ini = @ScriptDir&'\inet.ini'
If FileExists('B:\inet.ini') Then Global $Ini = 'B:\inet.ini'
$login = IniRead ($Ini, "setinet", "login", "55tt44ee"); �����
$Passw = IniRead ($Ini, "setinet", "passw", "88nn33zz") ; ������
$name_lnk = IniRead ($Ini, "setinet", "name_lnk", "inet") ; ��� ����������, ��� �� ��� ������ �����

If FileExists(@ScriptDir&'\rasphone.pbk') Then
FileCopy(@ScriptDir&'\rasphone.pbk', @AppDataCommonDir & '\Microsoft\Network\Connections\Pbk', 9)
else
If FileExists('C:\Documents and Settings\All Users\Application Data\Microsoft\Network\Connections\Pbk\rasphone.pbk') Then FileCopy('C:\Documents and Settings\All Users\Application Data\Microsoft\Network\Connections\Pbk\rasphone.pbk', @AppDataCommonDir & '\Microsoft\Network\Connections\Pbk', 9)
endif
ShellExecute ( @AppDataCommonDir & '\Microsoft\Network\Connections\Pbk\rasphone.pbk','','','open', @SW_HIDE )
WinWaitActive('������� ����������� - rasphone.pbk')
Send("{ENTER}")

WinWaitActive('�����������: '&$name_lnk)
Send("{TAB 2}")
Send("{SPACE}")
ControlSend('�����������: '&$name_lnk, "", "[CLASS:Edit; INSTANCE:1]", $login)
ControlSend('�����������: '&$name_lnk, "", "[CLASS:Edit; INSTANCE:2]", $Passw)
Send("{ENTER}")