#include <GuiConstants.au3>
#include <WindowsConstants.au3>
$my_gui = GUICreate("MyGUI", 300, 200, -1, -1, $WS_POPUP)
_GuiRoundCorners($my_gui, 0, 0, 30, 30)
GUISetBkColor(0x85BBDD)
GUIRegisterMsg($WM_NCHITTEST, 'WM_NCHITTEST')
$Button1 = GUICtrlCreateButton("Выход", 20, 100, 80, 20)
GUISetState()
While 1
    $msg = GUIGetMsg()
    Switch $msg
        Case $GUI_EVENT_CLOSE
            ExitLoop
        Case $Button1
            ExitLoop
    EndSwitch

WEnd
Exit

Func _GuiRoundCorners($h_win, $i_x1, $i_y1, $i_x3, $i_y3)
    Dim $pos, $ret, $ret2
    $pos = WinGetPos($h_win)
    $ret = DllCall("gdi32.dll", "long", "CreateRoundRectRgn", "long", $i_x1, "long", $i_y1, "long", $pos[2], "long", $pos[3], "long", $i_x3, "long", $i_y3)
    If $ret[0] Then
        $ret2 = DllCall("user32.dll", "long", "SetWindowRgn", "hwnd", $h_win, "long", $ret[0], "int", 1)
        If $ret2[0] Then
            Return 1
        Else
            Return 0
        EndIf
    Else
        Return 0
    EndIf
EndFunc   ;==>_GuiRoundCorners

Func WM_NCHITTEST($hWnd, $msg, $wParam, $lParam)
    Local $iProc = DllCall('user32.dll', 'int', 'DefWindowProc', 'hwnd', $hWnd, 'int', _
            $msg, 'wparam', $wParam, 'lparam', $lParam)
    If $iProc[0] = $HTCLIENT Then Return $HTCAPTION
    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NCHITTEST
