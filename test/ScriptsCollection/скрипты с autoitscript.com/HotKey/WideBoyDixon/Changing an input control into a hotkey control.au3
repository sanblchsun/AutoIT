; ==================================================================================================
; <_HotKeyControl.au3>
;
; Functions:
;   _ToggleAsHotkeyControl()
;   _GetAutoItHotkey()
;
;   _HotkeyWindowProc()
;   _GetAutoItCode()
;   _ShowHotKey()
;   _GetHandleIndex()
;
; Author: WideBoyDixon
; ==================================================================================================

#include-once

#include <WinAPI.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIEdit.au3>

#Region VIRTUAL_KEYS
Global Const $VKEY_LBUTTON = 0x01, $VKEY_RBUTTON = 0x02, $VKEY_CANCEL = 0x03, $VKEY_MBUTTON = 0x04
Global Const $VKEY_XBUTTON1 = 0x05, $VKEY_XBUTTON2 = 0x06, $VKEY_BACK = 0x08, $VKEY_TAB = 0x09
Global Const $VKEY_CLEAR = 0x0C, $VKEY_RETURN = 0x0D, $VKEY_SHIFT = 0x10, $VKEY_CONTROL = 0x11
Global Const $VKEY_MENU = 0x12, $VKEY_PAUSE = 0x13, $VKEY_CAPITAL = 0x14, $VKEY_KANA = 0x15
Global Const $VKEY_HANGEUL = 0x15, $VKEY_HANGUL = 0x15, $VKEY_JUNJA = 0x17, $VKEY_FINAL = 0x18
Global Const $VKEY_HANJA = 0x19, $VKEY_KANJI = 0x19, $VKEY_ESCAPE = 0x1B, $VKEY_CONVERT = 0x1C
Global Const $VKEY_NONCONVERT = 0x1D, $VKEY_ACCEPT = 0x1E, $VKEY_MODECHANGE = 0x1F, $VKEY_SPACE = 0x20
Global Const $VKEY_PRIOR = 0x21, $VKEY_NEXT = 0x22, $VKEY_END = 0x23, $VKEY_HOME = 0x24
Global Const $VKEY_LEFT = 0x25, $VKEY_UP = 0x26, $VKEY_RIGHT = 0x27, $VKEY_DOWN = 0x28
Global Const $VKEY_SELECT = 0x29, $VKEY_PRINT = 0x2A, $VKEY_EXECUTE = 0x2B, $VKEY_SNAPSHOT = 0x2C
Global Const $VKEY_INSERT = 0x2D, $VKEY_DELETE = 0x2E, $VKEY_HELP = 0x2F, $VKEY_LWIN = 0x5B
Global Const $VKEY_RWIN = 0x5C, $VKEY_APPS = 0x5D, $VKEY_SLEEP = 0x5F, $VKEY_NUMPAD0 = 0x60
Global Const $VKEY_NUMPAD1 = 0x61, $VKEY_NUMPAD2 = 0x62, $VKEY_NUMPAD3 = 0x63, $VKEY_NUMPAD4 = 0x64
Global Const $VKEY_NUMPAD5 = 0x65, $VKEY_NUMPAD6 = 0x66, $VKEY_NUMPAD7 = 0x67, $VKEY_NUMPAD8 = 0x68
Global Const $VKEY_NUMPAD9 = 0x69, $VKEY_MULTIPLY = 0x6A, $VKEY_ADD = 0x6B, $VKEY_SEPARATOR = 0x6C
Global Const $VKEY_SUBTRACT = 0x6D, $VKEY_DECIMAL = 0x6E, $VKEY_DIVIDE = 0x6F, $VKEY_F1 = 0x70
Global Const $VKEY_F2 = 0x71, $VKEY_F3 = 0x72, $VKEY_F4 = 0x73, $VKEY_F5 = 0x74
Global Const $VKEY_F6 = 0x75, $VKEY_F7 = 0x76, $VKEY_F8 = 0x77, $VKEY_F9 = 0x78
Global Const $VKEY_F10 = 0x79, $VKEY_F11 = 0x7A, $VKEY_F12 = 0x7B, $VKEY_F13 = 0x7C
Global Const $VKEY_F14 = 0x7D, $VKEY_F15 = 0x7E, $VKEY_F16 = 0x7F, $VKEY_F17 = 0x80
Global Const $VKEY_F18 = 0x81, $VKEY_F19 = 0x82, $VKEY_F20 = 0x83, $VKEY_F21 = 0x84
Global Const $VKEY_F22 = 0x85, $VKEY_F23 = 0x86, $VKEY_F24 = 0x87, $VKEY_NUMLOCK = 0x90
Global Const $VKEY_SCROLL = 0x91, $VKEY_OEM_NEC_EQUAL = 0x92, $VKEY_OEM_FJ_JISHO = 0x92, $VKEY_OEM_FJ_MASSHOU = 0x93
Global Const $VKEY_OEM_FJ_TOUROKU = 0x94, $VKEY_OEM_FJ_LOYA = 0x95, $VKEY_OEM_FJ_ROYA = 0x96
Global Const $VKEY_LSHIFT = 0xA0, $VKEY_RSHIFT = 0xA1, $VKEY_LCONTROL = 0xA2, $VKEY_RCONTROL = 0xA3
Global Const $VKEY_LMENU = 0xA4, $VKEY_RMENU = 0xA5, $VKEY_BROWSER_BACK = 0xA6, $VKEY_BROWSER_FORWARD = 0xA7
Global Const $VKEY_BROWSER_REFRESH = 0xA8, $VKEY_BROWSER_STOP = 0xA9, $VKEY_BROWSER_SEARCH = 0xAA, $VKEY_BROWSER_FAVORITES = 0xAB
Global Const $VKEY_BROWSER_HOME = 0xAC, $VKEY_VOLUME_MUTE = 0xAD, $VKEY_VOLUME_DOWN = 0xAE, $VKEY_VOLUME_UP = 0xAF
Global Const $VKEY_MEDIA_NEXT_TRACK = 0xB0, $VKEY_MEDIA_PREV_TRACK = 0xB1, $VKEY_MEDIA_STOP = 0xB2, $VKEY_MEDIA_PLAY_PAUSE = 0xB3
Global Const $VKEY_LAUNCH_MAIL = 0xB4, $VKEY_LAUNCH_MEDIA_SELECT = 0xB5, $VKEY_LAUNCH_APP1 = 0xB6, $VKEY_LAUNCH_APP2 = 0xB7
Global Const $VKEY_OEM_1 = 0xBA, $VKEY_OEM_PLUS = 0xBB, $VKEY_OEM_COMMA = 0xBC, $VKEY_OEM_MINUS = 0xBD
Global Const $VKEY_OEM_PERIOD = 0xBE, $VKEY_OEM_2 = 0xBF, $VKEY_OEM_3 = 0xC0, $VKEY_OEM_4 = 0xDB
Global Const $VKEY_OEM_5 = 0xDC, $VKEY_OEM_6 = 0xDD, $VKEY_OEM_7 = 0xDE, $VKEY_OEM_8 = 0xDF
Global Const $VKEY_OEM_AX = 0xE1, $VKEY_OEM_102 = 0xE2, $VKEY_ICO_HELP = 0xE3, $VKEY_ICO_00 = 0xE4
Global Const $VKEY_PROCESSKEY = 0xE5, $VKEY_ICO_CLEAR = 0xE6, $VKEY_PACKET = 0xE7, $VKEY_OEM_RESET = 0xE9
Global Const $VKEY_OEM_JUMP = 0xEA, $VKEY_OEM_PA1 = 0xEB, $VKEY_OEM_PA2 = 0xEC, $VKEY_OEM_PA3 = 0xED
Global Const $VKEY_OEM_WSCTRL = 0xEE, $VKEY_OEM_CUSEL = 0xEF, $VKEY_OEM_ATTN = 0xF0, $VKEY_OEM_FINISH = 0xF1
Global Const $VKEY_OEM_COPY = 0xF2, $VKEY_OEM_AUTO = 0xF3, $VKEY_OEM_ENLW = 0xF4, $VKEY_OEM_BACKTAB = 0xF5
Global Const $VKEY_ATTN = 0xF6, $VKEY_CRSEL = 0xF7, $VKEY_EXSEL = 0xF8, $VKEY_EREOF = 0xF9
Global Const $VKEY_PLAY = 0xFA, $VKEY_ZOOM = 0xFB, $VKEY_NONAME = 0xFC, $VKEY_PA1 = 0xFD, $VKEY_OEM_CLEAR = 0xFE
#EndRegion

#Region GLOBAL_VARIABLES
; This maps virtual keycodes to AutoIt equivalents
Global $gaVirtkeyMap[75][2] = [[$VKEY_SPACE, "{SPACE}"], [$VKEY_RETURN, "{ENTER}"], [$VKEY_MENU, "{ALT}"], [$VKEY_BACK, "{BS}"], _ ; 4
                                [$VKEY_DELETE, "{DEL}"], [$VKEY_UP, "{UP}"], [$VKEY_DOWN, "{DOWN}"], [$VKEY_LEFT, "{LEFT}"], _ ; 8
                                [$VKEY_RIGHT, "{RIGHT}"], [$VKEY_HOME, "{HOME}"], [$VKEY_END, "{END}"], [$VKEY_ESCAPE, "{ESC}"], _ ; 12
                                [$VKEY_INSERT, "{INS}"], [$VKEY_PRIOR, "{PGUP}"], [$VKEY_NEXT, "{PGDN}"], [$VKEY_F1, "{F1}"], _ ; 16
                                [$VKEY_F2, "{F2}"], [$VKEY_F3, "{F3}"], [$VKEY_F4, "{F4}"], [$VKEY_F5, "{F5}"], _ ; 20
                                [$VKEY_F6, "{F6}"], [$VKEY_F7, "{F7}"], [$VKEY_F8, "{F8}"], [$VKEY_F9, "{F9}"], _ ; 24
                                [$VKEY_F10, "{F10}"], [$VKEY_F11, "{F11}"], [$VKEY_F12, "{F12}"], [$VKEY_TAB, "{TAB}"], _ ; 28
                                [$VKEY_PRINT, "{PRINTSCREEN}"], [$VKEY_LWIN, "{LWIN}"], [$VKEY_RWIN, "{RWIN}"], _ ; 31
                                [$VKEY_NUMLOCK, "{NUMLOCK}"], [$VKEY_CAPITAL, "{CAPSLOCK}"], [$VKEY_SCROLL, "{SCROLLLOCK}"], _ ; 34
                                [$VKEY_PAUSE, "{PAUSE}"], [$VKEY_NUMPAD0, "{NUMPAD0}"], [$VKEY_NUMPAD1, "{NUMPAD1}"], _ ; 37
                                [$VKEY_NUMPAD2, "{NUMPAD2}"], [$VKEY_NUMPAD3, "{NUMPAD3}"], [$VKEY_NUMPAD4, "{NUMPAD4}"], _ ; 40
                                [$VKEY_NUMPAD5, "{NUMPAD5}"], [$VKEY_NUMPAD6, "{NUMPAD6}"], [$VKEY_NUMPAD7, "{NUMPAD7}"], _ ; 43
                                [$VKEY_NUMPAD8, "{NUMPAD8}"], [$VKEY_NUMPAD9, "{NUMPAD0}"], [$VKEY_ADD, "{NUMPADADD}"], _ ; 46
                                [$VKEY_SUBTRACT, "{NUMPADSUB}"], [$VKEY_DIVIDE, "{NUMPADDIV}"], [$VKEY_DECIMAL, "{NUMPADDOT}"], _ ; 49
                                [$VKEY_APPS, "{APPSKEY}"], [$VKEY_LMENU, "{LALT}"], [$VKEY_RMENU, "{RALT}"], _ ; 52
                                [$VKEY_LCONTROL, "{LCTRL}"], [$VKEY_RCONTROL, "{RCTRL}"], [$VKEY_LSHIFT, "{LSHIFT}"], _ ; 55
                                [$VKEY_RSHIFT, "{RSHIFT}"], [$VKEY_SLEEP, "{SLEEP}"], [$VKEY_BROWSER_BACK, "{BROWSER_BACK}"], _ ; 58
                                [$VKEY_BROWSER_FORWARD, "{BROWSER_FORWARD}"], [$VKEY_BROWSER_REFRESH, "{BROWSER_REFRESH}"], _ ; 60
                                [$VKEY_BROWSER_STOP, "{BROWSER_STOP}"], [$VKEY_BROWSER_SEARCH, "{BROWSER_SEARCH}"], _ ; 62
                                [$VKEY_BROWSER_FAVORITES, "{BROWSER_FAVORITES}"], [$VKEY_BROWSER_HOME, "{BROWSER_HOME}"], _ ; 64
                                [$VKEY_VOLUME_MUTE, "{VOLUME_MUTE}"], [$VKEY_VOLUME_DOWN, "{VOLUME_DOWN}"], [$VKEY_VOLUME_UP, "{VOLUME_UP}"], _ ; 67
                                [$VKEY_MEDIA_NEXT_TRACK, "{MEDIA_NEXT}"], [$VKEY_MEDIA_PREV_TRACK, "{MEDIA_PREV}"], _ ; 69
                                [$VKEY_MEDIA_STOP, "{MEDIA_STOP}"], [$VKEY_MEDIA_PLAY_PAUSE, "{MEDIA_PLAY_PAUSE}"], _ ; 71
                                [$VKEY_LAUNCH_MAIL, "{LAUNCH_MAIL}"], [$VKEY_LAUNCH_MEDIA_SELECT, "{LAUNCH_MEDIA}"], _ ; 73
                                [$VKEY_LAUNCH_APP1, "{LAUNCH_APP1}"], [$VKEY_LAUNCH_APP2, "{LAUNCH_APP2}"]] ; 75
                        
; Up to 20 hotkeys. Use this array to store:
;   - Window handle of the edit control
;   - AutoIt key combination
;   - Wndproc_new
;   - Wndproc_old
;   - Modifier key flags
;   - Locked flag
;   - Key
Global $gaHotkeyList[20][7]
#EndRegion

; ==================================================================================================
; Func _ToggleAsHotkeyControl($hWnd)
;
; Function to toggle whether the input control is a hotkey
;
; $hWnd = Handle to the input control
;
; Returns:
;   Success: True
;   Failure: False, with @error set:
;
; Author: WideBoyDixon
; ==================================================================================================
Func _ToggleAsHotkeyControl($hWnd)
    Dim $nI, $nJ = -1, $bFound = False
    
    ; Check the current array to see if we've already got this one
    For $nI = 0 To UBound($gaHotkeyList) - 1
        If $gaHotkeyList[$nI][0] = $hWnd Then
            ; Found it
            $bFound = True
            $nJ = $nI
            ExitLoop
        ElseIf (Not IsHWnd($gaHotkeyList[$nI][0])) And ($nJ = -1) Then
            ; Remember the first empty location
            $nJ = $nI
        EndIf
    Next
    
    ; If we already had it then remove this one
    If $bFound Then
        $gaHotkeyList[$nJ][0] = ""
        _WinAPI_SetWindowLong($hWnd, 0xFFFFFFFC, $gaHotkeyList[$nJ][3])
        Return SetError(0, 0, True)
    EndIf
    
    ; If we don't have any spare slots then this is an error
    If ($nJ = -1) Then Return SetError(1, 0, False)
    
    ; Store the details and subclass the window
    $gaHotkeyList[$nJ][0] = $hWnd
    $gaHotkeyList[$nJ][1] = ""
    $gaHotkeyList[$nJ][2] = DllCallbackRegister("_HotkeyWindowProc", "ptr", "hwnd;uint;long;ptr")
    $gaHotkeyList[$nJ][3] = _WinAPI_SetWindowLong($hWnd, 0xFFFFFFFC, DllCallbackGetPtr($gaHotkeyList[$nJ][2]))
    $gaHotkeyList[$nJ][4] = 0
    $gaHotkeyList[$nJ][5] = False
    $gaHotkeyList[$nJ][6] = ""
    
    ; Success
    Return SetError(0, 0, True)
EndFunc

; ==================================================================================================
; Func _HotkeyWindowProc($hWnd, $uiMsg, $wParam, $lParam)
;
; Windows procedure for subclassing an input control
;
; $hWnd = Handle to the input control
; $uiMsg = The windows message
; $wParam = WPARAM
; $lParam = LPARAM
;
; Returns:
;   1 = Don't process this message as it's already been handled
;   Other = Use the default processing for this message
;
; Author: WideBoyDixon
; ==================================================================================================
Func _HotkeyWindowProc($hWnd, $uiMsg, $wParam, $lParam)
    Local $scanCode, $sAutoitKey
    Local $nIndex = _GetHandleIndex($hWnd) ; Get the index of this window in the array
    If $nIndex >= 0 Then
        If $uiMsg = $WM_GETDLGCODE Then
            If $wParam = $VKEY_RETURN Then
                $uiMsg = $WM_KEYDOWN ; A bit of a hack to get {ENTER} recognised ...
            EndIf
        EndIf
        Switch $uiMsg
            Case $WM_SETFOCUS
                ; Re-start when we get the focus
                $gaHotkeyList[$nIndex][4] = 0
                $gaHotkeyList[$nIndex][5] = False
                $gaHotkeyList[$nIndex][6] = ""
            Case $WM_SYSKEYDOWN, $WM_KEYDOWN
                ; A key is down
                $scanCode = DllCall("user32.dll", "uint", "MapVirtualKey", "uint", $wParam, "uint", 2) ; Map the virtual key to a scan code
                Switch $wParam
                    Case $VKEY_SHIFT, $VKEY_LSHIFT, $VKEY_RSHIFT
                        ; Shift has been pressed
                        $gaHotkeyList[$nIndex][4] = BitOR($gaHotkeyList[$nIndex][4], 1)
                    Case $VKEY_CONTROL, $VKEY_LCONTROL, $VKEY_RCONTROL
                        ; Control has been pressed
                        $gaHotkeyList[$nIndex][4] = BitOR($gaHotkeyList[$nIndex][4], 2)
                    Case $VKEY_LWIN, $VKEY_RWIN
                        ; Windows key has been pressed
                        $gaHotkeyList[$nIndex][4] = BitOR($gaHotkeyList[$nIndex][4], 4)
                    Case $VKEY_MENU, $VKEY_LMENU, $VKEY_RMENU
                        ; Alt key has been pressed
                        $gaHotkeyList[$nIndex][4] = BitOR($gaHotkeyList[$nIndex][4], 8)
                    Case Else
                        $sAutoitKey = _GetAutoItCode($wParam) ; Is there an AutoIt equivalent?
                        If $sAutoitKey = "" Then
                            ; No AutoIt code ... can we use the scan code?
                            If $scanCode[0] <> 0 Then $sAutoitKey = Chr($scanCode[0])
                        EndIf
                        
                        ; If we have a key then store it
                        If $sAutoitKey <> "" Then
                            $gaHotkeyList[$nIndex][6] = $sAutoitKey
                            _ShowHotKey($nIndex)
                            $gaHotkeyList[$nIndex][5] = True
                        EndIf
                EndSwitch

                
                If Not $gaHotkeyList[$nIndex][5] Then _ShowHotKey($nIndex) ; Show the current status
                Return 1 ; Don't process this message any more
            Case $WM_SYSKEYUP, $WM_KEYUP
                ; A key is up
                Switch $wParam
                    Case $VKEY_SHIFT, $VKEY_LSHIFT, $VKEY_RSHIFT
                        ; Shift is up
                        $gaHotkeyList[$nIndex][4] = BitAND($gaHotkeyList[$nIndex][4], 14)
                    Case $VKEY_CONTROL, $VKEY_LCONTROL, $VKEY_RCONTROL
                        ; Control is up
                        $gaHotkeyList[$nIndex][4] = BitAND($gaHotkeyList[$nIndex][4], 13)
                    Case $VKEY_LWIN, $VKEY_RWIN
                        ; Windows key is up
                        $gaHotkeyList[$nIndex][4] = BitAND($gaHotkeyList[$nIndex][4], 11)
                    Case $VKEY_MENU, $VKEY_LMENU, $VKEY_RMENU
                        ; Alt is up
                        $gaHotkeyList[$nIndex][4] = BitAND($gaHotkeyList[$nIndex][4], 7)
                EndSwitch
                If Not $gaHotkeyList[$nIndex][5] Then _ShowHotKey($nIndex) ; Show the current status if necessary
                If $gaHotkeyList[$nIndex][5] Then
                    ; Have all modifier keys been released? If so then reset the hotkey
                    $gaHotkeyList[$nIndex][5] = ($gaHotkeyList[$nIndex][5] <> 0)
                    If Not $gaHotkeyList[$nIndex][5] Then $gaHotkeyList[$nIndex][6] = ""
                EndIf
                Return 1 ; Don't process this message any more
            Case $WM_CHAR, $WM_PASTE, $WM_CUT
                Return 1 ; Don't process this message any more
        EndSwitch
        
        ; Use default processing for all other messages
        Return _WinAPI_CallWindowProc($gaHotkeyList[$nIndex][3], $hWnd, $uiMsg, $wParam, $lParam)
    Else
        Return _WinAPI_DefWindowProc($hWnd, $uiMsg, $wParam, $lParam)
    EndIf
EndFunc

; ==================================================================================================
; Func _GetAutoItCode($vkCode)
;
; Get an AutoIt equivalent for a virtual key
;
; $vkCode = The virtual key code
;
; Returns:
;   The AutoIt equivalent or an empty string if there isn't one
;
; Author: WideBoyDixon
; ==================================================================================================
Func _GetAutoItCode($vkCode)
    Local $nI, $sRet = ""
    
    ; Look through the map array to find this value
    For $nI = 0 To UBound($gaVirtkeyMap) - 1
        If $gaVirtkeyMap[$nI][0] = $vkCode Then
            ; Found it ... return it
            $sRet = $gaVirtkeyMap[$nI][1]
            ExitLoop
        EndIf
    Next
    
    Return SetError(0, 0, $sRet)
EndFunc

; ==================================================================================================
; Func _ShowHotKey($nIndex)
;
; Display the HotKey for an input control
;
; $nIndex = The array index for the control
;
; Returns:
;   None - the text of the control is set
;
; Author: WideBoyDixon
; ==================================================================================================
Func _ShowHotKey($nIndex)
    Local $sText = ""
    $gaHotkeyList[$nIndex][1] = ""
    
    ; Build up the HotKey - display and AutoIt specific
    If BitAND($gaHotkeyList[$nIndex][4], 1) Then
        $gaHotkeyList[$nIndex][1] &= "+"
        $sText &= "SHIFT + "
    EndIf
    If BitAND($gaHotkeyList[$nIndex][4], 2) Then
        $gaHotkeyList[$nIndex][1] &= "^"
        $sText &= "CTRL + "
    EndIf
    If BitAND($gaHotkeyList[$nIndex][4], 4) Then
        $gaHotkeyList[$nIndex][1] &= "#"
        $sText &= "WIN + "
    EndIf
    If BitAND($gaHotkeyList[$nIndex][4], 8) Then
        $gaHotkeyList[$nIndex][1] &= "!"
        $sText &= "ALT + "
    EndIf
    $gaHotkeyList[$nIndex][1] &= $gaHotkeyList[$nIndex][6]
    $sText &= $gaHotkeyList[$nIndex][6]
    
    ; Set the window text and set the selection to be the end of the string
    _WinAPI_SetWindowText($gaHotkeyList[$nIndex][0], $sText)
    _GUICtrlEdit_SetSel($gaHotkeyList[$nIndex][0], StringLen($sText), StringLen($sText))
EndFunc

; ==================================================================================================
; Func _GetHandleIndex($hWnd)
;
; Get the index in the array for a window handle
;
; $hWnd = The window handle of the input control
;
; Returns:
;   The array index for the handle or -1 if it's not found
;
; Author: WideBoyDixon
; ==================================================================================================
Func _GetHandleIndex($hWnd)
    Local $nI, $nJ = -1
    For $nI = 0 To UBound($gaHotkeyList) - 1
        If $gaHotkeyList[$nI][0] = $hWnd Then
            $nJ = $nI
            ExitLoop
        EndIf
    Next
    Return $nJ
EndFunc

; ==================================================================================================
; Func _GetAutoItHotkey($hWnd)
;
; Get the AutoIt HotKey combination for a window handle
;
; $hWnd = The window handle of the input control
;
; Returns:
;   Success: The AutoIt version of the HotKey which can be used in hotkeyset
;   Failure: An empty string ("") with @error set to 1
;
; Author: WideBoyDixon
; ==================================================================================================
Func _GetAutoItHotkey($hWnd)
    Local $nIndex = _GetHandleIndex($hWnd)
    If $nIndex = -1 Then Return SetError(1, 0, "")
    Return SetError(0, 0, $gaHotkeyList[$nIndex][1])
EndFunc

; ==================================================================================================
; Func _SetAutoItHotkey($hWnd, $sAutoitKey)
;
; Set the AutoIt HotKey combination for a window handle
;
; $hWnd = The window handle of the input control
; $sAutoitKey = The Autoit HotKey string
;
; Returns:
;   Success: The AutoIt version of the HotKey which can be used in hotkeyset
;   Failure: An empty string ("") with @error set to 1
;
; Author: WideBoyDixon
; ==================================================================================================
Func _SetAutoItHotkey($hWnd, $sAutoitKey)
    Local $nIndex = _GetHandleIndex($hWnd), $sKey = $sAutoitKey
    If $nIndex = -1 Then Return SetError(1, 0, False)
    $gaHotkeyList[$nIndex][4] = 0
    $gaHotkeyList[$nIndex][5] = False
    $gaHotkeyList[$nIndex][6] = ""
    While StringInStr("+^#!", StringLeft($sKey, 1)) > 0
        Switch StringLeft($sKey, 1)
            Case "+"
                $gaHotkeyList[$nIndex][4] += 1
            Case "^"
                $gaHotkeyList[$nIndex][4] += 2
            Case "#"
                $gaHotkeyList[$nIndex][4] += 4
            Case "!"
                $gaHotkeyList[$nIndex][4] += 8
        EndSwitch
        $sKey = StringMid($sKey, 2)
    Wend
    $gaHotkeyList[$nIndex][6] = $sKey
    _ShowHotKey($nIndex)
EndFunc

; ?oY?? OLZ??^?? {
; .?O?jeh??6#include "_HotKeyControl.au3"

GUICreate("Press a key", 256, 72)
Dim $cEdit1 = GUICtrlCreateInput("", 8, 8, 240, 24)
Dim $hwndEdit1 = GUICtrlGetHandle($cEdit1)
Dim $cEdit2 = GUICtrlCreateInput("", 8, 40, 240, 24)
Dim $hwndEdit2 = GUICtrlGetHandle($cEdit2)
GUISetState(@SW_SHOW)

_ToggleAsHotkeyControl($hwndEdit1)
_ToggleAsHotkeyControl($hwndEdit2)

_SetAutoItHotkey($hwndEdit2, "+^{F3}")

Do
    Sleep(10)
Until GUIGetMsg() = $GUI_EVENT_CLOSE

MsgBox(64, "Hotkey 1", _GetAutoItHotkey($hwndEdit1), 2)
MsgBox(64, "Hotkey 2", _GetAutoItHotkey($hwndEdit2), 2)

_ToggleAsHotkeyControl($hwndEdit2)
_ToggleAsHotkeyControl($hwndEdit1)

GUIDelete()

Exit