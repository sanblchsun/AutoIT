; AZJIO
; http://www.autoitscript.com/forum/topic/147373-inivirtual

#include <IniVirtual.au3>
$sPath = @ScriptDir & '\Sample.ini'
$s_ini_Text = FileRead($sPath)
$a_ini_Main2D = _IniVirtual_Initial($s_ini_Text)

$sText= _
'NewKey1=NewValue1' & @CRLF & _
'NewKey2=NewValue2'

; ������ ������ (�����)
_IniVirtual_WriteSection($a_ini_Main2D, 'Section6', $sText)

; ������ ���������� ������
$aRes = _IniVirtual_ReadSection($a_ini_Main2D, 'Section6')
_ArrayDisplay($aRes, '������ Section6')

; �������� ��� ����������
$s_ini_Text = _IniVirtual_Save($a_ini_Main2D)
MsgBox(0, '���������� ini-�����', $s_ini_Text)

; Global $aRes[3][2] = [[2], ['NewKey1', 'NewValue1'], ['NewKey2', 'NewValue2']]

; ������ ������ (�������), �� 2 �������
_IniVirtual_WriteSection($a_ini_Main2D, 'Section3', $aRes, 2)

; �������� ��� ����������
$s_ini_Text = _IniVirtual_Save($a_ini_Main2D)
MsgBox(0, '���������� ini-�����', $s_ini_Text)