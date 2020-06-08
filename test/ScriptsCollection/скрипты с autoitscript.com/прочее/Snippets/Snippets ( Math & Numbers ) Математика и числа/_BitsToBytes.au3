; Author: ProgAndy
ConsoleWrite(_BitsToBytes(1000) & @CRLF)

Func _BitsToBytes($sBits) ; coded by ProgAndy
	Local $bBytes = Binary(''), $iLen = StringLen($sBits)
	Local $iCnt = 0, $iVal = 0
	For $i = 1 To $iLen
		$iCnt += 1
		$iVal = BitShift($iVal, -1)
		If "1" = StringMid($sBits, $i, 1) Then
			$iVal = BitOR($iVal, 1)
		EndIf
		If $iCnt = 8 Then
			$iCnt = 0
			$bBytes &= BinaryMid($iVal, 1, 1)
			$iVal = 0
		EndIf
	Next
	If $iCnt Then $bBytes &= BinaryMid(Binary(BitShift($iVal, -8 + $iCnt)), 1, 1)
	Return $bBytes
EndFunc   ;==>_BitsToBytes