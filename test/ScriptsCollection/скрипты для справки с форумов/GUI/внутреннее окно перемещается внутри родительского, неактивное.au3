#include <GuiConstants.au3>
#include <WindowsConstants.au3>

Opt("GUIOnEventMode", 1)

$Main_GUI = GUICreate("Main", 500, 500)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
GUISetState(@SW_SHOW, $Main_GUI)

$Child_GUI = GUICreate("Child", 200, 100, 10, 50, BitOr($WS_CHILD, $WS_OVERLAPPEDWINDOW), Default, $Main_GUI)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
GUICtrlCreateButton('SecondguiButton', 0, 0)
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