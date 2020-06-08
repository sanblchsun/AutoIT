#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <WinAPI.au3>

$hGUI = GUICreate("Move Label")
$Checkbox = GUICtrlCreateCheckbox("My Checkbox, Move me ;)", 20, 20, -1, 16)
$Label = GUICtrlCreateButton("Кнопка блин", 20, 50, -1, 22)
GUICtrlSetCursor(-1, 0)

GUISetState()

While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            Exit
        Case $GUI_EVENT_PRIMARYDOWN
            Ctrl_Drag_And_Move($hGUI, $Checkbox, "Checkbox")
            Ctrl_Drag_And_Move($hGUI, $Label, "Label")
    EndSwitch
WEnd

Func Ctrl_Drag_And_Move($hGUI, $nCtrlID, $sCtrlName)
    Local $aCur_Info, $aCtrl_Pos, $aMouse_Pos, $iNewLeft_Pos, $iNewTop_Pos, $aRet[2]
    Local $stPoint, $iOld_Opt_MCM, $aGUI_Pos, $aCtrl_Pos, $hGUI_Dummy, $nCtrlID_Dummy
    
    $aMouse_Pos = MouseGetPos()
    
    $stPoint = DllStructCreate("int X;int Y")
    DllStructSetData($stPoint, 1, $aMouse_Pos[0])
    DllStructSetData($stPoint, 2, $aMouse_Pos[1])
    
    If _WinAPI_WindowFromPoint($stPoint) <> GUICtrlGetHandle($nCtrlID) Then
        Return SetError(1, 0, 0)
    EndIf
    
    $iOld_Opt_MCM = Opt("MouseCoordMode", 2)
    $aGUI_Pos = WinGetPos($hGUI)
    $aCtrl_Pos = ControlGetPos($hGUI, "", $nCtrlID)
    
    $hGUI_Dummy = GUICreate("", _
        $aGUI_Pos[2]-10, $aGUI_Pos[3]-30, $aGUI_Pos[0]+5, $aGUI_Pos[1]+25, $WS_POPUP, $WS_EX_TOPMOST, $hGUI)
    
    $nCtrlID_Dummy = Execute("GUICtrlCreate" & $sCtrlName & _
        '(' & _
        '"' & GUICtrlRead($nCtrlID, 1) & '", ' & _
        $aCtrl_Pos[0] & ', ' & _
        $aCtrl_Pos[1] & ', ' & _
        $aCtrl_Pos[2] & ', ' & _
        $aCtrl_Pos[3] & _
        ')')
    
    WinSetTrans($hGUI_Dummy, "", 50)
    GUISetState(@SW_SHOW, $hGUI_Dummy)
    
    $aCur_Info = GUIGetCursorInfo($hGUI_Dummy)
    
    GUICtrlSetState($nCtrlID, $GUI_HIDE)
    
    If IsArray($aCur_Info) And $aCur_Info[2] = 1 Then
        While IsArray($aCur_Info) And $aCur_Info[2] = 1
            $aCur_Info = GUIGetCursorInfo($hGUI_Dummy)
            $aCtrl_Pos = ControlGetPos($hGUI_Dummy, "", $nCtrlID_Dummy)
            $aMouse_Pos = MouseGetPos()
            
            $iNewLeft_Pos = $aMouse_Pos[0] - ($aCtrl_Pos[2] / 2)
            $iNewTop_Pos = $aMouse_Pos[1] - ($aCtrl_Pos[3] / 2)
            
            If $aCtrl_Pos[0] <> $iNewLeft_Pos Or $aCtrl_Pos[1] <> $iNewTop_Pos Then
                GUICtrlSetPos($nCtrlID_Dummy, $iNewLeft_Pos, $iNewTop_Pos)
                
                ToolTip($sCtrlName & " coords:" & @CRLF & "X: " & $iNewLeft_Pos & @CRLF & "Y: " & $iNewTop_Pos, _
                    $aGUI_Pos[0] + $aMouse_Pos[0] + 20, $aGUI_Pos[1] + $aMouse_Pos[1] + 50)
            Else
                Sleep(5)
            EndIf
        WEnd
    EndIf
    
    ToolTip("")
    
    If $iNewLeft_Pos And $iNewTop_Pos Then GUICtrlSetPos($nCtrlID, $iNewLeft_Pos+2, $iNewTop_Pos+3)
    GUICtrlSetState($nCtrlID, $GUI_SHOW)
    GUIDelete($hGUI_Dummy)
    
    Opt("MouseCoordMode", $iOld_Opt_MCM)
    
    $aRet[0] = $iNewLeft_Pos
    $aRet[1] = $iNewTop_Pos
    
    Return $aRet
EndFunc