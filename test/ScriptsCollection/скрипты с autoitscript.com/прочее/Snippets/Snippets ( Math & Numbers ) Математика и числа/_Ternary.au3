; Author: guinness
ConsoleWrite(_Ternary(10, 'Is True.', 'Is False.') & @CRLF)
ConsoleWrite(_Ternary(0, 'Is True.', 'Is False.') & @CRLF)
 
; Version: 1.00. AutoIt: V3.3.8.1
Func _Ternary($iValue, $vTrue, $vFalse) ; Like _Iif but uses 0 or non-zero e.g. 1 or above instead of a boolean result.
    Local $aArray[2] = [$vFalse, $vTrue]
    Return $aArray[Number(Number($iValue) > 0)]
EndFunc   ;==>_Ternary