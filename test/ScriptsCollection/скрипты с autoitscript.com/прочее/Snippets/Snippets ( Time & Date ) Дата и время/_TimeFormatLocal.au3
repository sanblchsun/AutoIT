; Author: GEOSoft
; Return a time string using the local settings format.
MsgBox(4096, "", _TimeFormatLocal(@HOUR & @MIN & @SEC))
MsgBox(4096, "", _TimeFormatLocal(@HOUR & "h" & @MIN & ":" & @SEC))

Func _TimeFormatLocal($sTime);; Use Local time format settings
	Local $sFormat = RegRead("HKCU\Control Panel\International", "sTimeFormat")
	If @error Then
		$sFormat = "h:mm:ss tt"
	EndIf
	Local $aFormat = StringRegExp($sFormat, "\w*(.)\w*(.).*", 3)
	If @error Then
		SetError(1, 0, 0)
	EndIf
	Return StringRegExpReplace($sTime, "(\d{2}).?(\d{2}).?(\d{2})", "\1" & $aFormat[0] & "\2" & $aFormat[1] & "\3")
EndFunc   ;==>_TimeFormatLocal