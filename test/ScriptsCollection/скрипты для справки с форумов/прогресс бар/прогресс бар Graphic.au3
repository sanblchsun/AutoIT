
; sak
;http://www.autoitscript.com/forum/topic/126473-easy-graphic-progress-bar/

#NoTrayIcon
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

Opt("MustDeclareVars", 1)

Global $Form, $Graphic, $Label
Global $nMsg, $i, $time = 50

GraphicProgress()
Func GraphicProgress()
$Form = GUICreate("Form1", 302, 15, -1, -1, _
BitOR($WS_MINIMIZEBOX,$WS_SYSMENU,$WS_DLGFRAME,$WS_POPUP,$WS_GROUP,$WS_CLIPSIBLINGS), _
BitOR($WS_EX_OVERLAPPEDWINDOW,$WS_EX_TOPMOST,$WS_EX_WINDOWEDGE))
$Graphic = GUICtrlCreateGraphic(0, 0, 1, 15)
GUICtrlSetBkColor(-1, 0xFF0000)
$Label = GUICtrlCreateLabel("0%", 137, 2, 26, 13)
GUICtrlSetFont(-1, 6, 400, 0, "MS Sans Serif")
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUISetState(@SW_SHOW)

While 1
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case $GUI_EVENT_CLOSE
            Exit
        Case 0
            For $i = 1 To 302 Step 1
                GUICtrlSetPos($Graphic, 0, 0, $i, 15)
                GUICtrlSetData($Label, Round($i/3.02) & "%")
                If GUICtrlRead($Label) = 48 Then GUICtrlSetColor($Label, 0xFFFFFF)
                Sleep($time)
            Next
            For $i = 302 To 1 Step -1
                GUICtrlSetPos($Graphic, 0, 0, $i, 15)
                GUICtrlSetData($Label, Round($i/3.02) & "%")
                If GUICtrlRead($Label) = 52 Then GUICtrlSetColor($Label, 0x000000)
                Sleep($time)
            Next
                Exit
    EndSwitch
WEnd
EndFunc