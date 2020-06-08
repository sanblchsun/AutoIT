; Author: guinness
ConsoleWrite(_Boolean(True) & @CRLF) ; Returns True.
ConsoleWrite(_Boolean("This is a string with something True.") & @CRLF) ; Returns False if a string of text (excluding True/False or a number.)
ConsoleWrite(_Boolean("1") & @CRLF) ; Returns True as it is a string but a number.
ConsoleWrite(_Boolean("False") & @CRLF) ; Returns False.
ConsoleWrite(_Boolean("False") & @CRLF) ; Returns False.
ConsoleWrite(_Boolean(1) & @CRLF) ; Returns True.

; Convert a value to Boolean (True or False).
; If a number is passed then anything that is NOT 0 is True and if a string is the explicit word True, False or a number than it's equivilant boolean value is returned.
; Anthing else e.g. This is a string is False.
Func _Boolean($fValue)
	If IsBool($fValue) Then
		Return $fValue
	EndIf
	Return Number($fValue) >= 1
EndFunc   ;==>_Boolean