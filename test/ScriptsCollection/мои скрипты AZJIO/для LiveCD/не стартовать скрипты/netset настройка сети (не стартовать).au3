;  @AZJIO
#NoTrayIcon
OnAutoItExitRegister('_Exit')
$keyExit = "0" ; 1 - "ОК", 0 или другое значение - "Применить" по окончании скрипта
$sTitle = "[REGEXPTITLE:PE .+? 0\.\d\d.*]" ; тестировано на 0.58, PENetwork_Rus.lng не изменять иначе имя дочернего окна не совпадает.
$exe = "PENetwork.exe" ;в RusLive PENetwork.exe; в к-ре 7sh3 RUN-NETCFG.CMD при условии неавтостарта сети.
$namewin = "Выбор файла конфигурации сети."
$DNS_adres = 'DNS-адреса'
$Add_DNS_adres = 'Добавить DNS-сервер-адрес'

$tmp = FileOpenDialog($namewin, @ScriptDir, "Конфиг (*.ini)", 1)
If @error Then Exit
Global $Ini = $tmp
$name = IniRead($Ini, "setnet", "name", "")

If $name = "Start" Then
	Run($exe)
	Exit
EndIf

If $name = "Cleaner1" Or $name = "Cleaner2" Or $name = "Cleaner3" Then
	$hWnd = _GetWnd()
	Sleep(300)
	BlockInput(1) ;блокировать мышь и клавиатуру
	If $name = "Cleaner2" Then
		Send("{TAB 2}")
		Send("{RIGHT}")
		Sleep(300)
	EndIf
	If $name = "Cleaner3" Then
		Send("{TAB 2}")
		Send("{RIGHT 2}")
		Sleep(300)
	EndIf
	ControlClick($hWnd, "", "[CLASS:Button; INSTANCE:19]")
	ControlClick($hWnd, "", "[CLASS:Button; INSTANCE:27]")
	ControlClick($hWnd, "", "[CLASS:Button; INSTANCE:29]")
	Sleep(300)
	If $keyExit = "1" Then
		ControlClick($hWnd, "", "[CLASS:Button; INSTANCE:10]")
	Else
		ControlClick($hWnd, "", "[CLASS:Button; INSTANCE:9]")
	EndIf
	BlockInput(0) ;разблокировать мышь и клавиатуру
	Exit
EndIf

Global $ctrl[4]

$dev = IniRead($Ini, "setnet", "number_device", "")
$IP = IniRead($Ini, "setnet", "IP", "")
$MS = IniRead($Ini, "setnet", "MS", "")
$GW = IniRead($Ini, "setnet", "GW", "")
$DNS1 = IniRead($Ini, "setnet", "DNS1", "")
$DNS2 = IniRead($Ini, "setnet", "DNS2", "")
$DNS3 = IniRead($Ini, "setnet", "DNS3", "")

$hWnd = _GetWnd()
BlockInput(1) ;блокировать мышь и клавиатуру
If $dev = 2 Then
	Sleep(300)
	Send("{TAB 2}")
	Send("{RIGHT}")
EndIf

If $dev = 3 Then
	Sleep(300)
	Send("{TAB 2}")
	Send("{RIGHT 2}")
EndIf
Sleep(300)
$aIP = StringSplit($IP, '.', 2)
If Not @error And UBound($aIP) = 4 Then
	ControlClick($hWnd, "", "[CLASS:Button; INSTANCE:19]")
	Dim $ctrl[4]= ['5', '4', '3', '2']
	_Send($ctrl, $aIP)
EndIf

$aMS = StringSplit($MS, '.', 2)
If Not @error And UBound($aMS) = 4 Then
	Dim $ctrl[4]= ['9', '8', '7', '6']
	_Send($ctrl, $aMS)
EndIf

$aGW = StringSplit($GW, '.', 2)
If Not @error And UBound($aGW) = 4 Then
	Dim $ctrl[4]= ['13', '12', '11', '10']
	_Send($ctrl, $aGW)
EndIf

$aDNS1 = StringSplit($DNS1, '.', 2)
If Not @error And UBound($aDNS1) = 4 Then
	Dim $ctrl[4]= ['17', '16', '15', '14']
	_Send($ctrl, $aDNS1)
EndIf

$aDNS2 = StringSplit($DNS2, '.', 2)
$aDNS3 = StringSplit($DNS3, '.', 2)
If $DNS2 And $DNS3 And UBound($aDNS2) = 4 And UBound($aDNS3) = 4 Then
	ControlClick($hWnd, "", "[CLASS:Button; INSTANCE:28]")
	Sleep(300)
	ControlClick($DNS_adres, "", "[CLASS:Button; INSTANCE:3]")
	Sleep(300)
	Dim $ctrl[4]= ['4', '3', '2', '1']
	_Send($ctrl, $aDNS2, $Add_DNS_adres)

	ControlClick($Add_DNS_adres, "", "[CLASS:Button; INSTANCE:1]")
	Sleep(300)
	ControlClick($DNS_adres, "", "[CLASS:Button; INSTANCE:3]")
	Sleep(300)

	Dim $ctrl[4]= ['4', '3', '2', '1']
	_Send($ctrl, $aDNS3, $Add_DNS_adres)

	ControlClick($Add_DNS_adres, "", "[CLASS:Button; INSTANCE:1]")
	Sleep(300)
	ControlClick($DNS_adres, "", "[CLASS:Button; INSTANCE:5]")
EndIf

Sleep(300)
If $keyExit = "1" Then
	ControlClick($hWnd, "", "[CLASS:Button; INSTANCE:10]")
Else
	ControlClick($hWnd, "", "[CLASS:Button; INSTANCE:9]")
EndIf

Func _Send($ctrl, $aDNS, $gui = $hWnd)
	For $i = 0 To 3
		ControlSend($gui, "", '[CLASS:Edit; INSTANCE:' & $ctrl[$i] & ']', $aDNS[$i])
	Next
EndFunc   ;==>_Send

Func _GetWnd()
	$iPID = ProcessExists($exe)
	If $iPID Then ;если существует процесс PENetwork.exe, то завершить его
		ProcessClose($iPID)
		If Not ProcessWaitClose($iPID, 3) Then _Error('ProcessClose')
	EndIf
	Run($exe)
	$hWnd = WinWait($sTitle, "", 5) ; без таймаута (5) ожидание бесконечно
	If Not $hWnd Then _Error('Окно не найдено')
	Return $hWnd
EndFunc   ;==>_GetWnd

Func _Error($msg)
	Exit MsgBox(4096, 'Ошибка', $msg & ', завершаем работу скрипта')
EndFunc   ;==>_Error

Func _Exit()
	BlockInput(0) ; разблокирует при ошибке или выходе
EndFunc   ;==>_Exit