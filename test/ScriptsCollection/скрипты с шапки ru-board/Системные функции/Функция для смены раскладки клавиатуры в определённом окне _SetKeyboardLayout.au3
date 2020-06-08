$hLayout_Wnd = WinGetHandle("[Active]")

_SetKeyboardLayout(419, $hLayout_Wnd)

Func _SetKeyboardLayout($sLayoutID, $hWnd)
    Local $WM_INPUTLANGCHANGEREQUEST = 0x50

    If StringLen($sLayoutID) <= 3 Then $sLayoutID = "00000" & $sLayoutID
    Local $aRet = DllCall("user32.dll", "long", "LoadKeyboardLayout", "str", $sLayoutID, "int", 0)

    DllCall("user32.dll", "ptr", "SendMessage", "hwnd", $hWnd, "int", $WM_INPUTLANGCHANGEREQUEST, "int", 1, "int", $aRet[0])
EndFunc