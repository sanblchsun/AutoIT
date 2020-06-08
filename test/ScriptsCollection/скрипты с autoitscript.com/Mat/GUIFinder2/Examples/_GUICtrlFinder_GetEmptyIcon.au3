
#include<GUIFinder.au3>

$hGUI = GUICreate("_GUICtrlFinder_GetEmptyIcon Example", 300, 40)

$hFinder = _GUICtrlFinder_Create($hGUI, 130, 4)

_GUICtrlFinder_SetFullIcon($hFinder, __GUICtrlFinder_GetDefaultResources(2))
_GUICtrlFinder_SetEmptyIcon($hFinder, -1)

ConsoleWrite("Empty Icon = " & Hex(_GUICtrlFinder_GetEmptyIcon($hFinder)) & @LF)

GUISetState()

While True
	$iMsg = GUIGetMsg()
	Switch $iMsg
		Case -3
			ExitLoop
	EndSwitch
WEnd