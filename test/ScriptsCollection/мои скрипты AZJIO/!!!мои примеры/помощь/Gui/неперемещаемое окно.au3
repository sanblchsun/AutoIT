$Gui = GUICreate("Неперемещаемое окно", 300, 200, 100, 50)
GUISetState()

$GP = WinGetPos($Gui)
GUIRegisterMsg(0x0046, "WM_WINDOWPOSCHANGING")

Do
Until GUIGetMsg()=-3

Func WM_WINDOWPOSCHANGING($hWnd, $Msg, $wParam, $lParam)
    Local $stWinPos = DllStructCreate("uint;uint;int;int;int;int;uint", $lParam)
    DllStructSetData($stWinPos, 3, $GP[0])
    DllStructSetData($stWinPos, 4, $GP[1])
EndFunc