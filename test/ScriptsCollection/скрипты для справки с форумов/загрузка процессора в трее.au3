; _CPU_IdleClock_Update взята из скрипта "FTP Explorer" от Beege и модифицирована AZJIO для вывода иконки в трее.

#include <Date.au3>
#include <GuiStatusBar.au3>
Global $Kernel32 = DllOpen('kernel32.dll'), $TmpCPU
AdlibRegister('_CPU_IdleClock_Update', 1000)
TraySetIcon('taskmgr.exe', -3)
TrayTip("Загрузка процессора", 'CPU: 0%', 1)

While 1
	Sleep(100000000)
WEnd

Func _CPU_IdleClock_Update()
	Static $StartTimes[2], $EndTimes[2], $bFirstRun = True
	Static $CPU_Kernel = DllStructCreate($tagFileTime), $CPU_User = DllStructCreate($tagFileTime), $CPU_Idle = DllStructCreate($tagFileTime)
	Static $pCPU_Kernel = DllStructGetPtr($CPU_Kernel), $pCPU_User = DllStructGetPtr($CPU_User), $pCPU_Idle = DllStructGetPtr($CPU_Idle)

	DllCall($Kernel32, "int", "GetSystemTimes", "ptr", $pCPU_Idle, "ptr", $pCPU_Kernel, "ptr", $pCPU_User)
	$EndTimes[0] = (DllStructGetData($CPU_Kernel, 1) + DllStructGetData($CPU_User, 1)); Kerneltime + UserTime
	$EndTimes[1] = DllStructGetData($CPU_Idle, 1);IdleTime

	If $bFirstRun Then
		$StartTimes = $EndTimes
		$bFirstRun = False
		Return
	EndIf

	Local $Idle_Time = $EndTimes[1] - $StartTimes[1]
	If $Idle_Time > 0 Then ; Every once in a while idle time will be negative because the 32bit value gets to high and goes back to zero causing starttime to be bigger then endtime
		Local $Total_Time = $EndTimes[0] - $StartTimes[0]
		Local $CPU_ico = Round((($Total_Time - $Idle_Time) / $Total_Time) * 11)
		Local $CPU_Percent = (($Total_Time - $Idle_Time) / $Total_Time) * 100
		$CPU_Percent = StringFormat('CPU: %.1f%%', $CPU_Percent)
		If $TmpCPU <> $CPU_Percent Then
			TrayTip("Загрузка процессора", $CPU_Percent, 1)
			TraySetIcon('taskmgr.exe', -3-$CPU_ico)
			$TmpCPU = $CPU_Percent
		EndIf
	EndIf
	$StartTimes = $EndTimes
EndFunc