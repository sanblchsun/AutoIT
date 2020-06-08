
; 0 < $epoch_time < 2147483647
; 0 = 1970, от которого эта функия работает

$epoch_time = 1234567890
    $aCall = DllCall("msvcrt.dll", "str:cdecl", "ctime", "int*", $epoch_time)
    ConsoleWrite("EPOCH time = " & $epoch_time & @CRLF)
	; Время в формате даты с добавлением разницы временной зоны
    ConsoleWrite("EPOCH time converted to your timezone time = " & $aCall[0] & @CRLF)