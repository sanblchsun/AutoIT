#include <Array.au3>
#include <_FileListToArrayRecursive.au3>

$timer = TimerInit()
$aReadOnly = _FileListToArrayRecursive(@WindowsDir, '*', 1+4)
MsgBox(0,"����� ����������", '����� : '&Round(TimerDiff($timer) / 1000, 2) & ' ���')

_ArrayDisplay($aReadOnly)