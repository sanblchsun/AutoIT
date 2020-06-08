#include <GuiConstantsEx.au3> 
#include <StaticConstants.au3> 
#include <WindowsConstants.au3> 
; 
 
Global $Img_Path = @SystemDir & "\oobe\images\wpakey.jpg" ;@SystemDir & "\Setup.bmp" 
Global $iStep = 1 
 
$Main_GUI = GUICreate("Wizard Demo!", 400, 300) 
 
_GUICtrlCreateSeperator(0, 2, 265, 3, 396) 
 
$Back_Button = GUICtrlCreateButton("<<Back", 170, 270, 60) 
GUICtrlSetState(-1, $GUI_DISABLE) 
$Next_Button = GUICtrlCreateButton("Next>>", 240, 270, 60) 
 
$Exit_Button = GUICtrlCreateButton("Exit", 325, 270, 60) 
 
;Step 1 
$Pic_Step1 = GUICtrlCreatePic($Img_Path, 2, 2, 160, 263, $SS_SUNKEN, $WS_EX_STATICEDGE+$WS_EX_CLIENTEDGE) 
$Label_Step1 = GUICtrlCreateLabel("Wellcome!", 240, 20, 150) 
GUICtrlSetFont(-1, 12, 800) 
 
;Step 2 
$Input_Step2 = GUICtrlCreateInput("Some input", 10, 20, 180, 20) 
$CheckBox_Step2 = GUICtrlCreateCheckbox("Some checkbox", 10, 50) 
 
;Step 3 
$Edit_Step3 = GUICtrlCreateEdit("Some Edit", 10, 20, 180, 220) 
$Label_Step3 = GUICtrlCreateLabel("Some Label", 220, 20) 
 
_Elements_SetState($Input_Step2, $Label_Step3, $GUI_HIDE) 
 
GUISetState(@SW_SHOW, $Main_GUI) 
 
While 1 
    $Msg = GUIGetMsg() 
 
    Switch $Msg 
        Case $GUI_EVENT_CLOSE, $Exit_Button 
            If $iStep > 1 Then 
                $Ask = MsgBox(256+52, "Attention", "Are you sure you want to exit the Wizard now?", 0, $Main_GUI) 
                If $Ask <> 6 Then ContinueLoop 
            EndIf 
 
            Exit 
        Case $Next_Button 
            $iStep += 1 
 
            Switch $iStep 
                Case 2 
                    _Elements_SetState($Pic_Step1, $Label_Step1, $GUI_HIDE) 
                    _Elements_SetState($Input_Step2, $CheckBox_Step2, $GUI_SHOW) 
 
                    GUICtrlSetState($Back_Button, $GUI_ENABLE) 
                Case 3 
                    _Elements_SetState($Input_Step2, $CheckBox_Step2, $GUI_HIDE) 
                    _Elements_SetState($Edit_Step3, $Label_Step3, $GUI_SHOW) 
 
                    GUICtrlSetState($Next_Button, $GUI_DISABLE) 
            EndSwitch 
        Case $Back_Button 
            $iStep -= 1 
 
            Switch $iStep 
                Case 2 
                    _Elements_SetState($Edit_Step3, $Label_Step3, $GUI_HIDE) 
                    _Elements_SetState($Input_Step2, $CheckBox_Step2, $GUI_SHOW) 
 
                    GUICtrlSetState($Next_Button, $GUI_ENABLE) 
                Case 1 
                    _Elements_SetState($Input_Step2, $CheckBox_Step2, $GUI_HIDE) 
                    _Elements_SetState($Pic_Step1, $Label_Step1, $GUI_SHOW) 
 
                    GUICtrlSetState($Back_Button, $GUI_DISABLE) 
                    GUICtrlSetState($Next_Button, $GUI_ENABLE) 
            EndSwitch 
    EndSwitch 
WEnd 
 
Func _GUICtrlCreateSeperator($Direction, $Left, $Top, $Width=3, $Lenght=25) 
    Switch $Direction 
        Case 0 
            GUICtrlCreateLabel("", $Left, $Top, $Lenght, $Width, $SS_SUNKEN) 
        Case 1 
            GUICtrlCreateLabel("", $Left, $Top, $Width, $Lenght, $SS_SUNKEN) 
    EndSwitch 
EndFunc 
 
Func _Elements_SetState($iFirstCtrlID, $iLastCtrlID, $iState) 
    For $i = $iFirstCtrlID To $iLastCtrlID 
        GUICtrlSetState($i, $iState) 
    Next 
EndFunc 