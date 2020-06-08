#include <GUIConstantsEx.au3>
#include <GUICtrlSetResizing.au3>

$hGUI = GUICreate("_GUICtrl_SetOnResize - Example", 700, 480)

$Edit = GUICtrlCreateEdit("", 40, 40, 280, 200)
_GUICtrl_SetOnResize($hGUI, $Edit, 10, $iGCSOR_DefCtrlMinSize, $iGCSOR_LEFT_EDGE) ;Resize only Left edge (-1 resize all)

$ListView = GUICtrlCreateListView("Column", 340, 40, 300, 200)
GUICtrlCreateListViewItem("Item", $ListView)
_GUICtrl_SetOnResize($hGUI, $ListView, 10, $iGCSOR_DefCtrlMinSize, BitOR($iGCSOR_TOP_EDGE, $iGCSOR_BOTTOM_EDGE)) ;Resize Top + Bottom

$Checkbox = GUICtrlCreateCheckbox("Some Checkbox", 40, 270)
GUICtrlSetBkColor(-1, 0xFFFFFF)
_GUICtrl_SetOnResize($hGUI, $Checkbox, 10, $iGCSOR_DefCtrlMinSize, BitOR($iGCSOR_LEFT_EDGE, $iGCSOR_RIGHT_EDGE)) ;Resize Left + Right

$Label = GUICtrlCreateLabel("Some Label", 40, 320, -1, 15)
GUICtrlSetBkColor(-1, 0x0000FF)
GUICtrlSetColor(-1, 0xFFFFFF)
_GUICtrl_SetOnResize($hGUI, $Label, 10, 15, BitOR($iGCSOR_TOP_EDGE, $iGCSOR_RIGHT_EDGE)) ;Resize Top + Right

$Button = GUICtrlCreateButton("Some Button", 40, 370, 100, 40)
_GUICtrl_SetOnResize($hGUI, $Button, 10, $iGCSOR_DefCtrlMinSize, BitOR($iGCSOR_BOTTOM_EDGE, $iGCSOR_LEFT_EDGE)) ;Resize Bottom + Left

GUISetState(@SW_SHOW, $hGUI)

While 1
	$nMsg = GUIGetMsg()
	
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
	EndSwitch
WEnd
