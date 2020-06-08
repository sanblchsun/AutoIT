
Global $VH1=0, $VH2=0, $S1=1
HotKeySet('{Down}', '_U_Click')
HotKeySet('{Right}', '_U_Click')
HotKeySet('{Up}', '_D_Click')
HotKeySet('{Left}', '_D_Click')
HotKeySet('{Tab}', '_Tab')

GUIRegisterMsg(0x0115 , "WM_VSCROLL")
$GUI = GUICreate("Bit(AND, OR, XOR, Shift)", 320, 245)

$slider1 = GUICtrlCreateSlider(15, 20, 30, 200, 0x0002+0x00010000)
GUICtrlSetLimit(-1, 170, 0)
GUICtrlSetState(-1, 256)
$hSlider_Handle1 = GUICtrlGetHandle(-1)

$slider2 = GUICtrlCreateSlider(55, 20, 30, 200, 0x0002+0x00010000)
GUICtrlSetLimit(-1, 170, 0)
$hSlider_Handle2 = GUICtrlGetHandle(-1)

GUICtrlCreateLabel('Логические вычисление'&@CRLF&'(Tab - выбор слайдера,'&@CRLF&'стрелками сдвиг слайдера на 1)', 100, 10, 215, 51)
$Schet = GUICtrlCreateLabel( _
'Числа = '&$VH1&' и '&$VH2&@CRLF& _
'BitAND = 0'&@CRLF& _
'BitOR   = 0'&@CRLF& _
'BitXOR = 0'&@CRLF& _
'BitShift = 0', 105, 61, 210, 200)
GUICtrlSetFont(-1,18)
GUISetState()

Do
Until GUIGetMsg() = -3

Func WM_VSCROLL($hWnd, $Msg, $wParam, $lParam)
	#forceref $Msg, $wParam, $lParam
	Local $nScrollCode = BitAND($wParam, 0x0000FFFF)
	Local $value = BitShift($wParam, 16)
	
	Switch $lParam
		Case $hSlider_Handle1
			If $nScrollCode = 5 Then
				$VH1=$value
				$S1=1
			EndIf
		Case $hSlider_Handle2
		   If $nScrollCode = 5 Then
				$VH2=$value
				$S1=2
			EndIf
	EndSwitch
If $nScrollCode = 5 Then
	GUICtrlSetData($Schet, _
'Числа = '&$VH1&' и '&$VH2&@CRLF& _
'BitAND = '&BitAND($VH1, $VH2)&@CRLF& _
'BitOR   = '&BitOR($VH1, $VH2)&@CRLF& _
'BitXOR = '&BitXOR($VH1, $VH2)&@CRLF& _
'BitShift = '&BitShift($VH1, $VH2))
EndIf

	Return 'GUI_RUNDEFMSG'
EndFunc

Func _Tab()
    If $S1=1 Then
		$S1=2
	Else
		$S1=1
	EndIf
EndFunc

Func _D_Click()
	
    If $S1=1 Then
		$VH1-=1
	ElseIf $S1=2 Then
		$VH2-=1
	EndIf
	If $VH1=-1 Then $VH1=0
	If $VH2=-1 Then $VH2=0
    If $S1=1 Then
		GUICtrlSetData($slider1, $VH1)
	ElseIf $S1=2 Then
		GUICtrlSetData($slider2, $VH2)
	EndIf
	_SetData()
EndFunc

Func _U_Click()
    If $S1=1 Then
		$VH1+=1
	ElseIf $S1=2 Then
		$VH2+=1
	EndIf
	If $VH1=171 Then $VH1=170
	If $VH2=171 Then $VH2=170
    If $S1=1 Then
		GUICtrlSetData($slider1, $VH1)
	ElseIf $S1=2 Then
		GUICtrlSetData($slider2, $VH2)
	EndIf
	_SetData()
EndFunc

Func _SetData()
	GUICtrlSetData($Schet, _
'Числа = '&$VH1&' и '&$VH2&@CRLF& _
'BitAND = '&BitAND($VH1, $VH2)&@CRLF& _
'BitOR   = '&BitOR($VH1, $VH2)&@CRLF& _
'BitXOR = '&BitXOR($VH1, $VH2)&@CRLF& _
'BitShift = '&BitShift($VH1, $VH2))
EndFunc