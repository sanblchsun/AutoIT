#include <Guiconstants.au3> 
Opt("GUIOnEventMode", 1) 
Opt("GUICloseOnEsc", 0) 

$Gui=GUICreate("", 400, 300, -1, -1)

GUISetOnEvent($GUI_EVENT_CLOSE, "ExitGui")

$Closed_button = GUICtrlCreateButton("X", 377, 4, 18, 18)
GUICtrlSetFont(-1, 10, 700, 0, "Tahoma")
GUICtrlSetOnEvent(-1, "ExitGui")
GUICtrlSetState(-1, $GUI_DISABLE)

$Mim_button = GUICtrlCreateButton("-", 337, 4, 18, 18) 
GUICtrlSetFont(-1, 13, 700, 0, "Arial Black") 
GUICtrlSetOnEvent(-1, "MimimizeGui") 

$Max_button = GUICtrlCreateButton(CHR(152),357,4,18,18) 
GUICtrlSetFont(-1, 9, 700, 0, "Tahoma") 
GUICtrlSetState(-1, $GUI_DISABLE) 

$TitleLabel = GUICtrlCreateLabel("Drag GUI", 5, 5, 325, 18) 
GUICtrlSetFont(-1, 12, 700, 0, "Courier New") 
GUICtrlSetColor(-1, 0xBEFFBE) 
GUICtrlSetBkColor(-1, 0x000000) 

$Exit = GUICtrlCreateButton("Exit", 320, 260, 60, 20) 
GUICtrlSetOnEvent(-1, "ExitGui") 

DllCall("User32.dll","long","AnimateWindow","hwnd",$Gui,"long",300,"long",0x10) 
GUISetState() 

While 1 
Sleep(100) 
WEnd 

Func MimimizeGui() 
GUISetState(@SW_MINIMIZE) 
EndFunc 

Func ExitGui() 
DllCall("User32.dll","long","AnimateWindow","hwnd",$Gui,"long",300,"long",0x10+0x10000) 
Exit 
EndFunc 
