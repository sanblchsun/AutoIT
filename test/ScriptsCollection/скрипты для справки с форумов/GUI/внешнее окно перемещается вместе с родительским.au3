#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>

Opt("GUIOnEventMode", 1)

$Main_GUI = GUICreate("Main", 500, 500, -1, -1)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
GUISetState()

$Child_GUI = GUICreate("Child", 200, 100, 10, 50, $GUI_SS_DEFAULT_GUI, $WS_EX_MDICHILD, $Main_GUI)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
$iButton = GUICtrlCreateButton('Start', 10, 10, 120, 22)
GUISetState(@SW_SHOW, $Child_GUI)

WinActivate($Main_GUI)
GUISwitch($Main_GUI) 

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