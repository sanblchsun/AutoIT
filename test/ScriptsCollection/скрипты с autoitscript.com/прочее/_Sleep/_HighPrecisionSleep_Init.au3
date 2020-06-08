Func _HighPrecisionSleep(ByRef $aSleep)
    DllCall($aSleep[0],"dword","ZwDelayExecution","int",0,"ptr",$aSleep[2])
EndFunc

Func _HighPrecisionSleep_Init($iMicroSeconds=0)
    Local $aSleep[3] = [DllOpen("ntdll.dll"),DllStructCreate("int64 time;")]
    $aSleep[2] = DllStructGetPtr($aSleep[1])
    DllStructSetData($aSleep[1],"time",-1*($iMicroSeconds*10))
    Return $aSleep
EndFunc

Func _HighPrecisionSleep_Set(ByRef $aSleep, $iMicroSeconds)
    DllStructSetData($aSleep[1],"time",-1*($iMicroSeconds*10))
EndFunc

Func _HighPrecisionSleep_UnInit(ByRef $aSleep)
    DllClose($aSleep[0])
    Dim $aSleep[3] = [0,0,0]
EndFunc

$Sleep = _HighPrecisionSleep_Init(10)

_HighPrecisionSleep($Sleep) ; sleep 10 microseconds

_HighPrecisionSleep_Set($Sleep,100)
_HighPrecisionSleep($Sleep) ; sleep 100 microseconds