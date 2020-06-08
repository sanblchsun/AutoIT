_Restart()
Func _Restart()
    $iRestart = MsgBox(49, 'Restart?', 'If press "OK", will restart')
    If $iRestart = 1 Then
        If @Compiled Then
            Run(@ScriptFullPath)
        Else
            $hProc = @AutoItExe & ' "' & @ScriptFullpath & '"'
            Run($hProc)
        EndIf
        Exit
    EndIf
EndFunc
 