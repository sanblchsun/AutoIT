Global $Ini = @ScriptDir&'\inet.ini'
If FileExists('B:\inet.ini') Then Global $Ini = 'B:\inet.ini'
$login = IniRead ($Ini, "setinet", "login", "55tt44ee"); логин
$Passw = IniRead ($Ini, "setinet", "passw", "88nn33zz") ; пароль
$name_lnk = IniRead ($Ini, "setinet", "name_lnk", "inet") ; имя соединения, оно же имя ярлыка инета

If FileExists(@ScriptDir&'\rasphone.pbk') Then
FileCopy(@ScriptDir&'\rasphone.pbk', @AppDataCommonDir & '\Microsoft\Network\Connections\Pbk', 9)
else
If FileExists('C:\Documents and Settings\All Users\Application Data\Microsoft\Network\Connections\Pbk\rasphone.pbk') Then FileCopy('C:\Documents and Settings\All Users\Application Data\Microsoft\Network\Connections\Pbk\rasphone.pbk', @AppDataCommonDir & '\Microsoft\Network\Connections\Pbk', 9)
endif
ShellExecute ( @AppDataCommonDir & '\Microsoft\Network\Connections\Pbk\rasphone.pbk','','','open', @SW_HIDE )
WinWaitActive('Сетевые подключения - rasphone.pbk')
Send("{ENTER}")

WinWaitActive('Подключение: '&$name_lnk)
Send("{TAB 2}")
Send("{SPACE}")
ControlSend('Подключение: '&$name_lnk, "", "[CLASS:Edit; INSTANCE:1]", $login)
ControlSend('Подключение: '&$name_lnk, "", "[CLASS:Edit; INSTANCE:2]", $Passw)
Send("{ENTER}")