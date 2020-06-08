;"MR" (Mover|Resizer) version 0.1

HotKeySet ("^{Left}", "fmLeft")
HotKeySet ("^{Right}", "fmRight")
HotKeySet ("^{UP}", "fmUP")
HotKeySet ("^{DOWN}", "fmDOWN")

HotKeySet ("+{Left}", "fvLeft")
HotKeySet ("+{Right}", "fvRight")
HotKeySet ("+{UP}", "fvUP")
HotKeySet ("+{DOWN}", "fvDOWN")

dim $ax[4], $ay[4], $aw[4], $ah[4], $active[4], $result[4]

$tray=WinGetPos("[CLASS:Shell_TrayWnd]")

For $x = 0 to 3 Step 1
    $ax[$x] = Round((@DesktopWidth/4)*($x+1))
Next

For $y = 0 to 3 Step 1
    $ay[$y] = Round(((@DesktopHeight-$tray[3])/4)*($y+1))
Next

;MsgBox (64, "", $ay[0] &" "& $ay[1] &" "& $ay[2] &" "& $ay[3] )

For $w = 0 to 3 Step 1
    $aw[$w] = Round((@DesktopWidth/4)*($w+1))
Next

For $h = 0 to 3 Step 1
    $ah[$h] = Round(((@DesktopHeight-$tray[3])/4)*($h+1))
Next

While 1
    $nMsg = GUIGetMsg()
WEnd

Func fmLeft()
WinSetState ("[ACTIVE]","", @SW_RESTORE)
$active=WinGetPos ("[ACTIVE]")
if $active[0] > 0 AND $active[0] < $ax[0] Then
    $result[0] = 0
ElseIf $active[0] > $ax[0] and  $active[0] < $ax[1] Then
    $result[0] = $ax[0]
ElseIf $active[0] > $ax[1] and  $active[0] < $ax[2] Then
    $result[0] = $ax[1]
ElseIf $active[0] > $ax[2] and  $active[0] < $ax[3] Then
    $result[0] = $ax[2]
ElseIf $active[0] = 0 Then
    $result[0] = 0
ElseIf $active[0] = $ax[0] Then
    $result[0] = 0
ElseIf $active[0] = $ax[1] Then
    $result[0] = $ax[0]
ElseIf $active[0] = $ax[2] Then
    $result[0] = $ax[1]
EndIf
WinMove("[ACTIVE]","", $result[0], $active[1], $active[2], $active[3])
EndFunc

Func fmRight()
WinSetState ("[ACTIVE]","", @SW_RESTORE)
$active=WinGetPos ("[ACTIVE]")
if $active[0] > 0 AND $active[0] < $ax[0] Then
    $result[0] = $ax[0]
ElseIf $active[0] > $ax[0] and  $active[0] < $ax[1] Then
    $result[0] = $ax[1]
ElseIf $active[0] > $ax[1] and  $active[0] < $ax[2] Then
    $result[0] = $ax[2]
ElseIf $active[0] > $ax[2] and  $active[0] < $ax[3] Then
    $result[0] = $ax[2]
ElseIf $active[0] = 0 Then
    $result[0] = $ax[0]
ElseIf $active[0] = $ax[0] Then
    $result[0] = $ax[1]
ElseIf $active[0] = $ax[1] Then
    $result[0] = $ax[2]
ElseIf $active[0] = $ax[2] Then
    $result[0] = $ax[2]
EndIf
WinMove("[ACTIVE]","", $result[0], $active[1], $active[2], $active[3])
EndFunc

Func fmUP()
WinSetState ("[ACTIVE]","", @SW_RESTORE)
$active=WinGetPos ("[ACTIVE]")
if $active[1] > 0 AND $active[1] < $ay[0] Then
    $result[1] = 0
ElseIf $active[1] > $ay[0] and  $active[1] < $ay[1] Then
    $result[1] = $ay[0]
ElseIf $active[1] > $ay[1] and  $active[1] < $ay[2] Then
    $result[1] = $ay[1]
ElseIf $active[1] > $ay[2] and  $active[1] < $ay[3] Then
    $result[1] = $ay[2]
ElseIf $active[1] = 0 Then
    $result[1] = 0
ElseIf $active[1] = $ay[0] Then
    $result[1] = 0
ElseIf $active[1] = $ay[1] Then
    $result[1] = $ay[0]
ElseIf $active[1] = $ay[2] Then
    $result[1] = $ay[1]
EndIf
WinMove("[ACTIVE]", "", $active[0], $result[1],  $active[2], $active[3])
EndFunc

Func fmDOWN()
WinSetState ("[ACTIVE]","", @SW_RESTORE)
$active=WinGetPos ("[ACTIVE]")
if $active[1] > 0 AND $active[1] < $ay[0] Then
    $result[1] = $ay[0]
ElseIf $active[1] > $ay[0] and  $active[1] < $ay[1] Then
    $result[1] = $ay[1]
ElseIf $active[1] > $ay[1] and  $active[1] < $ay[2] Then
    $result[1] = $ay[2]
ElseIf $active[1] > $ay[2] and  $active[1] < $ay[3] Then
    $result[1] = $ay[2]
ElseIf $active[1] = 0 Then
    $result[1] = $ay[0]
ElseIf $active[1] = $ay[0] Then
    $result[1] = $ay[1]
ElseIf $active[1] = $ay[1] Then
    $result[1] = $ay[2]
ElseIf $active[1] = $ay[2] Then
    $result[1] = $ay[2]
EndIf
WinMove("[ACTIVE]", "", $active[0], $result[1],  $active[2], $active[3])
EndFunc

Func fvLeft()
WinSetState ("[ACTIVE]","", @SW_RESTORE)
$active=WinGetPos ("[ACTIVE]")
if $active[2] > 0 AND $active[2] < $aw[0] Then
    $result[2] = 0
ElseIf $active[2] > $aw[0] and  $active[2] < $aw[1] Then
    $result[2] = $aw[0]
ElseIf $active[2] > $aw[1] and  $active[2] < $aw[2] Then
    $result[2] = $aw[1]
ElseIf $active[2] > $aw[2] and  $active[2] < $aw[3] Then
    $result[2] = $aw[2]
ElseIf $active[2] = $aw[0] Then
    $result[2] = $aw[0]
ElseIf $active[2] = $aw[1] Then
    $result[2] = $aw[0]
ElseIf $active[2] = $aw[2] Then
    $result[2] = $aw[1]
ElseIf $active[2] = $aw[3] Then
    $result[2] = $aw[2]
EndIf
WinMove("[ACTIVE]","", $active[0], $active[1], $result[2], $active[3])
EndFunc

Func fvRight()
WinSetState ("[ACTIVE]","", @SW_RESTORE)
$active=WinGetPos ("[ACTIVE]")
if $active[2] > 0 AND $active[2] < $aw[0] Then
    $result[2] = $aw[0]
ElseIf $active[2] > $aw[0] and  $active[2] < $aw[1] Then
    $result[2] = $aw[1]
ElseIf $active[2] > $aw[1] and  $active[2] < $aw[2] Then
    $result[2] = $aw[2]
ElseIf $active[2] > $aw[2] and  $active[2] < $aw[3] Then
    $result[2] = $aw[2]
ElseIf $active[2] = $aw[0] Then
    $result[2] = $aw[1]
ElseIf $active[2] = $aw[1] Then
    $result[2] = $aw[2]
ElseIf $active[2] = $aw[2] Then
    $result[2] = $aw[3]
ElseIf $active[2] = $aw[3] Then
    $result[2] = $aw[3]
EndIf
WinMove("[ACTIVE]","", $active[0], $active[1], $result[2], $active[3])
EndFunc

Func fvUP()
WinSetState ("[ACTIVE]","", @SW_RESTORE)
$active=WinGetPos ("[ACTIVE]")
if $active[3] > 0 AND $active[3] < $ah[0] Then
    $result[3] = $ah[0]
ElseIf $active[3] > $ah[0] and  $active[3] < $ah[1] Then
    $result[3] = $ah[0]
ElseIf $active[3] > $ah[1] and  $active[3] < $ah[2] Then
    $result[3] = $ah[1]
ElseIf $active[3] > $ah[2] and  $active[3] < $ah[3] Then
    $result[3] = $ah[2]
ElseIf $active[3] = $ah[0] Then
    $result[3] = $ah[0]
ElseIf $active[3] = $ah[1] Then
    $result[3] = $ah[0]
ElseIf $active[3] = $ah[2] Then
    $result[3] = $ah[1]
ElseIf $active[3] = $ah[3] Then
    $result[3] = $ah[2]
EndIf
WinMove("[ACTIVE]","", $active[0], $active[1], $active[2], $result[3])
EndFunc

Func fvDOWN()
WinSetState ("[ACTIVE]","", @SW_RESTORE)
$active=WinGetPos ("[ACTIVE]")
if $active[3] > 0 AND $active[3] < $ah[0] Then
    $result[3] = $ah[0]
ElseIf $active[3] > $ah[0] and  $active[3] < $ah[1] Then
    $result[3] = $ah[1]
ElseIf $active[3] > $ah[1] and  $active[3] < $ah[2] Then
    $result[3] = $ah[2]
ElseIf $active[3] > $ah[2] and  $active[3] < $ah[3] Then
    $result[3] = $ah[3]
ElseIf $active[3] = $ah[0] Then
    $result[3] = $ah[1]
ElseIf $active[3] = $ah[1] Then
    $result[3] = $ah[2]
ElseIf $active[3] = $ah[2] Then
    $result[3] = $ah[3]
ElseIf $active[3] = $ah[3] Then
    $result[3] = $ah[3]
EndIf
WinMove("[ACTIVE]","", $active[0], $active[1], $active[2], $result[3])
EndFunc