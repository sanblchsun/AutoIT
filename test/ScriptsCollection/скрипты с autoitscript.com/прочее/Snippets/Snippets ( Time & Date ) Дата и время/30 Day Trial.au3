; Author: MSLx Fanboy
; 30 Day Trial

#include <Date.au3>

#include <String.au3>

If RegRead("HKCU\Software\Microsoft\Windows\Current Version", "XPClean Menu") = "" Then
	RegWrite("HKCU\Software\Microsoft\Windows\Current Version", "XPClean Menu", "REG_SZ", _StringEncrypt(1, _NowCalc(), @ComputerName))
	SetError(0)
EndIf

$startdate = _StringEncrypt(0, RegRead("HKCU\Software\Microsoft\Windows\Current Version", "XPClean Menu"), @ComputerName)

If _DateDiff("D", $startdate, _NowCalc()) > 30 Then
	MsgBox(0, "*XPClean Menu*", "Your registration period has expired.")
	Exit
EndIf