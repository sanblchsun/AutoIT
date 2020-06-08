;*****************************************************
; Function:  _RegSearch
;
; Purpose:  Performs a recursive search of the registry starting at $sStartKey, looking for $sSearchVal
;
; Syntax:  _RegSearch($sStartKey, $sSearchVal, $iType = 0x07, $fArray = False)
;
; Where:  $sStartKey = Reg path at which to begin search
;       $sSearchVal = The string to search for, or RegExp pattern to use if $iType bit 3 is set
;       $iType = Matching types to return:
;           1 = Key names
;           2 = Value names
;           4 = Value data
;           8 = $sSearchVal is a RegExp pattern (default is StringInStr)
;           Add bits together for multiple match types, default is 7 (all types, StringInStr matching)
;       $fArray = Return an array of results vice the string ([0] = count)
;
; Return value:  On success, returns a string containing a @LF delimited list of matching key names and values:
;       Where a key name matches, it is listed as a reg path with trailing backslash:
;           i.e. HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\
;       Where a value name matches, it is listed as a reg path without trailing backslash:
;           i.e. HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WallPaperDir
;       Where the data matches, the format is path = data:
;           i.e. HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WallPaperDir = %SystemRoot%\Web\Wallpaper
;       On failure, returns 0 and sets @error.
;
; Notes:    No matches is not an error, returns "" or an array with [0] = 0 depending on $fArray
;           Default StringInStr() matches are not case sensitive.
;*****************************************************
; Change Log:
;  v1.0.0.0  |  03/17/05  |  Original SearchReg() by Holger
;  v2.0.0.0  |  08/10/06  |  Native AutoIt version by PsaltyDS
;  v2.0.0.1  |  08/16/06  |  Fixed bug reported by markloman
;  v2.0.1.0  |  07/30/08  |  Added $iType and $fArray parameters
;  v2.0.2.0  |  11/12/08  |  Fixed bug returning array [0] = 1 vice 0 for none found
;  v2.0.3.0  |  06/22/10  |  Fixed bug appending some result strings together reported by squid808
;  v2.1.0.0  |  06/23/10  |  Added $iType option for RegExp patterns, and pseudo wildcard "*"
;*****************************************************
Func _RegSearch($sStartKey, $sSearchVal, $iType = 0x07, $fArray = False)
    Local $v, $sVal, $k, $sKey, $sFound = "", $sFoundSub = "", $avFound[1] = [0]

    ; Trim trailing backslash, if present
    If StringRight($sStartKey, 1) = "\" Then $sStartKey = StringTrimRight($sStartKey, 1)

    ; Generate type flags
    If Not BitAND($iType, 0x07) Then Return SetError(1, 0, 0); No returns selected
    Local $fKeys = BitAND($iType, 0x1), $fValue = BitAND($iType, 0x2), $fData = BitAND($iType, 0x4), $fRegExp = BitAND($iType, 0x8)

    ; Check for wildcard
    If (Not $fRegExp) And ($sSearchVal == "*") Then
        ; Use RegExp pattern "." to match anything
        $iType += 0x8
        $fRegExp = 0x8
        $sSearchVal = "."
    EndIf

    ; This checks values and data in the current key
    If ($fValue Or $fData) Then
        $v = 1
        While 1
            $sVal = RegEnumVal($sStartKey, $v)
            If @error = 0 Then
                ; Valid value - test its name
                If $fValue Then
                    If $fRegExp Then
                        If StringRegExp($sVal, $sSearchVal, 0) Then $sFound &= $sStartKey & "\" & $sVal & @LF
                    Else
                        If StringInStr($sVal, $sSearchVal) Then $sFound &= $sStartKey & "\" & $sVal & @LF
                    EndIf
                EndIf

                ; test its data
                If $fData Then
                    $readval = RegRead($sStartKey, $sVal)
                    If $fRegExp Then
                        If StringRegExp($readval, $sSearchVal, 0) Then $sFound &= $sStartKey & "\" & $sVal & " = " & $readval & @LF
                    Else
                        If StringInStr($readval, $sSearchVal) Then $sFound &= $sStartKey & "\" & $sVal & " = " & $readval & @LF
                    EndIf
                EndIf
                $v += 1
            Else
                ; No more values here
                ExitLoop
            EndIf
        WEnd
    EndIf

    ; This loop checks subkeys
    $k = 1
    While 1
        $sKey = RegEnumKey($sStartKey, $k)
        If @error = 0 Then
            ; Valid key - test it's name
            If $fKeys Then
                If $fRegExp Then
                    If StringRegExp($sKey, $sSearchVal, 0) Then $sFound &= $sStartKey & "\" & $sKey & "\" & @LF
                Else
                    If StringInStr($sKey, $sSearchVal) Then $sFound &= $sStartKey & "\" & $sKey & "\" & @LF
                EndIf
            EndIf

            ; Now search it
            $sFoundSub = _RegSearch($sStartKey & "\" & $sKey, $sSearchVal, $iType, False) ; use string mode to test sub keys
            If $sFoundSub <> "" Then $sFound &= $sFoundSub & @LF
        Else
            ; No more keys here
            ExitLoop
        EndIf
        $k += 1
    WEnd

    ; Return results
    If StringRight($sFound, 1) = @LF Then $sFound = StringTrimRight($sFound, 1)
    If $fArray Then
        If StringStripWS($sFound, 8) <> "" Then $avFound = StringSplit($sFound, @LF)
        Return $avFound
    Else
        Return $sFound
    EndIf
EndFunc   ;==>_RegSearch