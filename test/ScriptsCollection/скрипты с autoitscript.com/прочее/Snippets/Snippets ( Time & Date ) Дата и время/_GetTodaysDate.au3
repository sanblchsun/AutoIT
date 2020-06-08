; Author: guinness
ConsoleWrite(_GetTodaysDate() & @CRLF) ; Return the date and the time.
ConsoleWrite(_GetTodaysDate(0) & @CRLF) ; Return the date only.

Func _GetTodaysDate($iReturnTime = 1)
	Local $aMDay[8] = [7, "Sun", "Mon", "Tue", "Wed", "Thur", "Fri", "Sat"], _
			$aMonth[13] = [12, "Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec"], $aTime[2] = ["", ' ' & @HOUR & ':' & @MIN & ':' & '00']
	Return $aMDay[@WDAY] & ', ' & @MDAY & ' ' & $aMonth[@MON] & ' ' & @YEAR & $aTime[$iReturnTime]
EndFunc   ;==>_GetTodaysDate