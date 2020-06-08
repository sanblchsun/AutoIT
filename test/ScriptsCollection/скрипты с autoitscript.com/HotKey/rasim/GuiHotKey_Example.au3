#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>

#include <GuiHotKey.au3>

Global Enum $Calc_HotkeyID = 1001, $Notepad_HotkeyID, $Paint_HotkeyID

Opt("GuiOnEventMode", 1)

$hGUI = GUICreate("HotKey controls demo", 300, 200)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")

GUICtrlCreateLabel("Hotkeys for calculator", 95, 10, 120, 15)
GUICtrlSetFont(-1, Default, 800)
GUICtrlSetState(-1, $GUI_FOCUS)

$CalcReg_Button = GUICtrlCreateButton("Register", 11, 30, 75, 20)
GUICtrlSetOnEvent(-1, "_MyHotkeyRegisterFunc")

$CalcUnReg_Button = GUICtrlCreateButton("Unregister", 215, 30, 75, 20)
GUICtrlSetOnEvent(-1, "_MyHotkeyUnregisterFunc")

$hHotkey_Calc = _GuiCtrlHotKey_Create($hGUI, 95, 30, 110, 20)
_GuiCtrlHotKey_SetHotkey($hHotkey_Calc, 67, BitOR($HOTKEYF_ALT, $HOTKEYF_CONTROL))

GUICtrlCreateLabel("Hotkeys for notepad", 95, 70, 115, 15)
GUICtrlSetFont(-1, Default, 800)

$NotepadReg_Button = GUICtrlCreateButton("Register", 11, 90, 75, 20)
GUICtrlSetOnEvent(-1, "_MyHotkeyRegisterFunc")

$NotepadUnReg_Button = GUICtrlCreateButton("Unregister", 215, 90, 75, 20)
GUICtrlSetOnEvent(-1, "_MyHotkeyUnregisterFunc")

$hHotkey_Notepad = _GuiCtrlHotKey_Create($hGUI, 95, 90, 110, 20)
_GuiCtrlHotKey_SetHotkey($hHotkey_Notepad, 78, BitOR($HOTKEYF_ALT, $HOTKEYF_CONTROL))

GUICtrlCreateLabel("Hotkeys for paint", 95, 130, 115, 15)
GUICtrlSetFont(-1, Default, 800)

$PaintReg_Button = GUICtrlCreateButton("Register", 11, 150, 75, 20)
GUICtrlSetOnEvent(-1, "_MyHotkeyRegisterFunc")

$PaintUnReg_Button = GUICtrlCreateButton("Unregister", 215, 150, 75, 20)
GUICtrlSetOnEvent(-1, "_MyHotkeyUnregisterFunc")

$hHotkey_Paint = _GuiCtrlHotKey_Create($hGUI, 95, 150, 110, 20)
_GuiCtrlHotKey_SetHotkey($hHotkey_Paint, 80, BitOR($HOTKEYF_ALT, $HOTKEYF_CONTROL))

GUIRegisterMsg($WM_HOTKEY, "WM_HOTKEY")

GUISetState()

While 1
	Sleep(100)
WEnd

Func _MyHotkeyRegisterFunc()
	Local $aHotkey
	
	Switch @GUI_CtrlId
		Case $CalcReg_Button
			$aHotkey = _GuiCtrlHotKey_GetHotkey($hHotkey_Calc)
			If IsArray($aHotkey) Then _GuiCtrlHotKey_RegisterHotkey($hGUI, $Calc_HotkeyID, $aHotkey[0], $aHotkey[1])
		Case $NotepadReg_Button
			$aHotkey = _GuiCtrlHotKey_GetHotkey($hHotkey_Notepad)
			If IsArray($aHotkey) Then _GuiCtrlHotKey_RegisterHotkey($hGUI, $Notepad_HotkeyID, $aHotkey[0], $aHotkey[1])
		Case $PaintReg_Button
			$aHotkey = _GuiCtrlHotKey_GetHotkey($hHotkey_Paint)
			If IsArray($aHotkey) Then _GuiCtrlHotKey_RegisterHotkey($hGUI, $Paint_HotkeyID, $aHotkey[0], $aHotkey[1])
		EndSwitch
EndFunc

Func _MyHotkeyUnregisterFunc()
	Switch @GUI_CtrlId
		Case $CalcUnReg_Button
			_GuiCtrlHotKey_UnregisterHotkey($hGUI, $Calc_HotkeyID)
		Case $NotepadUnReg_Button
			_GuiCtrlHotKey_UnregisterHotkey($hGUI, $Notepad_HotkeyID)
		Case $PaintUnReg_Button
			_GuiCtrlHotKey_UnregisterHotkey($hGUI, $Paint_HotkeyID)
		EndSwitch
EndFunc

Func WM_HOTKEY($hWnd, $Msg, $wParam, $lParam)
	Local $iKeyID = BitAND($wParam, 0x0000FFFF)
	
	Switch $iKeyID
		Case $Calc_HotkeyID
			Run("calc.exe")
		Case $Notepad_HotkeyID
			Run("notepad.exe")
		Case $Paint_HotkeyID
			Run("mspaint.exe")
	EndSwitch
	
	Return $GUI_RUNDEFMSG
EndFunc

Func _Exit()
	Exit
EndFunc