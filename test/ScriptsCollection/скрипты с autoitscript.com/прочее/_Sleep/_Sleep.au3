Global $dll_kernel32 = DllOpen('kernel32.dll')

$timer = TimerInit()
_Sleep(1)
; Sleep(1)
MsgBox(0, "����� ����������", '����� : ' & Round(TimerDiff($timer) , 2) & ' ����')

DllClose($dll_kernel32)

Func _Sleep($ms)
    DllCall($dll_kernel32, "DWORD", "Sleep", "int", $ms)
EndFunc