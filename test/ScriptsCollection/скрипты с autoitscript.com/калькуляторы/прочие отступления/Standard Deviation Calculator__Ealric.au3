#cs
===============================================================================
|| Program Name:     Standard Deviation Calculator
|| Description:      Program for sports predictions
|| Version:          2.0
|| Author(s):        Ealric/Drabin
===============================================================================
#ce

#include <Array.au3>
#include <Constants.au3>
#include <EditConstants.au3>
#include <File.au3>
#include <GUIConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <Misc.au3>
#include <WinAPI.au3>

; Create our main gui interface
; Define all of our Globals and Arrays
Global $author = "Ealric/Drabin", $version = "1.0.0"
Global $backgrndcolor = 0x0FFCC66, $commandcolor = 0x066ffff, $optioncolor = 0x0ffdd88, $scriptcolor = 0x0ffddff, $buttoncolor = 0x0660000, $hctrlcolor = 0x000000, $_font = 0x0FFFFFF
Global $parent = GUICreate("Standard Deviation Calculator, Version: " & $version, 383, 680) 

GUISetBkColor($backgrndcolor)

; FILE MENU START
; POSITION -1,0
$filemenu = GUICtrlCreateMenu("File")
$filenewitem = GUICtrlCreateMenuItem("New", $filemenu)
GUICtrlSetState($filenewitem, $GUI_DEFBUTTON)
$fileopenitem = GUICtrlCreateMenuItem("Open", $filemenu)
GUICtrlSetState($fileopenitem,  $GUI_DISABLE)
GUICtrlCreateMenuItem("", $filemenu, 2) ;
$fileitem1 = GUICtrlCreateMenuItem("Test File Item", $filemenu)
$fileitem2 = GUICtrlCreateMenuItem("Test File Item 2", $filemenu)
GUICtrlCreateMenuItem("", $filemenu, 6) 
$exititem = GUICtrlCreateMenuItem("Exit", $filemenu)
; FILE MENU END

; HELP MENU START
; POSITION -1,3
$helpmenu = GUICtrlCreateMenu("Help", -1, 4)
$aboutitem = GUICtrlCreateMenuItem("About", $helpmenu)
; HELP MENU END

; CREATE GUI BUTTONS FOR MACROS
; EACH BUTTON CAN THEN BE REPLACED BY A NEW ONE DEFINED FROM USER INPUT

Global $boxonehctrl = _GUICtrlCreateGroupBox("Input", 10, 17, 3, 361, 182)
GUICtrlSetColor($boxonehctrl, $hctrlcolor)
Global $labelinput = GUICtrlCreateLabel("Enter numbers separated by commas" & @CRLF & "E.g: 10,20,30,40,50",30,35,300,40)
Global $inputlabel = GUICtrlCreateInput("", 40, 85, 300, 60)
GUICtrlSetBkColor($inputlabel, $_font)
Global $calculatebtn = GUICtrlCreateButton("Calculate",140,165,100,20)
Global $boxtwohctrl = _GUICtrlCreateGroupBox("Output", 10, 232, 3, 361, 182)
GUICtrlSetColor($boxtwohctrl, $hctrlcolor)
GUICtrlCreateLabel("Total Numbers:",30,250,100,20)
GUICtrlCreateLabel("Mean (Average):",30,270,100,20)
GUICtrlCreateLabel("Standard Deviation:",30,290,100,20)
Global $numlabel = GUICtrlCreateLabel("",170,250,100,20)
Global $meanlabel = GUICtrlCreateLabel("",170,270,100,20)
Global $deviatelabel = GUICtrlCreateLabel("",170,290,100,20)
GUISetState()

#cs

Main GUI Script Begins below.

#ce

While 1
    $msg = GUIGetMsg()

    Select
        Case $msg = $GUI_EVENT_CLOSE Or $msg = $exititem
            Exit
        Case $msg = $calculatebtn
            _arrayfunc()
    EndSelect
WEnd
GUIDelete()

#cs

Main GUI Script Ends.

#ce

Func _arrayfunc()
    GUICtrlSetData($numlabel,'')
    GUICtrlSetData($meanlabel,'')
    GUICtrlSetData($deviatelabel,'')
    $numarray = StringSplit(GUICtrlRead($inputlabel),",",2)
    Local $i,$x,$number,$mean,$deviation
    If UBound($numarray) <= 1 Then ; Provide an error on the number of arguments(numbers separated by commas) present.
        MsgBox(48,"Error: Number of Arguments","The number of arguments must be greater than one and none of them can be empty.")
    Else
        $mean = _Mean($numarray)
        $number = UBound($numarray)
        $deviate = _StdDev($numarray, 5)
        GuiCtrlSetdata($numlabel, $number)
        GUICtrlSetData($meanlabel, $mean)
        GUICtrlSetData($deviatelabel, $deviate)
    EndIf
EndFunc

; || _GUICtrlCreateEdge() function (by GaryFrost)
Func _GUICtrlCreateEdge($i_x, $i_y, $i_width, $i_height, $v_color)
    GUICtrlCreateGraphic($i_x, $i_y, $i_width, $i_height, 0x1000)
    GUICtrlSetBkColor(-1, $v_color)
EndFunc   ;==>_GUICtrlCreateEdge

; || _GUICtrlCreateGroupBox() function (by GaryFrost)
; || Usage _GUICtrlCreateGroupBox(Left, Top, LineWeight, Width, Height, Color)
Func _GUICtrlCreateGroupBox($sText, $i_x, $i_y, $i_weight, $i_width, $i_height, $v_color = -1)
    Local $hdc = _WinAPI_GetDC(0)
    Local $tSize = _WinAPI_GetTextExtentPoint32($hdc, $sText)
    If ($v_color == -1) Then $v_color = 0x000000
    ; left vertical line
    _GUICtrlCreateEdge($i_x, $i_y, $i_weight, $i_height, $v_color)
    Local $h_ctlid = GUICtrlCreateLabel($sText, $i_x + 4, $i_y - (DllStructGetData($tSize, "Y") / 2))
    GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
    ; top horizontal line
    _GUICtrlCreateEdge($i_x + DllStructGetData($tSize, "X") - 4, $i_y, $i_width - DllStructGetData($tSize, "X") + 4, $i_weight, $v_color)
    ; right vertical line
    _GUICtrlCreateEdge($i_width + $i_x - 1, $i_y, $i_weight, $i_height, $v_color)
    ; bottom horizontal line
    _GUICtrlCreateEdge($i_x, $i_height + $i_y - 1, $i_width + $i_weight - 1, $i_weight, $v_color)
    Return $h_ctlid
EndFunc   ;==>_GUICtrlCreateGroupBox



#cs
INCLUDE IS BELOW
#ce

#include-Once

; #FUNCTION# ;===============================================================================
;
; Name...........: _StdDev
; Description ...: Returns the standard deviation between all numbers stored in an array
; Syntax.........: _StdDev($anArray, $iStdFloat)
; Parameters ....: $anArray - An array containing 2 or more numbers
;                  $iStdFloat - (Optional) The number of decimal places to round for STD
;                  $iType - (Optional) Decides the type of Standard Deviation to use:
;                  |1 - Method One (Standard method using Mean)
;                  |2 - Method Two (Non-Standard method using Squares)
; Return values .: Success - Standard Deviation between multiple numbers
;                  Failure - Returns empty and Sets @Error:
;                  |0 - No error.
;                  |1 - Invalid $anArray (not an array)
;                  |2 - Invalid $anArray (contains less than 2 numbers)
;                  |3 - Invalid $iStdFloat (cannot be negative)
;                  |4 - Invalid $iStdFloat (not an integer)
; Author ........: Ealric
; Modified.......:
; Remarks .......:
; Related .......: _StdDev
; Link ..........;
; Example .......; Yes;
;
;==========================================================================================
Func _StdDev(ByRef $anArray, $iStdFloat = 0, $iType = 1)
    If Not IsArray($anArray) Then Return SetError(1, 0, "") ; Set Error if not an array
    If UBound($anArray) <= 1 Then Return SetError(2, 0, "") ; Set Error if array contains less than 2 numbers
    If $iStdFloat <= -1 Then Return SetError(3, 0, "") ; Set Error if argument is negative
    If Not IsInt($iStdFloat) Then Return SetError(4, 0, "") ; Set Error if argument is not an integer
    Local $n = 0, $nSum = 0
    Local $iMean = _Mean($anArray)
    Local $iCount = _StatsCount($anArray)
    Switch $iType
        Case 1 
            For $i = 0 To $iCount - 1
                $n += ($anArray[$i] - $iMean)^2
            Next
            If ($iStdFloat = 0) Then
                Local $nStdDev = Sqrt($n / ($iCount-1))
            Else
                Local $nStdDev = Round(Sqrt($n / ($iCount-1)), $iStdFloat)
            EndIf
            Return $nStdDev
        Case 2 
            For $i = 0 To $iCount - 1
                $n = $n + $anArray[$i]
                $nSum = $nSum + ($anArray[$i] * $anArray[$i])
            Next
            If ($iStdFloat = 0) Then
                Local $nStdDev = Sqrt(($nSum - ($n * $n) / $iCount) / ($iCount - 1))
            Else
                Local $nStdDev = Round(Sqrt(($nSum - ($n * $n) / $iCount) / ($iCount - 1)), $iStdFloat)
            EndIf
            Return $nStdDev
    EndSwitch
EndFunc   ;==>_StdDev

; #FUNCTION#;===============================================================================
;
; Name...........: _Mean
; Description ...: Returns the mean of a data set, choice of Pythagorean means
; Syntax.........: _Mean(Const ByRef $anArray[, $iStart = 0[, $iEnd = 0[, $iType = 1]]])
; Parameters ....: $anArray - 1D Array containing data set
;                  $iStart - Starting index for calculation inclusion
;                  $iEnd - Last index for calculation inclusion
;                  $iType - One of the following:
;                  |1 - Arithmetic mean (default)
;                  |2 - Geometric mean
;                  |3 - Harmonic mean
; Return values .: Success - Mean of data set
;                  Failure - Returns "" and Sets @Error:
;                  |0 - No error.
;                  |1 - $anArray is not an array or is multidimensional
;                  |2 - Invalid mean type
;                  |3 - Invalid boundaries
; Author ........: Andybiochem
; Modified.......:
; Remarks .......:
; Related .......:
; Link ..........;
; Example .......;
;
;;==========================================================================================
Func _Mean(Const ByRef $anArray, $iStart = 0, $iEnd = 0, $iType = 1)
    If Not IsArray($anArray) Or UBound($anArray, 0) <> 1 Then Return SetError(1, 0, "")
    If Not IsInt($iType) Or $iType < 1 Or $iType > 3 Then Return SetError(2, 0, "")
    Local $iUBound = UBound($anArray) - 1
    If Not IsInt($iStart) Or Not IsInt($iEnd) Then Return SetError(3, 0, "")
    If $iEnd < 1 Or $iEnd > $iUBound Then $iEnd = $iUBound
    If $iStart < 0 Then $iStart = 0
    If $iStart > $iEnd Then Return SetError(3, 0, "")
    Local $nSum = 0, $iN = ($iEnd - ($iStart - 1))
    Switch $iType
        Case 1;Arithmetic mean
            For $i = $iStart To $iEnd
                $nSum += $anArray[$i]
            Next
            Return $nSum / $iN
        Case 2;Geometric mean
            For $i = $iStart To $iEnd
                $nSum *= $anArray[$i]
                If $i = $iStart Then $nSum += $anArray[$i]
            Next
            Return $nSum ^ (1 / $iN)
        Case 3;Harmonic mean
            For $i = $iStart To $iEnd
                $nSum += 1 / $anArray[$i]
            Next
            Return $iN / $nSum
    EndSwitch
EndFunc   ;==>_Mean

Func _StatsSum(ByRef $a_Numbers)
    If Not IsArray($a_Numbers) Then SetError(1, 0, "") ;If not an array of value(s) then error and return a blank string
    Local $i_Count = _StatsCount($a_Numbers)
    Local $n_SumX = 0

    For $i = 0 To $i_Count - 1 Step 1
        $n_Sum += $a_Numbers[$i]
    Next

    Return $n_Sum
EndFunc   ;==>_StatsSum

Func _StatsCount(ByRef $a_Numbers)
    Return UBound($a_Numbers)
EndFunc   ;==>_StatsCount

Func _StatsCp($n_USL, $n_LSL, $n_StdDev)
    If Not IsNumber($n_USL) Then SetError(1, 0, "")
    If Not IsNumber($n_LSL) Then SetError(2, 0, "")
    If Not IsNumber($n_StdDev) Then SetError(3, 0, "")

    Return ($n_USL - $n_LSL) / (6 * $n_StdDev)
EndFunc   ;==>_StatsCp

Func _StatsCpk($n_USL, $n_LSL, $n_StdDev, $n_Mean)
    If Not IsNumber($n_USL) Then SetError(1, 0, "")
    If Not IsNumber($n_LSL) Then SetError(2, 0, "")
    If Not IsNumber($n_StdDev) Then SetError(3, 0, "")
    If Not IsNumber($n_Mean) Then SetError(4, 0, "")
    Local $n_AboveMean = ($n_USL - $n_Mean) / (3 * $n_StdDev)
    Local $n_BelowMean = ($n_Mean - $n_LSL) / (3 * $n_StdDev)

    If $n_AboveMean < $n_BelowMean Then
        Return $n_AboveMean
    Else
        Return $n_BelowMean
    EndIf
EndFunc   ;==>_StatsCpk