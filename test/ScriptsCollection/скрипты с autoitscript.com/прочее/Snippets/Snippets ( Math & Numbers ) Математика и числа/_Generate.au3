; Author: monoceres
Local $aNumbers = _Generate(7, 1, 36)

Local $sString = ''

For $i = 0 To UBound($aNumbers) - 1
	$sString &= "Element " & $i & ": " & $aNumbers[$i] & @CRLF
Next

MsgBox(4096, '', $sString)

; Pick a random set of numbers.
Func _Generate($iSize = 7, $iMin = 1, $iMax = 36)
	Local $aArray[$iSize], $sReturn = ''
	$aArray[0] = Random($iMin, $iMax, 1)
	For $i = 0 To $iSize - 1
		While 1
			$sReturn = Random($iMin, $iMax, 1)
			For $j = 0 To $i - 1
				If $aArray[$j] = $sReturn Then
					ContinueLoop 2
				EndIf
			Next
			ExitLoop
		WEnd
		$aArray[$i] = $sReturn
	Next
	Return $aArray
EndFunc   ;==>_Generate