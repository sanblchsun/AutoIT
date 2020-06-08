
#include<GUIHotkey.au3>

Local $hGUI = GUICreate("Testing Hotkey Control")

Local $hHotkey = _GUICtrlHotkey_Create($hGUI, 2, 2)

GUISetState()

While 1
	Switch GUIGetMsg()
		Case -3
			Exit
	EndSwitch
WEnd