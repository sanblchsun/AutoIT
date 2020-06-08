#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
;

HotKeySet("^+e", "_Exit_Proc")



$hFrame_GUI = GUICreate("Frame", 500, 300, -1, -1, _
    BitOR($WS_POPUP, $WS_SIZEBOX), BitOR($WS_EX_TOPMOST, $WS_EX_TOOLWINDOW))

$hGUI = GUICreate("Resizing Transparent GUI Example", 500, 300, 4, 4, _
    $WS_POPUP, BitOR($WS_EX_MDICHILD, $WS_EX_TOOLWINDOW, $WS_EX_TRANSPARENT), $hFrame_GUI)

_GUICreateHole($hFrame_GUI, 4, 4, 497, 297)
_GUISetOptions_Proc()

GUISetState(@SW_SHOW, $hGUI)
GUISetState(@SW_SHOW, $hFrame_GUI)

WM_SIZE($hFrame_GUI)

GUIRegisterMsg($WM_SIZE, "WM_SIZE")

While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            Exit
    EndSwitch
WEnd

Func _GUISetOptions_Proc()
    Local $aHWnds[2] = [$hGUI, $hFrame_GUI]

    For $i = 0 To 1
        WinSetTrans($aHWnds[$i], "", 100)
        GUISetBkColor(0xFF0000, $aHWnds[$i])
        GUISetCursor(0, 1, $aHWnds[$i])
    Next
EndFunc

Func _GUICreateHole($hWin, $i_X, $i_Y, $i_SizeW, $i_SizeH)
    Local $aWinPos, $aOuter_Rgn, $aInner_Rgn, $aCombined_Rgn

    Local Const $RGN_AND = 1
    Local Const $RGN_OR = 2
    Local Const $RGN_XOR = 3
    Local Const $RGN_DIFF = 4
    Local Const $RGN_COPY = 5

    $aWinPos = WinGetPos($hWin)

    $aOuter_Rgn = DllCall("gdi32.dll", "long", "CreateRectRgn", "long", 0, "long", 0, "long", $aWinPos[2], "long", $aWinPos[3])
    $aInner_Rgn = DllCall("gdi32.dll", "long", "CreateRectRgn", "long", _
        $i_X, "long", $i_Y, "long", $i_X + $i_SizeW, "long", $i_Y + $i_SizeH)

    $aCombined_Rgn = DllCall("gdi32.dll", "long", "CreateRectRgn", "long", 0, "long", 0, "long", 0, "long", 0)

    DllCall("gdi32.dll", "long", "CombineRgn", _
        "long", $aCombined_rgn[0], "long", $aOuter_Rgn[0], "long", $aInner_Rgn[0], "int", $RGN_DIFF)

    DllCall("user32.dll", "long", "SetWindowRgn", "hwnd", $hWin, "long", $aCombined_Rgn[0], "int", 1)
EndFunc

Func WM_SIZE($hWnd=0, $MsgID=0, $wParam=0, $lParam=0)
    Switch $hWnd
        Case $hFrame_GUI
            Local $aFrameGUI_Pos = WinGetPos($hFrame_GUI)
            _GUICreateHole($hFrame_GUI, 4, 4, $aFrameGUI_Pos[2]-8, $aFrameGUI_Pos[3]-8)
            WinMove($hGUI, "", $aFrameGUI_Pos[0] + 4, $aFrameGUI_Pos[1] + 4, $aFrameGUI_Pos[2] - 8, $aFrameGUI_Pos[3] - 8)
    EndSwitch
EndFunc

Func _Exit_Proc()
    Exit
EndFunc