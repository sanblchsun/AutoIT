; AZJIO
; http://www.autoitscript.com/forum/topic/147373-inivirtual

#include <IniVirtual.au3>
$sPath = @ScriptDir & '\Sample.ini'
$s_ini_Text = FileRead($sPath)
$a_ini_Main2D = _IniVirtual_Initial($s_ini_Text)

; �������� ������
_IniVirtual_Delete($a_ini_Main2D, 'Section1')
_IniVirtual_Delete($a_ini_Main2D, 'Section2')

; ���������� � ��������� ������
$s_ini_Text = _IniVirtual_Save($a_ini_Main2D)
MsgBox(0, '���������� ini-�����', $s_ini_Text)