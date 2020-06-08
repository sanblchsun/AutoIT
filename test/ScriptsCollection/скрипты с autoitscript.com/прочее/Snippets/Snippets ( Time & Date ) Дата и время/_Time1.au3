; Author: SmOke_N
ConsoleWrite(_Time() & @CRLF)

Func _Time()
	Local $AMPM, $hour
	If @HOUR > 12 Then
		$hour = @HOUR - 12
		$AMPM = "PM"
	ElseIf @HOUR = 0 Then
		$hour = 12
		$AMPM = "AM"
	Else
		$hour = @HOUR
		$AMPM = "AM"
	EndIf
	Return $hour & ":" & @MIN & $AMPM
EndFunc   ;==>_Time