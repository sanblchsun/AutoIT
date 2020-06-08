#include <Encoding.au3>

$sLog = ''
$hRun = Run(@ComSpec & " /C schtasks", "", @SW_HIDE, 2)
While 1
    $sLog &= StdoutRead($hRun)
    If @error Then ExitLoop
    Sleep(10)
WEnd
MsgBox(0, "", _Encoding_OEM2ANSI($sLog))