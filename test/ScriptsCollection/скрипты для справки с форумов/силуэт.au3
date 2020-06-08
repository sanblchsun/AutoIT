#include <GUIConstants.au3> 
#include <WindowsConstants.au3> 

$Main_Gui = GUICreate("Transparent Pic Demo", 345, 0, -1, -1, $WS_POPUP) 
$Pic_Gui = GUICreate("", 345, 232, 10, 75, $WS_POPUP, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $Main_Gui) 

GUICtrlCreatePic(@SystemDir & "\oobe\images\monitor.gif", 0, 0, 0, 0) 

GUISetState(@SW_SHOW, $Pic_Gui) 
GUISetState(@SW_SHOW, $Main_Gui) 

While GUIGetMsg() <> $GUI_EVENT_CLOSE 
WEnd 