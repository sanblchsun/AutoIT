#include "MsgBox.au3"

$MB_MESSAGEBEEP = 1
$MB_TIMEOUTCOUNT = 1

$nFlags = BitOR($MB_TOPMOST, $MB_SYSTEMMODAL, $MB_DEFBUTTON1, $MB_ICONASTERISK, $MB_YESNO)
$sTitle = "My Custom MsgBox"
$sText = "Are you sure?"
$iTimeOut = 2
$hWnd = WinGetHandle("")

$Ask = MsgBox($nFlags, $sTitle, $sText, $iTimeOut, $hWnd)
ConsoleWrite(StringFormat("+ Return: %i\n! TimedOut: %s\n", $Ask, $Ask = -1))

$Ask = _MsgBoxEx($nFlags, $sTitle, $sText, $iTimeOut, $hWnd)
ConsoleWrite(StringFormat("+ Return: %i\n! TimedOut: %s\n", $Ask, @extended = 1))