; Author: GEOSoft
ConsoleWrite("Время " & _Time() & @CRLF)

Func _Time($iSec = 0, $tFormat = 12)
	Local $fKey = "HKCU\Control Panel\International", $ap = RegRead($fKey, "s1159")
	Local $pStr = RegRead($fKey, "s2359"), $tSep = RegRead($fKey, "sTime"), $sStr = ""
	Local $hour = @HOUR
	If $tFormat = 12 Then
		If $hour = 0 Then $hour = 12
		If @HOUR >= 12 Then
			$hour = @HOUR
			If $hour > 12 Then $hour -= 12
			$ap = $pStr
		EndIf
	Else
		$ap = ""
		$hour = StringFormat("%02u", $hour)
	EndIf
	If $iSec <> 0 Then $sStr = $tSep & @SEC
	If $ap <> "" Then $ap = Chr(32) & $ap
	Return $hour & $tSep & @MIN & $sStr & $ap
EndFunc   ;==>_Time