; AZJIO
; http://www.autoitscript.com/forum/topic/133224-filesearch-foldersearch/
#include <Array.au3> ; ��� _ArrayDisplay
#include <FileOperations.au3>

; �����
; i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!
; ��� ����� � ����� WINDOWS � ���� �������
$timer = TimerInit()
$FolderList = _FO_FolderSearch(@SystemDir, '', True, 125)
$timer = Round(TimerDiff($timer) / 1000, 2) & ' ���'
_ArrayDisplay($FolderList, $timer & ' - ��� �����')
; i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!
; ��� ����� � ����� WINDOWS � ���� �������, ������������� ����, ������� 1
$timer = TimerInit()
$FolderList = _FO_FolderSearch(@SystemDir, '*', True, 1, 0)
$timer = Round(TimerDiff($timer) / 1000, 2) & ' ���'
_ArrayDisplay($FolderList, $timer & ' - ��� �����')
; i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!
; �������� ����� � ����� WINDOWS � ���� ���������
$timer = TimerInit()
$FolderList = _FO_FolderSearch(@UserProfileDir, '*', True, 0, 0, 0)
$timer = Round(TimerDiff($timer) / 1000, 2) & ' ���'
MsgBox(0, $timer & ' - ������������� ����', $FolderList)
; i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!