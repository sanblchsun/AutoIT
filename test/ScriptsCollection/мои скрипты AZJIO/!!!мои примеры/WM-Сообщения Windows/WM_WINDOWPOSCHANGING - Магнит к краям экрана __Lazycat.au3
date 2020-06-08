; http://www.autoitscript.com/forum/topic/24342-form-snap/page__view__findpost__p__170144
#include <GUIConstants.au3>

Global Const $WM_WINDOWPOSCHANGING = 0x0046 
Global Const $SPI_GETWORKAREA = 0x30

Global $nGap = 20, $nEdge = BitOR(1, 2, 4, 8); Left, Top, Right, Bottom

$hGUI = GUICreate("Snapped window", 300, 200)

GUIRegisterMsg($WM_WINDOWPOSCHANGING, "MY_WM_WINDOWPOSCHANGING")

GUISetState()

While 1
    $GUIMsg = GUIGetMsg()
    
    Switch $GUIMsg
        Case $GUI_EVENT_CLOSE
            ExitLoop
    EndSwitch
WEnd


Func MY_WM_WINDOWPOSCHANGING($hWnd, $Msg, $wParam, $lParam)
#cs
    HWND hwnd;
    HWND hwndInsertAfter;
    int x;
    int y;
    int cx;
    int cy;
    UINT flags;
#ce
    Local $stRect = DllStructCreate("int;int;int;int")
    Local $stWinPos = DllStructCreate("uint;uint;int;int;int;int;uint", $lParam)
    DllCall("User32.dll", "int", "SystemParametersInfo", "int", $SPI_GETWORKAREA, "int", 0, "ptr", DllStructGetPtr($stRect), "int", 0)
    Local $nLeft   = DllStructGetData($stRect, 1)
    Local $nTop = DllStructGetData($stRect, 2)
    Local $nRight  = DllStructGetData($stRect, 3) - DllStructGetData($stWinPos, 5)
    Local $nBottom = DllStructGetData($stRect, 4) - DllStructGetData($stWinPos, 6)
    If BitAND($nEdge, 1) and Abs($nLeft   - DllStructGetData($stWinPos, 3)) <= $nGap Then DllStructSetData($stWinPos, 3, $nLeft)
    If BitAND($nEdge, 2) and Abs($nTop  - DllStructGetData($stWinPos, 4)) <= $nGap Then DllStructSetData($stWinPos, 4, $nTop)
    If BitAND($nEdge, 4) and Abs($nRight  - DllStructGetData($stWinPos, 3)) <= $nGap Then DllStructSetData($stWinPos, 3, $nRight)
    If BitAND($nEdge, 8) and Abs($nBottom - DllStructGetData($stWinPos, 4)) <= $nGap Then DllStructSetData($stWinPos, 4, $nBottom)
    Return 0
EndFunc