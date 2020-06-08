#include <GUIConstantsEx.au3> 
#include <ComboConstants.au3> 
 
$hGUI = GUICreate("Test Script", 300, 120) 
 
$sReplaceData = GUICtrlCreateButton("Replace", 20, 20) 
 
$nCombo = GUICtrlCreateCombo("", 20, 70, 260, 20) 
GUICtrlSetData(-1, "Data|More data", "Data") 
 
GUISetState(@SW_SHOW, $hGUI) 
 
While 1 
    Switch GUIGetMsg() 
        Case $GUI_EVENT_CLOSE 
            Exit 
        Case $sReplaceData 
            GUICtrlSendMsg($nCombo, $CB_RESETCONTENT, 0, 0) 
            GUICtrlSetData($nCombo, "New Data|My Data", "New Data") 
    EndSwitch 
WEnd 