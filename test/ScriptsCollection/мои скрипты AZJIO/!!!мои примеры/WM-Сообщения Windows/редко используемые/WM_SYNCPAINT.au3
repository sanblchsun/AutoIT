Global $k=0
$Gui = GUICreate("Перемести другое окно поверх этого", 390, 140)
GUICtrlCreateLabel('Функция WM_SYNCPAINT срабатывает в момент перемещения другого окна поверх текущего. Срабатывает при освобождении площади, но не при перекрывании.', 5, 5, 360, 130)

GUISetState()

GUIRegisterMsg(0x0088 , "WM_SYNCPAINT")

Do
Until GUIGetMsg() = -3

Func WM_SYNCPAINT()
	$k+=1
	WinSetTitle($Gui, '', 'Вызов ' &$k& ' раз')
EndFunc