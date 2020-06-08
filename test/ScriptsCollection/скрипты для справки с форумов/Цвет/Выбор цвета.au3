#include <Misc.au3>
$hGui = GUICreate("Choose Color")
$btn = GUICtrlCreateButton("Choose Color", 150, 150)
$iColor=0
GUISetState()
While 1
	Switch GUIGetMsg()
		Case -3
			Exit
		Case $btn
			$iColor = _ChooseColor(2, $iColor, 2, $hGui)
			GUISetBkColor($iColor)
	EndSwitch
WEnd