#include <GUIConstantsEx.au3>

#include "GUIExtender.au3"

$hGUI = GUICreate("Test", 500, 200)

_GUIExtender_Init($hGUI, 1)

_GUIExtender_Section_Start(0, 100)
GUICtrlCreateGroup(" 1 - Static ", 10, 10, 80, 180)
_GUIExtender_Section_Action(2, "", "", 70, 20, 15, 15)
_GUIExtender_Section_End()

_GUIExtender_Section_Start(100, 100)
GUICtrlCreateGroup(" 2 - Extendable ", 110, 10, 80, 180)
_GUIExtender_Section_End()

_GUIExtender_Section_Start(200, 100)
GUICtrlCreateGroup(" 3 - Static", 210, 10, 80, 180)
_GUIExtender_Section_Action(4, "Close 4", "Open 4", 220, 90, 60, 20, 1) ; Push button
_GUIExtender_Section_End()

_GUIExtender_Section_Start(300, 100)
GUICtrlCreateGroup(" 4 - Extendable", 310, 10, 80, 180)
_GUIExtender_Section_End()

_GUIExtender_Section_Start(400, 100)
GUICtrlCreateGroup(" 5 - Static", 410, 10, 80, 180)
_GUIExtender_Section_Action(0, "Close All", "Open All", 420, 160, 60, 20) ; Normal button
_GUIExtender_Section_End()

GUICtrlCreateGroup("", -99, -99, 1, 1)

_GUIExtender_Section_Extend(2, False)

GUISetState()

While 1
	$iMsg = GUIGetMsg()
	Switch $iMsg
		Case $GUI_EVENT_CLOSE
			Exit
	EndSwitch
	_GUIExtender_Action($iMsg) ; Check for click on Action control
WEnd