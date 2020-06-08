#include <WindowsConstants.au3>
Global $k = 0, $L = 0
$Gui = GUICreate("WM_ENTERSIZEMOVE, WM_EXITSIZEMOVE", 490, 140, -1, -1, $WS_OVERLAPPEDWINDOW)
GUICtrlCreateLabel('WM_ENTERSIZEMOVE выполняется в НАЧАЛЕ изменения размеров или перемещении окна.' & @CRLF & 'WM_EXITSIZEMOVE выполняется в КОНЦЕ изменения размеров или перемещении окна. ', 5, 5, 480, 34)
$StatusBar = GUICtrlCreateLabel('', 10, 40, 450, 100)
GUICtrlSetFont(-1, 15)

GUISetState()

GUIRegisterMsg(0x0231, "WM_ENTERSIZEMOVE")
GUIRegisterMsg(0x0232, "WM_EXITSIZEMOVE")

Do
Until GUIGetMsg() = -3

Func WM_ENTERSIZEMOVE($hWnd, $MsgID, $WParam, $LParam)
	$k += 1
	GUICtrlSetData($StatusBar, 'WM_ENTERSIZEMOVE = ' & $k & @LF & '   WM_EXITSIZEMOVE = ' & $L)
EndFunc

Func WM_EXITSIZEMOVE($hWnd, $MsgID, $WParam, $LParam)
	$L += 1
	GUICtrlSetData($StatusBar, 'WM_ENTERSIZEMOVE = ' & $k & @LF & '   WM_EXITSIZEMOVE = ' & $L)
EndFunc