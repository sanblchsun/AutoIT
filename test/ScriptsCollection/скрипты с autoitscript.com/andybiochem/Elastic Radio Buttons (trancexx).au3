;====== Elastic Trail script ======
; Original JavaScript by Philip Winston - pwinston@yahoo.com
; Adapted for AutoIT by AndyBiochem

#include <WindowsConstants.au3>
#include <GuiConstantsEx.au3>

;----- Variables -----
Global $iDots = 7;Number of dots
Global $aDots[$iDots][5];Dots array
Global $iXpos = 0
Global $iYpos = 0
Global $iDeltaT = 0.01
Global $iSegLen = 10
Global $iSpringK = 10
Global $iMass = 1
Global $iXGravity = 0
Global $iYGravity = 50
Global $iRes = 10
Global $iStopVel = 0.1
Global $iStopAcc = 0.1
Global $iDotSize = 5
Global $iBounce = 0.75

Global $iHeight = @DesktopHeight
Global $iWidth = @DesktopWidth

;----- 'Dots' -----
For $i = 1 To ($iDots - 1)
    $aDots[$i][0] = GUICreate("", $iDotSize, $iDotSize, 144, 160, $WS_POPUP, $WS_EX_TOOLWINDOW)
    GUISetBkColor(_RandomColor())
    GUISetState(@SW_SHOW)
Next

;############### LOOP ###############
While 1

    Sleep(20)

    $m = MouseGetPos()
    $iXpos = $m[0]
    $iYpos = $m[1]

    _Animate()

WEnd
;####################################


Func _Animate()

    $aDots[0][1] = $iXpos
    $aDots[0][2] = $iYpos

    For $i = 1 To ($iDots - 1)

        Local $spring[3]
        $spring[1] = 0
        $spring[2] = 0

        _Spring_Force($i - 1, $i, $spring)
        If $i < ($iDots - 1) Then _Spring_Force($i + 1, $i, $spring)

        Local $resist[3]
        $resist[1] = -$aDots[$i][3] * $iRes
        $resist[2] = -$aDots[$i][4] * $iRes


        Local $accel[3]
        $accel[1] = ($spring[1] + $resist[1]) / $iMass + $iXGravity
        $accel[2] = ($spring[2] + $resist[2]) / $iMass + $iYGravity

        $aDots[$i][3] += ($iDeltaT * $accel[1])
        $aDots[$i][4] += ($iDeltaT * $accel[2])


        If Abs($aDots[$i][3]) < $iStopVel And Abs($aDots[$i][4]) < $iStopVel And Abs($accel[1]) < $iStopAcc And Abs($accel[2]) < $iStopAcc Then
            $aDots[$i][3] = 0
            $aDots[$i][4] = 0
        EndIf

        $aDots[$i][1] += $aDots[$i][3]
        $aDots[$i][2] += $aDots[$i][4]

        If ($aDots[$i][2] < 0) Then
            If ($aDots[$i][4] < 0) Then $aDots[$i][4] = $iBounce * - $aDots[$i][4]
            $aDots[$i][2] = 0
        EndIf

        If ($aDots[$i][2] >= $iHeight - $iDotSize - 1) Then
            If ($aDots[$i][4] > 0) Then $aDots[$i][4] = $iBounce * - $aDots[$i][4]
            $aDots[$i][2] = $iHeight - $iDotSize - 1
        EndIf

        If ($aDots[$i][1] >= $iWidth - $iDotSize) Then
            If ($aDots[$i][3] > 0) Then $aDots[$i][3] = $iBounce * - $aDots[$i][3]
            $aDots[$i][1] = $iWidth - $iDotSize - 1
        EndIf

        If ($aDots[$i][1] < 0) Then
            If ($aDots[$i][3] < 0) Then $aDots[$i][3] = $iBounce * - $aDots[$i][3]
            $aDots[$i][1] = 0
        EndIf

        WinMove($aDots[$i][0], 0, $aDots[$i][1], $aDots[$i][2])

    Next

EndFunc  ;==>_Animate


Func _Spring_Force($i, $j, ByRef $spring)

    Local $springF

    $dx = $aDots[$i][1] - $aDots[$j][1]
    $dy = $aDots[$i][2] - $aDots[$j][2]
    $len = Sqrt($dx ^ 2 + $dy ^ 2)

    If Not ($len > $iSegLen) Then Return

    $springF = $iSpringK * ($len - $iSegLen)
    $spring[1] += ($dx / $len) * $springF
    $spring[2] += ($dy / $len) * $springF

EndFunc  ;==>_Spring_Force

Func _RandomColor()
    $r = "0x"
    For $i = 0 To 2
        $r &= Hex(Random(0, 255), 2)
    Next
    Return $r
EndFunc  ;==>_RandomColor


Func _Close()
    Exit
EndFunc  ;==>_Close
