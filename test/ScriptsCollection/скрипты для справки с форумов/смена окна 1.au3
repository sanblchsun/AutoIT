#include <GUIConstants.au3> 
#Include <StaticConstants.au3> 
 
Global $Countdown = 51 
 
Opt("GUIOnEventMode", 1) 
 
$Main = GUICreate ("Main", 500, 200) 
GUISetOnEvent ($GUI_EVENT_CLOSE, "Close_Main") 
$Lable = GUICtrlCreateLabel ("", 10, 10, 480, 50) 
GUICtrlSetStyle (-1, $SS_CENTER) 
GUICtrlSetColor (-1, 0xB60038) 
GUICtrlSetFont (-1, 18, 400, 2) 
$Child = GUICreate ("Child", 300, 200) 
GUISetOnEvent ($GUI_EVENT_CLOSE, "Close_Child") 
GUICtrlCreateButton ("Выход", 10, 170, 100, 20) 
GUICtrlSetOnEvent (-1, "Exit_Programm") 
 
GUISetState (@SW_SHOW, $Main) 
 
While 1 
    Sleep (100) 
    $Countdown -= 1 
    If Not StringInStr($Countdown / 10, ".") And $Countdown >= 0 Then GUICtrlSetData ($Lable, "До смены окошка осталось: " & $Countdown / 10 & " сек.") 
    If $Countdown = 0 And Not WinActive ("Child") Then Close_Main() 
WEnd 
 
Func Close_Main() 
    GUISetState (@SW_HIDE, $Main) 
    GUISetState (@SW_SHOW, $Child) 
    GUISwitch ($Child) 
EndFunc 
 
Func Close_Child() 
    GUISetState (@SW_HIDE, $Child) 
    GUISetState (@SW_SHOW, $Main) 
    GUISwitch ($Main) 
    $Countdown = 51 
EndFunc 
 
Func Exit_Programm() 
    Exit 
EndFunc 