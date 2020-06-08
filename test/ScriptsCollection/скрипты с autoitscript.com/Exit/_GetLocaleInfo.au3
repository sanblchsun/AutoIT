; _GetLocaleInfo.au3
#include <array.au3>
#include <ie.au3>

#region Examples
Local $log = ""
$log &= _GLI_Day() & @TAB & @TAB & "current day in PC's default language" & @LF
$log &= _GLI_Day("", 2) & @TAB & @TAB & "abbreviated current day in PC's default language" & @LF
$log &= _GLI_Day(1) & @TAB & @TAB & "first day of week (sunday)" & @LF
$log &= _GLI_Day(7) & @TAB & @TAB & "last day of week (saturday)" & @LF
$log &= _GLI_Day("", "", "040c") & @TAB & @TAB & " current day in French" & @LF
$log &= _GLI_Day("", "", "0411") & @TAB & @TAB & " current day in Japanese" & @LF
$log &= _GLI_Day("", "", "0419") & @TAB & @TAB & " current day in Russian (Cyrillic)" & @LF
$log &= _GLI_Day("7", "", "0809") & @TAB & @TAB & " last day in English" & @LF
$log &= _GLI_Day("7", "2", "0809") & @TAB & @TAB & " abbreviated last day in English" & @LF
$log &= "" & @LF
$log &= _GLI_Month() & @TAB & @TAB & " current month in PC's default language" & @LF
$log &= _GLI_Month("", 2) & @TAB & @TAB & " abbreviated current month in PC's default language" & @LF
$log &= _GLI_Month(1) & @TAB & @TAB & " first month (January)" & @LF
$log &= _GLI_Month(12) & @TAB & " last month  (December)" & @LF
$log &= _GLI_Month("", "", "040c") & @TAB & @TAB & " current month in French" & @LF
$log &= _GLI_Month("", "", "0411") & @TAB & @TAB & " current month in Japanese" & @LF
$log &= _GLI_Month("", "", "0419") & @TAB & @TAB & " current month in Russian (Cyrillic)" & @LF
$log &= _GLI_Month("12", "", "0809") & @TAB & " last month in English" & @LF
$log &= _GLI_Month("12", "2", "0809") & @TAB & @TAB & " abbreviated last month in English" & @LF
MsgBox(262144, "_GLI_Day() and  _GLI_Month() examples", $log)
MsgBox(262144, " ", _GLI_Index()) ; show default country indexes
MsgBox(262144, " ", _GLI_Index("040c")) ; show France indexes
MsgBox(262144, " ", _GLI_CLIDs()) ; show all CLIDs
Exit
#endregion Examples

#region udf _GetLocaleInfo.au3

; #INDEX# =======================================================================================================================
; Title .........:  _GetLocaleInfo
; AutoIt Version : 3.3.8.1 or later
; Language ......: English
; Description ...: Functions to retrieve informations from locales
; Author(s) .....: Exit
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
; _GLI_Day
; _GLI_Month
; _GLI_CLIDs
; _GLI_Index
; #INTERNAL_USE_ONLY# ===========================================================================================================
;__GLI_Get
; ===============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name...........: _GLI_Day
; Description ...: Get the localized name of a weekday
; Syntax.........: _GLI_Day( [$i_Day = @WDAY [, $i_Abbrev = 1 [, $s_LCID = ""]]])
; Parameters ....: $i_Day        - Optional: specifies the day of week (1=sunday, 7=saturday)
;                                           Default:  current day of week (@wday)
;                   $i_Abbrev    - Optional: specifies long or abbreviated format
;                                        1 = (Default) long format      (Saturday)
;                                        2 = abbreviated format        (Sat)
;                   $s_LCID         - Optional: specifies the Locale ID in hex
;                                        Default: @OSLang (default language of the PC)
; Return values .: On Success    - Returns a string variable with the weekday name
;                  On Failure    - Returns empty string and sets @ERROR
;                    @ERROR        - 0  = No Error
;                                - 1  = Invalid $i_Day (not between 1 and 7)
;                                - 2  = Invalid $i_Abbrev (not 1 or 2)
;                                - 3  = Invalid $s_LCID
; Author ........: Exit
; ===============================================================================================================================
Func _GLI_Day($i_Day = @WDAY, $i_Abbrev = 1, $s_LCID = "")
    ; validate $i_Day variable
    If $i_Day = Default Or $i_Day = "Default" Or $i_Day = "" Then $i_Day = @WDAY
    $i_Day += 0
    If $i_Day < 1 Or $i_Day > 7 Then Return SetError(1, 0, "")
    ; validate $i_Abbrev variable
    If $i_Abbrev = Default Or $i_Abbrev = "Default" Or $i_Abbrev = "" Then $i_Abbrev = 1
    $i_Abbrev += 0
    If $i_Abbrev < 1 Or $i_Abbrev > 2 Then Return SetError(2, 0, "")
    ; validate $s_LCID variable
    ; If $s_LCID is not valid, @error = 3
    ; for Locale IDs use function _GLI_CLIDs()
    ; or see http://msdn.microsoft.com/goglobal/bb964664
    Local $NLS_definition_Index = Mod($i_Day + 5, 7) + 42 + ($i_Abbrev - 1) * 7
    ; for $NLS_definition_Index use function _GLI_Index()
    ; or see here:
    ;     http://www.trigeminal.com/code/CalendarStuff.bas
    ;     ftp://ftp.biomed.cas.cz/pub/local/lucie/fabio/BC5/INCLUDE/WIN16/olenls.h
    Local $sReturn = __GLI_Get(Dec($s_LCID), $NLS_definition_Index)
    If $sReturn = "" Then Return SetError(3, 0, "")
    Return $sReturn
EndFunc   ;==>_GLI_Day

; #FUNCTION# ====================================================================================================================
; Name...........: _GLI_Month
; Description ...: Get the localized name of a month
; Syntax.........: _GLI_Month( [$i_Month = @mon [, $i_Abbrev = 1 [, $s_LCID = ""]]])
; Parameters ....: $i_Month      - Optional: specifies the month  (1=January, 12=December)
;                                        Default:  current month (@mon)
;                   $i_Abbrev    - Optional: specifies long or abbreviated format
;                                        1 = (Default) long format      (January)
;                                        2 = abbreviated format        (Jan)
;                   $s_LCID      - Optional: specifies the Locale ID in hex
;                                        Default: @OSLang (default language of the PC)
; Return values .: On Success    - Returns a string variable with the month name
;                  On Failure    - Returns empty string and sets @ERROR
;                    @ERROR      - 0  = No Error
;                                - 1  = Invalid $i_Month (not between 1 and 12)
;                                - 2  = Invalid $i_Abbrev (not 1 or 2)
;                                - 3  = Invalid $s_LCID
; Author ........: Exit
; ===============================================================================================================================
Func _GLI_Month($i_Month = @MON, $i_Abbrev = 1, $s_LCID = "")
    ; validate $i_Month variable
    If $i_Month = Default Or $i_Month = "Default" Or $i_Month = "" Then $i_Month = @MON
    $i_Month += 0
    If $i_Month < 1 Or $i_Month > 12 Then Return SetError(1, 0, "")
    ; validate $i_Abbrev variable
    If $i_Abbrev = Default Or $i_Abbrev = "Default" Or $i_Abbrev = "" Then $i_Abbrev = 1
    $i_Abbrev += 0
    If $i_Abbrev < 1 Or $i_Abbrev > 2 Then Return SetError(2, 0, "")
    ; validate $s_LCID variable
    ; If $s_LCID is not valid, @error = 3
    Local $NLS_definition_Index = $i_Month + 55 + ($i_Abbrev - 1) * 12
    Local $sReturn = __GLI_Get(Dec($s_LCID), $NLS_definition_Index)
    If $sReturn = "" Then Return SetError(3, 0, "")
    Return $sReturn
EndFunc   ;==>_GLI_Month

; #FUNCTION# ====================================================================================================================
; Name...........: _GLI_CLIDs
; Description ...: Display all CLIDs in a browser window and opionally save HTML output
; Syntax.........: _GLI_CLIDs( [$iSaveHTML = 0])
; Parameters ....: $i_SaveHTML   - Optional: specifies if HTML output should be saved
;                                        0 = (Default) do not save HTML output
;                                        1 = save HTML output to file                                     Default: @OSLang (default language of the PC)
; Return values .: On Success    - Returns a string variable with the HTML output
;                  On Failure    - Returns empty string
; Author ........: Exit
; ===============================================================================================================================
#include <array.au3>
#include <ie.au3>
Func _GLI_CLIDs($iSaveHTML = 0)
    Local $s_LCID = "007f 0501 05fe 09ff" ; omit pseudo LCIDs
    Local $iLens_LCID = StringLen($s_LCID) + 1 ; count for stringtrimleft()
    Local $sTemp
    For $i = 0 To 0xffff
        $sTemp = __GLI_Get($i, 1)
        If StringInStr($s_LCID, $sTemp) Then ContinueLoop
        $s_LCID &= " " & $sTemp
    Next
    Local $aLCID = StringSplit(StringStripWS(StringTrimLeft($s_LCID, $iLens_LCID), 7), " ", 3)
    Local $aResult[UBound($aLCID)][6]
    Local $LCID
    For $i = 0 To UBound($aResult) - 1
        $aResult[$i][0] = $aLCID[$i]
        $LCID = Dec($aResult[$i][0])
        ; === short locale
        $aResult[$i][1] = __GLI_Get($LCID, 92)
        If $aResult[$i][1] = "" Then $aResult[$i][1] = __GLI_Get($LCID, 89) & "-" & __GLI_Get($LCID, 90)
        ; === language(country)  in english
        $aResult[$i][2] = __GLI_Get($LCID, 114)
        If $aResult[$i][2] = "" Then $aResult[$i][2] = __GLI_Get($LCID, 4097) & "(" & __GLI_Get($LCID, 4098) & ")"
        ; === language(country)  in your language
        $aResult[$i][3] = __GLI_Get($LCID, 2)
        ; === language(country)  in local language
        $aResult[$i][4] = __GLI_Get($LCID, 115)
        If $aResult[$i][4] = "" Then $aResult[$i][4] = __GLI_Get($LCID, 4) & " (" & __GLI_Get($LCID, 8) & ")"
        ; === currency sign
        $aResult[$i][5] = __GLI_Get($LCID, 20) & " (" & __GLI_Get($LCID, 21) & ") " & __GLI_Get($LCID, 4103) & " (" & __GLI_Get($LCID, 4104) & ")"
    Next
    _ArraySort($aResult, 0, 0, 0, 2)
    Local $sHTML = "<H3>A total of " & UBound($aResult) & " LCIDs on a " & @OSVersion & " System sorted by english language </H3> "
    $sHTML &= @LF & '<TABLE border=1 cellSpacing=0 borderColor=#c0c0c0 cellPadding=3 width="100%"><TBODY><TR>'
    Local $sHTMLdef = @LF & '<TD style="BACKGROUND-COLOR: rgb(0,0,153); COLOR: white; FONT-WEIGHT: bold">'
    $sHTML &= $sHTMLdef & 'LCID (dec)'
    $sHTMLdef = '</TD>' & $sHTMLdef
    $sHTML &= $sHTMLdef & 'LCID (hex'
    $sHTML &= $sHTMLdef & 'Locale '
    $sHTML &= $sHTMLdef & 'Language(Country) in english language'
    $sHTML &= $sHTMLdef & 'Language(Country) in your language'
    $sHTML &= $sHTMLdef & 'Language(Country) in local language'
    $sHTML &= $sHTMLdef & 'Currency'
    $sHTML &= '</TD></TR>'
    For $i = 0 To UBound($aResult) - 1
        $sHTML &= @LF & "<TR><TD>" & Dec($aResult[$i][0]) & "</TD><TD>" & $aResult[$i][0] & "</TD><TD>" & $aResult[$i][1] & "</TD><TD>" & $aResult[$i][2] & "</TD><TD>" & $aResult[$i][3] & "</TD><TD>" & $aResult[$i][4] & "</TD><TD>" & $aResult[$i][5] & "</TD></TR>"
    Next
    $sHTML &= "</TBODY></TABLE>"
    $oIE = _IECreate()
    _IEBodyWriteHTML($oIE, $sHTML)
    If $iSaveHTML Then
        Local $sFilehandle = FileOpen(FileSaveDialog("Save HTML source ?", @ScriptDir, "HTML files (*.htm*)", 16, @ScriptFullPath & ".html"), 2 + 8 + 32)
        FileWrite($sFilehandle, $sHTML)
        FileClose($sFilehandle)
    EndIf
    Return $sHTML
EndFunc   ;==>_GLI_CLIDs

; #FUNCTION# ====================================================================================================================
; Name...........: _GLI_Index
; Description ...: Display all index entries of a CLID in a browser window
; Syntax.........: _GLI_Index( [$s_LCID = @OSLang])
; Parameters ....:  $s_LCID       - Optional: specifies the Locale ID in hex
;                                      Default: @OSLang (default language of the PC)
; Return values .: On Success    - Returns a string variable with the HTML output
;                  On Failure    - Returns empty string
; Author ........: Exit
; ===============================================================================================================================
Func _GLI_Index($s_LCID = @OSLang)
    Local $sTemp
    Local $s_LCIDdec = Dec($s_LCID)
    Local $sHTML = ""
    For $i = 1 To 4200
        $ih = Hex($i, 4)
        $sTemp = __GLI_Get($s_LCIDdec, $i)
        If $sTemp = "" Then ContinueLoop
        ;ConsoleWrite($ih & " " & $i & " " & $sTemp & @CR)
        $sHTML &= $ih & " " & $i & " " & $sTemp & " <" & "br>" & @CR
    Next
    $oIE = _IECreate()
    _IEBodyWriteHTML($oIE, $sHTML)
    Return $sHTML
EndFunc   ;==>_GLI_Index

; #FUNCTION# ====================================================================================================================
; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __GLI_Get
; Description ...: Get an index entrie of a LCID
; Syntax.........: __GLI_Get( $iLCID_Dec ,$iIndex)
; Parameters ....: $iLCID_Dec       - specifies the Locale ID in decimal
;                  $iIndex          - specifies the index of the LCID in decimal
; Return values .: On Success    - Returns a string variable with the index data
;                  On Failure    - Returns empty string
; Author ........: Exit
; ===============================================================================================================================
Func __GLI_Get($iLCID_Dec, $iIndex)
    Local $aTemp = DllCall('kernel32.dll', 'int', 'GetLocaleInfoW', 'ulong', $iLCID_Dec, 'dword', $iIndex, 'wstr', '', 'int', 2048)
    Return $aTemp[3]
EndFunc   ;==>__GLI_Get

#endregion udf _GetLocaleInfo.au3