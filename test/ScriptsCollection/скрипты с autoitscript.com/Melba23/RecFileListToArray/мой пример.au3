
#include <Array.au3>
#include "RecFileListToArray.au3"

$timer = TimerInit()
; ���� | ���������� | 1-������ ����� | 1- �������� (��������) | 1- ���������� | 1-������������� ���� | ��������� ����������

; $aArray = _RecFileListToArray('C:\WINDOWS\system32', "*", 2, 1, 0, 2) ;  ������ �����
; $aArray = _RecFileListToArray('C:\', "*", 1, 0, 0, 2) ;  ������ ����� � ����� ����� �
$aArray = _RecFileListToArray(@WindowsDir, "*", 1, 1, 0, 2) ;  ������ �����
$timer = Round(TimerDiff($timer) / 1000, 2) & ' ���'
_ArrayDisplay($aArray, $timer)

