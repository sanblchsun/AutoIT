; Author: SolidSnake26
; Calculate the Distance between two points
; Author - SolidSnake
ConsoleWrite(_Distance(210, 345, 273, 465) & @CRLF)

Func _Distance($iX1, $iY1, $iX2, $iY2)
	Return Sqrt(($iX1 - $iX2) ^ 2 + ($iY1 - $iY2) ^ 2)
EndFunc   ;==>_Distance