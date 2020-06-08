Global $k=0
$Gui = GUICreate("Двойной клик правой кнопкой мыши на заголовке", 550, 240, -1, -1, 0x00040000+0x00020000)
GUICtrlCreateLabel('Функция WM_NCRBUTTONDBLCLK срабатывает в момент двойного клика правой кнопки мыши в НЕ клиенской области окна, точнее на заголовке и краях окна, когда курсор меняется на изменение размеров окна.', 5, 5, 380, 74)
GUISetState()

GUIRegisterMsg(0x00A6, "WM_NCRBUTTONDBLCLK")

While 1
   $msg = GUIGetMsg()
   Select
       Case $msg = -3
           Exit
   EndSelect
WEnd

Func WM_NCRBUTTONDBLCLK($hWndGui, $MsgId, $wParam, $lParam)
    $X = BitShift($lParam, 16)
    $Y = BitAND($lParam, 0xFFFF)
	$k+=1
	WinSetTitle($Gui, '', 'Двойной клик ' &$k& ' раз, x='&$X&', y='&$Y)
EndFunc