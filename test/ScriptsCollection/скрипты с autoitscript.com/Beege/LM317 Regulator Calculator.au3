#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListBox.au3>
#include <ProgressConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <array.au3>
#include <file.au3>
#include <GuiListView.au3>
#include <GuiStatusBar.au3>
#include <GuiEdit.au3>

$Gui = GUICreate("LM317 Regulator Calculator", 530, 453)
$I_V_R1 = GUICtrlCreateInput("", 42, 48, 63, 21)
$I_V_R2 = GUICtrlCreateInput("", 120, 48, 63, 21)
$Label1 = GUICtrlCreateLabel("R1", 66, 30, 18, 17)
$Label2 = GUICtrlCreateLabel("R2", 144, 30, 18, 17)
$B_Vcalc = GUICtrlCreateButton("Calculate", 72, 78, 85, 25, 0)
$Pic1 = GUICtrlCreatePic(@ScriptDir & '\voltage pic.jpg', 240, 18, 265, 205, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
$Group1 = GUICtrlCreateGroup("Calculate V-out", 12, 6, 205, 103, $BS_CENTER)
GUICtrlSetFont(-1, 12, 800, 0, "MS Sans Serif")
GUICtrlCreateGroup("", -99, -99, 1, 1)
Global $List1 = GUICtrlCreateListView("R1|R2|Voltage|Tolerance", 180, 264, 331, 124)
_GUICtrlListView_SetColumnWidth ($List1, 0, 110)
_GUICtrlListView_SetColumnWidth ($List1, 1, 80)
_GUICtrlListView_SetColumnWidth ($List1, 2, 69)
_GUICtrlListView_SetColumnWidth ($List1, 3, 68)
Global $Progress1 = GUICtrlCreateProgress(180, 390, 331, 13, $PBS_SMOOTH)
$Group2 = GUICtrlCreateGroup("Calculate R2", 12, 126, 205, 103, $BS_CENTER)
GUICtrlSetFont(-1, 12, 800, 0, "MS Sans Serif")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$I_R2_R1 = GUICtrlCreateInput("", 42, 168, 63, 21)
$I_R2_V = GUICtrlCreateInput("", 120, 168, 63, 21)
$Label3 = GUICtrlCreateLabel("R1", 66, 150, 18, 17)
$Label4 = GUICtrlCreateLabel("V-out", 144, 150, 29, 17)
$B_R2calc = GUICtrlCreateButton("Calculate", 72, 198, 85, 25, 0)
$I_TargetV = GUICtrlCreateInput("", 24, 294, 63, 21)
$Label5 = GUICtrlCreateLabel("Target Vout", 26, 270, 60, 17)
$I_Tolerance = GUICtrlCreateInput("1.00", 102, 294, 63, 21)
$Label6 = GUICtrlCreateLabel("Tolerance %", 104, 270, 60, 17)
$Checkbox1 = GUICtrlCreateCheckbox("Advanced Search", 48, 330, 103, 19)
$Group3 = GUICtrlCreateGroup("Calculate R1 and R2 ", 12, 234, 511, 175, $BS_CENTER)
GUICtrlSetFont(-1, 12, 800, 0, "MS Sans Serif")
$B_TargetV = GUICtrlCreateButton("Calculate", 55, 363, 85, 25, 0)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$MenuItem1 = GUICtrlCreateMenu("&File")
$MenuItem6 = GUICtrlCreateMenu("&Help")
$MenuItem7 = GUICtrlCreateMenuitem("How to Use", $MenuItem6)
$MenuItem8 = GUICtrlCreateMenuitem("About", $MenuItem6)
$MenuItem2 = GUICtrlCreateMenuitem("Import Custom Resistor List", $MenuItem1)
$MenuItem3 = GUICtrlCreateMenuitem("Load Default Values", $MenuItem1)
$MenuItem5 = GUICtrlCreateMenuitem("View Loaded Resistor Values", $MenuItem1)
$MenuItem9 = GUICtrlCreateMenuitem("Current Regulator Calculator", $MenuItem1)
$MenuItem4 = GUICtrlCreateMenuitem("Exit", $MenuItem1)
Global $StatusBar1 = _GUICtrlStatusBar_Create ($Gui)
_GUICtrlStatusBar_SetMinHeight ($StatusBar1, 19)
GUISetState(@SW_SHOW)
Global $D_Resistors, $R1_Resistors, $ExtraR1s_Check = 0, $loadedvalues = 'Default Values'
_Load_Default_Values($D_Resistors)
_GUICtrlListView_RegisterSortCallBack ($List1)


While 1
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case $MenuItem7
            _Howtouse()
        Case $MenuItem9
            GUISetState(@SW_HIDE, $Gui)
            _Calc_Current()
            GUISetState(@SW_SHOW, $Gui)
        Case $List1
            _GUICtrlListView_SortItems ($List1, GUICtrlGetState($List1))
        Case $MenuItem3
            _Load_Default_Values($D_Resistors)
            $loadedvalues = 'Default Values'
            MsgBox(0, $loadedvalues & ' Imported!', UBound($D_Resistors) & ' Values have been Loaded')
            $ExtraR1s_Check = 0
        Case $MenuItem8
            MsgBox(0, 'About', 'LM317 Regulator Calculator' & @LF & @LF & 'Version 1.0' & @LF & @LF & 'Writen by Brian J Christy')
        Case $GUI_EVENT_CLOSE
            Exit
        Case $MenuItem4
            Exit
        Case $B_Vcalc
            $vR1 = GUICtrlRead($I_V_R1)
            $vR2 = GUICtrlRead($I_V_R2)
            _Format_View2Value($vR1)
            _Format_View2Value($vR2)
            $CalcV = _Calc_Voltage($vR1 & ',' & $vR2)
            MsgBox(0, 'Voltage', 'Vout = ' & $CalcV)
        Case $B_R2calc
            $rR1 = GUICtrlRead($I_R2_R1)
            _Format_View2Value($rR1)
            $R2 = _Calc_R2(GUICtrlRead($I_R2_V), $rR1)
            MsgBox(0, 'Resistor 2', 'R2 Value = ' & $R2)
        Case $B_TargetV
            Global $timeS = TimerInit()
            GUICtrlSetData($Progress1, 0)
            _GUICtrlListView_DeleteAllItems ($List1)
            _GUICtrlStatusBar_Destroy ($StatusBar1)
            $R1_Resistors = _V_R1_List($D_Resistors)
            Select
                Case GUICtrlRead($Checkbox1) = $GUI_CHECKED
                    If $ExtraR1s_Check = 0 Then
                        $R1_Resistors_Ext = $R1_Resistors
                        $StatusBar1 = _GUICtrlStatusBar_Create ($Gui)
                        _GUICtrlStatusBar_SetMinHeight ($StatusBar1, 19)
                        _GUICtrlStatusBar_SetText ($StatusBar1, '  Generating Extended R1 Values....')
                        _Find_R1_Extras1($D_Resistors, $R1_Resistors_Ext)
                        _GUICtrlStatusBar_Destroy ($StatusBar1)
                        $ExtraR1s_Check = 1
                    EndIf
                    $StatusBar1 = _GUICtrlStatusBar_Create ($Gui)
                    _GUICtrlStatusBar_SetMinHeight ($StatusBar1, 19)
                    _GUICtrlStatusBar_SetText ($StatusBar1, '  Performing Search....')
                    $values = _Find_Voltages_Extended($R1_Resistors_Ext, $D_Resistors, GUICtrlRead($I_TargetV), GUICtrlRead($I_Tolerance))
                    _GUICtrlStatusBar_Destroy ($StatusBar1)
                Case GUICtrlRead($Checkbox1) = $GUI_UNCHECKED
                    $StatusBar1 = _GUICtrlStatusBar_Create ($Gui)
                    _GUICtrlStatusBar_SetMinHeight ($StatusBar1, 19)
                    _GUICtrlStatusBar_SetText ($StatusBar1, '  Performing Search....')
                    $values = _Find_Voltages($R1_Resistors, $D_Resistors, GUICtrlRead($I_TargetV), GUICtrlRead($I_Tolerance))
            EndSelect
            Global $B_DESCENDING[_GUICtrlListView_GetColumnCount ($List1) ]
            _GUICtrlListView_SimpleSort ($List1, $B_DESCENDING, 3)
            _GUICtrlStatusBar_Destroy ($StatusBar1)
            $StatusBar1 = _GUICtrlStatusBar_Create ($Gui)
            _GUICtrlStatusBar_SetMinHeight ($StatusBar1, 19)
            _GUICtrlStatusBar_SetText ($StatusBar1, '  Finished!      Search took ' & Round((TimerDiff($timeS) / 1000), 2) & ' Seconds.        Combinations Found = ' & _GUICtrlListView_GetItemCount ($List1))
        Case $MenuItem5
            Dim $Atemp = $D_Resistors
            For $i = 0 To UBound($Atemp) - 1
                _Format_Value2View($Atemp[$i])
            Next
            _ArrayDisplay($Atemp, $loadedvalues)
        Case $MenuItem2
            Dim $R_Values_Temp
            _Import_Custom_Values($R_Values_Temp)
            If IsArray($R_Values_Temp) = 1 Then
                $D_Resistors = $R_Values_Temp
                $ExtraR1s_Check = 0
                $loadedvalues = 'Custom Values'
                MsgBox(0, 'Custom Values Imported!', UBound($D_Resistors) & ' Values have been Loaded')
            Else
                ContinueLoop
            EndIf
    EndSwitch
WEnd

Func _Howtouse()
    Local $hEdit, $hGUI, $HnMsg
    $hGUI = GUICreate("How to Use", 400, 270)
    $hEdit = GUICtrlCreateEdit("", 2, 2, 394, 260, BitOR($ES_WANTRETURN, $WS_VSCROLL))
    _GUICtrlEdit_SetMargins($hEdit, BitOR($EC_LEFTMARGIN, $EC_RIGHTMARGIN), 10, 10)
    _GUICtrlEdit_SetText($hEdit, '-General-' & @CRLF & 'All resistors imported or entered into any inputbox can be abbriviated with ' & _
    'a K for thousand or M for million. The Default Resistor Values include all values found in the RadioShack Assortment Pack. ' & _
    'Imported custom resistor lists must a .txt file and can only have one value per line.'& _
    @CRLF & @CRLF &'-R1 and R2 Calculator- '& @CRLF & 'This section of the Calculator will search the current loaded resistor list for ' & _
    'R1 and R2 combinations that equal the target voltage ouput that you select for the regulator. R1 will always be returned ' & _
    'in the range of 100 to 1000 ohms. When using the advanced search option R1 will be returned in the following format. ' & _
    '--> $R1 = (R,R). $R1 is equal to the two Resistors in parenthesis connected in parallel.' & @CRLf & @CRLf & _
    '-Current Calculator-' & @CRLf & 'Target Values are enter in as Amps. So if you want 10mA you must enter .010' )
    _GUICtrlEdit_SetReadOnly($hEdit, True)
    GUISetState(@SW_SHOW)
        While 1
        $HnMsg = GUIGetMsg()
        Switch $HnMsg
            Case $GUI_EVENT_CLOSE
                GUIDelete($hGUI)
                ExitLoop
        EndSwitch
    WEnd
    Return
EndFunc
    
Func _Calc_R2($Vout, $R1)
    Local $R2
    $R2 = ((($Vout / 1.25) - 1) * $R1)
    Return $R2
EndFunc   ;==>_Calc_R2

Func _Find_R1_Extras1($dResistors, ByRef $r1s)
    Local $done, $string, $combo[1], $iSet2[1], $iset = 2
    Local $rEx[1][2], $i = 0, $a, $pValue, $string, $max, $b = 0, $count = 0
    Do
        If $dResistors[$i] > 1000 Then ExitLoop
        If $dResistors[$i] < 100 Then
            _ArrayDelete($dResistors, $i)
            $i -= 1
        EndIf
        $i += 1
    Until $i = UBound($dResistors)
    For $i = 0 To $iset - 1
        _ArrayAdd($iSet2, '0')
    Next
    _ArrayDelete($iSet2, 0)
    Do
        $string = ''
        For $i = 0 To UBound($iSet2) - 1
            $string &= $dResistors[$iSet2[$i]] & ','
        Next
        $string = StringTrimRight($string, 1)
        $pValue = _Parallel_Value($string)
        If BitAND($pValue < 1000, $pValue > 100) Then
            $max = UBound($rEx)
            ReDim $rEx[$max + 1][2]
            $rEx[$b][0] = $pValue
            $rEx[$b][1] = $string
            $b += 1
        EndIf
        $count += 1
        _Shift($dResistors, $iSet2, $done)
    Until $done = 1
    _ArrayDelete($rEx, UBound($rEx))
    For $i = 0 To UBound($r1s) - 1
        $max = UBound($rEx)
        ReDim $rEx[$max + 1][2]
        $rEx[$max][0] = $r1s[$i]
        $rEx[$max][1] = ';' & $r1s[$i]
    Next
    $r1s = $rEx
    Return $r1s
EndFunc   ;==>_Find_R1_Extras1

Func _Shift(ByRef $array, ByRef $iset, ByRef $done)
    Local $l
    If $iset[0] = UBound($array) - 1 Then
        $done = 1
        Return
    EndIf
    $x = UBound($iset) - 1
    While $x <> 0
        If $iset[$x] <> UBound($array) - 1 Then
            $iset[$x] += 1
            Return
        EndIf
        $x -= 1
        If $iset[$x] <> UBound($array) - 1 Then
            $iset[$x] += 1
            $l = $x
            Do
                $iset[$l + 1] = $iset[$x]
                $l += 1
            Until $l = UBound($iset) - 1
            Return
        EndIf
    WEnd
EndFunc   ;==>_Shift

Func _Tolerance($value, $Target)
    Local $vTolerance
    Select
        Case $value > $Target
            $vTolerance = Round((($value - $Target) / $Target) * 100, 4)
        Case $value < $Target
            $vTolerance = Round((($Target - $value) / $Target) * 100, 4)
        Case $value = $Target
            $vTolerance = 0
    EndSelect
    Return $vTolerance
EndFunc   ;==>_Tolerance

Func _Find_Voltages($r1s, $Rs, $t_Voltage, $Tolerance)
    Local $array[1], $i, $a, $string, $voltage, $high, $low, $count = 0, $ProgressT = (UBound($Rs) * UBound($r1s))
    Local $tR1, $tR2, $pTolerance, $timertrack
    $high = $t_Voltage+ ($t_Voltage* ($Tolerance / 100))
    $low = $t_Voltage- ($t_Voltage* ($Tolerance / 100))
    For $i = 0 To UBound($r1s) - 1
        
        For $a = 0 To UBound($Rs) - 1
            $string = $r1s[$i] & ',' & $Rs[$a]
            $voltage = _Calc_Voltage($string)
            If BitAND(($voltage <= $high) , ($voltage >= $low)) Then
                $pTolerance = _Tolerance($voltage, $t_Voltage)
                $tR1 = $r1s[$i]
                $tR2 = $Rs[$a]
                _Format_Value2View($tR2)
                _Format_Value2View($tR1)
                GUICtrlCreateListViewItem($tR1 & '|' & $tR2 & '|' & $voltage & '|' & $pTolerance & '%', $List1)
            EndIf
            $count += 1
            If $timeS >= $timertrack Then
                GUICtrlSetData($Progress1, ($count / $ProgressT) * 100)
                $timertrack += 50
            EndIf
        Next
    Next
    Return $array
EndFunc   ;==>_Find_Voltages

Func _Find_Voltages_Extended($r1s, $Rs, $t_Voltage, $Tolerance)
    Local $array[1], $i, $a, $string, $voltage, $high, $low, $count = 0, $ProgressT = (UBound($Rs) * UBound($r1s))
    Local $tR1, $tR2, $left, $pTolerance, $ptimertrack = 0, $ltimertrack = 0
    $high = $t_Voltage+ ($t_Voltage* ($Tolerance / 100))
    $low = $t_Voltage- ($t_Voltage* ($Tolerance / 100))
    For $i = 0 To UBound($r1s) - 1
        For $a = 0 To UBound($Rs) - 1
            $string = $r1s[$i][0] & ',' & $Rs[$a]
            $voltage = _Calc_Voltage($string)
            If BitAND(($voltage <= $high) , ($voltage >= $low)) Then
                $pTolerance = _Tolerance($voltage, $t_Voltage)
                $left = StringLeft($r1s[$i][1], 1)
                $tR2 = $Rs[$a]
                _Format_Value2View($tR2)
                If $left = ';' Then
                    GUICtrlCreateListViewItem($r1s[$i][0] & '|' & $tR2 & '|' & $voltage & '|' & $pTolerance & '%', $List1)
                Else
                    $tR1 = $r1s[$i][1]
                    $tR1 = _Stringformat($tR1, 0)
                    GUICtrlCreateListViewItem($r1s[$i][0] & ' = (' & $tR1 & ')' & '|' & $tR2 & '|' & $voltage & '|' & $pTolerance & '%', $List1)
                EndIf
            EndIf
            $count += 1
            If $timeS >= $ptimertrack Then
                GUICtrlSetData($Progress1, ($count / $ProgressT) * 100)
                $ptimertrack += 100
            EndIf
        Next
    Next
    Return
EndFunc   ;==>_Find_Voltages_Extended

Func _Stringformat($string, $type)
    Local $Atemp, $newString
    $string = StringReplace($string, ' ', '')
    $Atemp = StringSplit($string, ',')
    If $type = 0 Then
        For $i = 1 To $Atemp[0]
            _Format_Value2View($Atemp[$i])
            $newString &= $Atemp[$i] & ','
        Next
        $newString = StringTrimRight($newString, 1)
        Return $newString
    EndIf
    If $type = 1 Then
        For $i = 1 To $Atemp[0]
            _Format_View2Value($Atemp[$i])
            $newString &= $Atemp[$i] & ','
        Next
        $newString = StringTrimRight($newString, 1)
        Return $newString
    EndIf
EndFunc   ;==>_Stringformat

Func _Calc_Current()
    Local $Resistor, $T_Current, $wattage, $Form1c, $Pic1c, $Label1c, $Label2c, $Input1c, $Button1c, $Label3c, $Label4c, $Label5c
    $Form1c = GUICreate("Current Regulator", 251, 239, 431, 321)
    $Pic1c = GUICtrlCreatePic(@ScriptDir & '\current pic.jpg', 18, 12, 211, 97, BitOR($SS_NOTIFY, $WS_GROUP, $WS_CLIPSIBLINGS))
    $Label1c = GUICtrlCreateLabel("", 12, 180, 225, 17)
    $Label2c = GUICtrlCreateLabel("", 12, 204, 226, 17)
    $Input1c = GUICtrlCreateInput("", 30, 144, 73, 21)
    $Button1c = GUICtrlCreateButton("Calculate", 126, 138, 91, 25, 0)
    $Label3c = GUICtrlCreateLabel("Target Current", 30, 127, 72, 17)
    GUISetState(@SW_SHOW)
    While 1
        $nMsg = GUIGetMsg()
        Switch $nMsg
            Case $GUI_EVENT_CLOSE
                GUIDelete($Form1c)
                ExitLoop
            Case $Button1c
                $T_Current = GUICtrlRead($Input1c)
                $Resistor = Round((1.25 / $T_Current), 3)
                $wattage = Round(($T_Current ^ 2) * $Resistor, 2)
                GUICtrlSetData($Label1c, "Resistor Value = " & $Resistor & ' ohms')
                GUICtrlSetData($Label2c, "Resistor Power Rating >= " & $wattage & ' Watts')
        EndSwitch
    WEnd
    Return
EndFunc   ;==>_Calc_Current

Func _V_R1_List($R_Array)
    Local $array[1], $i
    For $i = 0 To UBound($R_Array) - 1
        If $R_Array[$i] >= 100 Then
            _ArrayAdd($array, $R_Array[$i])
        EndIf
        If $R_Array[$i] > 1000 Then
            _ArrayDelete($array, $i)
            _ArrayDelete($array, 0)
            Return $array
        EndIf
    Next
    
EndFunc   ;==>_V_R1_List

Func _Calc_Voltage($Resistors)
    Local $voltage, $array
    $Resistors = StringReplace($Resistors, ' ', '')
    $array = StringSplit($Resistors, ',')
    $voltage = 1.25* (1+ (Number($array[2]) / Number($array[1])))
    Return Round($voltage, 3)
EndFunc   ;==>_Calc_Voltage

Func _Format_View2Value(ByRef $value)
    If StringInStr($value, 'k') <> 0 Then
        $value = StringReplace($value, 'k', '')
        $value *= 1000
    EndIf
    If StringInStr($value, 'm') <> 0 Then
        $value = StringReplace($value, 'm', '')
        $value *= 1000000
    EndIf
    Return $value
EndFunc   ;==>_Format_View2Value

Func _Format_Value2View(ByRef $value)
    Local $count
    $count = StringLen($value)
    Select
        Case $count > 6
            $value = (Number($value) / 1000000) & 'M'
            Return
        Case $count > 3
            If StringInStr($value, '.') <> 0 Then Return
            $value = (Number($value) / 1000) & 'K'
            Return
    EndSelect
EndFunc   ;==>_Format_Value2View

Func _Load_Default_Values(ByRef $RadioShack)
    Local $T_RadioShack[65] = [1, 2.2, 10, 15, 22, 33, 39, 47, 51, 68, 82, 100, 120, 150, 180, 220, 270, 300, 330, _
            390, 470, 510, 560, 680, 820, 1000, 1200, 1500, 1800, 2200, 2700, 3000, 3300, 3900, 4700, 5100, 5600, _
            6800, 8200, 10000, 12000, 15000, 18000, 22000, 27000, 33000, 39000, 47000, 51000, 56000, 68000, 82000, _
            100000, 120000, 150000, 180000, 220000, 270000, 330000, 1000000, 1500000, 2200000, 3300000, 4700000, 10000000]
    $RadioShack = $T_RadioShack
EndFunc   ;==>_Load_Default_Values

Func _Import_Custom_Values(ByRef $Custom)
    Local $R_V_Check, $file
    $file = FileOpenDialog("Select File to Import", @ScriptDir & "\", "Text files (*.txt)", 1)
    If $file = '' Then Return
    _FileReadToArray($file, $R_V_Check)
    _ArrayDelete($R_V_Check, 0)
    _ArrayDeleteBlanks($R_V_Check)
    For $i = 0 To UBound($R_V_Check) - 1
        $R_V_Check[$i] = Number(_Format_View2Value($R_V_Check[$i]))
    Next
    _ArraySort($R_V_Check, 0)
    $Custom = $R_V_Check
EndFunc   ;==>_Import_Custom_Values

Func _ArrayDeleteBlanks(ByRef $array)
    $i = 0
    Do
        If $array[$i] = '' Then
            _ArrayDelete($array, $i)
            $i -= 1
        EndIf
        $i += 1
    Until $i = UBound($array)
EndFunc   ;==>_ArrayDeleteBlanks

Func _Parallel_Value($Resistors)
    Local $string, $array
    $Resistors = StringReplace($Resistors, ' ', '')
    $array = StringSplit($Resistors, ',')
    For $i = 1 To $array[0]
        $string += (1 / $array[$i])
        If $i = $array[0] Then $string = 1 / $string
    Next
    If $string < 5 Then
        $string = Round($string, 4)
    Else
        $string = Round($string, 2)
    EndIf
    Return $string
EndFunc   ;==>_Parallel_Value