;Retrieve Monitor Model and Serial
;13 November 2005 by Geert (NL)
;used parts made by archrival (http://www.autoitscript.com/forum/index.php?showtopic=11136)
;Edited by rover 18 June 2008

;Collect EDID strings for all active monitors
#AutoIt3Wrapper_Au3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
Opt("MustDeclareVars", 1)

; ConsoleWrites slow a script if not needed
Global $Debug = True ; change to False or comment out/remove ConsoleWrite() lines if debugging to console not needed

Global $iCounterEDID = 0
Global $asEDID[1], $edidarray[1], $error1, $error2, $error3
Global $iCounterMonitorName = 1, $iCounterMonitorCode, $iCounterMonitorControlFolder
Global $sMonitorName, $sMonitorCode, $sMonitorControlFolder, $sMonitorEDIDRead, $ser, $name, $j

Do
    $sMonitorName = RegEnumKey("HKLM\SYSTEM\CurrentControlSet\Enum\DISPLAY", $iCounterMonitorName)
    $error1 = @error
    If $Debug Then ConsoleWrite(@CRLF & '@@ Debug(' & @ScriptLineNumber & ') : $sMonitorName = ' & _
    StringStripWS($sMonitorName, 2) & @CRLF & '>Error code: ' & $error1 & @CRLF)
    If $sMonitorName <> "" Then
        $iCounterMonitorCode = 1
        Do
            ; Search 'monitor code' - e.g. 5&3aba5caf&0&10000080&01&00
            $sMonitorCode = RegEnumKey("HKLM\SYSTEM\CurrentControlSet\Enum\DISPLAY\" & _
            $sMonitorName, $iCounterMonitorCode)
            $error2 = @error
            If $Debug Then ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $sMonitorCode = ' & _
            StringStripWS($sMonitorCode, 2) & @CRLF & '>Error code: ' & $error2 & @CRLF)
            ; Search Control folder - When available, the active monitor is found
            $iCounterMonitorControlFolder = 1
            
            Do
                $sMonitorControlFolder = RegEnumKey("HKLM\SYSTEM\CurrentControlSet\Enum\DISPLAY\" & _
                        $sMonitorName & "\" & $sMonitorCode, $iCounterMonitorControlFolder)
                $error3 = @error
                If $Debug Then ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $sMonitorControlFolder = ' & _
                        StringStripWS($sMonitorControlFolder, 2) & @CRLF & '>Error code: ' & $error3 & @CRLF)
                If $sMonitorControlFolder == "Control" Then; Active monitor found!

                    Switch RegEnumVal("HKLM\SYSTEM\CurrentControlSet\Enum\DISPLAY\" & $sMonitorName & _
                        "\" & $sMonitorCode & "\Device Parameters", 1)
                        Case "EDID"
                            $sMonitorEDIDRead = RegRead("HKLM\SYSTEM\CurrentControlSet\Enum\DISPLAY\" & _
                                    $sMonitorName & "\" & $sMonitorCode & "\Device Parameters", "EDID")
                            If $sMonitorEDIDRead <> "" Then
                                $iCounterEDID += 1
                                $asEDID[0] = $iCounterEDID
                                ReDim $asEDID[UBound($asEDID) + 1]
                                $asEDID[UBound($asEDID) - 1] = $sMonitorEDIDRead; Add found EDID string to Array
                            EndIf
                        Case "BAD_EDID"
                            $iCounterEDID += 1
                            $asEDID[0] = $iCounterEDID
                            ReDim $asEDID[UBound($asEDID) + 1]
                            $asEDID[UBound($asEDID) - 1] = "BAD_EDID"; Add BAD_EDID string to Array
                        Case Else
                    EndSwitch
                EndIf
                $iCounterMonitorControlFolder += 1; Increase counter to search for next folder
            Until $error3 <> 0
            $iCounterMonitorCode += 1; Increase counter to search for next 'monitor code' folder
        Until $error2 <> 0
    EndIf
    $iCounterMonitorName += 1; Increase counter to search for next monitor
Until $error1 <> 0

; Decrypt collected EDID strings - Thanks archrival
For $k = 1 To $asEDID[0]
    Switch $asEDID[$k]
        Case ""
            $ser = ""
            $name = ""
        Case "BAD_EDID"
            $ser = "BAD_EDID"
            $name = "BAD_EDID"
        Case Else
            $j = 0
            Dim $edidarray[StringLen($asEDID[$k])]
            $edidarray[0] = (StringLen($asEDID[$k]) / 2) + 1
            For $i = 1 To StringLen($asEDID[$k]) Step 2
                $j += 1
                $edidarray[$j] = Dec(StringMid($asEDID[$k], $i, 2))
            Next
            $ser = StringStripWS(_FindMonitorSerial(), 1 + 2)
            $name = StringStripWS(_FindMonitorName(), 1 + 2)
    EndSwitch

    ;Show MonitorSerial & MonitorName: no info? -> Your using a notebook right!
    MsgBox(64, "Monitor " & $k, "MonitorSerial: " & @TAB & _
    $ser & @CRLF & "MonitorName: " & @TAB & $name)
Next

#region - Functions
Func _FindMonitorSerial(); Thanks archrival
    Local $sernumstr = "", $sernum = 0, $endstr
    For $i = 1 To (UBound($edidarray) / 2) - 4
        If $edidarray[$i] = "0" And $edidarray[$i + 1] = "0" And $edidarray[$i + 2] = "0" _
            And $edidarray[$i + 3] = "255" And $edidarray[$i + 4] = "0" Then
            $sernum = $i + 4
        EndIf
    Next
    If $sernum <> 0 Then
        $endstr = 0
        For $i = 1 To 13
            If $edidarray[$sernum + $i] = "10" Then
                $endstr = 1
            Else
                If $endstr = 0 Then
                    $sernumstr &= Chr($edidarray[$sernum + $i])
                EndIf
            EndIf
        Next
    EndIf
    Return $sernumstr
EndFunc   ;==>_FindMonitorSerial

Func _FindMonitorName(); Thanks archrival
    Local $n = 0, $namestr = "", $endstr
    For $i = 1 To (UBound($edidarray) / 2) - 4
        If $edidarray[$i] = "0" And $edidarray[$i + 1] = "0" And _
            $edidarray[$i + 2] = "252" And $edidarray[$i + 3] = "0" Then
            $n = $i + 3
        EndIf
    Next
    If $n <> 0 Then
        $endstr = 0
        For $i = 1 To 13
            If $edidarray[$n + $i] = "10" Then
                $endstr = 1
            Else
                If $endstr = 0 Then
                    $namestr &= Chr($edidarray[$n + $i])
                EndIf
            EndIf
        Next
    EndIf
    Return $namestr
EndFunc   ;==>_FindMonitorName
#endregion