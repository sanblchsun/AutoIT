$name=StringSplit('1|2|3|4|5|6|7|8|9|10', '|')
Global $check[$name[0]+1]
GUICreate("чекбоксы",150,270)
For $i = 1 to $name[0]
    $check[$i]=GUICtrlCreateCheckbox ($name[$i], 20,20*$i+30,100,20)
Next
$check_all=GUICtrlCreateCheckbox ("вкл/выкл все", 20,10,100,20)
GUISetState ()

While 1
    $msg = GUIGetMsg()
    Switch $msg
        Case $check_all
            $tr=1
            For $i = 1 to $name[0]
                If GUICtrlRead($check[$i])=1 Then
                    $tr=4
                    ExitLoop
                EndIf
            Next
            For $i = 1 To $name[0]
                GuiCtrlSetState($check[$i], $tr)
            Next
            GuiCtrlSetState($check_all, $tr)
        Case -3
            Exit
    EndSwitch
WEnd