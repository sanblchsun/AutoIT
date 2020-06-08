; Author: GaryFrost
; User/System Idle Time

#include <Date.au3>
HotKeySet("{Esc}", "_Terminate")

Local $last_active = 0, $iHours, $iMins, $iSecs
Local $not_idle = _CheckIdle($last_active, 1)
While (1)
	Sleep(200)
	$not_idle = _CheckIdle($last_active)
	_TicksToTime($not_idle, $iHours, $iMins, $iSecs)
	If $iHours Or $iMins Or $iSecs Then
		ConsoleWrite("Was Idle for: Hours: " & $iHours & " Minutes: " & $iMins & " Seconds: " & $iSecs & @LF)
	EndIf
WEnd

Func _CheckIdle(ByRef $last_active, $start = 0)
	Local $struct = DllStructCreate("uint;dword");
	DllStructSetData($struct, 1, DllStructGetSize($struct));
	If $start Then
		DllCall("user32.dll", "int", "GetLastInputInfo", "ptr", DllStructGetPtr($struct))
		$last_active = DllStructGetData($struct, 2)
		Return $last_active
	Else
		DllCall("user32.dll", "int", "GetLastInputInfo", "ptr", DllStructGetPtr($struct))
		If $last_active <> DllStructGetData($struct, 2) Then
			Local $save = $last_active
			$last_active = DllStructGetData($struct, 2)
			Return $last_active - $save
		EndIf
	EndIf
EndFunc   ;==>_CheckIdle

Func _Terminate()
	Exit
EndFunc   ;==>_Terminate