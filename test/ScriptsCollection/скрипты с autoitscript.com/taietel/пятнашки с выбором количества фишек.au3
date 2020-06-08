#include <EditConstants.au3>
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Array.au3>
;coded by taietel

Opt("GUIOnEventMode", 1)
Global $Columns = 4, $hCols
Global $Rows = 4, $hRows
Global $iW = 360
Global $iH = 360
Global $w = Int(($iW - 10) / $Columns)
Global $h = Int(($iH - 55) / $Rows)
Global $iMoves = 0
Global $aShuff[$Rows * $Columns]
Global $aImages[$Rows][$Columns][1]
Global $hBtns[4], $aMenu[12], $hGUI, $hSbr
Global $bShuf = False

_GUI_Interface()

While 1
    Sleep(100)
WEnd

Func _ShuffleTiles()
    Local $aShuff = _Shuffle($Rows, $Columns)
    For $i = 0 To $Rows - 1
        For $j = 0 To $Columns - 1;
            If $i <> 0 Or $j <> 0 Then
                GUICtrlSetData($aImages[$i][$j][0], $aShuff[$j + $i * $Columns])
            EndIf
        Next
    Next
    $bShuf = True
EndFunc   ;==>_ShuffleTiles

Func _ChangeGrid()
    For $i = 0 To $Rows - 1
        For $j = 0 To $Columns - 1
            GUICtrlDelete($aImages[$i][$j][0])
        Next
    Next
    $Rows = GUICtrlRead($hRows)
    $Columns = GUICtrlRead($hCols)
    Select
        Case $Rows < 3 Or $Columns < 3
            $Rows = 3
            $Columns = 3
        Case $Rows > 10 Or $Columns > 10
            $Rows = 10
            $Columns = 10
    EndSelect
    $iMoves = 0
    ReDim $aImages[$Rows][$Columns][1]
    $w = Int(($iW - 10) / $Columns)
    $h = Int(($iH - 55) / $Rows)
    For $i = 0 To $Rows - 1
        For $j = 0 To $Columns - 1
            $aImages[$i][$j][0] = GUICtrlCreateButton("", 5 + $j * $w, 28 + $i * $h, $w, $h, $BS_BITMAP)
            GUICtrlSetState(-1, $GUI_FOCUS)
            If $i <> 0 Or $j <> 0 Then
                GUICtrlSetData($aImages[$i][$j][0], $j + $i * $Columns)
                GUICtrlSetCursor(-1, 0)
            Else
                GUICtrlSetData($aImages[$i][$j][0], "X")
                GUICtrlSetColor(-1, 0x990000)
            EndIf
            GUICtrlSetOnEvent(-1, "_ImageClick")
            Local $pb = ControlGetPos($hGUI, "", $aImages[$i][$j][0])
            GUICtrlSetFont(-1, Int($pb[3] / 2.5), 800, 0, "Arial", 4)
        Next
    Next
EndFunc   ;==>_ChangeGrid

Func _ImageClick()
    $iMoves += 1
    Switch @GUI_CtrlId
        Case $aImages[0][0][0] To $aImages[$Rows - 1][$Columns - 1][0]
            _Status("Moves so far: " & $iMoves)
            Local $p1 = ControlGetPos($hGUI, "", @GUI_CtrlId)
            Local $p0 = ControlGetPos($hGUI, "", $aImages[0][0][0])
            If (Abs($p1[0] - $p0[0]) = $w And $p1[1] = $p0[1]) Or ($p1[0] = $p0[0] And Abs($p1[1] - $p0[1]) = $h) Then
                ControlMove($hGUI, "", $aImages[0][0][0], $p1[0], $p1[1])
                ControlMove($hGUI, "", @GUI_CtrlId, $p0[0], $p0[1])
                ;Return
            EndIf
    EndSwitch
    Local $t1, $t2
    For $i = 0 To $Rows - 1
        For $j = 0 To $Columns - 1
            $t1 &= GUICtrlRead($aImages[$i][$j][0]) & "|"
            $t2 &= $j + $i * $Columns & "|"
        Next
    Next
    If StringTrimLeft($t1, 2) = StringTrimLeft($t2, 2) And $bShuf = True Then
        MsgBox(64, "CONGRATULATIONS!", "Darn, you're good!")
    Else
        If $iMoves = 500 Then MsgBox(32, "AutoIT Game", "That's the spirit!" & @CRLF & "A few more clicks and you need to get a new mouse!...")
    EndIf
EndFunc   ;==>_ImageClick

Func _GUI_Interface()
    $hGUI = GUICreate("AutoIT Puzle Game", $iW, $iH, -1, -1, BitOR($WS_POPUP, $WS_THICKFRAME))
    GUISetBkColor(0x506550)
    GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
    GUICtrlCreateLabel(StringUpper("yet another autoit game"), 8, 6, $iW - 199, 16, BitOR($SS_CENTER, $SS_CENTERIMAGE), $GUI_WS_EX_PARENTDRAG)
    GUICtrlSetFont(-1, 8, 800, 0)
    GUICtrlSetColor(-1, 0xFEFECC)
    GUICtrlSetBkColor(-1, 0x304330)
    GUICtrlCreateLabel("Grid:", $iW - 186, 6, 24, 16, $SS_CENTERIMAGE, $GUI_WS_EX_PARENTDRAG)
    GUICtrlSetFont(-1, 8, 800, 0)
    GUICtrlSetColor(-1, 0xFEFECC)
    $hRows = GUICtrlCreateInput("4", $iW - 160, 5, 25, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $WS_BORDER), 0)
    GUICtrlSetTip(-1, "Enter number of rows", "Info:", 1)
    GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
    GUICtrlSetColor(-1, 0x880000)
    GUICtrlSetBkColor(-1, 0xdddd33)
    GUICtrlCreateLabel("x", $iW - 133, 5, 16, 16, $SS_CENTERIMAGE, $GUI_WS_EX_PARENTDRAG)
    GUICtrlSetFont(-1, 8, 800, 0)
    GUICtrlSetColor(-1, 0xFEFECC)
    $hCols = GUICtrlCreateInput("4", $iW - 125, 5, 25, 17, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $WS_BORDER), 0)
    GUICtrlSetTip(-1, "Enter number of columns", "Info:", 1)
    GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
    GUICtrlSetColor(-1, 0x880000)
    GUICtrlSetBkColor(-1, 0xdddd33)
    $hBtns[0] = GUICtrlCreateIcon("shell32.dll", -28, $iW - 22, 6, 16, 16)
    GUICtrlSetCursor(-1, 0)
    GUICtrlSetTip(-1, "I had enough!...", "Info:", 1)
    GUICtrlSetOnEvent(-1, "_Exit")
    $hBtns[1] = GUICtrlCreateIcon("shell32.dll", -222, $iW - 42, 6, 16, 16)
    GUICtrlSetCursor(-1, 0)
    GUICtrlSetTip(-1, "About...", "Info:", 1)
    GUICtrlSetOnEvent(-1, "_About")
    $hBtns[2] = GUICtrlCreateIcon("shell32.dll", -44, $iW - 98, 5, 16, 16)
    GUICtrlSetCursor(-1, 0)
    GUICtrlSetTip(-1, "Change the grid!", "Info:", 1)
    GUICtrlSetOnEvent(-1, "_ChangeGrid")
    GUICtrlSetState(-1, $GUI_FOCUS)
    $hBtns[3] = GUICtrlCreateIcon("shell32.dll", -147, $iW - 82, 6, 16, 16)
    GUICtrlSetCursor(-1, 0)
    GUICtrlSetTip(-1, "Shuffle the tiles", "Info:", 1)
    GUICtrlSetOnEvent(-1, "_ShuffleTiles")
    For $i = 0 To $Rows - 1
        For $j = 0 To $Columns - 1
            $aImages[$i][$j][0] = GUICtrlCreateButton("", 5 + $j * $w, 28 + $i * $h, $w, $h, $BS_BITMAP)
            If $i <> 0 Or $j <> 0 Then
                GUICtrlSetData($aImages[$i][$j][0], $j + $i * $Columns)
                GUICtrlSetCursor(-1, 0)
            Else
                GUICtrlSetData($aImages[$i][$j][0], "X")
                GUICtrlSetColor(-1, 0x990000)
            EndIf
            GUICtrlSetOnEvent(-1, "_ImageClick")
            Local $pb = ControlGetPos($hGUI, "", $aImages[$i][$j][0])
            GUICtrlSetFont(-1, Int($pb[3] / 2.5), 800, 0, "Arial", 4)
        Next
    Next
    $hSbr = GUICtrlCreateLabel("", 5, $iH - 24, $iW - 10, 20, $SS_CENTERIMAGE, $WS_EX_STATICEDGE)
    GUICtrlSetColor(-1, 0xefefef)
    GUISetState(@SW_SHOW)
EndFunc   ;==>_GUI_Interface

Func _Shuffle($iRows, $iColumns)
    Local $grid = $iRows * $iColumns
    Local $n = "", $aNumbers[$grid]
    For $i = 0 To $grid - 1
        $n &= $i & "|"
    Next
    $n = StringSplit(StringTrimRight($n, 1), "|", 2)
    Local $aTmp[$grid]
    Do
        $m = Random(1, $grid - 1, 1)
        $p = Random(1, $grid - 1, 1)
        If $n[$m] <> "" And $aNumbers[$p] = "" Then
            $aNumbers[$p] = $n[$m]
            $n[$m] = ""
            $aTmp = _ArrayUnique($aNumbers)
        EndIf
    Until UBound($aTmp) > $grid
    For $i = 0 To $grid - 1
        If $aNumbers[$i] = "" Then
            For $j = 0 To $grid - 1
                If $n[$j] <> "" Then $aNumbers[$i] = $n[$j]
            Next
        EndIf
    Next
    Return $aNumbers
EndFunc   ;==>_Shuffle

Func _Status($sText)
    GUICtrlSetData($hSbr, "  " & $sText)
EndFunc   ;==>_Status

Func _About()
    Local $sRet = DllCall("shell32.dll", "long", "ShellAboutA", "ptr", $hGUI, "str", "AutoIt Game - coded by taietel", "str", "Mihai Iancu © 1973-2011", "long", 0)
    If @error Then SetError(1, 0, 0)
    Return $sRet
EndFunc   ;==>_About

Func _Exit()
    Exit
EndFunc   ;==>_Exit