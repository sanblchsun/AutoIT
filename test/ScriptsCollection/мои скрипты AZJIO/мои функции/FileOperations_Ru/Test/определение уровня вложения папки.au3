MsgBox(0, '������ ��� � ����� ������ ��� ������', '����� ������ �� ������� ��� ��������� ����')
Exit
; ������ ��� ����������� ����������� ����������� ������ �������� � ����� ����

; ���� �� ��������� ����� � ����� ����� � ���������� ���� ��������������� �������� �������, �� ��� ����� 22.txt ����������� � ��� ��������� �����

$name = 'C:\01234567891234'

; ������ ����
$file = FileOpen($name, 2)
FileWrite($file, 'text for test')
FileClose($file)

; ���������� ���� � ������� � 121 ������� ��������
If FileMove($name, 'C:\0\1\2\3\4\5\6\7\8\9\0\1\2\3\4\5\6\7\8\9\0\1\2\3\4\5\6\7\8\9\0\1\2\3\4\5\6\7\8\9\0\1\2\3\4\5\6\7\8\9\0\1\2\3\4\5\6\7\8\9\0\1\2\3\4\5\6\7\8\9\0\1\2\3\4\5\6\7\8\9\0\1\2\3\4\5\6\7\8\9\0\1\2\3\4\5\6\7\8\9\0\1\2\3\4\5\6\7\8\9\0\1\2\3\4\5\6\7\8\9\0\', 9) Then
	MsgBox(0, 'Message', '���, Yahoo, Yes')
Else
	MsgBox(0, 'Message', '���, No')
EndIf


; ��� � �������� "C:\0"  � ������� 119 � �� ������� ��� �����, � ��� ������ 120 �������. � ���� �� ���� ������ �� ����� (C:) �� �������� ������� 121.
; � ����� ������� 121 �������� ������������ ������� �� �������� ����� ������ �����. ������� ����� ����� �� ���� ������ ������� ������������. ��� ���� � ����� ���������� ����� ������� 14 ��������. ����� ���� 259 ��������