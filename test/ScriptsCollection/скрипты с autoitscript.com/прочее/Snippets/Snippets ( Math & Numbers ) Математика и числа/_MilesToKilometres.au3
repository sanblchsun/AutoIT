; Author: guinness
; Usage _MilesToKilometres( Number Of Miles To Calculate By )  &

ConsoleWrite(_MilesToKilometres(1) & @CRLF) ; Change the (1) to the distance required

Func _MilesToKilometres($iLength)
	Return $iLength * 1.609
EndFunc   ;==>_MilesToKilometres