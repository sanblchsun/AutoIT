#include <GUIConstantsEx.au3>

Global $gui = GUICreate("Vector Operations",300,100)
Global $a[3]
GUICtrlCreateLabel("I",5,7)
$a[0] = GUICtrlCreateInput("0",10,5,25)
GUICtrlCreateLabel("J",45,7)
$a[1] = GUICtrlCreateInput("0",55,5,25)
GUICtrlCreateLabel("K",85,7)
$a[2] = GUICtrlCreateInput("0",95,5,25)
Global $operation = GUICtrlCreateCombo("+",130,5,30)
GUICtrlSetData(-1,"-|*|?|x|•")
Global $b[3], $bl[3]
$bl[0] = GUICtrlCreateLabel("I",165,7)
$b[0] = GUICtrlCreateInput("0",170,5,25)
$bl[1] = GUICtrlCreateLabel("J",205,7)
$b[1] = GUICtrlCreateInput("0",215,5,25)
$bl[2] = GUICtrlCreateLabel("K",245,7)
$b[2] = GUICtrlCreateInput("0",255,5,25)

Global $equals = GUICtrlCreateButton("Equals",5,37,100)

Global $c[3]
Global $cl[3]
$cl[0] = GUICtrlCreateLabel("I",5,77)
$c[0] = GUICtrlCreateInput("",10,75,50)
$cl[1] = GUICtrlCreateLabel("J",70,77)
$c[1] = GUICtrlCreateInput("",80,75,50)
$cl[2] = GUICtrlCreateLabel("K",135,77)
$c[2] = GUICtrlCreateInput("",145,75,50)
GUISetState()

While 1
    $msg = GUIGetMsg()
    Switch $msg
        Case -3
            Exit
        Case $equals
            Process()
        Case $operation
            Change()
    EndSwitch
    Sleep(10)
WEnd

Func Change()
    If GUICtrlRead($operation) == "*" Or GUICtrlRead($operation) == "?" Then
        For $i=0 To 2
            GUICtrlSetState($b[$i],$GUI_HIDE)
            GUICtrlSetState($bl[$i],$GUI_HIDE)
            GUICtrlSetState($c[$i],$GUI_SHOW)
            GUICtrlSetState($cl[$i],$GUI_SHOW)
        Next
        GUICtrlSetState($b[0],$GUI_SHOW)
    Else
        For $i=0 To 2
            GUICtrlSetState($b[$i],$GUI_SHOW)
            GUICtrlSetState($bl[$i],$GUI_SHOW)
        Next
        If GUICtrlRead($operation) == "•" Then
            For $i=0 To 2
                GUICtrlSetState($c[$i],$GUI_HIDE)
                GUICtrlSetState($cl[$i],$GUI_HIDE)
            Next
            GUICtrlSetState($c[0],$GUI_SHOW)
        Else
            For $i=0 To 2
                GUICtrlSetState($c[$i],$GUI_SHOW)
                GUICtrlSetState($cl[$i],$GUI_SHOW)
            Next
        EndIf
    EndIf
EndFunc

Func Process()
    Switch GUICtrlRead($operation)
        Case "+"
            GUICtrlSetData($c[0],GUICtrlRead($a[0])+GUICtrlRead($b[0]))
            GUICtrlSetData($c[1],GUICtrlRead($a[1])+GUICtrlRead($b[1]))
            GUICtrlSetData($c[2],GUICtrlRead($a[2])+GUICtrlRead($b[2]))
        Case "-"
            GUICtrlSetData($c[0],GUICtrlRead($a[0])-GUICtrlRead($b[0]))
            GUICtrlSetData($c[1],GUICtrlRead($a[1])-GUICtrlRead($b[1]))
            GUICtrlSetData($c[2],GUICtrlRead($a[2])-GUICtrlRead($b[2]))
        Case "*"
            GUICtrlSetData($c[0],GUICtrlRead($a[0])*GUICtrlRead($b[0]))
            GUICtrlSetData($c[1],GUICtrlRead($a[1])*GUICtrlRead($b[0]))
            GUICtrlSetData($c[2],GUICtrlRead($a[2])*GUICtrlRead($b[0]))
        Case "?"
            GUICtrlSetData($c[0],GUICtrlRead($a[0])/GUICtrlRead($b[0]))
            GUICtrlSetData($c[1],GUICtrlRead($a[1])/GUICtrlRead($b[0]))
            GUICtrlSetData($c[2],GUICtrlRead($a[2])/GUICtrlRead($b[0]))
        Case "x"
            GUICtrlSetData($c[0],GUICtrlRead($a[1])*GUICtrlRead($b[2])-GUICtrlRead($a[2])*GUICtrlRead($b[1]))
            GUICtrlSetData($c[1],GUICtrlRead($a[2])*GUICtrlRead($b[0])-GUICtrlRead($a[0])*GUICtrlRead($b[2]))
            GUICtrlSetData($c[2],GUICtrlRead($a[0])*GUICtrlRead($b[1])-GUICtrlRead($a[1])*GUICtrlRead($b[0]))
        Case "•"
            GUICtrlSetData($c[0],GUICtrlRead($a[0])*GUICtrlRead($b[0])+GUICtrlRead($a[1])*GUICtrlRead($b[1])+GUICtrlRead($a[2])*GUICtrlRead($b[2]))
    EndSwitch
EndFunc
