Global $k=0

GUIRegisterMsg(0x007E,"WM_DISPLAYCHANGE")
$Gui = GUICreate("Измени разрешение экрана", 370, 140, -1, -1, 0x00040000+0x00020000)
GUICtrlCreateLabel('Функция WM_DISPLAYCHANGE срабатывает в момент изменения разрешения экрана.', 5, 5, 360, 130)
GUISetState()

Do
Until GUIGetMsg() = -3

Func WM_DISPLAYCHANGE($hWnd,$iMsg,$wParam,$lParam)
	$x=Dec(StringMid(Hex($lParam) , 5, 8))
	$y=Dec(StringMid(Hex($lParam) , 1, 4))
	$k+=1
	WinSetTitle($Gui, '', 'Вызов ' &$k& ' раз, '&$x&'x'&$y)
EndFunc