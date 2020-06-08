Global $k=0
GUIRegisterMsg (0x0216, "WM_MOVING")
$Gui = GUICreate("Перемести окно", 390, 180, -1, -1, 0x00040000+0x00020000+0x00010000)
GUICtrlCreateLabel('Функция WM_MOVING срабатывает в момент перемещения окна. Отличается от WM_MOVE тем, что срабатывает в момент отпуска окна.', 5, 5, 380, 34)
$condition = GUICtrlCreateLabel('', 10, 40, 380, 140)
GUICtrlSetFont(-1,14)

GUISetState()

Do
Until GUIGetMsg() = -3

Func WM_MOVING($hWnd, $Msg, $wParam, $lParam)
	; получаем координаты сторон окна
	Local $sRect = DllStructCreate("Int[4]", $lparam), _
	$left = DllStructGetData($sRect, 1, 1), _
	$top = DllStructGetData($sRect, 1, 2), _
	$Right = DllStructGetData($sRect, 1, 3), _
	$bottom = DllStructGetData($sRect, 1, 4)

	$k+=1
	GUICtrlSetData($condition,'Вызов ' &$k& ' раз'&@CRLF&'Left='&$left&@CRLF&'Top='&$top&@CRLF& 'Right='&$Right&@CRLF&'Bottom='&$bottom)

	Return 'GUI_RUNDEFMSG'
EndFunc