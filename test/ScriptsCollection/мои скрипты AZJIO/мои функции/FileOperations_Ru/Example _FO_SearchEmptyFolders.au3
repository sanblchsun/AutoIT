; AZJIO
; http://www.autoitscript.com/forum/topic/133224-filesearch-foldersearch/
#include <Array.au3> ; ��� _ArrayDisplay
#include <FileOperations.au3>

; i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!
; ����� ������ ����� � ����� WINDOWS � ���� ������
$timer = TimerInit()
$FolderList = _FO_SearchEmptyFolders(@UserProfileDir, 0, 0)
MsgBox(0, '����� : ' & Round(TimerDiff($timer) / 1000, 2) & ' ���', $FolderList)
; i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!
; ����� ������ ����� � ����� WINDOWS � ������
$timer = TimerInit()
$FolderList = _FO_SearchEmptyFolders(@WindowsDir)
_ArrayDisplay($FolderList, '����� : ' & Round(TimerDiff($timer) / 1000, 2) & ' ���')
; i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!