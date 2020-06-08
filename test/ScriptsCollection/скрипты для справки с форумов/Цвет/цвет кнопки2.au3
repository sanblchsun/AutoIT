#Include <Constants.au3>
#Include <GUIConstantsEx.au3>
#Include <StaticConstants.au3>
#Include <WindowsConstants.au3>
#Include <WinAPI.au3>

Global $hLastWndProc
Global $hBtnCtrlWndProc = DllCallbackRegister('__GUICtrlCreateButton_WndProc', 'ptr', 'hwnd;uint;wparam;lparam')
Global $pBtnCtrlWndProc = DllCallbackGetPtr($hBtnCtrlWndProc)

$hForm = GUICreate('Set Button Color - _GUICtrlCreateButtonEx', 370, 65)

$aButton1 = _GUICtrlCreateButtonEx('Button1', 30, 20, 70, 23, BitOR($SS_CENTER, $SS_CENTERIMAGE), -1, 0xFF00FF)
$aButton2 = _GUICtrlCreateButtonEx('Button2', 110, 20, 70, 23, BitOR($SS_CENTER, $SS_CENTERIMAGE), -1, 0xFF0000)
$aButton3 = _GUICtrlCreateButtonEx('Button3', 190, 20, 70, 23, BitOR($SS_CENTER, $SS_CENTERIMAGE), -1, 0x00FF00)
$aButton4 = _GUICtrlCreateButtonEx('Button4', 270, 20, 70, 23, BitOR($SS_CENTER, $SS_CENTERIMAGE), -1, 0x0000FF)

GUISetState()

While 1
    $nMsg = GUIGetMsg()

    Switch $nMsg
        Case $GUI_EVENT_CLOSE
            For $i = 1 To 4
                _WinAPI_SetWindowLong(Execute("$aButton" & $i & "[2]"), $GWL_WNDPROC, $hLastWndProc)
            Next

            DllCallbackFree($hBtnCtrlWndProc)

            Exit
        Case $aButton1[0], $aButton2[0], $aButton3[0], $aButton4[0]
            MsgBox(64, 'Message', GUICtrlRead($nMsg+1, 1) & ' is pressed.', 0, $hForm)
    EndSwitch
WEnd

Func _GUICtrlCreateButtonEx($sText, $iLeft, $iTop, $iWidth = -1, $iHeight = -1, $nStyle = -1, $nExStyle = -1, $nColor = -1)
    Local $anButton[3]

    $anButton[0] = GUICtrlCreateButton('', $iLeft, $iTop, $iWidth, $iHeight)
    $anButton[1] = GUICtrlCreateLabel($sText, $iLeft, $iTop, $iWidth, $iHeight, BitOR($SS_CENTER, $SS_CENTERIMAGE))
    $anButton[2] = GUICtrlGetHandle($anButton[0])
    GUICtrlSetBkColor($anButton[1], $GUI_BKCOLOR_TRANSPARENT)

    GUICtrlSetColor($anButton[1], $nColor)
    $hLastWndProc = _WinAPI_SetWindowLong($anButton[2], $GWL_WNDPROC, $pBtnCtrlWndProc)

    Return $anButton
EndFunc

Func __GUICtrlCreateButton_WndProc($hWnd, $iMsg, $wParam, $lParam)
    Switch $iMsg
        Case $WM_PAINT
            Local $tRECT = DllStructCreate($tagRECT)
            Local $Ret = DllCall('user32.dll', 'int', 'GetUpdateRect', 'hwnd', $hWnd, 'ptr', DllStructGetPtr($tRECT), 'int', 1)

            If $Ret[0] Then
                _WinAPI_InvalidateRect(GUICtrlGetHandle(_WinAPI_GetDlgCtrlID($hWnd) + 1), $tRECT)
            EndIf
    EndSwitch

    Return _WinAPI_CallWindowProc($hLastWndProc, $hWnd, $iMsg, $wParam, $lParam)
EndFunc