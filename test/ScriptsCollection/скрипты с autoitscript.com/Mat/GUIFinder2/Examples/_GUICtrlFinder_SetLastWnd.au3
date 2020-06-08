
#include<GUIFinder.au3>

$hGUI = GUICreate("_GUICtrlFinder_SetLastWnd Example", 300, 40)

$hFinder = _GUICtrlFinder_Create($hGUI, 100, 4)
$hBtn = GUICtrlCreateButton("Set window!", 140, 6, 80, 30)

GUISetState()
GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")

While True
	$iMsg  = GUIGetMsg()
	Switch $iMsg
		Case -3
			ExitLoop
		Case $hBtn
			_GUICtrlFinder_SetLastWnd($hFinder, $hGUI)
	EndSwitch
WEnd

Func WM_COMMAND($hWnd, $iMsg, $wParam, $lParam)
	Switch _WinAPI_HiWord($wParam)
		Case $FN_WNDCHANGED
			WinSetTitle($hWnd, "", "Handle: " & _GUICtrlFinder_GetLastWnd($lParam))
		Case $FN_STARTUSE
			WinSetTrans($hWnd, "", 150)
		Case $FN_ENDUSE
			WinSetTrans($hWnd, "", 255)
			WinSetTitle($hWnd, "", "_GUICtrlFinder_Create Example")
	EndSwitch
EndFunc   ;==>WM_COMMAND