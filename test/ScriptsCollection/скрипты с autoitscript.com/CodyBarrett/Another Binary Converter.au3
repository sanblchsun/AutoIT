#include <GUICONSTANTS.AU3>
#include <WINDOWSCONSTANTS.AU3>
#include <STATICCONSTANTS.AU3>
#include <EDITCONSTANTS.AU3>
#include <MISC.AU3>
Opt ('GUIoneventmode', 1)
$Status = 0
$GUI = GUICreate ('Binary Converter', 300, 400, -1, -1, -2138570616)
GUISetBkColor (0x0, $GUI)
$lTitleBar = GUICtrlCreateLabel ('Binary Converter', 20, 0, 280, 20, $SS_CENTER)
GUICtrlSetBkColor (-1, 0x2E2E2E)
GUICtrlSetFont (-1, 10, 400, '', 'Fixedsys')
GUICtrlSetColor (-1, 0xFFFFA2)
GUICtrlSetOnEvent (-1, '_Win_Move_')
$lb_Exit = GUICtrlCreateLabel ('', 0, 0, 20, 20)
GUICtrlSetBkColor (-1, 0x2E2E2E)
GUICtrlSetState (-1, $GUI_DISABLE)
$lExit = GUICtrlCreateLabel ('x', 1, 1, 18, 18, $SS_CENTER)
GUICtrlSetBkColor (-1, 0x2E2E2E)
GUICtrlSetFont (-1, 10, 400, '', 'Fixedsys')
GUICtrlSetColor (-1, 0xFFFFA2)
GUICtrlSetOnEvent (-1, '_Exit_')
$lb_ToBinary = GUICtrlCreateLabel ('', 19, 39,262,22)
GUICtrlSetState (-1, $GUI_DISABLE)
$lToBinary = GUICtrlCreateLabel ('Convert To Binary', 20, 40, 260, 20, $SS_CENTER)
GUICtrlSetBkColor (-1, 0x2E2E2E)
GUICtrlSetFont (-1, 10, 400, '', 'Fixedsys')
GUICtrlSetColor (-1, 0xFFFFA2)
GUICtrlSetOnEvent (-1, '_Convert_To_')
$lb_FromBinary = GUICtrlCreateLabel ('', 19, 69,262,22)
GUICtrlSetState (-1, $GUI_DISABLE)
$lFromBinary = GUICtrlCreateLabel ('Convert From Binary', 20, 70, 260, 20, $SS_CENTER)
GUICtrlSetBkColor (-1, 0x2E2E2E)
GUICtrlSetFont (-1, 10, 400, '', 'Fixedsys')
GUICtrlSetColor (-1, 0xFFFFA2)
GUICtrlSetOnEvent (-1, '_Convert_From_')
$iInput = GUICtrlCreateEdit ('', 20, 100, 260, 280, 2101248)
GUICtrlSetBkColor (-1, 0x2E2E2E)
GUICtrlSetFont (-1, '', 400, '', 'Fixedsys')
GUICtrlSetColor (-1, 0xFFFFA2)
GUISetOnEvent ($GUI_EVENT_CLOSE, '_Exit_', $GUI)
GUISetState ()
While 1
    $Ggci = GUIGetCursorInfo ($GUI)
    If $Ggci[4] = $lExit Then
        GUICtrlSetBkColor ($lb_Exit, 0xFFFFA2)
        GUICtrlSetBkColor ($lb_ToBinary, 0x2E2E2E)
        GUICtrlSetBkColor ($lb_FromBinary, 0x2E2E2E)
    ElseIf $Ggci[4] = $lToBinary Then
        GUICtrlSetBkColor ($lb_ToBinary, 0xFFFFA2)
        GUICtrlSetBkColor ($lb_FromBinary, 0x2E2E2E)
        GUICtrlSetBkColor ($lb_Exit, 0x2E2E2E)
    ElseIf $Ggci[4] = $lFromBinary Then
        GUICtrlSetBkColor ($lb_ToBinary, 0x2E2E2E)
        GUICtrlSetBkColor ($lb_FromBinary, 0xFFFFA2)
        GUICtrlSetBkColor ($lb_Exit, 0x2E2E2E)
    Else
        GUICtrlSetBkColor ($lb_ToBinary, 0x2E2E2E)
        GUICtrlSetBkColor ($lb_FromBinary, 0x2E2E2E)
        GUICtrlSetBkColor ($lb_Exit, 0x2E2E2E)
    EndIf
    Sleep (100)
WEnd
Func _Convert_To_ ()
    If $Status = 1 Then Return
    $s = StringSplit (GUICtrlRead ($iInput), '')
    GUICtrlSetData ($iInput, '')
    For $i = 1 To UBound ($s) - 1
        $Asc = Asc($s[$i]) 
        $oBin = ''
        For $iii=7 To 0 Step -1
            If $Asc >= 2 ^$iii Then
                $Asc -= 2  ^$iii
                $oBin &= 1
            Else
                $oBin &= 0
            EndIf
        Next
        GUICtrlSetData ($iInput , GUICtrlRead ($iInput) & ' ' & $oBin)
    Next
    GUICtrlSetData ($iInput, StringTrimLeft (GUICtrlRead ($iInput), 1))
    $s = ''
    $Asc = ''
    $i = ''
    $iii = ''
    $oBin = ''
    $Status = 1
EndFunc

Func _Convert_From_ ()
    If $Status = 0 Then Return
    $Asc = ''
    $s = GUICtrlRead ($iInput)
    GUICtrlSetData ($iInput, '')
    $s = StringSplit ($s, ' ')
    For $i = 1  To UBound ($s) - 1
        $Asc = 0 
        For $iii = 0 To 7
            If StringMid ($s[$i], 8 - $iii, 1) = 1 Then $Asc += 2 ^ $iii 
        Next
        $l = Chr ($Asc) 
        GUICtrlSetData ($iInput,GUICtrlRead ($iInput) & $l)
        $l = ''
    Next
    $l = ''
    $Asc = ''
    $Status = 0
EndFunc

Func _Win_Move_ ()
    $MouseXY = MouseGetPos ()
    $WinXY = WinGetPos ($GUI)
    $xOff = $MouseXY[0] - $WinXY[0]
    $yOFF = $MouseXY[1] - $WinXY[1]
    While _IsPressed ('01')
        WinMove ($GUI, '',MouseGetPos (0) - $xOff ,MouseGetPos (1) - $yOFF)
        Sleep (10)
    WEnd
EndFunc

Func _Exit_ ()
    Exit
EndFunc
