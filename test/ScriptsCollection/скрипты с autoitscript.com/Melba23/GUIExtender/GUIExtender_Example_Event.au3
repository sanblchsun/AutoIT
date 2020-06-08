#include <GUIConstantsEx.au3>

#include "GUIExtender.au3"

Opt("GUIOnEventMode", 1)

$hGUI = GUICreate("Test", 300, 390)
GUISetOnEvent($GUI_EVENT_CLOSE, "On_Exit")

_GUIExtender_Init($hGUI)

_GUIExtender_Section_Start(0, 70)
GUICtrlCreateGroup(" 1 - Static ", 10, 10, 280, 50)
_GUIExtender_Section_Action(2, "", "", 270, 40, 15, 15, 0, 1) ; Normal button
_GUIExtender_Section_End()

_GUIExtender_Section_Start(70, 110)
GUICtrlCreateGroup("2 - Extendable ", 10, 70, 280, 100)
_GUIExtender_Section_End()

_GUIExtender_Section_Start(180, 60)
GUICtrlCreateGroup(" 3 - Static ", 10, 180, 280, 50)
$iRet = _GUIExtender_Section_Action(4, "Close 4", "Open 4", 225, 205, 60, 20, 1, 1) ; Push button
ConsoleWrite($iRet & @CRLF)
_GUIExtender_Section_End()

_GUIExtender_Section_Start(240, 60)
GUICtrlCreateGroup("4 - Extendable ", 10, 240, 280, 50)
_GUIExtender_Section_End()

_GUIExtender_Section_Start(300, 90)
GUICtrlCreateGroup(" 5 - Static ", 10, 300, 280, 80)
_GUIExtender_Section_Action(0, "Close All", "Open All", 20, 340, 60, 20, 0, 1) ; Normal button
_GUIExtender_Section_End()

GUICtrlCreateGroup("", -99, -99, 1, 1)

_GUIExtender_Section_Extend(4, False)

GUISetState()

While 1
	Sleep(10)
WEnd

Func On_Exit()
	Exit
EndFunc