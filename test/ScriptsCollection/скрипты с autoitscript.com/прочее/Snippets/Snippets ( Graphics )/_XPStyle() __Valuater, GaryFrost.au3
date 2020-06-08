; XP Style For Colours

#include <GuiConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

Global $XS_n, $x = 0
Global $gui = GUICreate("MyGUI", 350, 42, -1, -1, BitOR($WS_OVERLAPPEDWINDOW, $WS_CLIPSIBLINGS))
_XPStyle(1)
Local $Pic_1 = GUICtrlCreateLabel("", 10, 10, 340, 20)
GUICtrlSetBkColor($Pic_1, 0xff0000) ;Red
Local $Label_2 = GUICtrlCreateLabel("", 10, 10, 340, 20)
Local $Label_3 = GUICtrlCreateLabel("", 10, 13, 5, 15, $SS_CENTER)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
_XPStyle(0)

GUISetState()
Do
	Local $msg = GUIGetMsg()
	If $msg = $GUI_EVENT_CLOSE Then ExitLoop
	Local $pos = ControlGetPos($gui, "", $Label_2)
	If $pos[0] < 340 Then
		GUICtrlSetPos($Label_2, $pos[0] + ((360 / 100) * 1), 10)
		GUICtrlSetPos($Label_3, 10, 13, $pos[0] + ((360 / 100) * 1), 15)
		GUICtrlSetData($Label_3, Int($pos[0] + ((360 / 100) * 1)) & "%")
	EndIf
	Sleep(20)
	If $x = 0 Then
		If $pos[0] > 339.9 Then
			MsgBox(0, "test", "Done!")
			$x = 1
		EndIf
	EndIf
	$msg = GUIGetMsg()
	If $msg = $GUI_EVENT_CLOSE Then Exit
Until $msg = $GUI_EVENT_CLOSE

Func _XPStyle($OnOff = 1)
	If $OnOff And StringInStr(@OSType, "WIN32_NT") Then
		$XS_n = DllCall("uxtheme.dll", "int", "GetThemeAppProperties")
		DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", 0)
		Return 1
	ElseIf StringInStr(@OSType, "WIN32_NT") And IsArray($XS_n) Then
		DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", $XS_n[0])
		$XS_n = ""
		Return 1
	EndIf
	Return 0
EndFunc