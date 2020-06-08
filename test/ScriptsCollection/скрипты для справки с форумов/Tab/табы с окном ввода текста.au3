#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>

_Main()

Func _Main()

; Create GUI
    $Form1 = GUICreate("AutoBot", 500, 300)
    $Tab1 = GUICtrlCreateTab(2, 2, 500, 300)
    
    $TabItem1 = GUICtrlCreateTabItem("Tab 1")
    $Button1 = GUICtrlCreateButton("Button1", 405, 25, 80)
    $iMemo1 = GUICtrlCreateEdit("", 0, 25, 400, 275)
    GUICtrlSetFont($iMemo1, 9, 400, 0, "Courier New")
    GUICtrlSetBkColor(-1, 0x000000)
    GUICtrlSetColor(-1, 0xFFDAB9)
    GUISetState()
    
    $TabItem2 = GUICtrlCreateTabItem("Tab 2")
    GUICtrlSetState(-1,$GUI_SHOW)
    $Button2 = GUICtrlCreateButton("Button2", 405, 25, 80)
    $iMemo2 = GUICtrlCreateEdit("", 0, 25, 400, 275)
    GUICtrlSetFont($iMemo2, 9, 400, 0, "Courier New")
    GUICtrlSetBkColor(-1, 0xff0000)
    GUICtrlSetColor(-1, 0xFFDAB9)
    GUISetState()
    GUICtrlCreateTabItem("")
        
    $TabItem3 = GUICtrlCreateTabItem("Tab 3")
    GUICtrlSetState(-1,$GUI_SHOW)
    $Button3 = GUICtrlCreateButton("Button3", 405, 25, 80)
    $iMemo3 = GUICtrlCreateEdit("", 0, 25, 400, 275)
    GUICtrlSetFont($iMemo3, 9, 400, 0, "Courier New")
    GUICtrlSetBkColor(-1, 0xDD00CC)
    GUICtrlSetColor(-1, 0xFFDAB9)
    GUISetState()
    GUICtrlCreateTabItem("")
    
    $TabItem4 = GUICtrlCreateTabItem("Tab 4")
    GUICtrlSetState(-1,$GUI_SHOW)
    $Button4 = GUICtrlCreateButton("Button4", 405, 25, 80)
    $iMemo4 = GUICtrlCreateEdit("", 0, 25, 400, 275)
    GUICtrlSetFont($iMemo4, 9, 400, 0, "Courier New")
    GUICtrlSetBkColor(-1, 0xDDFFCC)
    GUICtrlSetColor(-1, 0xFFDAB9)
    GUISetState()   
    GUICtrlCreateTabItem("")


EndFunc

While 1
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case $GUI_EVENT_CLOSE
            Exit

    EndSwitch
WEnd