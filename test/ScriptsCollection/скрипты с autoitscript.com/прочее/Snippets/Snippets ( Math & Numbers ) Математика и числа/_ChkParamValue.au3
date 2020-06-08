; Author: UEZ
$v = 79 ; Bitmask -> 1 + 2 + 4 + 8 + 64 = 79 =  0100 1111

ConsoleWrite(_ChkParamValue(7, $v) & @LF)
ConsoleWrite(_ChkParamValue(32, $v) & @LF)
ConsoleWrite(_ChkParamValue(77, $v) & @LF)
ConsoleWrite(_ChkParamValue(16, $v) & @LF)

;======================================================================================
; Function Name:    _ChkParamValue
; Description:          Check whether any combination of n parameter values is valid
; Parameters:           $iParam: an integer value to check
;                               $iBitmask: an integer value with the possible parameter values
; Return Value(s):  	True -> $iParam is a valid parameter
;                               False -> $iParam is NOT a valid parameter
;
; Error codes:          1: $iParam not an integer
;                               2: $iBitmask not an integer
; Author(s):            UEZ
; Version:              v0.99 Build 2012-05-10 Beta
; Example:
;                               $iBitmask = 79  ; Bitmask -> 1 + 2 + 4 + 8 + 64 = 79 =  0100 1111
;                               ConsoleWrite(_ChkParamValue(7, $iBitmask) & @LF)
;                               ConsoleWrite(_ChkParamValue(32, $iBitmask) & @LF)
;                               ConsoleWrite(_ChkParamValue(77, $iBitmask) & @LF)
;                               ConsoleWrite(_ChkParamValue(16, $iBitmask) & @LF)
;=======================================================================================
Func _ChkParamValue($iParam, $iBitmask)
	If Not IsInt($iParam) Then Return SetError(1, 0, 0)
	If Not IsInt($iBitmask) Then Return SetError(2, 0, 0)
	If Not $iParam Or $iParam > $iBitmask Then Return 0
	Local $c = BitXOR(BitAND($iBitmask, $iParam), $iParam)
	If Not $c Then Return True
	Return False
EndFunc   ;==>_ChkParamValue