$Tr=0
$hForm = GUICreate('Тест иконки курсора', 270, 200)
GUICtrlCreateEdit('', 10, 10, 200, 100)
$Button = GUICtrlCreateButton('Изменить поведение курсора', 10, 150, 170, 28)
GUISetCursor(0, 0, $hForm)

GUISetState()

While 1
	$msg = GUIGetMsg()
	Switch $msg
		Case $Button
			If $Tr Then
				GUISetCursor(0, 0, $hForm)
				$Tr=0
			Else
				GUISetCursor(0, 1, $hForm)
				$Tr=1
			EndIf
		Case -3
			Exit
	EndSwitch
WEnd