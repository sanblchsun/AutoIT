#NoTrayIcon
$keyExit="1" ; Если 1, тогда "ОК", если 0 или другое значение, тогда "Применить" по окончании скрипта.
$version=WinList("[REGEXPTITLE:PE Network Manager *]") ; тестировано на 0.56, PENetwork_Rus.lng не изменять иначе имя дочернего окна не совпадает.
$netexe = "PENetwork.exe" ;в RusLive PENetwork.exe; в к-ре 7sh3 RUN-NETCFG.CMD при условии неавтостарта сети.
Global $Ini = @ScriptDir&'\autonet.ini'
If FileExists('B:\autonet.ini') Then Global $Ini = 'B:\autonet.ini'
$name = IniRead ($Ini, "setnet", "name", "")


$dev = IniRead ($Ini, "setnet", "number_device", "")
$IP = IniRead ($Ini, "setnet", "IP", "")
$MS = IniRead ($Ini, "setnet", "MS", "")
$GW = IniRead ($Ini, "setnet", "GW", "")
$DNS1 = IniRead ($Ini, "setnet", "DNS1", "")
$DNS2 = IniRead ($Ini, "setnet", "DNS2", "")
$DNS3 = IniRead ($Ini, "setnet", "DNS3", "")

If ProcessExists ( "PENetwork.exe" )<>0 Then
    ProcessClose ( "PENetwork.exe" )
    ProcessWaitClose ( "PENetwork.exe" )
EndIf
Run($netexe)
WinWaitActive($version)
If @OSType="WIN32_NT" Then BlockInput ( 1 ) ;блокировать мышь и клавиатуру
If $dev=2 Then
Sleep(300)
Send("{TAB 2}")
Send("{RIGHT}")
EndIf

If $dev=3 Then
Sleep(300)
Send("{TAB 2}")
Send("{RIGHT 2}")
EndIf
$aIP = StringSplit($IP, ".")
$aMS = StringSplit($MS, ".")
$aGW = StringSplit($GW, ".")
$aDNS1 = StringSplit($DNS1, ".")
$aDNS2 = StringSplit($DNS2, ".")
$aDNS3 = StringSplit($DNS3, ".")
Sleep(300)
If $IP <> "" Then
ControlClick($version, "", "[CLASS:Button; INSTANCE:19]")
ControlSend($version, "", "[CLASS:Edit; INSTANCE:5]", $aIP[1])
ControlSend($version, "", "[CLASS:Edit; INSTANCE:4]", $aIP[2])
ControlSend($version, "", "[CLASS:Edit; INSTANCE:3]", $aIP[3])
ControlSend($version, "", "[CLASS:Edit; INSTANCE:2]", $aIP[4])
EndIf

If $MS <> "" Then
ControlSend($version, "", "[CLASS:Edit; INSTANCE:9]", $aMS[1])
ControlSend($version, "", "[CLASS:Edit; INSTANCE:8]", $aMS[2])
ControlSend($version, "", "[CLASS:Edit; INSTANCE:7]", $aMS[3])
ControlSend($version, "", "[CLASS:Edit; INSTANCE:6]", $aMS[4])
EndIf

If $GW <> "" Then
ControlSend($version, "", "[CLASS:Edit; INSTANCE:13]", $aGW[1])
ControlSend($version, "", "[CLASS:Edit; INSTANCE:12]", $aGW[2])
ControlSend($version, "", "[CLASS:Edit; INSTANCE:11]", $aGW[3])
ControlSend($version, "", "[CLASS:Edit; INSTANCE:10]", $aGW[4])
EndIf

If $DNS1 <> "" Then
ControlSend($version, "", "[CLASS:Edit; INSTANCE:17]", $aDNS1[1])
ControlSend($version, "", "[CLASS:Edit; INSTANCE:16]", $aDNS1[2])
ControlSend($version, "", "[CLASS:Edit; INSTANCE:15]", $aDNS1[3])
ControlSend($version, "", "[CLASS:Edit; INSTANCE:14]", $aDNS1[4])
EndIf

If $DNS2 <> "" Then
ControlClick($version, "", "[CLASS:Button; INSTANCE:28]")
Sleep(300)
ControlClick("DNS-адреса", "", "[CLASS:Button; INSTANCE:3]")
Sleep(300)

ControlSend("Добавить DNS-сервер-адрес", "", "[CLASS:Edit; INSTANCE:4]", $aDNS2[1])
ControlSend("Добавить DNS-сервер-адрес", "", "[CLASS:Edit; INSTANCE:3]", $aDNS2[2])
ControlSend("Добавить DNS-сервер-адрес", "", "[CLASS:Edit; INSTANCE:2]", $aDNS2[3])
ControlSend("Добавить DNS-сервер-адрес", "", "[CLASS:Edit; INSTANCE:1]", $aDNS2[4])

ControlClick("Добавить DNS-сервер-адрес", "", "[CLASS:Button; INSTANCE:1]")
Sleep(300)
ControlClick("DNS-адреса", "", "[CLASS:Button; INSTANCE:3]")
Sleep(300)

ControlSend("Добавить DNS-сервер-адрес", "", "[CLASS:Edit; INSTANCE:4]", $aDNS3[1])
ControlSend("Добавить DNS-сервер-адрес", "", "[CLASS:Edit; INSTANCE:3]", $aDNS3[2])
ControlSend("Добавить DNS-сервер-адрес", "", "[CLASS:Edit; INSTANCE:2]", $aDNS3[3])
ControlSend("Добавить DNS-сервер-адрес", "", "[CLASS:Edit; INSTANCE:1]", $aDNS3[4])

ControlClick("Добавить DNS-сервер-адрес", "", "[CLASS:Button; INSTANCE:1]")
Sleep(300)
ControlClick("DNS-адреса", "", "[CLASS:Button; INSTANCE:5]")
EndIf

Sleep(300)
If $keyExit="1" Then
ControlClick($version, "", "[CLASS:Button; INSTANCE:10]")
Else
ControlClick($version, "", "[CLASS:Button; INSTANCE:9]")
EndIf
BlockInput ( 0 ) ;разблокировать мышь и клавиатуру

Exit