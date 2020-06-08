; Author: Valuater
MsgBox(0, "Сколько время?", _Time())

Func _Time()
	Local $hour = @HOUR, $AMPM = "AM"
	If $hour > 11 Then $AMPM = "PM"
	If $hour = 0 Then $hour = 12
	If $hour > 12 Then $hour -= 12
	Return $hour & ":" & @MIN & " " & $AMPM
EndFunc   ;==>_Time