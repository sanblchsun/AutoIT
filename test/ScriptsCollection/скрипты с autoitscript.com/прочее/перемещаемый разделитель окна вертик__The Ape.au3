#include <GUIConstants.au3>
#include <WindowsConstants.au3>

$GUI = GUICreate("$GUI", 500, 250, -1, -1, $WS_OVERLAPPEDWINDOW)
$EditL = GUICtrlCreateEdit("$EditL", 0, 0, 245, 250)
GUICtrlSetBkColor(-1, 0xcccccc)
$VslideWid = 6
$VslideWIdBy2 = Int($VslideWid / 2)
GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKBOTTOM + $GUI_DOCKWIDTH + $GUI_DOCKLEFT)
$EditR = GUICtrlCreateEdit("$EditR", 245 + $VslideWid, 0, 250, 250)
GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKBOTTOM + $GUI_DOCKLEFT + $GUI_DOCKRIGHT)
GUICtrlSetBkColor(-1, 0xaaaaaa)
;~ $Drag = GUICtrlCreatePic("", 245, 0, $VslideWid, 250)
;~ GUICtrlSetImage(-1,"vertslider1.bmp")
$Drag = GUICtrlCreateLabel("", 245, 0, $VslideWid, 250)
GUICtrlSetCursor(-1, 13)
GUICtrlSetResizing(-1, $GUI_DOCKTOP + $GUI_DOCKBOTTOM + $GUI_DOCKWIDTH + $GUI_DOCKLEFT)

GUISetState()

$LPos = ControlGetPos($GUI, "", $EditL)
$RPos = ControlGetPos($GUI, "", $EditR)
$DPos = ControlGetPos($GUI, "", $Drag)
$WinTray = WinGetPos("[CLASS:Shell_TrayWnd]")

While 1
    $msg = GUIGetMsg()
    Select

        Case $msg = $Drag
            $LPos = ControlGetPos($GUI, "", $EditL)
            $RPos = ControlGetPos($GUI, "", $EditR)
            $DPos = ControlGetPos($GUI, "", $Drag)
            $WPos = WinGetPos($GUI)
            GUISetCursor(13, 1, $GUI)
            GUISetState(@SW_DISABLE, $GUI)
            Do
                $pos = GUIGetCursorInfo($GUI)
                ControlMove($GUI, "", $Drag, $pos[0] - $VslideWIdBy2, $DPos[1], $VslideWid, $DPos[3])
;~              ControlMove($GUI, "", $EditL, $LPos[0], $LPos[1], $pos[0]-$VslideWIdBy2, $LPos[3])
;~              ControlMove($GUI, "", $EditR, $pos[0]+$VslideWIdBy2, $RPos[1], $WPos[2]-$pos[0]-$VslideWid, $RPos[3])
            Until $pos[2] = 0
            ControlMove($GUI, "", $EditL, $LPos[0], $LPos[1], $pos[0] - $VslideWIdBy2, $LPos[3])
            ControlMove($GUI, "", $EditR, $pos[0] + $VslideWIdBy2, $RPos[1], $WPos[2] - $pos[0] - $VslideWid, $RPos[3])
            GUISetCursor()
            GUISetState(@SW_ENABLE, $GUI)
            GUICtrlSetState($Drag, $GUI_FOCUS)
            $LPos = ControlGetPos($GUI, "", $EditL)
            $RPos = ControlGetPos($GUI, "", $EditR)
            $DPos = ControlGetPos($GUI, "", $Drag)

        Case $msg = $GUI_EVENT_MAXIMIZE
            _Event()
            
        Case $msg = $GUI_EVENT_RESTORE
            _Event()
            
        Case $msg = $GUI_EVENT_RESIZED
            _Event()
            
        Case $msg = $GUI_EVENT_CLOSE
            Exit
    EndSelect
WEnd

Func _Event()
    $WPos = WinGetPos($GUI)
    ControlMove($GUI, "", $Drag, $DPos[0] - $VslideWIdBy2, $DPos[1], $VslideWid, $WPos[3] - $WinTray[3])
    ControlMove($GUI, "", $EditL, $LPos[0], $LPos[1], $LPos[2] - $VslideWIdBy2, $WPos[3] - $WinTray[3])
    ControlMove($GUI, "", $EditR, $DPos[0] + $VslideWIdBy2, $RPos[1], $WPos[2] - $RPos[0] - $VslideWid, $WPos[3] - $WinTray[3])
    $LPos = ControlGetPos($GUI, "", $EditL)
    $RPos = ControlGetPos($GUI, "", $EditR)
    $DPos = ControlGetPos($GUI, "", $Drag)
EndFunc   ;==>_Event

GUIDelete()

Exit
