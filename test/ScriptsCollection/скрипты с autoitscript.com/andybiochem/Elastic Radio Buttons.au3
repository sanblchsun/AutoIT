;====== Elastic Trail script ======
; Original JavaScript by Philip Winston - pwinston@yahoo.com
; Adapted for AutoIT by AndyBiochem

#include <GUIConstantsEx.au3>

Opt("GUIOnEventMode", 1)
Opt("MouseCoordMode",2)

;----- Variables -----
Global $iDots = 7       ;Number of dots
Global $aDots[$iDots][5] ;Dots array
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
Global $iDotSize = 13
Global $iBounce = 0.75

Global $iHeight = 700
Global $iWidth = 700

;----- GUI -----
GUICreate("",$iHeight,$iWidth)
GUISetOnEvent($GUI_EVENT_CLOSE,"_Close")

;----- 'Dots' -----
For $i = 1 to ($iDots - 1)
    $aDots[$i][0] = GUICtrlCreateRadio("", 144, 160,$iDotSize,$iDotSize)
Next

GUISetState(@SW_SHOW)
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
    
    GUICtrlSetPos($aDots[0][0],$aDots[0][1],$aDots[0][2])

    for $i = 1 to ($iDots - 1)
        
        Dim $spring[3]
        $spring[1] = 0
        $spring[2] = 0

        _Spring_Force($i-1, $i, $spring)
        If $i < ($iDots - 1) Then _Spring_Force($i+1, $i, $spring)
        
        Dim $resist[3]
        $resist[1] = -$aDots[$i][3] * $iRes
        $resist[2] = -$aDots[$i][4] * $iRes
        

        Dim $accel[3]
        $accel[1] = ($spring[1] + $resist[1])/$iMass + $iXGravity
        $accel[2] = ($spring[2] + $resist[2])/ $iMass + $iYGravity
        
        $aDots[$i][3] += ($iDeltaT * $accel[1])
        $aDots[$i][4] += ($iDeltaT * $accel[2])
        

        If abs($aDots[$i][3]) < $iStopVel And abs($aDots[$i][4]) < $iStopVel And abs($accel[1]) < $iStopAcc And abs($accel[2]) < $iStopAcc Then
            $aDots[$i][3] = 0
            $aDots[$i][4] = 0
        EndIf
        
        $aDots[$i][1] += $aDots[$i][3]
        $aDots[$i][2]+= $aDots[$i][4]
        
        if ($aDots[$i][2] <  0) Then
            if ($aDots[$i][4] < 0) Then $aDots[$i][4]= $iBounce * -$aDots[$i][4]
            $aDots[$i][2]= 0
        EndIf

        if ($aDots[$i][2] >=  $iHeight - $iDotSize - 1) Then
            if ($aDots[$i][4] > 0) Then $aDots[$i][4]= $iBounce * -$aDots[$i][4]
            $aDots[$i][2]= $iHeight - $iDotSize - 1
        EndIf
        
        if ($aDots[$i][1] >= $iWidth - $iDotSize) Then
            if ($aDots[$i][3]> 0) Then $aDots[$i][3]= $iBounce * -$aDots[$i][3]
            $aDots[$i][1]= $iWidth - $iDotSize - 1
        EndIf
        
        if ($aDots[$i][1] < 0) Then
            if ($aDots[$i][3] < 0) Then $aDots[$i][3]= $iBounce * -$aDots[$i][3]
            $aDots[$i][1]= 0
        EndIf
        
        GUICtrlSetPos($aDots[$i][0],$aDots[$i][1],$aDots[$i][2])
    
    Next

EndFunc


Func _Spring_Force($i, $j, ByRef $spring)
    
    Local $springF

    $dx = $aDots[$i][1] - $aDots[$j][1]
    $dy = $aDots[$i][2] - $aDots[$j][2]
    $len = Sqrt($dx^2 + $dy^2)
    
    If Not ($len > $iSegLen) Then Return
    
    $springF = $iSpringK * ($len - $iSegLen)
    $spring[1] += ($dx / $len) * $springF
    $spring[2] += ($dy / $len) * $springF

EndFunc


Func _Close()
    Exit
EndFunc
