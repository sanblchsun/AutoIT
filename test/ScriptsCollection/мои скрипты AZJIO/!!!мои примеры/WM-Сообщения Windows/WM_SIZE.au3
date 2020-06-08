Global $k=0
$Gui = GUICreate("Измени размер окна", 370, 140, -1, -1, 0x00040000+0x00020000+0x00010000)
GUICtrlCreateLabel('Функция WM_SIZE срабатывает только в момент изменения размеров окна. Можно сделать особую установку положения некоторых элементов интерфейса в момент изменения размеров окна', 5, 5, 360, 130)

GUISetState()

GUIRegisterMsg(0x05 , "WM_SIZE") ; он же 0x0005

Do
Until GUIGetMsg() = -3

Func WM_SIZE($hWnd, $Msg, $wParam, $lParam)
	#forceref $Msg, $wParam
	Local $xClient, $yClient

	; Координаты области клиенской части.
	$xClient = BitAND($lParam, 0xFFFF) ; _WinAPI_LoWord
	$yClient = BitShift($lParam, 16) ; _WinAPI_HiWord
	
	$k+=1
	WinSetTitle($Gui, '', 'Вызов ' &$k& ' раз, x='&$xClient&', y='&$yClient)

	Return 'GUI_RUNDEFMSG'
EndFunc