
#include<GUIHotkey.au3>

Local $hGUI = GUICreate("Testing Hotkey Control")

Local $hCodeInp = GUICtrlCreateInput(0, 2, 2, 100, 20)

Local $hHotkey = _GUICtrlHotkey_Create($hGUI, 2, 34)
_GUICtrlHotkey_SetRules($hHotkey, $HKCOMB_NONE, $HOTKEYF_ALT)

GUISetState()

Local $wHotkeyOld, $wHotkey
While 1
	Switch GUIGetMsg()
		Case -3
			Exit
		Case Else
			$wHotkey = _GUICtrlHotkey_GetHotkeyCode($hHotkey)
			If $wHotkey <> $wHotkeyOld Then
				GUICtrlSetData($hCodeInp, $wHotkey)
				$wHotkeyOld = $wHotkey
			EndIf
	EndSwitch
WEnd
