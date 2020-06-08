
#include<GUIHotkey.au3>

Local $hGUI = GUICreate("Testing Hotkey Control")

Local $hBtn = GUICtrlCreateButton("Click here to set the hotkey!", 2, 2, 140, 30)

Local $hHotkey = _GUICtrlHotkey_Create($hGUI, 2, 34)
_GUICtrlHotkey_SetRules($hHotkey, $HKCOMB_NONE, $HOTKEYF_ALT)

GUISetState()

Local $sHotkeyOld
While 1
	Switch GUIGetMsg()
		Case -3
			Exit
		Case $hBtn
			HotKeySet($sHotkeyOld)
			$sHotkeyOld = _GUICtrlHotkey_GetHotkey($hHotkey)
			If $sHotkeyOld = "" Then
				MsgBox(16, "Error", "No hotkey entered!")
				ContinueLoop
			EndIf
			HotKeySet($sHotkeyOld, "_HotkeyTriggered")
	EndSwitch
WEnd

Func _HotkeyTriggered()
	MsgBox(64, "Info", "You pressed the hotkey! Hotkey: " & @HotKeyPressed)
EndFunc   ;==>_HotkeyTriggered