Global $square[11][11]
Global $color[10] = [0x00FFFF, 0xFF0000, 0x00FF00, 0x0000FF, 0xFFFFFF, 0xFFFF00, 0x999900, 0x009999, 0x00FFFF, 0xFF00FF]

GUICreate("", 240, 240)
For $x = 1 to 10
    For $y = 1 to 10
        $square[$x][$y] = GUICtrlCreateLabel("", $x * 20, $y * 20, 20, 20)
        GUICtrlSetBkColor(-1, $color[Random(0, 9, 1)])
    Next
Next
GUISetState()
Do
Until GUIGetMsg() = -3