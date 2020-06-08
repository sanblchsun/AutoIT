; Author: Holger
; Timer To "Thousandths" Of A Second

While 1
	ToolTip(@HOUR & ':' & @MIN & ':' & @SEC & ':' & _MSec())
	Sleep(1)
WEnd

Exit

Func _MSec()
	Local $stSystemTime = DllStructCreate('ushort;ushort;ushort;ushort;ushort;ushort;ushort;ushort')
	DllCall('kernel32.dll', 'none', 'GetSystemTime', 'ptr', DllStructGetPtr($stSystemTime))
	Local $sMilliSeconds = StringFormat('%03d', DllStructGetData($stSystemTime, 8))
	$stSystemTime = 0
	Return $sMilliSeconds
EndFunc   ;==>_MSec