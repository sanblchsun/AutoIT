; переделал, упростил пример отсюда http://www.autoitscript.com/forum/index.php?showtopic=79991&view=findpost&p=616473


#include <WindowsConstants.au3>

Global Const $WMSZ_LEFT = 1
Global Const $WMSZ_RIGHT = 2

Opt("GUIResizeMode", 0x0322)
$Form1 = GUICreate("Измени размер окна", 422, 237, -1, -1, BitOR($WS_MINIMIZEBOX, $WS_SIZEBOX))
GUICtrlCreateLabel('Пропорциональный ресайз окна', 10, 10, 250, 17)
GUISetState()

$gp = WinGetPos($Form1)
Global $HtoW = $gp[3] / $gp[2]
GUIRegisterMsg(0x0214, "WM_SIZING")

While 1
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case -3
            Exit
    EndSwitch
WEnd

Func WM_SIZING($hWnd, $iMsg, $wparam, $lparam)
    Local $sRect = DllStructCreate("Int[4]", $lparam)
    Local $left = DllStructGetData($sRect, 1, 1)
    Local $top = DllStructGetData($sRect, 1, 2)
    Local $Right = DllStructGetData($sRect, 1, 3)
    Local $bottom = DllStructGetData($sRect, 1, 4)

    Switch $wparam
        Case $WMSZ_LEFT, $WMSZ_RIGHT
            $newHt = ($Right - $left) * $HtoW
            DllStructSetData($sRect, 1, DllStructGetData($sRect, 1, 2) + $newHt, 4)
        Case Else
            $newWid = ($bottom - $top) / $HtoW
            DllStructSetData($sRect, 1, DllStructGetData($sRect, 1, 1) + $newWid, 3)
    EndSwitch
EndFunc