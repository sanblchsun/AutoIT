;Проверяем, не запустился ли скрипт из ком. строки (чтобы скрипт не запускался вечно :) )
If Not StringInStr($CmdLineRaw, "/CmdLineRun") Then
    _Self_Restart(5) ;Через 5 секунд скрипт запустится снова
Else
    MsgBox(64, "", "Hello, this is after _Self_Restart session ;)")
EndIf

Func _Self_Restart($iTime)
    Run(@ComSpec & ' /c Ping -n ' & $iTime & ' localhost > nul & "' & @ScriptFullPath & '" /CmdLineRun', @ScriptDir, @SW_HIDE)
    Exit
EndFunc