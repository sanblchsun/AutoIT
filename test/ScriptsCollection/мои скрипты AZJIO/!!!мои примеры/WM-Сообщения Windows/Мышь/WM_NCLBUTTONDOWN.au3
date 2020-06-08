Global $k=0
$Gui = GUICreate("Кликни на заголовке", 370, 140, -1, -1, 0x00040000+0x00020000)
GUICtrlCreateLabel('Функция WM_NCLBUTTONDOWN срабатывает в момент нажатия левой кнопки мыши в НЕ клиенской области окна, точнее на заголовке и краях окна, когда курсор меняется на изменение размеров окна.', 5, 5, 360, 54)
GUISetState()

GUIRegisterMsg(0x00A1, "WM_NCLBUTTONDOWN")

While 1
   $msg = GUIGetMsg()
   Select
       Case $msg = -3
           Exit
   EndSelect
WEnd

Func WM_NCLBUTTONDOWN($hWndGui, $MsgId, $wParam, $lParam)
    $X = BitShift($lParam, 16)
    $Y = BitAND($lParam, 0xFFFF)
	$k+=1
	WinSetTitle($Gui, '', 'Кликнул ' &$k& ' раз, x='&$X&', y='&$Y)
EndFunc