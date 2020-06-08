#include <GUIConstantsEx.au3>

Opt("MouseCoordMode", 2)

$Form1 = GUICreate("Проба", 400, 300, -1, -1)
GUISetBkColor(0xFFFFCC)
$Label1 = GUICtrlCreateLabel("", 100, 30, 200, 0)
GUICtrlSetBkColor($Label1, 0x33FF00)
$Button1 = GUICtrlCreateButton("Поехали", 100, 250, 200, 30)
GUISetState(@SW_SHOW)

While 1
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case $GUI_EVENT_CLOSE
            Exit
        Case $Button1
            GUICtrlSetState($Button1, $GUI_DISABLE)
            BlockInput(1)
            $pos = ControlGetPos("", "", $Label1)
            For $i = 1 To 200
                MouseMove($pos[0], $pos[1] + $i, 25)
                GUICtrlSetPos($Label1, $pos[0], $pos[1], $pos[2], $i)
            Next
            BlockInput(0)
    EndSwitch
WEnd
