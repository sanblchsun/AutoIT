; Saunders
; Custom GUI Cursor, Mouse over second gui to view.

#include <GuiConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Local $Gui = GUICreate("Test", 300, 200)
GUISetState()

Local $Gui2 = GUICreate("Test", 300, 200, 750)
GUISetState()

GUIRegisterMsg($WM_SETCURSOR, 'WM_SETCURSOR')

Local $Cur = DllCall("user32.dll", "int", "LoadCursorFromFile", "str", "C:\windows\cursors\pen_m.cur")
If @error Then MsgBox(0, "dd", "whoopsie!")

While 1
	Local $Msg = GUIGetMsg(1)
	Select
		Case $Msg[0] = $GUI_EVENT_CLOSE
			Exit
	EndSelect
WEnd

Func WM_SETCURSOR($hWnd, $iMsg, $iWParam, $iLParam)
	If $hWnd = $Gui Then
		DllCall("user32.dll", "int", "SetCursor", "int", $Cur[0])
		Return 0
	EndIf
EndFunc