#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=..\..\..\..\Documents and Settings\Diesel Home\My Documents\My documents\Dowloads\Fast Launcher\Icons\019.ico
#AutoIt3Wrapper_outfile=Spearmans Rank.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Description=Spearmans rank calculator!
#AutoIt3Wrapper_Res_Fileversion=1.0.0.2
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_LegalCopyright=Matt Diesel 2009
#AutoIt3Wrapper_Run_AU3Check=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
; Spearmans rank!!

#include<excel.au3>

Local $alist[2], $aInp[2], $hTab, $aLbl[2]

$hGUI = GUICreate("Spearmans Rank", 300, 580, -1, -1, BitOR(0x00040000, 0x00080000, 0x00020000, 0x00010000, 0x00C00000))
   GUICtrlCreateLabel("Spearans Rank is a famous test for finding a correlation between 2 data sets. " & _
        "Start by entering your sets of data to compare. The computer do the maths for you.", 2, 2, 296, 40)
      GUICtrlSetResizing(-1, 0x0002 + 0x0020 + 0x0200)
   GUICtrlCreateLabel("Dataset name:", 4, 72, 70, 20)
      GUICtrlSetResizing(-1, 0x0002 + 0x0020 + 0x0200 + 0x0100)
   $hTab = GUICtrlCreateTab(2, 44, 296, 514)
      GUICtrlSetResizing(-1, 0x0020 + 0x0002 + 0x0040 + 0x0004)
      GUICtrlCreateTabItem("Set 1 Data")
         $aInp[0] = GUICtrlCreateInput("Set 1 Data", 74, 70, 220, 20)
            GUICtrlSetResizing(-1, 0x0020 + 0x0002 + 0x0200 + 0x0004)
         $alist[0] = GUICtrlCreateListView("Data:", 2, 90, 230, 466, 0x8000 + 0x0008, 0x00000020 + 0x00000001 + 0x00010000)
            GUICtrlSetResizing(-1, 0x0020 + 0x0002 + 0x0040 + 0x0004)
            GUICtrlSendMsg($alist[0], 0x1000 + 30, 0, -2)
         $aLbl[0] = GUICtrlCreateLabel("0 Item(s).", 234, 534, 80, 20)
            GUICtrlSetResizing(-1, 0x0040 + 0x0004 + 0x0100 + 0x0200)
      GUICtrlCreateTabItem("Set 2 Data")
         $aInp[1] = GUICtrlCreateInput("Set 2 Data", 74, 70, 220, 20)
            GUICtrlSetResizing(-1, 0x0020 + 0x0002 + 0x0200 + 0x0004)
         $alist[1] = GUICtrlCreateListView("Data:", 2, 90, 230, 466, 0x8000 + 0x0008, 0x00000020 + 0x00000001 + 0x00010000)
            GUICtrlSetResizing(-1, 0x0020 + 0x0002 + 0x0040 + 0x0004)
            GUICtrlSendMsg($alist[1], 0x1000 + 30, 0, -2)
         $aLbl[1] = GUICtrlCreateLabel("0 Item(s).", 234, 534, 80, 20)
            GUICtrlSetResizing(-1, 0x0040 + 0x0004 + 0x0100)
   GUICtrlCreateTabItem("")
   $hAdd = GUICtrlCreateButton("Add", 234, 90, 60, 20)
      GUICtrlSetResizing(-1, 0x0020 + 0x0004 + 0x0100 + 0x0200)
   $hEdt = GUICtrlCreateButton("Edit", 234, 112, 60, 20)
      GUICtrlSetResizing(-1, 0x0020 + 0x0004 + 0x0100 + 0x0200)
   $hRem = GUICtrlCreateButton("Remove", 234, 134, 60, 20)
      GUICtrlSetResizing(-1, 0x0020 + 0x0004 + 0x0100 + 0x0200)
   $hAll = GUICtrlCreateButton("Remove All", 234, 156, 60, 20)
      GUICtrlSetResizing(-1, 0x0020 + 0x0004 + 0x0100 + 0x0200)

   GUICtrlCreateLabel("By Matt Diesel 2009", 2, 560, 128, 20)
   GUICtrlSetResizing(-1, 0x0240)
   $hCnc = GUICtrlCreateButton("Cancel", 132, 558, 80, 20)
   GUICtrlSetResizing(-1, 0x0240)
   $hFin = GUICtrlCreateButton("Finished", 214, 558, 80, 20)
   GUICtrlSetResizing(-1, 0x0240)
   GUICtrlSetState($hFin, 128)

GUISetState()

Local $aCur[2] = ["Set 1 Data", "Set 2 Data"]

While 1
    Switch GUIGetMsg()
        Case - 3, $hCnc
            Exit
        Case $hAdd
            $nCur = GUICtrlRead($hTab)
            $temp = InputBox("Enter new value...", "Please enter the new value to be added to data set " & $nCur + 1 & ".", _
                    "", "", 200, 130)
            If @Error Then ContinueLoop
            _CheckInput($temp + 0)
            If @Error Then ContinueLoop
            GUICtrlCreateListViewItem($temp, $alist[$nCur])
            GUICtrlSetData($aLbl[$nCur], StringRegExpReplace(GUICtrlRead($aLbl[$nCur]), "([0-9]*)(.*)", "\1") + 1 & " Item(s).")
            If(GUICtrlSendMsg($alist[0], 0x1000 + 4, 0, 0) = GUICtrlSendMsg($alist[1], 0x1000 + 4, 0, 0)) AND(GUICtrlSendMsg($alist[1], 0x1000 + 4, 0, 0) <> 0) Then
                GUICtrlSetState($hFin, 64)
            Else
                GUICtrlSetState($hFin, 128)
            EndIf
        Case $hEdt
            $nCur = GUICtrlRead($hTab)
            $nItm = GUICtrlRead($alist[$nCur])
            If $nItm = 0 Then ContinueLoop
            $temp = InputBox("Edit Current Value...", "Please enter the new value for the current data in set " & $nCur + 1 & ".", _
                    StringTrimRight(GUICtrlRead($nItm), 1), "", 200, 130)
            If @Error Then ContinueLoop
            If $temp = "" Then
                GUICtrlDelete($nItm)
                GUICtrlSetData($aLbl[$nCur], StringRegExpReplace(GUICtrlRead($aLbl[$nCur]), "([0-9]*)(.*)", "\1") - 1 & " Item(s).")
                If(GUICtrlSendMsg($alist[0], 0x1000 + 4, 0, 0) = GUICtrlSendMsg($alist[1], 0x1000 + 4, 0, 0)) AND(GUICtrlSendMsg($alist[1], 0x1000 + 4, 0, 0) <> 0) Then
                    GUICtrlSetState($hFin, 64)
                Else
                    GUICtrlSetState($hFin, 128)
                EndIf
                continueLoop
            EndIf
            _CheckInput($temp + 0)
            If @Error Then ContinueLoop
            GUICtrlSetData($nItm, $temp)
        Case $hRem
            GUICtrlDelete(GUICtrlRead($alist[GUICtrlRead($hTab)]))
            GUICtrlSetData($aLbl[$nCur], StringRegExpReplace(GUICtrlRead($aLbl[$nCur]), "([0-9]*)(.*)", "\1") - 1 & " Item(s).")
            If(GUICtrlSendMsg($alist[0], 0x1000 + 4, 0, 0) = GUICtrlSendMsg($alist[1], 0x1000 + 4, 0, 0)) AND(GUICtrlSendMsg($alist[1], 0x1000 + 4, 0, 0) <> 0) Then
                GUICtrlSetState($hFin, 64)
            Else
                GUICtrlSetState($hFin, 128)
            EndIf
        Case $hAll
            GUICtrlSendMsg($alist[GUICtrlRead($hTab)], 0x1000 + 9, 0, 0)
            GUICtrlSetData($aLbl[$nCur], "0 Item(s).")
            GUICtrlSetState($hFin, 128)
        Case $hFin
            Local $nCnt[2] = [GUICtrlSendMsg($alist[0], 0x1000 + 4, 0, 0), GUICtrlSendMsg($alist[1], 0x1000 + 4, 0, 0)]
            If $nCnt[0] <> $nCnt[1] Then ContinueLoop 1 + 0 * MsgBox(16, "Error", _
                    "Number of items in each data set do not match! You have " & $nCnt[0] & " bits of data in set 1, and " & _
                    $nCnt[1] & " bits i set 2." & @CRLF & @CRLF & "Please check your data sets and then continue.")
            Local $aItem0[$nCnt[0] + 1]
            Local $aItem1[$nCnt[0] + 1]
            For $i = 1 to $nCnt[0]
                $aItem0[$i] = ControlListView($hGUI, "", $alist[0], "GetText", $i - 1, 0) + 0
                $aItem1[$i] = ControlListView($hGUI, "", $alist[1], "GetText", $i - 1, 0) + 0
            Next
            $temp0 = _ArrayGetOrder($aItem0, 1, 0, 1)
            $temp1 = _ArrayGetOrder($aItem1, 1, 0, 1)
            $temp = 0
            For $i = 0 to $nCnt[0] - 1
                $temp += ($temp0[$i] - $temp1[$i]) ^ 2
            Next
            $oExcel = _ExcelBookNew(0)
            _ExcelSheetNameSet($oExcel, "Results")
            ; Headings
            _ExcelWriteCell($oExcel, "Spearmans rank Results", 1, 1)
            _ExcelWriteCell($oExcel, GUICtrlRead($aInp[0]), 3, 1)
            _ExcelWriteCell($oExcel, "Rank", 3, 2)
            _ExcelWriteCell($oExcel, GUICtrlRead($aInp[1]), 3, 3)
            _ExcelWriteCell($oExcel, "Rank", 3, 4)
            _ExcelWriteCell($oExcel, "Difference", 3, 5)
            _ExcelWriteCell($oExcel, "d^2", 3, 6)
            ; Data
            For $i = 1 to $nCnt[0]
                _ExcelWriteCell($oExcel, $aItem0[$i], $i + 3, 1)
                _ExcelWriteCell($oExcel, $temp0[$i - 1], $i + 3, 2)
                _ExcelWriteCell($oExcel, $aItem1[$i], $i + 3, 3)
                _ExcelWriteCell($oExcel, $temp1[$i - 1], $i + 3, 4)
                _ExcelWriteCell($oExcel, $temp0[$i - 1] - $temp1[$i - 1], $i + 3, 5)
                _ExcelWriteCell($oExcel, ($temp0[$i - 1] - $temp1[$i - 1]) ^ 2, $i + 3, 6)
            Next
            _ExcelWriteCell($oExcel, $temp, $i + 4, 6)
            _ExcelWriteCell($oExcel, 1 - ((6 * $temp) / (($nCnt[0] ^ 3) - $nCnt[0])), $i + 7, 6)
            $oExcel.Columns.AutoFit
            $sFile = FileSaveDialog("Save spearmans rank analysis...", @WorkingDir, "Excel spreadsheet (*.xls)|All Files (*.*)")
            If @Error Then _ExcelBookClose($oExcel, 0)
            _ExcelBookSaveAs($oExcel, $sFile)
    EndSwitch
    $cur = GUICtrlRead($hTab)
    If GUICtrlRead($aInp[$cur]) = $aCur[$cur] Then ContinueLoop
    $aCur[$cur] = GUICtrlRead($aInp[$cur])
    GUICtrlSetData(GUICtrlRead($hTab, 1), $aCur[$cur])
WEnd

Func _ArrayGetOrder($aArray, $iStart = 0, $iEnd = 0, $nRetType = 0)
    If Not IsArray($aArray) Then Return SetError(1, 0, -1)
    If UBound($aArray, 0) <> 1 Then Return SetError(3, 0, -1)

    Local $iUBound = UBound($aArray) - 1

    ; Bounds checking
    If $iEnd < 1 Or $iEnd > $iUBound Then $iEnd = $iUBound
    If $iStart < 0 Then $iStart = 0
    If $iStart > $iEnd Then Return SetError(2, 0, -1)

    Local $temp = ""

    For $i = $iStart to $iEnd
        $iMaxIndex = 0
        If Not IsNumber($aArray[$i]) Then Return SetError(4, $i, -1)
        For $x = $iStart To $iEnd
            If $aArray[$iMaxIndex] < $aArray[$x] Then $iMaxIndex = $x
        Next
        $temp = $iMaxIndex & "," & $temp
        $aArray[$iMaxIndex] = 0
    Next
    $temp = StringTrimRight($temp, 1)
    If $nRetType = 0 then return $temp
    Return StringSplit($temp, ",", 2)
EndFunc   ;==>_ArrayGetOrder

Func _CheckInput($sInput)
    If $sInput = "" Then Return SetError(1, 0 * MsgBox(16, "Error", "Input cannot be blank"), 0)
    If Not IsNumber($sInput) Then SetError(2, 0 * MsgBox(16, "Error", "Input must be a number"), 0)
    Return 1
EndFunc   ;==>_CheckInput