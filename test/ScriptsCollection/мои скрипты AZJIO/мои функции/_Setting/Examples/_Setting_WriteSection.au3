; AZJIO
; http://www.autoitscript.com/forum/topic/143315-setting-choice-of-storage-options-registry-or-ini-file/
#include <_Setting.au3>

$TrReg = 1
$sPath = 'HKEY_CURRENT_USER\Software\MySoft'
$sData = "Key1=Value1" & @LF & "Key2=Value2" & @LF & "Key3=Value3"

_Setting_WriteSection($sPath, 'section', $sData, '', $TrReg) ; записываем

; Запись в реестр последнего раздела, чтобы просмотреть результаты
RegWrite('HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit',"LastKey","REG_SZ", $sPath)
RunWait('regedit.exe') ; смотрим в реестре
RegDelete($sPath) ; удаляем созданный раздел