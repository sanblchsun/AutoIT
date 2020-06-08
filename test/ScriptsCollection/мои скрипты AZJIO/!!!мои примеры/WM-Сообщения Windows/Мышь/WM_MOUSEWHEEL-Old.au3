Global $k1=0
Global $k2=0
GUIRegisterMsg(0x020A , "WM_MOUSEWHEEL")
$Gui = GUICreate("Крути колесо мыши вниз / вверх",  370, 100)
GUICtrlCreateLabel('Функция WM_MOUSEWHEEL срабатывает в момент вращения колёсика мыши. Можно использовать для установки числовых параметров в инпутах c GUICtrlCreateUpdown.', 5, 5, 360, 50)
$Label1 = GUICtrlCreateLabel("колесо мыши сдвинулось вверх 0 раз", 10, 60, 226, 17)
$Label2 = GUICtrlCreateLabel("колесо мыши сдвинулось вниз 0 раз", 10, 80, 226, 17)
$Input=GUICtrlCreateInput("", 240, 65, 100, 21)
GUISetState ()

While 1
	$msg = GUIGetMsg()
	Select
		Case $msg = -3
			Exit
	EndSelect
WEnd

Func WM_MOUSEWHEEL($hWnd,$nMsg,$wParam,$lParam)
	; MsgBox(0, 'Сообщение', $hWnd&@CRLF&$nMsg&@CRLF&$wParam&@CRLF&$lParam)
	If $wParam=0x00780000 Then
		$k1+=1
		GUICtrlSetData($Label1, 'колесо мыши сдвинулось вверх '&$k1&' раз')
		WinSetTitle($Gui, '', 'вверх '&$k1&' раз, вниз '&$k2&' раз')
		GUICtrlSetData($Input, $k1&' - '&$k2&' = '&$k1-$k2)
	EndIf
	If $wParam=0xFF880000 Then
		$k2+=1
		GUICtrlSetData($Label2, 'колесо мыши сдвинулось вниз '&$k2&' раз')
		WinSetTitle($Gui, '', 'вверх '&$k1&' раз, вниз '&$k2&' раз')
		GUICtrlSetData($Input, $k1&' - '&$k2&' = '&$k1-$k2)
	EndIf
EndFunc