HotKeySet('{ESC}', '_Quit')
Func _Quit()
    Exit
EndFunc

Global $MP1, $d=6
$MP1 = MouseGetPos()

AdlibRegister('_myFunc', 200)
While 1
    Sleep(1000)
WEnd


Func _myFunc()
    $MP2 = MouseGetPos()
    If $MP2[0]=$MP1[0] And $MP2[1]=$MP1[1] Then ; �� �����
        Return
    ElseIf $MP2[0]>$MP1[0] And $MP2[1]>$MP1[1] Then ; ����� ����
        $MP2[0]-=$d
    ElseIf $MP2[0]>$MP1[0] And $MP2[1]<$MP1[1] Then ; ���� ����
        $MP2[0]-=$d
    ElseIf $MP2[0]<$MP1[0] And $MP2[1]<$MP1[1] Then ; ���� �����
        $MP2[1]+=$d
    ElseIf $MP2[0]<$MP1[0] And $MP2[1]>$MP1[1] Then ; ����� �����
        $MP2[1]-=$d
    ElseIf $MP2[0]<$MP1[0] And $MP2[1]=$MP1[1] Then ; �����
        $MP2[1]-=$d
    ElseIf $MP2[0]>$MP1[0] And $MP2[1]=$MP1[1] Then ; ����
        $MP2[1]+=$d
    ElseIf $MP2[0]=$MP1[0] And $MP2[1]<$MP1[1] Then ; ����
        $MP2[0]-=$d
    ElseIf $MP2[0]=$MP1[0] And $MP2[1]>$MP1[1] Then ; �����
        $MP2[0]+=$d
    EndIf
        MouseMove($MP2[0], $MP2[1], 10)
        $MP1[0]=$MP2[0]
        $MP1[1]=$MP2[1]
EndFunc