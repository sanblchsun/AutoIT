; Author: guinness
; _KilometresToMiles( Number Of Kilometers To Calculate By )
ConsoleWrite(_KilometresToMiles(1) & @CRLF) ; Change the (1) to the distance required

Func _KilometresToMiles($iLength)
	Return $iLength * 0.6214
EndFunc   ;==>_KilometresToMiles