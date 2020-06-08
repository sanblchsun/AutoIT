#include <WinAPI.au3>
#include <WindowsConstants.au3>
;

HotKeySet("{Pause}", "_Exit")

Global $pStub_KeyProc = DllCallbackRegister("_KeyboardProc", "int", "int;ptr;ptr")
Global $hHook = _WinAPI_SetWindowsHookEx($WH_KEYBOARD_LL, DllCallbackGetPtr($pStub_KeyProc), _WinAPI_GetModuleHandle(0), 0)

Global $iLastTime = -1
Global $sLast_vkCode = ""

While 1
    Sleep(100)
WEnd

Func _KeyboardProc($nCode, $wParam, $lParam)
    If $nCode < 0 Then Return _WinAPI_CallNextHookEx($hHook, $nCode, $wParam, $lParam)

    Switch $wParam
        Case $WM_KEYDOWN
            Local $KBDLLHOOKSTRUCT = DllStructCreate("dword vkCode;dword scanCode;dword flags;dword Time;ptr dwExtraInfo", $lParam)
            Local $iTime = DllStructGetData($KBDLLHOOKSTRUCT, "Time")
            Local $vkCode = DllStructGetData($KBDLLHOOKSTRUCT, "vkCode")

            If $iLastTime <> -1 Then
                Local $iElapsedTime = $iTime - $iLastTime
                $iLastTime = $iTime

                Local $sOut_Format = StringFormat("+> Elapsed time since last key input (Last=%s, Current=%s): %i ms\n", _
                    _Get_vkCode_Char($sLast_vkCode), _Get_vkCode_Char($vkCode), $iElapsedTime)

                ConsoleWrite($sOut_Format)
            Else
                $iLastTime = $iTime
                ConsoleWrite("!> First Key Input: " & _Get_vkCode_Char($vkCode) & @LF)
            EndIf

            $sLast_vkCode = $vkCode
    EndSwitch

    _WinAPI_CallNextHookEx($hHook, $nCode, $wParam, $lParam)
EndFunc

Func _Get_vkCode_Char($vkCode)
    Local $aKeys = StringSplit("{LMouse}|{RMouse}|{}|(MMouse}|{}|{}|{}|{BACKSPACE}|{TAB}|{}|{}|{}|{ENTER}|{}|{}|{SHIFT}|{CTRL}|{ALT}|{PAUSE}|{CAPSLOCK}|{}|{}|{}|{}|{}|{}|{ESC}|{}|{}|{}|{]|{SPACE}|{PGUP}|{PGDN}|{END}|{HOME}|{LEFT}|{UP}|{RIGHT}|{DOWN}|{SELECT}|{PRINTSCREEN}|{}|{PRINTSCREEN}|{INSERT}|{DEL}|{}|0|1|2|3|4|5|6|7|8|9|{}|{}|{}|{}|{}|{}|{}|a|b|c|d|e|f|g|h|i|j|k|l|m|n|o|p|q|r|s|t|u|v|w|x|y|z|{LWIN}|{RWIN}|{APPSKEY}|{}|{SLEEP}|{numpad0}|{numpad1}|{numpad2}|{numpad3}|{numpad4}|{numpad5}|{numpad6}|{numpad7}|{numpad8}|{numpad9}|{NUMPADMULT}|{NUMPADADD}|{}|{NUMPADSUB}|{NUMPADDOT}|{NUMPADDIV}|{F1}|{F2}|{F3}|{F4}|{F5}|{F6}|{F7}|{F8}|{F9}|{F10}|{F11}|{F12}|{F13}|{F14}|{F15}|{F16}|{F17}|{F18}|{F19}|{F20}|{F21}|{F22}|{F23}|{F24}|{}|{}|{}|{}|{}|{}|{}|{}|{NUMLOCK}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{SHIFT}|{SHIFT}|{CTRL}|{CTRL}|{ALT}|{ALT}|{BROWSER_BACK}|{BROWSER_FORWARD}|{BROWSER_REFRESH}|{BROWSER_STOP}|{BROWSER_SEARCH}|{BROWSER_FAVORITES}|{BROWSER_HOME}|{VOLUME_MUTE}|{VOLUME_DOWN}|{VOLUME_UP}|{MEDIA_NEXT}|{MEDIA_PREV}|{MEDIA_STOP}|{MEDIA_PLAY_PAUSE}|{LAUNCH_MAIL}|{LAUNCH_MEDIA}|{LAUNCH_APP1}|{LAUNCH_APP2}|{}|{}|;|{+}|,|{-}|.|/|`|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|[|\|]|'", "|")

    For $i = 1 To $aKeys[0]
        If $vkCode = $i Then Return $aKeys[$i]
    Next

    Return "0x" & Hex($vkCode, 2)
EndFunc

Func _Exit()
    DllCallbackFree($pStub_KeyProc)
    _WinAPI_UnhookWindowsHookEx($hHook)
    Exit
EndFunc