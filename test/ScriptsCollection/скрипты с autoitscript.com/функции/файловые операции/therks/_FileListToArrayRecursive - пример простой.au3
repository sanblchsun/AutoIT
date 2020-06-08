#include <Array.au3>
#include <_FileListToArrayRecursive.au3>

$timer = TimerInit()
$aReadOnly = _FileListToArrayRecursive(@WindowsDir, '*', 1+4)
MsgBox(0,"Время выполнения", 'Время : '&Round(TimerDiff($timer) / 1000, 2) & ' сек')

_ArrayDisplay($aReadOnly)