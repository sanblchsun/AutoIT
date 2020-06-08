#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

GUICreate("My GUI Progressbar", 220, 100, 100, 200)
$progressbar = GUICtrlCreateProgress(10, 10, 200, 20, -1, $WS_EX_LAYOUTRTL)
GUISetState()

For $i = 1 To 100
    GUICtrlSetData($progressbar, $i)
    Sleep(20)
    If GUIGetMsg() = $GUI_EVENT_CLOSE Then Exit
Next

Sleep(1000)