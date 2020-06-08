; #include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>

GUICreate('Измените размер окна',  420, 250, 11, 11, $WS_SIZEBOX+$WS_MAXIMIZEBOX+$WS_MINIMIZEBOX+$WS_CAPTION+$WS_POPUP+$WS_SYSMENU)

GUICtrlCreatePic(@SystemDir&'\oemlogo.bmp', 10, 10,170,170, $SS_CENTERIMAGE+$SS_SUNKEN)
GUICtrlSetResizing (-1,1)

GUICtrlCreatePic(@SystemDir&'\oemlogo.bmp', 190, 10,170,170, $SS_SUNKEN)
GUICtrlSetResizing (-1,1)

GUICtrlCreateIcon("shell32.dll", 22, 10, 190, 32, 32,  $SS_CENTERIMAGE+$SS_SUNKEN)
GUICtrlSetResizing (-1,1)

GUICtrlCreateIcon("shell32.dll", 22, 190, 190, 32, 32, $SS_SUNKEN)
GUICtrlSetResizing (-1,1)

GUISetState ()

Do
Until GUIGetMsg()=-3