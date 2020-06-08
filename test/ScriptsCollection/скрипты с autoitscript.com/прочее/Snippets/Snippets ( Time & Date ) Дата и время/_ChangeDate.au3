; Author: guinness
#include <Date.au3>

_ChangeDate(@YEAR, @MON, @MDAY)

Func _ChangeDate($iYear, $iMon, $iDay)
	Local $sDate = _DateTimeFormat($iDay & "/" & $iMon & "/" & $iYear, 2)
	RunWait(@ComSpec & " /c Date " & $sDate, "", @SW_HIDE)
	Return $sDate
EndFunc   ;==>_ChangeDate