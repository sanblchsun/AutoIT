; AZJIO
; http://www.autoitscript.com/forum/topic/143315-setting-choice-of-storage-options-registry-or-ini-file/
#include <_Setting.au3>

$TrReg = 1
$sPath = 'HKEY_CURRENT_USER\Software\MySoft'

_Setting_Write($sPath, 'section', 'key', 'value', $TrReg) ; ����������
MsgBox(0, '���������', _Setting_Read($sPath, 'section', 'key', '', $TrReg)) ; ������
RegDelete($sPath) ; ������� ��������� ������