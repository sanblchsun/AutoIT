; AZJIO
; http://www.autoitscript.com/forum/topic/133224-filesearch-foldersearch/
#include <Array.au3> ; ��� _ArrayDisplay
#include <FileOperations.au3>

; ����� � �����
; i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!
; ����� � ����� � ����� �������� WINDOWS, ����� � ���� ���������
; $timer = TimerInit()
$List = _FO_FolderSearch(@WindowsDir & '\Web', '*', True, 0, 0, 0) & @CRLF & _FO_FileSearch(@WindowsDir & '\Web', '*', True, 0, 0, 0)
; $timer = Round(TimerDiff($timer) / 1000, 2) & ' ���'
MsgBox(0, '����� � �����', $List)
; i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!

; ��������� ������
; i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!
; ��� ����� � ����� WINDOWS � ���� �������
$timer = TimerInit()
$FolderList = _FO_FileSearch(@SystemDir, _FO_CorrectMask('|*.log|*.txt   ..|*.avi..  |||*.log|*.bmp|*.log'))
$timer = Round(TimerDiff($timer) / 1000, 2) & ' ���'
_ArrayDisplay($FolderList, $timer & ' - ��� �����')
; i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!
$FolderList = _FO_FileSearch(@SystemDir, _FO_CorrectMask('||||'))
If @error Then MsgBox(0, '���������', '@error=' & @error)
; i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!

MsgBox(0, '|*.log|*.txt   ..|*.avi..  |||*.log|*.bmp|*.log', _FO_CorrectMask('|*.log|*.txt   ..|*.avi..  |||*.log|*.bmp|*.log'))
MsgBox(0, '*.avi..  |*|*.log', _FO_CorrectMask('*.avi..  |*|*.log'))

$e = _FO_CorrectMask('|..|  ..  | |')
If @error Then MsgBox(0, '|..|  ..  | |', $e & ' - @error=' & @error)