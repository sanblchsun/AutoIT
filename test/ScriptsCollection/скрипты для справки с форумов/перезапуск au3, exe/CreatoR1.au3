;���������, �� ���������� �� ������ �� ���. ������ (����� ������ �� ���������� ����� :) )
If Not StringInStr($CmdLineRaw, "/CmdLineRun") Then
    _Self_Restart(5) ;����� 5 ������ ������ ���������� �����
Else
    MsgBox(64, "", "Hello, this is after _Self_Restart session ;)")
EndIf

Func _Self_Restart($iTime)
    Run(@ComSpec & ' /c Ping -n ' & $iTime & ' localhost > nul & "' & @ScriptFullPath & '" /CmdLineRun', @ScriptDir, @SW_HIDE)
    Exit
EndFunc