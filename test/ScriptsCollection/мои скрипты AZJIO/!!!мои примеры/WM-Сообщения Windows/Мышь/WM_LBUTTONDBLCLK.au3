Global $k=0
$Gui = GUICreate("Сделай двойной клик", 400, 150)
GUICtrlCreateLabel('Функция WM_LBUTTONDBLCLK срабатывает в момент двойного клика мыши в клиенской области окна.', 5, 5, 380, 34)
GUISetState()

GUIRegisterMsg(0x0203, "WM_LBUTTONDBLCLK")

While 1
   $msg = GUIGetMsg()
   Select
       Case $msg = -3
           Exit
   EndSelect
WEnd

Func WM_LBUTTONDBLCLK($hWndGui, $MsgId, $wParam, $lParam)
    $X = BitShift($lParam, 16)
    $Y = BitAND($lParam, 0xFFFF)
	$k+=1
	WinSetTitle($Gui, '', 'Попытка ' &$k& ' раз, x='&$X&', y='&$Y)
EndFunc