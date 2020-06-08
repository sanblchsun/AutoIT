HotKeySet("{ESC}", "_Quit")
; проверка интернета по IP, не содержащегося в списке игнорирования и пингу адрес-ссылке в интернете
Global $Statys='no', $adres='http://www.google.ru/', $IPP=80 , $ignore='127.0.0.0;0.0.0.0', $iptest=''

While 1
_WriteIP2Text(@IPAddress1)
_WriteIP2Text(@IPAddress2)
_WriteIP2Text(@IPAddress3)
_WriteIP2Text(@IPAddress4)
    If $Statys='yes' Then _Ping()
    Sleep(1000)
WEnd

Func _WriteIP2Text($ip)
    If StringInStr(';'&$ignore&';', ';'&$ip&';')>0 Then
        Return
    Else
        $iptest=$ip
        $file = FileOpen(@ScriptDir&'\IP.txt' ,2)
        FileWrite($file, $ip)
        FileClose($file)
        $Statys='yes'
    EndIf
EndFunc

Func _Ping()
    TCPStartUp()
    $adres = StringRegExpReplace($adres, "(?:ht|f)tp\:\/\/(.*)\/.*", "\1")
While 1
    $socket = TCPConnect(TCPNameToIP($adres), $IPP)
    If @error Then
        Sleep(1000)
        ContinueLoop
    Else
        MsgBox(0, "Сообщение", 'Интернет работает'&@CRLF&'Ваш IP: '& $iptest)
		TCPShutdown()
        Exit
        ;ExitLoop
    EndIf
WEnd
EndFunc

Func _Quit()
    Exit
EndFunc