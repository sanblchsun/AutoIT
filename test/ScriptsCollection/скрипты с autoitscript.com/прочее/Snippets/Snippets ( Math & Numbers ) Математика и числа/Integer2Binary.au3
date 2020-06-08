; Author: UEZ
#include <String.au3>

ConsoleWrite(Integer2Binary(2048) & @CRLF)

Func Integer2Binary($in) ;coded by UEZ
	If $in = 0 Then Return 0
	Local $bin
	While $in > 0
		$bin &= Mod($in, 2)
		$in = Floor($in / 2)
	WEnd
	Return (_StringReverse($bin))
EndFunc   ;==>Integer2Binary