#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

 ; параметр $GUI_WS_EX_PARENTDRAG отвечает за перемещение за лейбл
 ; WM_NCHITTEST отвечает за перемещение за не занятую другими элементами область окна.
 ; если элементов много, то ко всем нужно применить $GUI_WS_EX_PARENTDRAG, либо сделать подложку - скрытый лэйбл с этим параметром, но не все элементы работают с такой подложкой
 ; в данном примере можно сделать лейбл по размеру окна, а текст центрировать стилем BitOR($SS_CENTER, $SS_CENTERIMAGE)
$h_HWND = GUICreate("", 268, 91, -1, -1, BitOR($WS_POPUP, $WS_CLIPSIBLINGS), $WS_EX_TOPMOST)
GUISetBkColor(0x0A246A)
GUIRegisterMsg($WM_NCHITTEST, 'WM_NCHITTEST')
GUICtrlCreateLabel("Нажми и тащи!", 70, 35, 170, 40, -1, $GUI_WS_EX_PARENTDRAG)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetFont(-1, 12, 400, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xA6CAF0)
GUICtrlSetCursor(-1, 0)
GUISetState(@SW_SHOW)

While 1
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case $GUI_EVENT_CLOSE
            Exit

    EndSwitch
WEnd

Func WM_NCHITTEST($hWnd, $Msg, $wParam, $lParam)
    Local $iProc = DllCall('user32.dll', 'int', 'DefWindowProc', 'hwnd', $hWnd, 'int', _
            $Msg, 'wparam', $wParam, 'lparam', $lParam)
			; ToolTip($iProc[0]&@CRLF&$HTCLIENT&@CRLF&$HTCAPTION&@CRLF&BitAND($lParam, 0xFFFF) &@CRLF&BitShift($lParam, 16)) ; просмотр возвращаемых параметров
    If $iProc[0] = $HTCLIENT Then Return $HTCAPTION
    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NCHITTEST