
#include<GUIFinder.au3>

$hGUI = GUICreate("_GUICtrlFinder_Create Example", 300, 40)

$hFinder = _GUICtrlFinder_Create($hGUI, 4, 4)

$hBtn = GUICtrlCreateButton("Read!", 40, 6, 80, 30)
$hInp = GUICtrlCreateInput("", 124, 10, 170, 20)

GUISetState()

While True
	Switch GUIGetMsg()
		Case -3
			ExitLoop
		Case $hBtn
			$hWnd = _GUICtrlFinder_GetLastWnd($hFinder)
			If $hWnd = 0 Then
				MsgBox(16, "Error", "You are supposed to select a window first :P")
				ContinueLoop
			EndIf

			GUICtrlSetData($hInp, "Handle: " & $hWnd)
	EndSwitch
WEnd
