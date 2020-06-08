; Author: guinness
ConsoleWrite(_RandomNumber() & @CRLF) ; Generates a random number

Func _RandomNumber($iStart = 0, $iEnd = 10000000000)
	Return Random($iStart, $iEnd, 1)
EndFunc   ;==>_RandomNumber