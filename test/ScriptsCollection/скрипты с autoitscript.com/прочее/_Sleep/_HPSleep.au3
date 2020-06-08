Func _HPSleep($iSleep, $fMs = 1)
    ; default is milliseconds, otherwise microseconds (1 ms = 1000 µs)
    If $fMs Then $iSleep *= 1000 ; convert to ms
    DllCall("ntdll.dll", "dword", "NtDelayExecution", "int", 0, "int64*", -10 * $iSleep)
EndFunc

Sleep(1000) ; more accurate results
For $i = 1 To 10
    $timer = TimerInit()
    _HPSleep(1) ; 1 ms
    ConsoleWrite(TimerDiff($timer) & @CRLF)
Next

; pretty good
$timer = TimerInit()
For $i = 1 To 100
    _HPSleep(10) ; 10 ms
Next
ConsoleWrite(TimerDiff($timer) & @CRLF)
; i got 999.876225456811

; still pretty good
$timer = TimerInit()
For $i = 1 To 100
    _HPSleep(1) ; 1 ms
Next
ConsoleWrite(TimerDiff($timer) & @CRLF)
; i got 99.9358030598962

; i think we hit an AutoIt limit at 1ms of sleep
$timer = TimerInit()
For $i = 1 To 100
    _HPSleep(100, 0) ; 100 microsec = 0.1 ms
Next
ConsoleWrite(TimerDiff($timer) & @CRLF)
; i got 99.962453081157