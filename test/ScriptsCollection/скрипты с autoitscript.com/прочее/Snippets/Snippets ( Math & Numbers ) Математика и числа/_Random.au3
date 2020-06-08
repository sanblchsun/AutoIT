; Author: guinness
; Usage = _Random(Minimum, Maximum, [Integer]) ~ ( Generates a random number within a given range )
 
ConsoleWrite(_Random(0, 1) & @CRLF) ; Will return a float number between 0 & 1.
ConsoleWrite(_Random(42, 42) & @CRLF) ; Will return 42, as both values are the same.
ConsoleWrite(_Random(1, 99, 1) & @CRLF) ; Will return an integer number between 1 & 99.
 
Func _Random($iMin, $iMax, $iInteger = 0)
    Local $iRandom = Random($iMin, $iMax, $iInteger)
    If @error Then
        Return $iMin
    EndIf
    Return $iRandom
EndFunc   ;==>_Random