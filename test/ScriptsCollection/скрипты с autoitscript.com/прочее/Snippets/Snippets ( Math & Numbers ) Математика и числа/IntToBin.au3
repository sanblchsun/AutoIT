; Author: Malkey
ConsoleWrite(IntToBin(2048) & @CRLF)

Func IntToBin($iInt) ; coded by Malkey
	Local $b = ""
	For $i = 1 To 32
		$b = BitAND($iInt, 1) & $b
		$iInt = BitShift($iInt, 1)
	Next
	Return $b
EndFunc   ;==>IntToBin