#include <GUIConstantsEx.au3> 
#include <GuiButton.au3> 
; 

Global Const $Config = @ScriptDir & "\Settings.ini" 

Global $AutoRun_Action = IniRead($Config, "AutoRun", "AutoRun", 0) 

; ======================================================================================= 

$Gui = GUICreate("Окно", 350, 300) 

$AutoRun_Check = GUICtrlCreateCheckbox("Autorun", 120, 120, 100, 20) 
If $AutoRun_Action == 1 Then GUICtrlSetState(-1, $GUI_CHECKED) 

$OK_Button = GUICtrlCreateButton("OK", 10, 20, 60, 20, $BS_DEFPUSHBUTTON) 

GUISetState() 

While 1 
Switch GUIGetMsg() 
Case $OK_Button 
_AutorunAddToggle() 
Case $GUI_EVENT_CLOSE 
IniWrite($Config, "AutoRun", "AutoRun", Number(GUICtrlRead($AutoRun_Check) = $GUI_CHECKED)) 
Exit 
EndSwitch 
WEnd 

Func _AutorunAddToggle() 
If GUICtrlRead($AutoRun_Check) <> $GUI_CHECKED Then Return 
Local $sRegKey = "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" 
Local $sDefParam = RegRead($sRegKey, "Win") 

If $sDefParam <> "" Then 
RegDelete($sRegKey, $sDefParam) 
Else 
RegWrite($sRegKey, "Win", "REG_SZ", @ScriptFullPath) 
EndIf 
EndFunc 