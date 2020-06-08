#include <FreeText.au3> ; ver 2.0.0
#include <Array.au3>

; FreeText.au3 - Demonstration Code - Horse Race
HotKeySet("{ESC}", "Terminate")
Func Terminate()
    Exit 0
EndFunc   ;==>Terminate

Dim $wait = 5

; you can copy and paste the Functions
_FreeText_Functions()

ToolTip("Hit (ESC) to Exit", 1, 1, "FreeText", 1)
; $BGrnd = _FreeText_CreateBackGround("Random")

Sleep($wait)
$TextGUI = _FreeText_Create("Valuater")
Sleep($wait)
_FreeText_StairCase($TextGUI, -15)
$GUI_Pos = _FreeText_GetPosition($TextGUI)
_ArrayDisplay($GUI_Pos)
Sleep($wait)
$DPos = _FreeText_Scatter($TextGUI);, 200, 3, 100, 0)
Sleep($wait)
_FreeText_ColorStrobe($TextGUI)
Sleep($wait)
_FreeText_SetTrans($TextGUI, 20)
Sleep($wait)
_FreeText_SetPosition($TextGUI, $DPos)
Sleep($wait)
_FreeText_Move($TextGUI, 200, 200)
Sleep($wait)
_FreeText_Blink($TextGUI)
Sleep($wait)
_FreeText_SetTrans($TextGUI, 255)
Sleep($wait)
_FreeText_ColorStrobe($TextGUI)
Sleep($wait)
_FreeText_SetColor($TextGUI, "Red")
Sleep($wait)
_FreeText_StairCase($TextGUI)
Sleep($wait)
_FreeText_ShockWave($TextGUI)
Sleep($wait)
_FreeText_Bump($TextGUI)
Sleep($wait)
_FreeText_Move($TextGUI, 100, 100)
Sleep($wait)
$TextGUI2 = _FreeText_Create("Examiner", -1, -1, 30)
Sleep($wait)
_FreeText_Animate($TextGUI2, 2)
Sleep($wait)
_FreeText_Animate($TextGUI2, 7)
Sleep($wait)
_FreeText_ColorStrobe($TextGUI2)
Sleep($wait)
_FreeText_Animate($TextGUI2, 6)
Sleep($wait)
$thanks = _FreeText_Create("ENJOY!  8)", 300, -1, 30)
Sleep($wait)
_FreeText_ColorStrobe($thanks)
Sleep($wait * 3)