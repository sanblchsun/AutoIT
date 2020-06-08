Opt("GUIOnEventMode",1)
GuiCreate("KJ's TC", 130, 70,-1, -1)
GUISetOnEvent(-3,"Exitt")

GUICtrlCreateLabel(":",33,12,15,15)
GUICtrlCreateLabel(":",63,12,15,15)
GUICtrlCreateLabel(":",33,42,15,15)
GUICtrlCreateLabel(":",63,42,15,15)
$Input_h1 = GuiCtrlCreateInput("", 10, 10, 20, 20)
$Input_m1 = GuiCtrlCreateInput("", 40, 10, 20, 20)
$Input_s1 = GuiCtrlCreateInput("", 70, 10, 20, 20)
$Input_h2 = GuiCtrlCreateInput("", 10, 40, 20, 20)
$Input_m2 = GuiCtrlCreateInput("", 40, 40, 20, 20)
$Input_s2 = GuiCtrlCreateInput("", 70, 40, 20, 20)
$Button_a = GuiCtrlCreateButton("+", 100, 5, 15, 15)
$Button_s = GuiCtrlCreateButton("-", 100, 25, 15, 15)
$Button_r = GuiCtrlCreateButton("R", 100, 45, 15, 15)

GUICtrlSetOnEvent($Button_a,"Add")
GUICtrlSetOnEvent($Button_s,"Subtract")
GUICtrlSetOnEvent($Button_r,"Reset")

GuiSetState()
While 1
Sleep(1000)
WEnd

Func Add()
    GUICtrlSetData($Input_s1,GUICtrlRead($Input_s1)+GUICtrlRead($Input_s2))
    GUICtrlSetData($Input_s2,"")
    While GUICtrlRead($Input_s1)>=60
        GUICtrlSetData($Input_m1,GUICtrlRead($Input_m1)+1)
        GUICtrlSetData($Input_s1,GUICtrlRead($Input_s1)-60)
    WEnd
    
    GUICtrlSetData($Input_m1,GUICtrlRead($Input_m1)+GUICtrlRead($Input_m2))
    GUICtrlSetData($Input_m2,"")
    While GUICtrlRead($Input_m1)>=60
        GUICtrlSetData($Input_h1,GUICtrlRead($Input_h1)+1)
        GUICtrlSetData($Input_m1,GUICtrlRead($Input_m1)-60)
    WEnd
    
    GUICtrlSetData($Input_h1,GUICtrlRead($Input_h1)+GUICtrlRead($Input_h2))
    GUICtrlSetData($Input_h2,"")
EndFunc

Func Subtract()
    GUICtrlSetData($Input_s1,GUICtrlRead($Input_s1)-GUICtrlRead($Input_s2))
    GUICtrlSetData($Input_s2,"")
    While GUICtrlRead($Input_s1)<0
        GUICtrlSetData($Input_m1,GUICtrlRead($Input_m1)-1)
        GUICtrlSetData($Input_s1,GUICtrlRead($Input_s1)+60)
    WEnd
    
    GUICtrlSetData($Input_m1,GUICtrlRead($Input_m1)-GUICtrlRead($Input_m2))
    GUICtrlSetData($Input_m2,"")
    While GUICtrlRead($Input_m1)<0
        GUICtrlSetData($Input_h1,GUICtrlRead($Input_h1)-1)
        GUICtrlSetData($Input_m1,GUICtrlRead($Input_m1)+60)
    WEnd
    
    GUICtrlSetData($Input_h1,GUICtrlRead($Input_h1)-GUICtrlRead($Input_h2))
    GUICtrlSetData($Input_h2,"")
EndFunc

Func Reset()
    GUICtrlSetData($Input_h1,"")
    GUICtrlSetData($Input_m1,"")
    GUICtrlSetData($Input_s1,"")
    GUICtrlSetData($Input_h2,"")
    GUICtrlSetData($Input_m2,"")
    GUICtrlSetData($Input_s2,"")
EndFunc

Func Exitt()
    Exit
EndFunc