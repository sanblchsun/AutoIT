; AZJIO
; http://www.autoitscript.com/forum/topic/143315-setting-choice-of-storage-options-registry-or-ini-file/
#include <_Setting.au3>

$sPath = FileOpenDialog('Открыть', @DesktopDir, 'Конфигурационный (*.ini)', 8, 'MySoft.ini')
If @error Then Exit
If StringRight($sPath, 4) <> '.ini' Then $sPath &= '.ini'

$sKey = 'HKEY_CURRENT_USER\Software\AutoIt v3'
_Setting_MigrateRegToIni($sKey, $sPath)

RunWait('notepad.exe "' & $sPath & '"') ; смотрим в блокноте
FileDelete($sPath) ; удаляем ini-файл