#include <GUIConstants.au3> 
#Include <Misc.au3> 

Opt("MouseClickDownDelay",9) 
Opt("SendKeyDownDelay",9) 
$Form1 = GUICreate("Combo", 234, 139+24, 197, 127) 
$Label1 = GUICtrlCreateLabel("Press Mouse3 To combo", 8, 8, 122, 17) 
$Label2 = GUICtrlCreateLabel("Combo Will Click Too", 8, 32, 115, 17) 
GUICtrlSetColor(-1, 0xFFFF00) 
GUICtrlSetBkColor(-1, 0x0000FF) 
GUICtrlSetCursor ($Label2, 0) 
$Progress1 = GUICtrlCreateProgress(16, 64, 150, 17) 
GUICtrlSetData(-1, RegRead("HKEY_CURRENT_USER\MuTools\Combo\","Skill1")/20) 
$Progress2 = GUICtrlCreateProgress(16, 88, 150, 17) 
GUICtrlSetData(-1, RegRead("HKEY_CURRENT_USER\MuTools\Combo\","Skill2")/20) 
$Progress3 = GUICtrlCreateProgress(16, 112, 150, 17) 
GUICtrlSetData(-1, RegRead("HKEY_CURRENT_USER\MuTools\Combo\","Skill3")/20) 
$Progress4 = GUICtrlCreateProgress(16, 112+24, 150, 17) 
GUICtrlSetData(-1, RegRead("HKEY_CURRENT_USER\MuTools\Combo\","Skill4")/20) 

$Label3 = GUICtrlCreateLabel("ALabel3", 184, 64, 43, 17) 
GUICtrlSetData(-1, RegRead("HKEY_CURRENT_USER\MuTools\Combo\","Skill1")) 
$skill1 = Guictrlread($label3) 

$Label4 = GUICtrlCreateLabel("ALabel4", 184, 88, 43, 17) 
GUICtrlSetData(-1, RegRead("HKEY_CURRENT_USER\MuTools\Combo\","Skill2")) 
$skill2 = Guictrlread($label4) 

$Label5 = GUICtrlCreateLabel("ALabel5", 184, 112, 43, 17) 
GUICtrlSetData(-1, RegRead("HKEY_CURRENT_USER\MuTools\Combo\","Skill3")) 
$skill3 = Guictrlread($label5) 

$Label6 = GUICtrlCreateLabel("ALabel6", 184, 112+24, 43, 17) 
GUICtrlSetData(-1, RegRead("HKEY_CURRENT_USER\MuTools\Combo\","Skill4")) 
$skill4 = Guictrlread($label6) 

GUISetState(@SW_SHOW) 

$id4 = 0 

Global $iKeyPressed = 0 
HotKeySet ('s', '_Send') 

While 1 
$nMsg = GUIGetMsg() 
Switch $nMsg 
Case $GUI_EVENT_CLOSE 
Exit 
Case $Label2 
If $id4 = 0 Then 
GUICtrlSetData($Label2,"Combo Will Not Click") 
GUICtrlSetBkColor($Label2, 0xFF0000) 
$id4 = 2 
ElseIF $id4 = 1 Then 
GUICtrlSetData($Label2,"Combo Will Click Too") 
GUICtrlSetBkColor($Label2, 0x0000FF) 
$id4 = 0 
elseiF $id4 = 2 Then 
GUICtrlSetData($Label2,"Combo Will Click Down") 
GUICtrlSetBkColor($Label2, 0x000FFF) 
$id4 = 1 
endif 
EndSwitch 
$handle = WinGetHandle("Combo") 
$guiarray = GUIGetCursorInfo($handle) 
IF $guiarray[4] = 5 and $guiarray[2] = 1 Then 
GUICtrlSetData($Progress1,($guiarray[0] -16)/1.5) 
$skill1 = Round(($guiarray[0] -16)/1.5,0) * 20 
Guictrlsetdata($Label3,$skill1) 
RegWrite("HKEY_CURRENT_USER\MuTools\Combo\","Skill1","REG_SZ",$skill1) 
EndIf 
IF $guiarray[4] = 6 and $guiarray[2] = 1 Then 
GUICtrlSetData($Progress2,($guiarray[0] -16)/1.5) 
$skill2 = Round(($guiarray[0] -16)/1.5,0) * 20 
Guictrlsetdata($Label4,$skill2) 
RegWrite("HKEY_CURRENT_USER\MuTools\Combo\","Skill2","REG_SZ",$skill2) 
EndIf 
IF $guiarray[4] = 7 and $guiarray[2] = 1 Then 
GUICtrlSetData($Progress3,($guiarray[0] -16)/1.5) 
$skill3 = Round(($guiarray[0] -16)/1.5,0) * 20 
Guictrlsetdata($Label5,$skill3) 
RegWrite("HKEY_CURRENT_USER\MuTools\Combo\","Skill3","REG_Sz",$skill3) 
EndIf 
IF $guiarray[4] = 8 and $guiarray[2] = 1 Then 
GUICtrlSetData($Progress4,($guiarray[0] -16)/1.5) 
$skill4 = Round(($guiarray[0]-16)/1.5,0) 
Guictrlsetdata($Label6,$skill4) 
RegWrite("HKEY_CURRENT_USER\MuTools\Combo\","Skill4","REG_Sz",$skill4) 
EndIf 

If _IsPressed(04) Then 
If $id4 = 0 Then 
MouseClick("right") 
EndIf 
If $id4 = 1 Then 
MouseDown("right") 
EndIf 
Send("1") 
Sleep($skill1) 
Send("2") 
Sleep($skill2) 
Send("3") 
Sleep($skill3) 
Sleep(0) 
Mouseup("right") 
EndIf 
WEnd 

Func _Send() 
If $iKeyPressed == 0 Then 
$iKeyPressed = 1 
While 1 
Send("w") 
Sleep($skill4) 
Send("q") 
If $iKeyPressed == 0 Then ExitLoop 
WEnd 
Else 
$iKeyPressed = 0 
EndIf 
EndFunc 