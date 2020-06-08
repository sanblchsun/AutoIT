Global $k=0
GUIRegisterMsg(0x0115 , "WM_VSCROLL")
$GUI = GUICreate("¬ертикальный", 350, 245)

$slider1 = GUICtrlCreateSlider(15, 20, 30, 200, 0x0002)
GUICtrlSetLimit(-1, 185, 0)
$hSlider_Handle1 = GUICtrlGetHandle(-1)

$slider2 = GUICtrlCreateSlider(55, 20, 30, 200, 0x0002)
GUICtrlSetLimit(-1, 185, 0)
$hSlider_Handle2 = GUICtrlGetHandle(-1)

GUICtrlCreateLabel('     WM_VSCROLL - команда позвол€ет получить величину регул€тора в момент задействовани€, а не зацикливать проверку состо€ни€.'&@CRLF&@CRLF&'     ≈сли вертикальных регул€торов более одного, то функци€ срабатывает при задействовании любого из вертикальных регул€торов', 100, 10, 245, 180)
$condition = GUICtrlCreateLabel('', 105, 160, 200, 70)
GUICtrlSetFont(-1,32)
GUISetState()

Do
Until GUIGetMsg() = -3

Func WM_VSCROLL($hWnd, $Msg, $wParam, $lParam)
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