#include <GUIConstantsEx.au3>

$gui = GUICreate("TEST", 200, 100)

$label = CreateBorderLabel("LABEL", 5, 5, 80, 20, 0xA00000, 2, 0x201)
GUICtrlSetBkColor(-1, 0xb0c4de)
GUICtrlSetColor(-1, 0x483d8d)

GUISetState(@SW_SHOW)

While 1
    $msg = GUIGetMsg()

    Select
        Case $msg = $GUI_EVENT_CLOSE
            ExitLoop
        Case $msg = $label
            MsgBox(0, "Test", "Label was clicked")
    EndSelect

WEnd

GUIDelete()
Exit

Func CreateBorderLabel($sText, $iX, $iY, $iW, $iH, $iColor, $iPenSize = 1, $iStyle = -1, $iStyleEx = 0) ;coded by funkey 2013
    Global $nID = GUICtrlCreateLabel("", $iX - $iPenSize, $iY - $iPenSize, $iW + 2 * $iPenSize, $iH + 2 * $iPenSize, 0)
    GUICtrlSetBkColor(-1, $iColor)
    GUICtrlCreateLabel($sText, $iX, $iY, $iW, $iH, $iStyle, $iStyleEx)
    Return $nID
EndFunc   ;==>CreateBorderLabel