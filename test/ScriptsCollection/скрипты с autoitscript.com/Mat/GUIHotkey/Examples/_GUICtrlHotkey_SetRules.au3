
#include<GUIHotkey.au3>

Local $hGUI = GUICreate("Testing Hotkey Control")

Local $hHotkey = _GUICtrlHotkey_Create($hGUI, 2, 2)
_GUICtrlHotkey_SetRules($hHotkey, $HKCOMB_NONE, $HOTKEYF_ALT); When entering an unmodified key, will add ALT+ to the beginning

GUISetState()

While 1
	Switch GUIGetMsg()
		Case -3
			Exit
	EndSwitch
WEnd
