; Retrieve Monitor Model and Serial
; 13 November 2005 by Geert (NL)
; used parts made by archrival (http://www.autoitscript.com/forum/index.php?showtopic=11136)
; Edited/upgraded by rover 20 June 2008

; Collect EDID strings for all active monitors

;Links
;http://en.wikipedia.org/wiki/Extended_display_identification_data
;http://www.lavalys.com/forum/lofiversion/index.php/t1829.html
;http://cwashington.netreach.net/depo/view.asp?Index=1087&ScriptType=vbscript

#AutoIt3Wrapper_Au3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
Opt("MustDeclareVars", 1)

;#include <Constants.au3>

; ConsoleWrites slow a script if not needed
Global $bDebug = True ; change to False or comment out/remove ConsoleWrite() lines if debugging to console not needed

Global $bDisplayAll = False ; if false only 'Active' monitors (reg entries with 'Control' key) with EDID info reported
; 'Active' monitors with no reported EDID data(serial, name, date) are ignored

Global $asEDID[1][2] = [[0, 0]]
Global $iCounterEDID = 0, $sResults
Global $edidarray[1], $error1, $error2, $error3
Global $iCounterMonitorName = 1, $iCounterMonitorCode, $iCounterMonitorControlFolder
Global $sMonitorName, $sMonitorCode, $sMonitorControlFolder, $bMonitorEDIDRead
Global $ser, $name, $j, $sManuDate, $sEDIDVer, $iExtended

Do
$sMonitorName = RegEnumKey("HKLM\SYSTEM\CurrentControlSet\Enum\DISPLAY", $iCounterMonitorName)
$error1 = @error
If $bDebug Then ConsoleWrite(@CRLF & '@@ Debug(' & @ScriptLineNumber & ') : $sMonitorName = ' & _
StringStripWS($sMonitorName, 2) & @CRLF & '>Error code: ' & $error1 & @CRLF)
If $sMonitorName <> "" Then
$iCounterMonitorCode = 1
Do
; Search 'monitor code' - e.g. 5&3aba5caf&0&10000080&01&00
$sMonitorCode = RegEnumKey("HKLM\SYSTEM\CurrentControlSet\Enum\DISPLAY\" & _
$sMonitorName, $iCounterMonitorCode)
$error2 = @error
If $bDebug Then ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $sMonitorCode = ' & _
StringStripWS($sMonitorCode, 2) & @CRLF & '>Error code: ' & $error2 & @CRLF)
; Search Control folder - When available, the active monitor is found
$iCounterMonitorControlFolder = 1
Do
$sMonitorControlFolder = RegEnumKey("HKLM\SYSTEM\CurrentControlSet\Enum\DISPLAY\" & _
$sMonitorName & "\" & $sMonitorCode, $iCounterMonitorControlFolder)
$error3 = @error
If $bDebug Then ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $sMonitorControlFolder = ' & _
StringStripWS($sMonitorControlFolder, 2) & @CRLF & '>Error code: ' & $error3 & @CRLF)
If $sMonitorControlFolder == "Control" Then; Active monitor found!
Switch RegEnumVal("HKLM\SYSTEM\CurrentControlSet\Enum\DISPLAY\" & $sMonitorName & _
"\" & $sMonitorCode & "\Device Parameters", 1)
Case "EDID"
$bMonitorEDIDRead = RegRead("HKLM\SYSTEM\CurrentControlSet\Enum\DISPLAY\" & _
$sMonitorName & "\" & $sMonitorCode & "\Device Parameters", "EDID")
$iExtended = @extended
If $bDebug Then ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $bMonitorEDIDRead = ' & _
$bMonitorEDIDRead & @CRLF & '>Error code: ' & @error & @CRLF & '>Extended code: ' & $iExtended & @CRLF)
;If $bMonitorEDIDRead <> "" And Not @error And $iExtended = $REG_BINARY Then
If $bMonitorEDIDRead <> "" And Not @error Then
$iCounterEDID += 1
$asEDID[0][0] = $iCounterEDID
ReDim $asEDID[UBound($asEDID) + 1][2]
; Add found EDID string to Array 
$asEDID[UBound($asEDID) - 1][0] = Hex($bMonitorEDIDRead) ;(convert from binary to hex string: AutoIt v3.3.0.0 and higher)
$asEDID[UBound($asEDID) - 1][1] = $sMonitorName
EndIf
Case "BAD_EDID"
$iCounterEDID += 1
$asEDID[0][0] = $iCounterEDID
ReDim $asEDID[UBound($asEDID) + 1][2]
$asEDID[UBound($asEDID) - 1][0] = "BAD_EDID"; Add BAD_EDID string to Array
$asEDID[UBound($asEDID) - 1][1] = $sMonitorName
EndSwitch
EndIf
$iCounterMonitorControlFolder += 1; Increase counter to search for next folder
Until $error3 <> 0
$iCounterMonitorCode += 1; Increase counter to search for next 'monitor code' folder
Until $error2 <> 0
EndIf
$iCounterMonitorName += 1; Increase counter to search for next monitor
Until $error1 <> 0

; Extract info from collected EDID strings - Thanks archrival
If $asEDID[0][0] Then
For $k = 1 To $asEDID[0][0]
Switch $asEDID[$k][0]
Case "BAD_EDID"
If Not $bDisplayAll Then ContinueLoop
$ser = "BAD_EDID"
$name = "BAD_EDID"
Case Else
$j = 0
ReDim $edidarray[StringLen($asEDID[$k][0])]
$edidarray[0] = (StringLen($asEDID[$k][0]) / 2) + 1
For $i = 1 To StringLen($asEDID[$k][0]) Step 2
$j += 1
$edidarray[$j] = Dec(StringMid($asEDID[$k][0], $i, 2))
Next
$ser = StringStripWS(_FindMonitorSerial($edidarray), 1 + 2)
$name = StringStripWS(_FindMonitorName($edidarray), 1 + 2)
If $name <> "Not Found" Then
$sManuDate = StringStripWS(_FindMonitorManuDate($asEDID[$k][0]), 1 + 2)
$sEDIDVer = StringStripWS(_FindMonitorEDIDVer($asEDID[$k][0]), 1 + 2)
Else
$sManuDate = ""
$sEDIDVer = ""
EndIf
If Not $bDisplayAll Then
If $name = "Not Found" Then ContinueLoop
EndIf
EndSwitch

$sResults &= @CRLF & "Monitor #" & $k & @CRLF & "VESA Monitor ID" & @TAB & $asEDID[$k][1] & @CRLF & _
"Serial: " & @TAB & @TAB & $ser & @CRLF & "Name: " & @TAB & @TAB & $name & @CRLF & _
"ManuDate: " & @TAB & $sManuDate & @CRLF & "EDID: " & @TAB & @TAB & $sEDIDVer & @CRLF
Next
Else
; No EDID or BAD_EDID entries found
$sResults = "No Monitors Found"
EndIf

;Show MonitorSerial & MonitorName: no info? -> Your using a notebook right!
MsgBox(64, "Active Monitor EDID Info", $sResults)
Exit

#Region - Functions
Func _FindMonitorSerial(ByRef $aArray); Thanks archrival
If Not IsArray($aArray) Then Return
Local $sSernumstr = "", $iSernum = 0, $iEndstr = 0
For $i = 1 To (UBound($aArray) / 2) - 4
If $aArray[$i] = "0" And $aArray[$i + 1] = "0" And $aArray[$i + 2] = "0" _
And $aArray[$i + 3] = "255" And $aArray[$i + 4] = "0" Then
$iSernum = $i + 4
EndIf
Next
If $iSernum Then
For $i = 1 To 13 ;try changing 13 to higher number
If $aArray[$iSernum + $i] = "10" Then
$iEndstr = 1
ElseIf Not $iEndstr Then
$sSernumstr &= Chr($aArray[$iSernum + $i])
EndIf
Next
Else
Return "Not Found"
EndIf
Return $sSernumstr
EndFunc ;==>_FindMonitorSerial

Func _FindMonitorName(ByRef $aArray); Thanks archrival
If Not IsArray($aArray) Then Return
Local $n = 0, $sNamestr = "", $iEndstr = 0
For $i = 1 To (UBound($aArray) / 2) - 4
If $aArray[$i] = "0" And $aArray[$i + 1] = "0" And _
$aArray[$i + 2] = "252" And $aArray[$i + 3] = "0" Then
$n = $i + 3
EndIf
Next
If $n Then
For $i = 1 To 13
If $aArray[$n + $i] = "10" Then
$iEndstr = 1
ElseIf Not $iEndstr Then
$sNamestr &= Chr($aArray[$n + $i])
EndIf
Next
Else
Return "Not Found"
EndIf
Return $sNamestr
EndFunc ;==>_FindMonitorName
#EndRegion - Functions

Func _FindMonitorManuDate(ByRef $sEDID)
Local $wk, $yr
$wk = Dec(StringMid($sEDID, 33, 2)) ; 10h BYTE week number of manufacture
$yr = Dec(StringMid($sEDID, 35, 2)) + 1990 ; 11h BYTE manufacture year - 1990
If $wk = 0 Or $wk > 52 Or $yr < 2000 Or $yr > @YEAR Then
Return ""
EndIf
Return "Week " & $wk & "/" & $yr
EndFunc ;==>_FindMonitorManuDate

Func _FindMonitorEDIDVer(ByRef $sEDID)
Local $iEDIDVer, $iEDIDRev
$iEDIDVer = Dec(StringMid($sEDID, 37, 2)) ; 12h BYTE EDID version
$iEDIDRev = Dec(StringMid($sEDID, 39, 2)) ; 13h BYTE EDID revision
If $iEDIDVer < 1 Or $iEDIDRev < 2 Then
Return ""
EndIf
Return "v" & $iEDIDVer & "." & $iEDIDRev
EndFunc ;==>_FindMonitorEDIDVer