; Author: Spiff59
ConsoleWrite(_BinToInt(111000) & @CRLF)

Func _BinToInt($sValue)
	Local $iOut = 0, $aValue = StringSplit($sValue, "")
	For $i = 1 To $aValue[0]
		$aValue[0] -= 1
		If $aValue[$i] = "1" Then $iOut += 2 ^ ($aValue[0])
	Next
	Return Int($iOut)
EndFunc   ;==>_BinToInt