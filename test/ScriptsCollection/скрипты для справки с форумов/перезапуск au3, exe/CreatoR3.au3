    If @extended Then
        While ProcessExists($Pid)
            Sleep(100)
        WEnd
    EndIf