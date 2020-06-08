#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>



$Form1 = GUICreate("Form1", 258, 107, 253, 190)
GUISetState()

OnAutoItExitRegister("_Exit")

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
WEnd


; сам скрипт

Func _Exit()
    MsgBox(0, '', 'Выходим') ;или другие действия
EndFunc
