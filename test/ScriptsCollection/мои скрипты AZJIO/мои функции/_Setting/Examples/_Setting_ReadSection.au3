; AZJIO
; http://www.autoitscript.com/forum/topic/143315-setting-choice-of-storage-options-registry-or-ini-file/
#include <Array.au3> ; для _ArrayDisplay
#include <_Setting.au3>

; Чтение из реестра
$TrReg = 1
$sPath = 'HKEY_CURRENT_USER\Software\AutoIt v3'
$Array = _Setting_ReadSection($sPath, 'AU3Info', $TrReg)
_ArrayDisplay($Array, 'ReadSection')

; Чтение из ini-файла
$TrReg = 0
$sPath = @HomeDrive & '\Boot.ini'
$Array = _Setting_ReadSection($sPath, 'boot loader', $TrReg)
_ArrayDisplay($Array, 'SectionNames')