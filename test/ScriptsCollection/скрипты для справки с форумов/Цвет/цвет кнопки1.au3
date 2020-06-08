#Include <Constants.au3>
#Include <GUIConstantsEx.au3>
#Include <StaticConstants.au3>
#Include <WindowsConstants.au3>
#Include <WinAPI.au3>

Dim $Button[4]

$hForm = GUICreate('MyGUI', 350, 63)

$Button[0] = GUICtrlCreateButton('', 20, 20, 70, 23)
GUICtrlCreateLabel('Button1', 20, 20, 70, 23, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetColor(-1, 0xFF00FF)

$Button[1] = GUICtrlCreateButton('', 100, 20, 70, 23)
GUICtrlCreateLabel('Button2', 100, 20, 70, 23, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetColor(-1, 0xFF0000)

$Button[2] = GUICtrlCreateButton('', 180, 20, 70, 23)
GUICtrlCreateLabel('Button1', 180, 20, 70, 23, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetColor(-1, 0x00FF00)

$Button[3] = GUICtrlCreateButton('', 260, 20, 70, 23)
GUICtrlCreateLabel('Button1', 260, 20, 70, 23, BitOR($SS_CENTER, $SS_CENTERIMAGE))
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetColor(-1, 0x0000FF)

$hDll = DllCallbackRegister('_WinProc', 'ptr', 'hwnd;uint;wparam;lparam')
$pDll = DllCallbackGetPtr($hDll)
For $i = 0 To UBound($Button) - 1
    $hProc = _WinAPI_SetWindowLong(GUICtrlGetHandle($Button[$i]), $GWL_WNDPROC, $pDll)
Next

GUISetState()

While 1
    $Msg = GUIGetMsg()
    Switch $Msg
        Case -3
            ExitLoop
        Case $Button[0], $Button[1], $Button[2], $Button[3]
            MsgBox(0, 'Message', 'Button is pressed.', 0, $hForm)
    EndSwitch
WEnd

For $i = 0 To UBound($Button) - 1
    _WinAPI_SetWindowLong(GUICtrlGetHandle($Button[$i]), $GWL_WNDPROC, $hProc)
Next
DllCallbackFree($hDll)

Func _WinProc($hWnd, $iMsg, $wParam, $lParam)
    Switch $iMsg
        Case $WM_PAINT

            Local $tRECT = DllStructCreate($tagRECT)
            Local $Ret = DllCall('user32.dll', 'int', 'GetUpdateRect', 'hwnd', $hWnd, 'ptr', DllStructGetPtr($tRECT), 'int', 1)

            If $Ret[0] Then
                _WinAPI_InvalidateRect(GUICtrlGetHandle(_WinAPI_GetDlgCtrlID($hWnd) + 1), $tRECT)
            EndIf
    EndSwitch
    Return _WinAPI_CallWindowProc($hProc, $hWnd, $iMsg, $wParam, $lParam)
EndFunc   ;==>_WinProc