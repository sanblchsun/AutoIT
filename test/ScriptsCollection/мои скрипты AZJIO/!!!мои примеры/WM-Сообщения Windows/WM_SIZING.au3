Global $k=0
$Gui = GUICreate("Измени размер окна", 370, 140, -1, -1, 0x00040000+0x00020000)
GUICtrlCreateLabel('Функция WM_SIZING срабатывает только в момент изменения размеров окна. Отличается от WM_SIZE тем, что срабатывает в момент отпуска окна. Можно сделать особую установку положения некоторых элементов интерфейса в момент изменения размеров окна', 5, 5, 360, 130)

GUISetState()

GUIRegisterMsg(0x0214 , "WM_SIZING")

Do
Until GUIGetMsg() = -3

Func WM_SIZING($hWnd, $iMsg, $wparam, $lparam)
	; получаем координаты сторон окна
	Local $sRect = DllStructCreate("Int[4]", $lparam), _
	$left = DllStructGetData($sRect, 1, 1), _
	$top = DllStructGetData($sRect, 1, 2), _
	$Right = DllStructGetData($sRect, 1, 3), _
	$bottom = DllStructGetData($sRect, 1, 4)

	$k+=1
	WinSetTitle($Gui, '', 'Вызов ' &$k& ' раз, x='&$Right-$left&', y='&$bottom-$top)

	Return 'GUI_RUNDEFMSG'
EndFunc