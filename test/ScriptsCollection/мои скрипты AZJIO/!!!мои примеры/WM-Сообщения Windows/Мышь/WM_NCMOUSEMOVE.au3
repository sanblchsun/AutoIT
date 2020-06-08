Global $k=0
$Gui = GUICreate("Перемещай мышь на заголовке", 400, 150)
GUICtrlCreateLabel('Функция WM_NCMOUSEMOVE срабатывает в момент перемещения мыши в неклиенской области окна.', 5, 5, 380, 34)
GUISetState()

GUIRegisterMsg(0x00A0, "WM_NCMOUSEMOVE")

While 1
   $msg = GUIGetMsg()
   Select
       Case $msg = -3
           Exit
   EndSelect
WEnd

Func WM_NCMOUSEMOVE($hWnd, $iMsg, $wParam, $lParam)
    $X = BitShift($lParam, 16)
    $Y = BitAND($lParam, 0xFFFF)
	$k+=1
	WinSetTitle($Gui, '', 'Попытка ' &$k& ' раз, x='&$X&', y='&$Y)
EndFunc