#include-once

#include <Array.au3> ; _ArrayDisplay
#Include "_RegSearch.au3"

; ============================================================================================
$timer = TimerInit()
$Array=_RegSearchKey('*d*', 'HKEY_CURRENT_CONFIG', 0, 0)
; $Array = _RegSearchKey('*Schemes*')
If @error Then MsgBox(0, '���������', '������, @error = ' & @error)
MsgBox(0, '����� : ' & Round(TimerDiff($timer) / 1000, 2) & ' ���', $Array)
; _ArrayDisplay($Array, '����� : ' & Round(TimerDiff($timer) / 1000, 2) & ' ���')


$timer = TimerInit()
$Array=_RegSearchValueName('*JPG*', 'HKEY_CURRENT_USER', 0, 2)
; $Array=_RegSearchValueName('*JPG*', 'HKEY_CLASSES_ROOT', 0, 0)
; $Array = _RegSearchValueName('*Schemes*')
If @error Then MsgBox(0, '���������', '������, @error = ' & @error)
; MsgBox(0, '����� : ' & Round(TimerDiff($timer) / 1000, 2) & ' ���', $Array)
_ArrayDisplay($Array, '����� : ' & Round(TimerDiff($timer) / 1000, 2) & ' ���')


$timer = TimerInit()
$Array=_RegSearchValue('*JPG*', 'HKEY_USERS', 0, 2)
; $Array=_RegSearchValue('*JPG*', 'HKEY_CLASSES_ROOT', 0, 0)
; $Array = _RegSearchValue('*Schemes*')
If @error Then MsgBox(0, '���������', '������, @error = ' & @error)
; MsgBox(0, '����� : ' & Round(TimerDiff($timer) / 1000, 2) & ' ���', $Array)
_ArrayDisplay($Array, '����� : ' & Round(TimerDiff($timer) / 1000, 2) & ' ���')