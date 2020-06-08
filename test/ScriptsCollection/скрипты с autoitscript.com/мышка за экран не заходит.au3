; http://www.autoitscript.com/forum/topic/94611-mouse-wrap/page__view__findpost__p__679643

#NoTrayIcon
HotKeySet("{Esc}","_Exit")
$Desktop_Area = WinGetPos("Program Manager")
If $Desktop_Area[0] < 0 Then
    $Desktop_Area[2] -= Abs($Desktop_Area[0])
EndIf
If $Desktop_Area[1] < 0 Then
    $Desktop_Area[3] -= Abs($Desktop_Area[1])
EndIf

While 1
    Sleep(10)
    $Mgp = MouseGetPos()
    If $Mgp[0] > $Desktop_Area[2] - 2 Then 
        MouseMove ($Desktop_Area[0] + 2, $Mgp[1], '')
    ElseIf $Mgp[0] < $Desktop_Area[0] + 2 Then 
        MouseMove ($Desktop_Area[2] - 2, $Mgp[1], '')
    EndIf
    
    If $Mgp[1] > $Desktop_Area[3] - 2 Then 
        MouseMove ($Mgp[0], $Desktop_Area[1] + 2, '')
    ElseIf $Mgp[1] < $Desktop_Area[1] + 2 Then 
        MouseMove ($Mgp[0], $Desktop_Area[3] - 2, '')
    EndIf
WEnd

Func _Exit()
    Exit
EndFunc