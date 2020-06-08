Global $k=0
$Gui = GUICreate("Измени размер окна", 370, 220, -1, -1, 0x00040000+0x00020000)
GUICtrlCreateLabel('Функция WM_WINDOWPOSCHANGING срабатывает в момент изменения размеров окна, перемещении, клике на заголовке. Можно сделать особую установку положения некоторых элементов интерфейса в момент изменения размеров окна', 5, 5, 360, 70)
$condition = GUICtrlCreateLabel('', 10, 75, 360, 135)

GUISetState()

GUIRegisterMsg(0x0046 , "WM_WINDOWPOSCHANGING")

Do
Until GUIGetMsg() = -3

Func WM_WINDOWPOSCHANGING($hWnd, $Msg, $wParam, $lParam)
	; получаем координаты сторон окна
	Local $sRect = DllStructCreate("Int[6]", $lparam), _
	$ykazatel = DllStructGetData($sRect, 1, 1), _
	$otpysk = DllStructGetData($sRect, 1, 2), _
	$left = DllStructGetData($sRect, 1, 3), _
	$top = DllStructGetData($sRect, 1, 4), _
	$WinSizeX = DllStructGetData($sRect, 1, 5), _
	$WinSizeY = DllStructGetData($sRect, 1, 6)

	$k+=1
	GUICtrlSetData($condition,'Вызов ' &$k& ' раз'&@CRLF&'число='&$ykazatel&@CRLF&'отпуск='&$otpysk&@CRLF& 'Left='&$left&@CRLF&'Top='&$top&@CRLF& 'WinSizeX='&$WinSizeX&@CRLF&'WinSizeY='&$WinSizeY)
	WinSetTitle($Gui, '', 'Вызов ' &$k& ' раз, x='&$WinSizeX&', y='&$WinSizeY)

	Return 'GUI_RUNDEFMSG'
EndFunc