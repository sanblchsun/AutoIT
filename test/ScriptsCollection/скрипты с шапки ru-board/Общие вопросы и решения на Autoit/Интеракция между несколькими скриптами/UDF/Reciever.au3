#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#include <AU3_INTERACT.au3>
;

#Region _AutoItSetInteraction() Part
Dim $aFunctions[3][3]

$aFunctions[0][0] = 1001
$aFunctions[0][1] = "My_Function_1"
$aFunctions[0][2] = "Some Param1"

$aFunctions[1][0] = 1002
$aFunctions[1][1] = "My_Function_2"
$aFunctions[1][2] = "This is parameter for My_Function_2"

$aFunctions[2][0] = 1003
$aFunctions[2][1] = "My_Function_3"
$aFunctions[2][2] = "Well, you get the picture "

_AutoItSetInteraction("_MYAPP_", $aFunctions)
#EndRegion _AutoItSetInteraction() Part
;

$hGUI = GUICreate("_AutoItSetInteraction Demo", 400, 200, -1, -1, -1, $WS_EX_TOPMOST)

$Edit = GUICtrlCreateEdit("", 10, 10, 380, 180)

GUISetState()

While 1
    $nMsg = GUIGetMsg()

    Switch $nMsg
        Case $GUI_EVENT_CLOSE
            Exit
    EndSwitch
WEnd

Func My_Function_1($vParam)
    GUICtrlSetData($Edit, "Function 1 Fired, with param:    " & $vParam & @CRLF, 1)
    MsgBox(262144+64, "", "Function 1 Fired!")
EndFunc

Func My_Function_2($vParam)
    GUICtrlSetData($Edit, "Function 2 Fired, with param:    " & $vParam & @CRLF, 1)
    MsgBox(262144+64, "", "Function 2 Fired!")
EndFunc

Func My_Function_3($vParam)
    GUICtrlSetData($Edit, "Function 3 Fired, with param:    " & $vParam & @CRLF, 1)
    MsgBox(262144+64, "", "Function 3 Fired!")
EndFunc