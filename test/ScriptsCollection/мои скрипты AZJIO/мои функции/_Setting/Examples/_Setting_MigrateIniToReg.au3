; AZJIO
; http://www.autoitscript.com/forum/topic/143315-setting-choice-of-storage-options-registry-or-ini-file/
#include <_Setting.au3>

$sPath = @HomeDrive & '\Boot.ini'
$sKey = 'HKEY_CURRENT_USER\Software\MySoft'
_Setting_MigrateIniToReg($sPath, $sKey)

; ������ � ������ ���������� �������, ����� ����������� ����������
RegWrite('HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit',"LastKey","REG_SZ", $sKey)
RunWait('regedit.exe') ; ������� � �������
RegDelete($sKey) ; ������� ��������� ������