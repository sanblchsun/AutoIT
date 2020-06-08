Global $MiIN = 15

While 1
	Sleep(1000)
	If Not IsDeclared("Time") Then
		If @MIN = $MiIN Then
			_MuFunc()
			$Time = @HOUR
		EndIf
	Else
		If $Time <> @HOUR Then
			If @MIN = $MiIN Then
				_MuFunc()
				$Time = @HOUR
			EndIf
		EndIf
	EndIf
WEnd

Func _MuFunc()
	MsgBox(0, "", "Наступило 15 минут следующего часа")
EndFunc
