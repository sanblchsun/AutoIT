$hDll=DllOpen("ntdll.dll")

$init = TimerInit()
_HighPrecisionSleepUnsafe(1000000, $hDll)
ConsoleWrite( TimerDiff($init) )

Func _HighPrecisionSleepUnsafe($iMicroSeconds,$hDll)
    _HighPrecisionSleepRawUnsafe( -1*($iMicroSeconds*10), $hDll )
EndFunc

Func _HighPrecisionSleepRawUnsafe($iMicroSecondsRaw, $hDll)
    $hStruct=DllStructCreate("int64 time;")
    DllStructSetData($hStruct,"time",$iMicroSecondsRaw)
    DllCall($hDll,"dword","ZwDelayExecution","int",0,"ptr",DllStructGetPtr($hStruct))
EndFunc