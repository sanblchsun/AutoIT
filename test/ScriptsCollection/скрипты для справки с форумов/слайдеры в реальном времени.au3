#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <SliderConstants.au3>
;

$Gui = GUICreate("Slider Update Demo", 250, 200)

GUIRegisterMsg($WM_HSCROLL, "WM_HVSCROLL")
GUIRegisterMsg($WM_VSCROLL, "WM_HVSCROLL")

$Vertical_Label = GUICtrlCreateLabel("Vertical Slider Read: 100", 20, 20, 200)
$Horizontal_Label = GUICtrlCreateLabel("Horizontal Slider Read: 0", 80, 120, 200)

$Vertical_Slider = GUICtrlCreateSlider(20, 50, 30, 120, BitOR($GUI_SS_DEFAULT_SLIDER, $TBS_VERT))
$Horizontal_Slider = GUICtrlCreateSlider(60, 150, 160, 30)

GUISetState()

While 1
    $nMsg = GUIGetMsg()
    
    Switch $nMsg
        Case $GUI_EVENT_CLOSE
            Exit
    EndSwitch
WEnd

Func WM_HVSCROLL($hWndGUI, $MsgID, $WParam, $LParam)
    Switch $LParam
        Case GUICtrlGetHandle($Vertical_Slider)
            GUICtrlSetData($Vertical_Label, "Vertical Slider Read: " & 100-GUICtrlRead($Vertical_Slider))
        Case GUICtrlGetHandle($Horizontal_Slider)
            GUICtrlSetData($Horizontal_Label, "Horizontal Slider Read: " & GUICtrlRead($Horizontal_Slider))
    EndSwitch
EndFunc