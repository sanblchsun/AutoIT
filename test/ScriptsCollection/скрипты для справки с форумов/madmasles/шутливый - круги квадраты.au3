#NoTrayIcon
#include <WindowsConstants.au3>
#include <WinAPI.au3>

HotKeySet('{ESC}', '_Quit')

$iW = Random(40, 150, 1)
$iH = Random(40, 150, 1)
$hDot_GUI = GUICreate('', $iW, $iH, -1, -1, $WS_POPUP, BitOR($WS_EX_TOOLWINDOW, $WS_EX_TOPMOST))
GUISetBkColor(0xFF0000)
$nLabel = GUICtrlCreateLabel('', 0, 0, $iW, $iH)
$hRgn = _WinAPI_CreateRoundRectRgn(0, 0, $iW, $iH, $iW, $iH)
_WinAPI_SetWindowRgn($hDot_GUI, $hRgn)
_WinAPI_DeleteObject($hRgn)
GUISetState(@SW_SHOWNOACTIVATE)

While 1
    WinSetOnTop($hDot_GUI, '', 1)
    $aCursor = GUIGetCursorInfo($hDot_GUI)
    If $aCursor[4] Then
        _WinAPI_MessageBeep(5)
        $iW = Random(40, 150, 1)
        $iH = Random(40, 150, 1)
        WinMove($hDot_GUI, '', Random(10, @DesktopWidth - $iW * 2, 1), Random(10, @DesktopHeight - $iH * 2, 1), $iW, $iH)
        If Mod($iW + $iH, 2) Then
            $hRgn = _WinAPI_CreateRoundRectRgn(0, 0, $iW, $iH, $iW, $iH)
            _WinAPI_SetWindowRgn($hDot_GUI, $hRgn)
            _WinAPI_DeleteObject($hRgn)
        Else
            $hRgn = _WinAPI_CreateRoundRectRgn(0, 0, $iW, $iH, 0, 0)
            _WinAPI_SetWindowRgn($hDot_GUI, $hRgn)
            _WinAPI_DeleteObject($hRgn)
        EndIf
        GUISetBkColor(Random(0, 16777215, 65793), $hDot_GUI)
    EndIf
    Sleep(10)
WEnd

Func _Quit()
    Exit
EndFunc   ;==>_Quit