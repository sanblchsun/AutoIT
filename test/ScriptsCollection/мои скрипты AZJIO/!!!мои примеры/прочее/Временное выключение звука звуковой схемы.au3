
;������ ��������� ���������
MsgBox(48, '���������', '������, ���� ������������')

;���������� ����� �����������
$SoundName=RegRead("HKCU\AppEvents\Schemes\Apps\.Default\SystemExclamation\.Current",'')
RegWrite("HKCU\AppEvents\Schemes\Apps\.Default\SystemExclamation\.Current",'',"REG_SZ",'')
;~~~~
;���������� ��������� � �������� ���������� ��������
MsgBox(48, '���������', '����� ���'&@CRLF&$SoundName)
;~~~~
; �������������� ����� �����������
RegWrite("HKCU\AppEvents\Schemes\Apps\.Default\SystemExclamation\.Current","","REG_SZ",$SoundName)
MsgBox(48, '���������', '�����, ���� ����������')