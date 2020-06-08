Global $k=0
GUIRegisterMsg(0x0003 , "WM_MOVE")
$Gui = GUICreate("Измени размер окна", 370, 140, -1, -1, 0x00040000+0x00020000)
GUICtrlCreateLabel('Функция WM_MOVE срабатывает только в момент перемещения окна. Можно сделать магнит к краям экрана, который задействуется только в момент перемещения окна', 5, 5, 360, 130)

GUISetState()

Do
Until GUIGetMsg() = -3

Func WM_MOVE($hWnd, $Msg, $wParam, $lParam)
	; координаты клиенской части окна
	Local $xClient = BitAND($lParam, 0xFFFF)
	Local $yClient = BitShift($lParam, 16)
	$k+=1
	WinSetTitle($Gui, '', 'Вызов ' &$k& ' раз, x='&$xClient&', y='&$yClient)
EndFunc