; AZJIO
; http://www.autoitscript.com/forum/topic/133224-filesearch-foldersearch/
#include <Array.au3> ; ��� _ArrayDisplay
#include <FileOperations.au3>

; �����
; i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!
; ��� ����� ����� WINDOWS � ���� �������
$timer = TimerInit()
$FileList = _FO_FileSearch(@WindowsDir)
$timer = Round(TimerDiff($timer) / 1000, 2) & ' ���'
_ArrayDisplay($FileList, $timer & ' - ��� �����')
; i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!
; ������ ����� exe � dll ����� WINDOWS � ���� ������
$timer = TimerInit()
$FileList = _FO_FileSearch(@WindowsDir, 'exe|dll', True, 0, 1, 0, 0)
$timer = Round(TimerDiff($timer) / 1000, 2) & ' ���'
MsgBox(0, $timer & ' - exe;dll', $FileList)
; i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!
; ��� �����, ����� exe � dll ����� WINDOWS � ���� ������ � �������������� ������
$timer = TimerInit()
$FileList = _FO_FileSearch(@WindowsDir, 'exe|dll', False, 0, 0, 0, 0)
$timer = Round(TimerDiff($timer) / 1000, 2) & ' ���'
MsgBox(0, $timer & ' - ����� exe|dll, �������. ����', $FileList)
; i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!
; ��� �����, ����� exe � dll ����� WINDOWS � ���� ������ � ������� ������ ��� ����������
$timer = TimerInit()
$FileList = _FO_FileSearch(@WindowsDir, 'exe|dll', False, 0, 3, 0, 0)
$timer = Round(TimerDiff($timer) / 1000, 2) & ' ���'
MsgBox(0, $timer & ' - ����� exe|dll, ��� ��� ����������', $FileList)
; i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!
; ������ ����� tmp � bak � gid ����� WINDOWS � ���� ������� � �������������� ������, ������ ��� �������� ���������� ������
$timer = TimerInit()
$FileList = _FO_FileSearch(@WindowsDir, 'tmp|bak|gid', True, 125, 0, 2)
$timer = Round(TimerDiff($timer) / 1000, 2) & ' ���'
_ArrayDisplay($FileList, $timer & ' - tmp|bak|gid, �������. ����, ������ ��. ����')
; i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!
; ������ ����� tmp � bak � gid ����� WINDOWS � ���� ������� � ������� ������ c ����������
$timer = TimerInit()
$FileList = _FO_FileSearch(@WindowsDir, 'tmp|bak|gid', True, 125, 2)
$timer = Round(TimerDiff($timer) / 1000, 2) & ' ���'
_ArrayDisplay($FileList, $timer & ' - tmp|bak|gid, ����� � �����������')
; i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!
; ������������ ������ � ����
$FileList = _FO_FileSearch('C:\WIN>DOWS', '*')
If @error Then
	MsgBox(0, '������', '��� ������: ' & @error)
	; Exit
EndIf
; i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!
; ������ ����� �� ����� *.is?|s*.cp* ����� WINDOWS � ���� �������
$timer = TimerInit()
$FileList = _FO_FileSearch(@WindowsDir, '*.is?|s*.cp*')
$timer = Round(TimerDiff($timer) / 1000, 2) & ' ���'
_ArrayDisplay($FileList, $timer & ' - *.is?|s*.cp*')
; i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!
; ������ ����� �� ����� shell*.*;config.* ����� WINDOWS � ���� �������
$timer = TimerInit()
$FileList = _FO_FileSearch(@WindowsDir, 'shell*.*|config.*')
$timer = Round(TimerDiff($timer) / 1000, 2) & ' ���'
_ArrayDisplay($FileList, $timer & ' - shell*.*|config.*')
; i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!
; ������ ����� exe � dll ����� WINDOWS � ������ � ������� ����������� ���������
$timer = TimerInit()
$FileList = _FO_FileSearch(@WindowsDir, '*', True, 125, 1, 0)
$FileList = StringRegExp($FileList, '(?mi)^(.*\.(?:exe|dll))(?:\r|\z)', 3)
$timer = Round(TimerDiff($timer) / 1000, 2) & ' sec'
_ArrayDisplay($FileList, UBound($FileList) & ' - ' & $timer & ' - RegExp (�����)')
; i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!