; AZJIO
; http://www.autoitscript.com/forum/topic/143315-setting-choice-of-storage-options-registry-or-ini-file/
#include <_Setting.au3>

; Чтение из реестра
$TrReg = 1
$sPath = 'HKEY_CURRENT_USER\Software\AutoIt v3'
$sValue = _Setting_Read($sPath, 'Aut2Exe', 'LastIconDir', '', $TrReg)
MsgBox(0, 'Сообщение', $sValue)

; Чтение из ini-файла
$TrReg = 0
$sPath = @HomeDrive & '\Boot.ini'
$sValue = _Setting_Read($sPath, 'boot loader', 'default', '', $TrReg)
MsgBox(0, 'Сообщение', $sValue)