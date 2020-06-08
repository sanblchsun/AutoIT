
#include<GUIHotkey.au3>

Local $hGUI = GUICreate("Testing Hotkey Control")

Local $hHotkey = _GUICtrlHotkey_Create($hGUI, 2, 2)
Local $hFont = _GUICtrlHotkey_SetFont($hHotkey, 12, 300, 2, "Times New Roman")

GUISetState()

While 1
	Switch GUIGetMsg()
		Case -3
			_GUICtrlHotkey_Delete($hHotkey) ; If you set a font for the hotkey control then it is very important you call
											; this function before closing, as the hFont should be released.
			Exit
	EndSwitch
WEnd
