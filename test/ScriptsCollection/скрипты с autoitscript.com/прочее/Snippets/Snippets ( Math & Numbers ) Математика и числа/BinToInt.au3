; Author: Malkey
ConsoleWrite(BinToInt(111000) & @CRLF)

Func BinToInt($bin) ;coded by Malkey
	Local $aArr = StringSplit($bin, "", 2)
	Local $dec = 0
	For $i = UBound($aArr) - 1 To 0 Step -1
		If $aArr[$i] = "1" Then
			$dec = BitXOR($dec, BitShift(1, -(UBound($aArr) - 1 - $i)))
		EndIf
	Next
	Return $dec
EndFunc   ;==>BinToInt