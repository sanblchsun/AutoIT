Global $hMain = GUICreate("Main", 300, 300, -1, -1, 268435456), $hEnter = GUICtrlCreateInput("", 10, 10, 250, 20), $hResult = GUICtrlCreateInput("", 10, 40, 250, 20)
GUIRegisterMsg(0x0111, "Calc")
Do
Until GUIGetMsg() = -3
Func Calc($hWnd, $Msg, $wParam, $lParam)
        GUICtrlSetData($hResult, Execute(GUICtrlRead($hEnter)))
EndFunc