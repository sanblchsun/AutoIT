Global Const $WM_DWMCOMPOSITIONCHANGED = 0x031E

$hForm = GUICreate('MyGUI', @DesktopWidth, @DesktopHeight)
GUIRegisterMsg($WM_DWMCOMPOSITIONCHANGED, 'WM_DWMCOMPOSITIONCHANGED')
WM_DWMCOMPOSITIONCHANGED($hForm, $WM_DWMCOMPOSITIONCHANGED, 0, 0)
GUISetState()

Do
Until GUIGetMsg() = -3

Func _WinAPI_DwmExtendFrameIntoClientArea($hWnd, $tMargins = 0)

    If Not IsDllStruct($tMargins) Then
        $tMargins = DllStructCreate('int;int;int;int')
        For $i = 1 To 4
            DllStructSetData($tMargins, $i, -1)
        Next
    EndIf

    Local $Ret = DllCall('dwmapi.dll', 'int', 'DwmExtendFrameIntoClientArea', 'hwnd', $hWnd, 'ptr', DllStructGetPtr($tMargins))

    If @error Then
        Return SetError(1, 0, 0)
    Else
        If $Ret[0] Then
            Return SetError(1, $Ret[0], 0)
        EndIf
    EndIf
    Return 1
EndFunc   ;==>_WinAPI_DwmExtendFrameIntoClientArea

Func _WinAPI_DwmIsCompositionEnabled()

    Local $Ret = DllCall('dwmapi.dll', 'int', 'DwmIsCompositionEnabled', 'int*', 0)

    If @error Then
        Return SetError(1, 0, 0)
    Else
        If $Ret[0] Then
            Return SetError(1, $Ret[0], 0)
        EndIf
    EndIf
    Return $Ret[1]
EndFunc   ;==>_WinAPI_DwmIsCompositionEnabled

Func WM_DWMCOMPOSITIONCHANGED($hWnd, $iMsg, $wParam, $lParam)

    Local $RGB = 0xFFFFFF

    Switch $hWnd
        Case $hForm
            If _WinAPI_DwmIsCompositionEnabled() Then
                _WinAPI_DwmExtendFrameIntoClientArea($hWnd)
                $RGB = 0
            EndIf
            GUISetBkColor($RGB, $hWnd)
    EndSwitch
    Return 0
EndFunc   ;==>WM_DWMCOMPOSITIONCHANGED
