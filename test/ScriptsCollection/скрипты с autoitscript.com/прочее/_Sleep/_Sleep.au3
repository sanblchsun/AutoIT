Global $dll_kernel32 = DllOpen('kernel32.dll')

$timer = TimerInit()
_Sleep(1)
; Sleep(1)
MsgBox(0, "Время выполнения", 'Время : ' & Round(TimerDiff($timer) , 2) & ' мсек')

DllClose($dll_kernel32)

Func _Sleep($ms)
    DllCall($dll_kernel32, "DWORD", "Sleep", "int", $ms)
EndFunc