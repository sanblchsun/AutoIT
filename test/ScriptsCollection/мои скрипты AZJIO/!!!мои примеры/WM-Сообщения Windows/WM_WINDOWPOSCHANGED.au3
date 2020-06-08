Global $k=0
$Gui = GUICreate("Измени размер окна или перемести", 390, 190, -1, -1, 0x00040000+0x00020000+0x00010000)
GUICtrlCreateLabel('Функция WM_WINDOWPOSCHANGED срабатывает в момент перемещения окна или изменения размеров.', 5, 5, 380, 34)
$condition = GUICtrlCreateLabel('', 10, 40, 360, 135)

GUISetState()
GUIRegisterMsg (0x0047, "WM_WINDOWPOSCHANGED")

Do
Until GUIGetMsg() = -3

Func WM_WINDOWPOSCHANGED($hWnd, $Msg, $wParam, $lParam)
	; получаем координаты сторон окна
	Local $sRect = DllStructCreate("Int[6]", $lparam), _
	$ykazatel = DllStructGetData($sRect, 1, 1), _
	$chislo = DllStructGetData($sRect, 1, 2), _
	$left = DllStructGetData($sRect, 1, 3), _
	$top = DllStructGetData($sRect, 1, 4), _
	$WinSizeX = DllStructGetData($sRect, 1, 5), _
	$WinSizeY = DllStructGetData($sRect, 1, 6)

	$k+=1
	GUICtrlSetData($condition,'Вызов ' &$k& ' раз'&@CRLF&'число='&$ykazatel&@CRLF&'число='&$chislo&@CRLF& 'Left='&$left&@CRLF&'Top='&$top&@CRLF& 'WinSizeX='&$WinSizeX&@CRLF&'WinSizeY='&$WinSizeY)
	WinSetTitle($Gui, '', 'Вызов ' &$k& ' раз, x='&$WinSizeX&', y='&$WinSizeY)

	Return 'GUI_RUNDEFMSG'
EndFunc