HotKeySet("{ESC}", "OnAutoItExit")

Global Const $WH_KEYBOARD_LL = 13
Global $hStub_KeyProc = DllCallbackRegister("_KeyProc", "int", "int;ptr;ptr")
Global $hMod = DllCall("kernel32.dll", "hwnd", "GetModuleHandle", "ptr", 0)
Global $hHook = DllCall("user32.dll", "hwnd", "SetWindowsHookEx", "int", _
        $WH_KEYBOARD_LL, "ptr", DllCallbackGetPtr($hStub_KeyProc), "hwnd", $hMod[0], "dword", 0)

While 1
    Sleep(2)
WEnd

Func EvaluateKey($nKeyCode)
    If $nKeyCode = 13 Then
        MsgBox(0, "", "Enter нажата.", 3)
    EndIf
EndFunc   ;==>EvaluateKey

Func _KeyProc($nCode, $wParam, $lParam)
    Local $aRet, $KEYHOOKSTRUCT

    If $nCode < 0 Then
        $aRet = DllCall("user32.dll", "long", "CallNextHookEx", "hwnd", $hHook[0], "int", $nCode, "ptr", $wParam, "ptr", $lParam)
        Return $aRet[0]
    EndIf

    If $wParam = 256 Then
        $KEYHOOKSTRUCT = DllStructCreate("dword;dword;dword;dword;ptr", $lParam)
        EvaluateKey(DllStructGetData($KEYHOOKSTRUCT, 1))
    EndIf

    $aRet = DllCall("user32.dll", "long", "CallNextHookEx", "hwnd", $hHook[0], "int", $nCode, "ptr", $wParam, "ptr", $lParam)

    Return $aRet[0]
EndFunc   ;==>_KeyProc

Func OnAutoItExit()
    If $hStub_KeyProc Then DllCallbackFree($hStub_KeyProc)
    $hStub_KeyProc = 0
    DllCall("user32.dll", "int", "UnhookWindowsHookEx", "hwnd", $hHook[0])
    If @HotKeyPressed <> "" Then Exit
EndFunc   ;==>OnAutoItExit