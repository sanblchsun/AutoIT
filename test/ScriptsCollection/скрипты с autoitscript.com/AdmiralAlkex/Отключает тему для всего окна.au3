; AdmiralAlkex
; http://www.autoitscript.com/forum/topic/119812-guictrlcreategroup-color-question/#entry832501
#include <ButtonConstants.au3>

DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", 0)
$Form1_1 = GUICreate("Amortization Plus", 644, 303, 207, 200)
$Group1 = GUICtrlCreateGroup("Amortization Table", 8, 0, 625, 81, BitOR($BS_CENTER, $BS_FLAT))
GUICtrlSetColor(-1, 0xFF0000)
GUICtrlSetFont(-1, 12, 400, 0, "Arial")
GUISetState()

Do
Until GUIGetMsg() = -3