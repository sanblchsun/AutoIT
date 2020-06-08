Global $k=0
$Gui = GUICreate("Сделай клик мышкой", 400, 150)
GUICtrlCreateLabel('Функция WM_LBUTTONDOWN срабатывает в момент нажатия левой кнопки мыши в клиенской области окна.', 5, 5, 380, 34)
GUISetState()

GUIRegisterMsg(0x0201, "WM_LBUTTONDOWN")

While 1
   $msg = GUIGetMsg()
   Select
       Case $msg = -3
           Exit
   EndSelect
WEnd

Func WM_LBUTTONDOWN($hWndGui, $MsgId, $wParam, $lParam)
    $X = BitShift($lParam, 16)
    $Y = BitAND($lParam, 0xFFFF)
	$k+=1
	WinSetTitle($Gui, '', 'Попытка ' &$k& ' раз, x='&$X&', y='&$Y)
EndFunc