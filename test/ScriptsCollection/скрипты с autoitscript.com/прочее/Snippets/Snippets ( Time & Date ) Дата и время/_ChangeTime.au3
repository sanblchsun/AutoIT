; Author: guinness
_ChangeTime(@HOUR, @MIN)

Func _ChangeTime($iHour, $iMin)
	Local $sTime = $iHour & RegRead("HKEY_CURRENT_USER\Control Panel\International", "sTime") & $iMin
	RunWait(@ComSpec & " /c Time " & $sTime, "", @SW_HIDE)
	Return $sTime
EndFunc   ;==>_ChangeTime