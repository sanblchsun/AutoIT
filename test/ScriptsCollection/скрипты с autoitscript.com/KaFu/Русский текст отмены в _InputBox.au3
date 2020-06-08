
; KaFu
; http://www.autoitscript.com/forum/topic/140024-english-msgbox-button-texts-for-everyone/page__view__findpost__p__983172

#include <WinAPI.au3>
Opt("MustDeclareVars", 1)
Global $hHookInputBox

InputBox("Test", "Eingabe")
_InputBox("Test", "Eingabe")

Func _InputBox($title, $prompt, $default = Default, $passwordchar = Default, $width = Default, $height = Default, $left = Default, $top = Default, $timeout = Default, $hwnd = Default)
    Local $hProcInputBox = DllCallbackRegister("CbtHookProcInputBox", "int", "int;int;int")
    Local $TIDInputBox = _WinAPI_GetCurrentThreadId()
    $hHookInputBox = _WinAPI_SetWindowsHookEx($WH_CBT, DllCallbackGetPtr($hProcInputBox), 0, $TIDInputBox)
    Local $iRet = InputBox($title, $prompt, $default, $passwordchar, $width, $height, $left, $top, $timeout, $hwnd)
    Local $ierror = @error
    _WinAPI_UnhookWindowsHookEx($hHookInputBox)
    DllCallbackFree($hProcInputBox)
    Return SetError($ierror, "", $iRet)
EndFunc   ;==>_InputBox

Func CbtHookProcInputBox($nCode, $wParam, $lParam, $hHookInputBox)
    Local $RET = 0, $hBitmap = 0, $xWnd = 0
    Local $sButtonText
    If $nCode < 0 Then
        $RET = _WinAPI_CallNextHookEx($hHookInputBox, $nCode, $wParam, $lParam)
        Return $RET
    EndIf
    Switch $nCode
        Case 5 ;5=HCBT_ACTIVATE
            _WinAPI_SetDlgItemText($wParam, 1, "OK")
            _WinAPI_SetDlgItemText($wParam, 2, "Отмена")
    EndSwitch
    Return
EndFunc   ;==>CbtHookProcInputBox

Func _WinAPI_SetDlgItemText($hDlg, $nIDDlgItem, $lpString)
    Local $aRet = DllCall('user32.dll', "int", "SetDlgItemText", _
            "hwnd", $hDlg, _
            "int", $nIDDlgItem, _
            "str", $lpString)
    Return $aRet[0]
EndFunc   ;==>_WinAPI_SetDlgItemText