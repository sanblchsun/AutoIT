; Author: guinness
ConsoleWrite(Chr(169) & " " & _CopyrightYear("2010") & @LF) ; Pass a String of 2010. This is the year the software was created.
ConsoleWrite(_CopyrightYear(2010) & @LF) ; Pass a Number of 2010.
ConsoleWrite(_CopyrightYear(2012) & @LF) ; Pass a Number of 2012.

Func _CopyrightYear($iStartYear, $sDelimeter = "-") ; Return a String representation.
	If Number($iStartYear) <> @YEAR Then
		Return String($iStartYear & " " & $sDelimeter & " " & @YEAR)
	EndIf
	Return String($iStartYear)
EndFunc   ;==>_CopyrightYear