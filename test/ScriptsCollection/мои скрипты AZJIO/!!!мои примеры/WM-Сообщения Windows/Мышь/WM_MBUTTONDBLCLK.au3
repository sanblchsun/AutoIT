Global $k=0
$Gui = GUICreate("Двойной клик средней кнопкой мыши", 400, 150)
GUICtrlCreateLabel('Функция WM_MBUTTONDBLCLK срабатывает в момент двойного клика мыши средней кнопкой в клиенской области окна.', 5, 5, 380, 34)
GUISetState()

GUIRegisterMsg(0x0209, "WM_MBUTTONDBLCLK")

While 1
   $msg = GUIGetMsg()
   Select
       Case $msg = -3
           Exit
   EndSelect
WEnd

Func WM_MBUTTONDBLCLK($hWndGui, $MsgId, $wParam, $lParam)
    $X = BitShift($lParam, 16)
    $Y = BitAND($lParam, 0xFFFF)
	$k+=1
	WinSetTitle($Gui, '', 'Попытка ' &$k& ' раз, x='&$X&', y='&$Y)
EndFunc