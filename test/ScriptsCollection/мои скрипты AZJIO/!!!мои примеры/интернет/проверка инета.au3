HotKeySet("{ESC}", "_Quit")
; проверка по полному/неполному IP и пингу адрес-ссылке в интернете
Global $iptest='192.168.', $adres='http://www.google.ru/', $IPP=80, $Statys='no'

While 1
_WriteIP2Text(@IPAddress1)
_WriteIP2Text(@IPAddress2)
_WriteIP2Text(@IPAddress3)
_WriteIP2Text(@IPAddress4)
	If $Statys='yes' Then _Ping()
    Sleep(1000)
WEnd

Func _WriteIP2Text($ip)
	If StringInStr($ip, $iptest)>0 Then
		$file = FileOpen(@ScriptDir&'\IP.txt' ,2)
		FileWrite($file, $ip)
		FileClose($file)
		$Statys='yes'
		$iptest=$ip
    EndIf
EndFunc

Func _Ping()
	TCPStartUp()
	$adres = StringRegExpReplace($adres, "(?:ht|f)tp\:\/\/(.*)\/.*", "\1")
While 1
	$socket = TCPConnect(TCPNameToIP($adres), $IPP)
	If @error Then
		ContinueLoop
	Else
		MsgBox(0, "Сообщение", 'Интернет работает'&@CRLF&'Ваш IP: '& $iptest)
		TCPShutdown()
		Exit
		;ExitLoop
	EndIf
    Sleep(1000)
WEnd
EndFunc

Func _Quit()
    Exit
EndFunc