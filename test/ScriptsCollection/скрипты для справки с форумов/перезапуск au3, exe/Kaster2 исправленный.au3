_Restart()
Func _Restart()
    $iRestart = MsgBox(49, 'Restart?', 'If press "OK", will restart')
    If $iRestart = 1 Then
        Run(@AutoItExe & ' "' & @ScriptFullpath & '"')
        Exit
    EndIf
EndFunc
 