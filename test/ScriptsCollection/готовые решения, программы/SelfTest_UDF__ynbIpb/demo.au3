#include <SelfTest_UDF.au3>
If @compiled = 0 Then 
	MsgBox (0, "", "������ �� ��������������!")
	Exit
EndIf
$sPassword = "1" ; ������ ���������� XXTEA
$iSelftestResult = _SelfTest ($sPassword) ; ��������� ���� �����������
If $iSelftestResult = 0 Then MsgBox (0, "", "���� ��������!" & @CRLF & $iSelftestResult)
If $iSelftestResult = 1 Then MsgBox (0, "", "�������� ������ �������!" & @CRLF & $iSelftestResult)
If $iSelftestResult = 2 Then MsgBox (0, "", "���� �� �������� ���������� ��� ��������!" & @CRLF & $iSelftestResult)
