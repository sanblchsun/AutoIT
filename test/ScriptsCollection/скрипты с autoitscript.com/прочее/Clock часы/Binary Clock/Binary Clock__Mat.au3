; Mat
; http://www.autoitscript.com/forum/topic/106972-binary-clock
Global $sCode

Opt("GUIOnEventMode", 1)

GUICreate("Binary Clock", 140, 94, -1, -1, 0x00080000 + 0x00C00000)
GUISetOnEvent(-3, "_Exit")
GUISetBkColor(0)

Global $ahItems[7][5]

$ahItems[0][1] = GUICtrlCreateCheckbox("", 2, 50, 17, 17)
$ahItems[0][0] = GUICtrlCreateCheckbox("", 2, 74, 17, 17)

$ahItems[1][3] = GUICtrlCreateCheckbox("", 26, 2, 17, 17)
$ahItems[1][2] = GUICtrlCreateCheckbox("", 26, 26, 17, 17)
$ahItems[1][1] = GUICtrlCreateCheckbox("", 26, 50, 17, 17)
$ahItems[1][0] = GUICtrlCreateCheckbox("", 26, 74, 17, 17)

$ahItems[2][2] = GUICtrlCreateCheckbox("", 50, 26, 17, 17)
$ahItems[2][1] = GUICtrlCreateCheckbox("", 50, 50, 17, 17)
$ahItems[2][0] = GUICtrlCreateCheckbox("", 50, 74, 17, 17)

$ahItems[3][3] = GUICtrlCreateCheckbox("", 74, 2, 17, 17)
$ahItems[3][2] = GUICtrlCreateCheckbox("", 74, 26, 17, 17)
$ahItems[3][1] = GUICtrlCreateCheckbox("", 74, 50, 17, 17)
$ahItems[3][0] = GUICtrlCreateCheckbox("", 74, 74, 17, 17)

$ahItems[4][2] = GUICtrlCreateCheckbox("", 98, 26, 17, 17)
$ahItems[4][1] = GUICtrlCreateCheckbox("", 98, 50, 17, 17)
$ahItems[4][0] = GUICtrlCreateCheckbox("", 98, 74, 17, 17)

$ahItems[5][3] = GUICtrlCreateCheckbox("", 122, 2, 17, 17)
$ahItems[5][2] = GUICtrlCreateCheckbox("", 122, 26, 17, 17)
$ahItems[5][1] = GUICtrlCreateCheckbox("", 122, 50, 17, 17)
$ahItems[5][0] = GUICtrlCreateCheckbox("", 122, 74, 17, 17)

GUISetState()

While 1
    BOX_Update()
    Sleep(500)
WEnd

Func BOX_Update()
    $sCode = ""
    Local $aTime[3] = [@HOUR, @MIN, @SEC], $t, $n, $i
    For $t = 0 To 2
        If StringLen($aTime[$t]) = 2 Then
            $n = StringLeft($aTime[$t], 1)
            For $i = 0 To 2
                If BitAND($n, 2 ^ $i) Then ContinueLoop 1 + 0 * BOX_Add($t * 2, $i, 1)
                BOX_Add($t * 2, $i, 0)
            Next
            $aTime[$t] -= $n * 10
        EndIf
        For $i = 0 To 3
            If BitAND($aTime[$t], 2 ^ $i) Then ContinueLoop 1 + 0 * BOX_Add($t * 2 + 1, $i, 1)
            BOX_Add($t * 2 + 1, $i, 0)
        Next
    Next
    BOX_RunCode()
EndFunc   ;==>BOX_Update

Func BOX_Add($i, $x, $iTicked)
    $sCode &= @CRLF & $i & "," & $x & "," & $iTicked
EndFunc   ;==>BOX_Add

Func BOX_SetState($i, $x, $iTicked)
    $iTicked = (($iTicked - 1) * - 3) + 1
    If Not BitAND(GUICtrlGetState($ahItems[$i][$x]), $iTicked) Then GUICtrlSetState($ahItems[$i][$x], $iTicked)
EndFunc   ;==>BOX_SetState

Func BOX_RunCode()
    Local $aData = StringSplit($sCode, @CRLF, 1)
    For $i = 1 To $aData[0]
        $aParams = StringSplit($aData[$i], ",")
        $aParams[0] = "CallArgArray"
        Call("BOX_SetState", $aParams)
    Next
EndFunc   ;==>BOX_RunCode

Func _Exit()
    Exit
EndFunc   ;==>_Exit