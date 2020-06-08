
#include<GUIHotkey.au3>

Local $hGUI = GUICreate("Testing Hotkey Control")

Local $hCodeInp = GUICtrlCreateInput(0, 2, 2, 100, 20)

Local $hHotkey = _GUICtrlHotkey_Create($hGUI, 2, 34)
_GUICtrlHotkey_SetRules($hHotkey, $HKCOMB_NONE, $HOTKEYF_ALT)

GUISetState()

Local $sHotkeyOld, $sHotkey
While 1
	Switch GUIGetMsg()
		Case -3
			Exit
		Case Else
			$sHotkey = _GUICtrlHotkey_GetHotkeyName($hHotkey)
			If $sHotkey <> $sHotkeyOld Then
				GUICtrlSetData($hCodeInp, $sHotkey)
				$sHotkeyOld = $sHotkey
			EndIf
	EndSwitch
WEnd
