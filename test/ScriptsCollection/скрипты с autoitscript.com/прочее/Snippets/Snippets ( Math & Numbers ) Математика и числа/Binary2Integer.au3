#include <String.au3>
; Author: UEZ
ConsoleWrite(Binary2Integer(111000) & @CRLF)

Func Binary2Integer($in) ;coded by UEZ
	Local $int, $x, $i = 1, $aTmp = StringSplit(_StringReverse($in), "")
	For $x = 1 To UBound($aTmp) - 1
		$int += $aTmp[$x] * $i
		$i *= 2
	Next
	$aTmp = 0
	Return StringFormat('%.0f', $int)
EndFunc   ;==>Binary2Integer