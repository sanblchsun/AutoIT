#include <WinAPI.au3>
#include <Constants.au3>
Local $hProcInputBox = DllCallbackRegister("CbtHookProcInputBox", "int", "int;int;int")
Local $TIDInputBox = _WinAPI_GetCurrentThreadId()
Local $hHookInputBox = _WinAPI_SetWindowsHookEx($WH_CBT, DllCallbackGetPtr($hProcInputBox), 0, $TIDInputBox)
Local $answer = InputBox("Question", "Where were you born?", "Planet Earth", "", -1, -1);, 0, 0)
_WinAPI_UnhookWindowsHookEx($hHookInputBox)
DllCallbackFree($hProcInputBox)

#region Just for fun(key)!!
;##########################################################
Func CbtHookProcInputBox($nCode, $wParam, $lParam)
 Static $iWindowIndex = 0
    Local $RET = 0, $hBitmap = 0, $xWnd = 0
    If $nCode < 0 Then
        $RET = _WinAPI_CallNextHookEx($hHookInputBox, $nCode, $wParam, $lParam)
        Return $RET
    EndIf
    Switch $nCode
 Case 3 ;3=HCBT_CREATEWND
  If $iWindowIndex = 2 Then
   _WinAPI_SetWindowLong($wParam, $GWL_STYLE, 0x50010081)
  EndIf
  $iWindowIndex += 1
  Case 5 ;5=HCBT_ACTIVATE
            _WinAPI_SetDlgItemText($wParam, 1, "Accept")
            _WinAPI_SetDlgItemText($wParam, 2, "Abort")
   _WinAPI_SetWindowPos($wParam, -1, 0, 0, 0, 0, BitOR(0x10, 0x2, 0x1))   ;WinSetOnTop
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
;##########################################################
#endregion Just for fun(key)!!