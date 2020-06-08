#Include <Misc.au3>

HotKeySet ( "{ESC}"   , "_Quit" )

$Modifier = 1
$Pressed  = 1

While 1
    Sleep(10)
    _CursorMove()
WEnd

Func _CursorMove()
    ; Reset Speed
    If (_IsPressed(25) + _IsPressed(26) + _IsPressed(27) + _IsPressed(28)) = 0 Then
        $Modifier = 1
        $Pressed  = 1
    EndIf
    ; Check Keys
    Select
        ; Cursor Up & Left
        Case _IsPressed(25) AND _IsPressed(26)
            $Delta_X = -1
            $Delta_Y = -1
        ; Cursor Up & Right
        Case _IsPressed(27) AND _IsPressed(26)
            $Delta_X = +1
            $Delta_Y = -1
        ; Cursor Down & Left
        Case _IsPressed(25) AND _IsPressed(28)
            $Delta_X = -1
            $Delta_Y = +1
        ; Cursor Down & Right
        Case _IsPressed(27) AND _IsPressed(28)
            $Delta_X = +1
            $Delta_Y = +1
        ; Cursor Left
        Case _IsPressed(25)
            $Delta_X = -1
            $Delta_Y =  0
        ; Cursor Up
        Case _IsPressed(26)
            $Delta_X =  0
            $Delta_Y = -1
        ; Cursor Right
        Case _IsPressed(27)
            $Delta_X = +1
            $Delta_Y =  0
        ; Cursor Down
        Case _IsPressed(28)
            $Delta_X =  0
            $Delta_Y = +1
        Case Else
            Return
    EndSelect
    ; Boost Mouse Speed
    If IsInt($Pressed / 10) Then
        $Modifier += 1
        $Pressed  += 1
    Else
        $Pressed  += 1
    EndIf
    ; Shift Accelerate
    If _IsPressed(10) Then
        $Accel = 3
    Else
        $Accel = 1
    EndIf
    ; Throttle Modifier
    If $Modifier >= 15 Then $Modifier = 15
    $X_Axis  = MouseGetPos(0) + ($Delta_X * ($Modifier * $Accel))
    $Y_Axis  = MouseGetPos(1) + ($Delta_Y * ($Modifier * $Accel))
    $Desktop = WinGetPos( "Program Manager" )
    ; Test Location - Multi Monitor
    If $X_Axis < $Desktop[0] Then $X_Axis = $Desktop[0]
    If $Y_Axis < $Desktop[1] Then $Y_Axis = $Desktop[1]
    If $X_Axis > $Desktop[2] - $Desktop[0] Then $X_Axis = $Desktop[2] - $Desktop[0]
    If $Y_Axis > $Desktop[3] - $Desktop[1] Then $Y_Axis = $Desktop[3] - $Desktop[1]
    MouseMove( $X_Axis , $Y_Axis , 1 )
EndFunc

Func _Quit()
    Exit
EndFunc
