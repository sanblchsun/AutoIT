#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
GUICreate('Кинь сюда группу файлов. Input принимает пути файлов одной строкой с разделителем "|"', @DesktopWidth-20, 80, -1, -1, $WS_OVERLAPPEDWINDOW,  $WS_EX_ACCEPTFILES)
GUICtrlCreateInput('', 5, 5, @DesktopWidth-30, 70)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)
GUISetState()
Do
Until GUIGetMsg() = -3