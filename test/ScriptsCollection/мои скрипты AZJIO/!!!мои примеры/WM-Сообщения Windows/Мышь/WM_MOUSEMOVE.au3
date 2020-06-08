Global $k=0
$Gui = GUICreate("Перемещай мышь в окне", 400, 150)
GUICtrlCreateLabel('Функция WM_MOUSEMOVE срабатывает в момент перемещения мыши в клиенской области окна.', 5, 5, 380, 34)
GUISetState()

GUIRegisterMsg(0x0200, "WM_MOUSEMOVE")

While 1
   $msg = GUIGetMsg()
   Select
       Case $msg = -3
           Exit
   EndSelect
WEnd

Func WM_MOUSEMOVE($hWnd, $iMsg, $wParam, $lParam)
    $X = BitShift($lParam, 16)
    $Y = BitAND($lParam, 0xFFFF)
	$k+=1
	WinSetTitle($Gui, '', 'Попытка ' &$k& ' раз, x='&$X&', y='&$Y)
EndFunc