#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <WinAPI.au3>

Opt("GUIOnEventMode", 1)

$Main_GUI = GUICreate("Main", 500, 500, -1, -1)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
GUISetState()
$Child_GUI = GUICreate("Child", 200, 100, 10, 50)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
$iButton = GUICtrlCreateButton('Start', 10, 10, 120, 22)
_WinAPI_SetParent($Child_GUI, $Main_GUI)
GUISetState(@SW_SHOW, $Child_GUI)

While 1
	Sleep(1000)
WEnd

Func _Exit()
	Switch @GUI_WinHandle
		Case $Main_GUI
			Exit
		Case $Child_GUI
			GUIDelete($Child_GUI)
	EndSwitch
EndFunc