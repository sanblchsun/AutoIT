; AZJIO
; http://www.autoitscript.com/forum/topic/147373-inivirtual

#include <IniVirtual.au3>
$sPath = @ScriptDir & '\Sample.ini'
$s_ini_Text = FileRead($sPath)
$a_ini_Main2D = _IniVirtual_Initial($s_ini_Text)

$sBefore = _IniVirtual_Read($a_ini_Main2D, 'Section3', 'p[ar;am', "�������� �� ���������, ���� �� �������")
$Res = _IniVirtual_Write($a_ini_Main2D, 'Section3', 'p[ar;am', ' --- New Value --- ')
$After = _IniVirtual_Read($a_ini_Main2D, 'Section3', 'p[ar;am', "�������� �� ���������, ���� �� �������")

MsgBox(0, '��������, �� � �����', $sBefore & @LF & $After)

$s_ini_Text = _IniVirtual_Save($a_ini_Main2D)
MsgBox(0, '���������� ini-�����', $s_ini_Text)