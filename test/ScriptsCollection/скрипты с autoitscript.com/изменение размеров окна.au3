#include <GuiConstants.au3>
 #include <windowsconstants.au3>

 ;Global Const $WM_LBUTTONDOWN = 0x0201
 Global Const $margin = 12; distance from edge of window where dragging is possible
 $Gui = GUICreate("Drag sides to resize", 420, 200, -1, -1, $WS_POPUP)
 GUISetBkColor(0xf1f100)

 $chk1 = GUICtrlCreateCheckbox("allow resizing and dragging", 140, 40)
 GUICtrlSetResizing(-1,$GUI_DOCKWIDTH)
 $Button = GUICtrlCreateButton("Exit", 140, 90, 150, 30)

 GUISetState(@SW_SHOW, $Gui)

 GUIRegisterMsg($WM_LBUTTONDOWN, "WM_LBUTTONDOWN")
 GUIRegisterMsg($WM_MOUSEMOVE, "SetCursor")

 While 1
 $msg = GUIGetMsg()
 Select
    Case $msg = $Button
    Exit
 EndSelect

 WEnd

;GetMousePosType returns a code depending on the border the mouse cursor is near
 Func GetMousePosType()
 Local $cp = GUIGetCursorInfo()
 Local $wp = WinGetPos($Gui)
 Local $side = 0
 Local $TopBot = 0
 Local $curs
 If $cp[0] < $margin Then $side = 1
 If $cp[0] > $wp[2] - $margin Then $side = 2
 If $cp[1] < $margin Then $TopBot = 3
 If $cp[1] > $wp[3] - $margin Then $TopBot = 6

 Return $side + $TopBot

 EndFunc;==>GetMousePosType

 Func SetCursor()
 Local $curs
 If GUICtrlRead($chk1) <> $GUI_CHECKED Then Return
 Switch GetMousePosType()
    Case 0
    $curs = 2
    Case 1, 2
    $curs = 13
    Case 3, 6
    $curs = 11
    Case 5, 7
    $curs = 10
    Case 4, 8
    $curs = 12
 EndSwitch

 GUISetCursor($curs, 1)

 EndFunc;==>SetCursor


 Func WM_LBUTTONDOWN($hWnd, $iMsg, $StartWIndowPosaram, $lParam)

 If GUICtrlRead($chk1) <> $GUI_CHECKED Then Return $GUI_RUNDEFMSG
 Local $drag = GetMousePosType()
 If $drag > 0 Then
    DllCall("user32.dll", "long", "SendMessage", "hwnd", $hWnd, "int", $WM_SYSCOMMAND, "int", 0xF000 + $drag, "int", 0)
 Else
    DllCall("user32.dll", "long", "SendMessage", "hwnd", $hWnd, "int", $WM_SYSCOMMAND, "int", 0xF012, "int", 0)
 EndIf

;F001 = LHS, F002 = RHS, F003 = top, F004 = TopLeft, F005 = TopRight, F006 = Bottom, F007 = BL, F008 = BR
;F009 = move gui, same as F011 F012 to F01F
;F010, moves cursor to centre top of gui - no idea what that is useful for.
;F020 minimizes
;F030 maximizes

 EndFunc;==>WM_LBUTTONDOWN
