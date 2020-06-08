#include <Constants.au3>
#include <Encoding.au3>

$iPID = Run(@ComSpec &' /C '& 'ipconfig.exe', @SystemDir, @SW_HIDE, $STDOUT_CHILD)
$sTXT = ""

While 1
    $sTXT &= StdoutRead($iPID)
    If @error Then ExitLoop
Wend

MsgBox(0,"", _Encoding_CyrillicTo1251($sTXT))


