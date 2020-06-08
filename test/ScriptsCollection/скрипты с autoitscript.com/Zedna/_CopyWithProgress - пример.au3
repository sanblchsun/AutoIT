#include "_CopyWithProgress.au3"

$n = _CopyWithProgress("C:\Program Files\Windows Media Player" & @LF & "C:\Program Files\Skype", "D:\st")
$n = _CopyWithProgress("C:\Program Files\Windows Media Player\setup_wm.exe", "D:\st")
$n = _CopyWithProgress("C:\Program Files\Windows Media Player\setup_wm.exe", "D:\st\wm.exe")
;~ If Not $n Then ConsoleWrite('error:' & @error & @CRLF)
; Возвращает True или False