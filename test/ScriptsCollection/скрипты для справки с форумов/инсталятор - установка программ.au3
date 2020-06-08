#include <GuiConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

$Main_GUI = GUICreate("Wizard Demo!", 400, 300)
$Img_Path = @SystemDir & "\oobe\images\wpakey.jpg" ;@SystemDir & "\Setup.bmp"
$iStep = 1

Global $Main_Ctrls[10][4] = _
        [ _
        [_GUICtrlCreateSeperator(0, 2, 265, 3, 396), 0, 0, 0], _
        [GUICtrlCreateButton("<<Back", 170, 270, 60), $GUI_DISABLE, $GUI_ENABLE, $GUI_ENABLE], _
        [GUICtrlCreateButton("Next>>", 240, 270, 60), $GUI_ENABLE, $GUI_ENABLE, $GUI_DISABLE], _
        [GUICtrlCreateButton("Exit", 325, 270, 60), 0, 0, 0], _
        [GUICtrlCreatePic($Img_Path, 2, 2, 160, 263, _
            $SS_SUNKEN, $WS_EX_STATICEDGE + $WS_EX_CLIENTEDGE), $GUI_SHOW, $GUI_HIDE, $GUI_HIDE], _
        [GUICtrlCreateLabel("Wellcome!", 240, 20, 150), $GUI_SHOW, $GUI_HIDE, $GUI_HIDE], _
        [GUICtrlCreateInput("Some input", 10, 20, 180, 20), $GUI_HIDE, $GUI_SHOW, $GUI_HIDE], _
        [GUICtrlCreateCheckbox("Some checkbox", 10, 50), $GUI_HIDE, $GUI_SHOW, $GUI_HIDE], _
        [GUICtrlCreateEdit("Some Edit", 10, 20, 180, 220), $GUI_HIDE, $GUI_HIDE, $GUI_SHOW], _
        [GUICtrlCreateLabel("Some Label", 220, 20), $GUI_HIDE, $GUI_HIDE, $GUI_SHOW] _
        ]

GUICtrlSetFont($Main_Ctrls[5][0], 12, 800)
_Elements_SetState($iStep)

GUISetState(@SW_SHOW, $Main_GUI)

While 1
    $Msg = GUIGetMsg()
   
    Switch $Msg
        Case $Main_Ctrls[3][0], $GUI_EVENT_CLOSE
            $Ask = MsgBox(256 + 52, "Attention", "Are you sure you want to exit the Wizard now?", 0, $Main_GUI)
            If $Ask <> 6 Then ContinueLoop
            Exit
        Case $Main_Ctrls[2][0]
            $iStep += 1
            _Elements_SetState($iStep)
        Case $Main_Ctrls[1][0]
            $iStep -= 1
            _Elements_SetState($iStep)
    EndSwitch
WEnd

Func _GUICtrlCreateSeperator($Direction, $Left, $Top, $Width = 3, $Lenght = 25)
    If $Direction Then Return GUICtrlCreateLabel("", $Left, $Top, $Width, $Lenght, $SS_SUNKEN)
    Return GUICtrlCreateLabel("", $Left, $Top, $Lenght, $Width, $SS_SUNKEN)
EndFunc   ;==>_GUICtrlCreateSeperator

Func _Elements_SetState($iStep)
    For $i = 1 To UBound($Main_Ctrls) - 1
        _GUICtrlSetState($Main_Ctrls[$i][0], $Main_Ctrls[$i][$iStep])
    Next
EndFunc   ;==>_Elements_SetState

Func _GUICtrlSetState($iCtrlID, $iState)
    If BitAND(GUICtrlGetState($iCtrlID), $iState) <> $iState Then
        GUICtrlSetState($iCtrlID, $iState)
    EndIf
EndFunc   ;==>_GUICtrlSetState