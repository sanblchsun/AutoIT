Global $k=0
$Gui = GUICreate("Кликни средней кнопкой мыши на заголовке", 450, 140, -1, -1, 0x00040000+0x00020000)
GUICtrlCreateLabel('Функция WM_NCMBUTTONDOWN срабатывает в момент нажатия средней кнопки мыши в НЕ клиенской области окна, точнее на заголовке и краях окна, когда курсор меняется на изменение размеров окна.', 5, 5, 440, 54)
GUISetState()

GUIRegisterMsg(0x00A7, "WM_NCMBUTTONDOWN")

While 1
   $msg = GUIGetMsg()
   Select
       Case $msg = -3
           Exit
   EndSelect
WEnd

Func WM_NCMBUTTONDOWN($hWndGui, $MsgId, $wParam, $lParam)
    $X = BitShift($lParam, 16)
    $Y = BitAND($lParam, 0xFFFF)
	$k+=1
	WinSetTitle($Gui, '', 'Кликнул ' &$k& ' раз, x='&$X&', y='&$Y)
EndFunc