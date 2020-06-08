#include <GUIConstantsEx.au3>
#include <WinAPI.au3>
#include <StaticConstants.au3>

Global $aLabel[11][2] = [[10]], $iWl = 100, $iHl = 20, $iMl = 10

$hGui = GUICreate('Test Label', $iWl * 2, $aLabel[0][0] * ($iHl + $iMl) + $iMl)
For $i = 1 To $aLabel[0][0]
    $aLabel[$i][0] = GUICtrlCreateLabel('Label ' & $i, $iWl / 2, $iMl + ($i - 1) * ($iHl + $iMl), $iWl, $iHl, _
            BitOR($SS_CENTER, $SS_CENTERIMAGE))
    GUICtrlSetBkColor(-1, 0xFF0000)
    GUICtrlSetCursor(-1, 0)
Next
GUISetState()

While 1
    _Label($aLabel)
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case $GUI_EVENT_CLOSE
            Exit
        Case $aLabel[1][0] To $aLabel[$aLabel[0][0]][0]
            GUICtrlSetBkColor($nMsg, 0x00FF00)
            MsgBox(64, 'Info', GUICtrlRead($nMsg), 0, $hGui)
    EndSwitch
WEnd

Func _Label(ByRef $a_Label)
    Local $a_Cur = GUIGetCursorInfo()
    If @error Then Return
    If $a_Cur[4] Then
        For $i = 1 To $a_Label[0][0]
            If $a_Cur[4] = $a_Label[$i][0] Then
                If Not $a_Label[$i][1] Then
                    GUICtrlSetBkColor($a_Label[$i][0], 0x0000FF)
                    $a_Label[$i][1] = 1
                    _WinAPI_MessageBeep(1)
                EndIf
            Else
                If $a_Label[$i][1] Then
                    GUICtrlSetBkColor($a_Label[$i][0], 0xFF0000)
                    $a_Label[$i][1] = 0
                EndIf
            EndIf
        Next
    Else
        For $i = 1 To $a_Label[0][0]
            If $a_Label[$i][1] Then
                GUICtrlSetBkColor($a_Label[$i][0], 0xFF0000)
                $a_Label[$i][1] = 0
            EndIf
        Next
    EndIf
EndFunc   ;==>_Label