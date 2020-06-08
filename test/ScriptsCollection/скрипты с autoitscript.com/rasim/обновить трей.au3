#include <WinAPI.au3>

$hTaskBar = _WinAPI_FindWindow("Shell_TrayWnd", "")
$hParent  = ControlGetHandle($hTaskBar, "", "TrayNotifyWnd1")
$hWnd     = ControlGetHandle($hParent, "", "ToolbarWindow321")

$WinRect  = _WinAPI_GetWindowRect($hWnd)

$aMousePos = MouseGetPos()

$Left  = DllStructGetData($WinRect, "Left")
$Right = DllStructGetData($WinRect, "Right")
$Top   = DllStructGetData($WinRect, "Top")

For $i = $Left To $Right
    MouseMove($i, $Top, 0)
Next

MouseMove($aMousePos[0], $aMousePos[1], 0)
