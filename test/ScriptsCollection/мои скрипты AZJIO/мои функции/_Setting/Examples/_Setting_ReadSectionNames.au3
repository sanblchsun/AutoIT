; AZJIO
; http://www.autoitscript.com/forum/topic/143315-setting-choice-of-storage-options-registry-or-ini-file/
#include <Array.au3> ; ��� _ArrayDisplay
#include <_Setting.au3>

; ������ �� �������
$TrReg = 1
$sPath = 'HKEY_CURRENT_USER\Software\AutoIt v3'
$Array = _Setting_ReadSectionNames($sPath, $TrReg)
_ArrayDisplay($Array, 'SectionNames')

; ������ �� ini-�����
$TrReg = 0
$sPath = @HomeDrive & '\Boot.ini'
$Array = _Setting_ReadSectionNames($sPath, $TrReg)
_ArrayDisplay($Array, 'SectionNames')