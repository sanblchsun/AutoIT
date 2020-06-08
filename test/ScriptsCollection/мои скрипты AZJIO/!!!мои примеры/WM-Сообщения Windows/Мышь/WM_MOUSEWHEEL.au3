Global $k1=0
Global $k2=0
Global Const $WM_MOUSEWHEEL = 0x020A

GUIRegisterMsg(0x020A , "WM_MOUSEWHEEL")
$Gui = GUICreate("Крути колесо мыши вниз / вверх",  370, 160)
GUICtrlCreateLabel('Функция WM_MOUSEWHEEL срабатывает в момент вращения колёсика мыши. Попробуйте удерживать Ctrl, Shift, кнопки мыши при вращении колёсика, код спец-клавиш тоже возвращается. Можно использовать для установки числовых параметров в инпутах c GUICtrlCreateUpdown.', 5, 5, 360, 75)
$Label1 = GUICtrlCreateLabel("колесо мыши сдвинулось вверх 0 раз", 10, 90, 226, 17)
$Label2 = GUICtrlCreateLabel("колесо мыши сдвинулось вниз 0 раз", 10, 110, 226, 17)
$Label3 = GUICtrlCreateLabel("", 10, 130, 226, 17)
$Input=GUICtrlCreateInput("", 240, 95, 100, 21)
GUISetState ()

While 1
	$msg = GUIGetMsg()
	Select
		Case $msg = -3
			Exit
	EndSelect
WEnd

Func WM_MOUSEWHEEL($hWndGui, $MsgId, $wParam, $lParam)
    If $MsgId = $WM_MOUSEWHEEL Then
        $Delta = BitShift($wParam, 16)
        $KeysHeld = BitAND($wParam, 0xFFFF)
        $X = BitShift($lParam, 16)
        $Y = BitAND($lParam, 0xFFFF)
		GUICtrlSetData($Label3, "Delta: "&$Delta&", Клавиша: "&$KeysHeld&",     X: "&$X&", Y: "&$Y)
		
        If $Delta > 0 Then
			$k1+=1
			GUICtrlSetData($Label1, 'колесо мыши сдвинулось вверх '&$k1&' раз')
			WinSetTitle($Gui, '', 'вверх '&$k1&' раз, вниз '&$k2&' раз')
			GUICtrlSetData($Input, $k1&' - '&$k2&' = '&$k1-$k2)
        Else
			$k2+=1
			GUICtrlSetData($Label2, 'колесо мыши сдвинулось вниз '&$k2&' раз')
			WinSetTitle($Gui, '', 'вверх '&$k1&' раз, вниз '&$k2&' раз')
			GUICtrlSetData($Input, $k1&' - '&$k2&' = '&$k1-$k2)
        EndIf
    EndIf
EndFunc