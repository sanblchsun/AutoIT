; #FUNCTION# ===================================================================
; Name...........: _StringRegExpSplit
; Description ...: Split a string according to a regular exp[b][/b]ression.
; Syntax.........: _StringRegExpSplit($sString, $sPattern)
; Parameters ....: $sString - String: String to split.
;                  $sPattern - String: Regular exp[b][/b]ression to split on.
; Return values .: Success - Array: Array of substrings, the total is in $array[0].
;                  Failure - Array: The count is 1 ($array[0]) and the full string is returned ($array[1]) and sets @error:
;                  |1 Delimiter not found.
;                  |2 Bad RegExp pattern, @extended contains the offset of the error in the pattern.
;                  |3 No suitable placeholder delimiter could be constructed.
; Author ........: dany
; Modified ......: czardas, AZJIO
; Remarks .......:
; Related .......:
; ==============================================================================
Func _StringRegExpSplit($sString, $sPattern)
    Local $sSplit, $sDelim, $aError[2] = [1, $sString]
    For $i = 1 To 31
        $sDelim &= Chr($i)
        If Not StringInStr($sString, $sDelim) Then ExitLoop
        If 32 = StringLen($sDelim) Then Return SetError(3, 0, $aError)
    Next
    $sSplit = StringRegExpReplace($sString, $sPattern, $sDelim)
    If @error Then Return SetError(2, @extended, $aError)
    If @extended = 0 Then Return SetError(1, 0, $aError)
    If Not IsBinary($sString) Then Return StringSplit($sSplit, $sDelim, 1)
    $sSplit = StringSplit($sSplit, $sDelim, 1)
    For $i = 2 To $sSplit[0]
        $sSplit[$i] = '0x' & $sSplit[$i]
    Next
    Return $sSplit
EndFunc