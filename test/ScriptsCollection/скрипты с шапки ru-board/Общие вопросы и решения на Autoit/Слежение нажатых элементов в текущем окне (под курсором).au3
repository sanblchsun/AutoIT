HotKeySet("^q", "_Quit")

Global $hUser32_Dll = DllOpen("User32.dll")

While 1
    If _IsPressedEx("{LMouse}", $hUser32_Dll) Then
        $hWindow = _WinGetHoveredHandle()
        $iCtrlID = _ControlGetHoveredID()

        $sWinTitle = WinGetTitle($hWindow)
        $sCtrlData = ControlGetText($hWindow, "", $iCtrlID)

        If Not StringInStr($sCtrlData, "Hovered Win Title:") Then
            If StringInStr($sWinTitle, "SciTE", 1) Then $sCtrlData = "" ;To prevent tooltip "hanging"

            ToolTip( _
                "Hovered Win Handle:    " & $hWindow & @CRLF & _
                "Hovered Win Title: " & $sWinTitle & @CRLF & _
                "Hovered CtrlID:        " & $iCtrlID & @CRLF & _
                "Hovered CtrlID Data:   " & $sCtrlData, Default, Default, "ToolTip Info", 1, 5)
        EndIf
    Else
        ToolTip("")
    EndIf

    Sleep(10)
WEnd

Func _ControlGetHoveredID()
    Local $iOld_Opt_MCM = Opt("MouseCoordMode", 1)

    Local $hRet = DllCall("user32.dll", "int", "WindowFromPoint", "long", MouseGetPos(0), "long", MouseGetPos(1))

    $hRet = DllCall("user32.dll", "int", "GetDlgCtrlID", "hwnd", $hRet[0])
    If $hRet[0] < 0 Then $hRet[0] = 0

    Opt("MouseCoordMode", $iOld_Opt_MCM)

    Return $hRet[0]
EndFunc

Func _WinGetHoveredHandle()
    Local $iOld_Opt_MCM = Opt("MouseCoordMode", 1)
    Local $aRet = DllCall("user32.dll", "int", "WindowFromPoint", "long", MouseGetPos(0), "long", MouseGetPos(1))

    Opt("MouseCoordMode", $iOld_Opt_MCM)

    $aRet = DllCall("User32.dll", "hwnd", "GetAncestor", "hwnd", $aRet[0], "uint", 2) ;$GA_ROOT

    Return HWnd($aRet[0])
EndFunc

Func _IsPressedEx($sHexKey, $vDLL = 'User32.dll')
    Local $aKeys = StringSplit("{LMouse}|{RMouse}|{}|(MMouse}|{}|{}|{}|{BACKSPACE}|{TAB}|{}|{}|{}|{ENTER}|{}|{}|{SHIFT}|{CTRL}|{ALT}|{PAUSE}|{CAPSLOCK}|{}|{}|{}|{}|{}|{}|{ESC}|{}|{}|{}|{]|{SPACE}|{PGUP}|{PGDN}|{END}|{HOME}|{LEFT}|{UP}|{RIGHT}|{DOWN}|{SELECT}|{PRINTSCREEN}|{}|{PRINTSCREEN}|{INSERT}|{DEL}|{}|0|1|2|3|4|5|6|7|8|9|{}|{}|{}|{}|{}|{}|{}|a|b|c|d|e|f|g|h|i|j|k|l|m|n|o|p|q|r|s|t|u|v|w|x|y|z|{LWIN}|{RWIN}|{APPSKEY}|{}|{SLEEP}|{numpad0}|{numpad1}|{numpad2}|{numpad3}|{numpad4}|{numpad5}|{numpad6}|{numpad7}|{numpad8}|{numpad9}|{NUMPADMULT}|{NUMPADADD}|{}|{NUMPADSUB}|{NUMPADDOT}|{NUMPADDIV}|{F1}|{F2}|{F3}|{F4}|{F5}|{F6}|{F7}|{F8}|{F9}|{F10}|{F11}|{F12}|{F13}|{F14}|{F15}|{F16}|{F17}|{F18}|{F19}|{F20}|{F21}|{F22}|{F23}|{F24}|{}|{}|{}|{}|{}|{}|{}|{}|{NUMLOCK}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{SHIFT}|{SHIFT}|{CTRL}|{CTRL}|{ALT}|{ALT}|{BROWSER_BACK}|{BROWSER_FORWARD}|{BROWSER_REFRESH}|{BROWSER_STOP}|{BROWSER_SEARCH}|{BROWSER_FAVORITES}|{BROWSER_HOME}|{VOLUME_MUTE}|{VOLUME_DOWN}|{VOLUME_UP}|{MEDIA_NEXT}|{MEDIA_PREV}|{MEDIA_STOP}|{MEDIA_PLAY_PAUSE}|{LAUNCH_MAIL}|{LAUNCH_MEDIA}|{LAUNCH_APP1}|{LAUNCH_APP2}|{}|{}|;|{+}|,|{-}|.|/|`|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|{}|[|\|]|'", "|")

    For $i = 1 To $aKeys[0]
        If $aKeys[$i] = $sHexKey Then
            $sHexKey = "0x" & Hex($i, 2)
            ExitLoop
        EndIf
    Next

    If StringLeft($sHexKey, 2) <> "0x" Then $sHexKey = '0x' & $sHexKey

    Local $a_R = DllCall($vDLL, "int", "GetAsyncKeyState", "int", $sHexKey)

    If Not @error And BitAND($a_R[0], 0x8000) = 0x8000 Then Return 1
    Return 0
EndFunc

Func _Quit()
    DllClose($hUser32_Dll)
    Exit
EndFunc