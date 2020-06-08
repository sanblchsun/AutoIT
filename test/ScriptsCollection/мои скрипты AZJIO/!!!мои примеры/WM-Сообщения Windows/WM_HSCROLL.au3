Global $k=0
GUIRegisterMsg(0x0114 , "WM_HSCROLL")
$GUI = GUICreate("√оризонтальный", 320, 185)

$slider1 = GUICtrlCreateSlider(10, 5, 200, 30)
GUICtrlSetLimit(-1, 185, 0)
$hSlider_Handle1 = GUICtrlGetHandle(-1)

$slider2 = GUICtrlCreateSlider(10, 35, 200, 30)
GUICtrlSetLimit(-1, 185, 0)
$hSlider_Handle2 = GUICtrlGetHandle(-1)

GUICtrlCreateLabel('     WM_HSCROLL - команда позвол€ет получить величину регул€тора в момент задействовани€, а не зацикливать проверку состо€ни€.'&@CRLF&@CRLF&'     ≈сли горизонтальных регул€торов более одного, то функци€ срабатывает при задействовании любого из горизонтальных регул€торов.', 10, 70, 300, 105)
$condition = GUICtrlCreateLabel('', 220, 5, 200, 40)
GUICtrlSetFont(-1,22)
GUISetState()

Do
Until GUIGetMsg() = -3

Func WM_HSCROLL($hWnd, $Msg, $wParam, $lParam)
	#forceref $Msg, $wParam, $lParam
	Local $nScrollCode = BitAND($wParam, 0xFFFF)
	Local $value = BitShift($wParam, 16)
	
	Switch $lParam
		Case $hSlider_Handle1
		   If $nScrollCode = 5 Then GUICtrlSetData($condition,'1 - '&$value)
			WinSetTrans($GUI,"",255-GUICtrlRead($slider1))
		Case $hSlider_Handle2
		   If $nScrollCode = 5 Then GUICtrlSetData($condition,'2 - '&$value)
	EndSwitch
	
	$k+=1
	WinSetTitle($Gui, '', '¬ызов ' &$k& ' раз, c='&$nScrollCode&', v='&$value)

	Return 'GUI_RUNDEFMSG'
EndFunc