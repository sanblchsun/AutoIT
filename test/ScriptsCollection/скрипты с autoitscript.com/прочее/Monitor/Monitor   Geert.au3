; Retrieve Monitor Model and Serial
; 13 November 2005 by Geert (NL)
; used parts made by archrival (http://www.autoitscript.com/forum/index.php?showtopic=11136)

; Collect EDID strings for all active monitors
$iCounterEDID = 0
Dim $asEDID[1]

$iCounterMonitorName = 1
Do
    $sMonitorName = RegEnumKey("HKLM\SYSTEM\CurrentControlSet\Enum\DISPLAY", $iCounterMonitorName)
    If $sMonitorName <> "" Then
        $iCounterMonitorCode = 1
        Do
           ; Search 'monitor code' - 5&3aba5caf&0&10000080&01&00
            $sMonitorCode = RegEnumKey("HKLM\SYSTEM\CurrentControlSet\Enum\DISPLAY\" & $sMonitorName, $iCounterMonitorCode)
           ; Search Control folder - When available, the active monitor is found
            $iCounterMonitorControlFolder = 1
            Do
                $sMonitorControlFolder = RegEnumKey("HKLM\SYSTEM\CurrentControlSet\Enum\DISPLAY\" & $sMonitorName & "\" & $sMonitorCode, $iCounterMonitorControlFolder)
                If $sMonitorControlFolder == "Control" Then; Active monitor found!
                    $sMonitorEDIDRead = RegRead("HKLM\SYSTEM\CurrentControlSet\Enum\DISPLAY\" & $sMonitorName & "\" & $sMonitorCode & "\Device Parameters", "EDID")
                    If $sMonitorEDIDRead <> "" Then
                        $sMonitorEDID = $sMonitorEDIDRead
                        $iCounterEDID = $iCounterEDID + 1
                        $asEDID[0] = $iCounterEDID
                        ReDim $asEDID[UBound($asEDID) + 1]
                        $asEDID[UBound($asEDID) - 1] = $sMonitorEDID; Add found EDID string to Array
                    EndIf
                EndIf
                $iCounterMonitorControlFolder = $iCounterMonitorControlFolder + 1; Increase counter to search for next folder
            Until $sMonitorControlFolder == ""
            $iCounterMonitorCode = $iCounterMonitorCode + 1; Increase counter to search for next 'monitor code' folder
        Until $sMonitorCode == ""
    EndIf
    $iCounterMonitorName = $iCounterMonitorName + 1; Increase counter to search for next monitor
Until $sMonitorName == ""


; Decrypt collected EDID strings - Thanks archrival
For $k = 1 To $asEDID[0]
    $sMonEDID = $asEDID[$k]
    If $sMonEDID <> "" Then
        $j = 0
        Dim $edidarray[StringLen($sMonEDID) ]
        $edidarray[0]= (StringLen($sMonEDID) / 2) + 1
        For $i = 1 To StringLen($sMonEDID) Step 2
            $j = $j + 1
            $edidarray[$j] = Dec(StringMid($sMonEDID, $i, 2))
        Next
        $ser = StringStripWS(_FindMonitorSerial(), 1 + 2)
        $name = StringStripWS(_FindMonitorName(), 1 + 2)
    Else
        $ser = ""
        $name = ""
    EndIf
    
    MsgBox(64, "Monitor " & $k, "MonitorSerial: " & $ser & @CRLF & "MonitorName: " & $name);Show MonitorSerial & MonitorName: no info? -> Your using a notebook right!
Next

; Functions

Func _FindMonitorSerial(); Thanks archrival
    $sernumstr = ""
    $sernum = 0
    For $i = 1 To (UBound($edidarray) / 2) - 4
        If $edidarray[$i] = "0" And $edidarray[$i + 1] = "0" And $edidarray[$i + 2] = "0" And $edidarray[$i + 3] = "255" And $edidarray[$i + 4] = "0" Then
            $sernum = $i + 4
        EndIf
    Next
    If $sernum <> 0 Then
        $endstr = 0
        $sernumstr = ""
        For $i = 1 To 13
            If $edidarray[$sernum + $i] = "10" Then
                $endstr = 1
            Else
                If $endstr = 0 Then
                    $sernumstr = $sernumstr & Chr($edidarray[$sernum + $i])
                EndIf
            EndIf
        Next
    Else
        $sernumstr = ""
    EndIf
    Return $sernumstr
EndFunc  ;==>_FindMonitorSerial

Func _FindMonitorName(); Thanks archrival
    $name = 0
    For $i = 1 To (UBound($edidarray) / 2) - 4
        If $edidarray[$i] = "0" And $edidarray[$i + 1] = "0" And $edidarray[$i + 2] = "252" And $edidarray[$i + 3] = "0" Then
            $name = $i + 3
        EndIf
    Next
    If $name <> 0 Then
        $endstr = 0
        $namestr = ""
        For $i = 1 To 13
            If $edidarray[$name + $i] = "10" Then
                $endstr = 1
            Else
                If $endstr = 0 Then
                    $namestr = $namestr & Chr($edidarray[$name + $i])
                EndIf
            EndIf
        Next
    Else
        $namestr = ""
    EndIf
    Return $namestr
EndFunc  ;==>_FindMonitorName