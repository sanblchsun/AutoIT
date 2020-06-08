; http://autoit-script.ru/index.php?topic=2930.msg21226#msg21226


$Timer = TimerInit()

$hList = FileOpen("ip.txt", 0)
If $hList = -1 Then
    MsgBox(0, "Error", "Не удается открыть файл.")
    Exit
EndIf

$hReport = FileOpen("report.txt", 2)

$sList = FileRead($hList)
$aList = StringSplit(StringStripCR(StringStripWS($sList, 3)), @LF)
$sList = _UniqueValues($aList)

FileWrite($hReport, $sList)

FileClose($hList)
FileClose($hReport)
ConsoleWrite(Round(TimerDiff($Timer)/1000) & @LF)


Func _UniqueValues($a_Values)
    
    Local $sList = ""
    If Not IsArray($a_Values) Then Return SetError(1, 0, 0)

    For $i = 1 To UBound($a_Values) -1
        Assign($a_Values[$i], Eval($a_Values[$i])+1)
        If Eval($a_Values[$i]) = 1 Then
            $sList &= $a_Values[$i] & "|" & "$" & $a_Values[$i] & "$" & @CRLF
        EndIf
    Next

    $ExpandVarStrings = Opt("ExpandVarStrings",1)
        Return SetError(0, 0 , $sList)
    Opt("ExpandVarStrings", $ExpandVarStrings)
    
EndFunc