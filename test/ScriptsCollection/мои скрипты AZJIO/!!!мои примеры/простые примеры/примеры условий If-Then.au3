Exit

; ������ ��� ��������

;!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

; ���������� �� ����������� �������
If $k = 8 Then
	If $z = 5 Then
		Exit
	EndIf
EndIf
; �������� �� ���� �������
If $k = 8 And $z = 5 Then
	Exit
EndIf
; ��� ������������� ��������� And ���� ������ �������� $k=8 ��������, �� ��������� ������� ($z=5 � ��.) �� �����������, ������� ����������� �������� ������������� ��������� ������, ���� � ����������� ������� ��������� ����������� ���������� ��������.

;!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

; ������� ���������������� ������� � ���������� �����������
If $k = 8 Then
	Exit
EndIf
If $z = 5 Then
	Exit
EndIf
; �������� �� ���� �������
If $k = 8 Or $z = 5 Then
	Exit
EndIf

;!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

; ������� ���������� ������� ����� ��������� ������� ���� ����������.
If ($k = 8 And $z = 5) Or ($f = 8 And Not $y = 5) Then
	MsgBox(0, '1', '��')
Else
	MsgBox(0, '0', '���')
EndIf
; ����� ������ ���������� ������� �������. ������� ����������� ��������� ������ � ��� �������� � ������ ����� ���� ��=1=True, ���� ���=0=False
; ��� ����� ����� 0 �������������� � ��=1=True, ������� ��� �������� ���������� ������ ����:
If $k <> 0 Then Exit
; �������� ��
If $k Then Exit

; ���������� �� ���������� ����������� - "������ ������"=���=0=False, "�� ������ ������"=��=1=True, ������� ��� ��������� ���������� ������ ����:
If $k <> '' Then Exit
; �������� ��
If $k Then Exit

; ���
If $k = '' Then Exit
; ����������
If Not $k Then Exit

;!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

; �������� �������������
; ����������� �������� ������� 1=1(�����, � ��������� 1) ��� 0=1(�� �����, � ��������� 0), �� ������� ���������� ������� FileExists ��� �������� ����������� ��������.
If FileExists($path) = 1 Then Exit
; �������� ��
If FileExists($path) Then Exit

; ����� ��������� �������, ������� ����� �������� �� "�� ���"="��" (�� ����"="����" � �������� �������)
If FileExists($path) = 0 Then Exit
; �������� ��
If Not FileExists($path) Then Exit

;!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

$l = '1'
$m = '5'

If Not ($l = "1" And $m = "5") And $l <> "" And $l <> "2" And $l <> "3" Then
	MsgBox(0, ' ', '������� 1 ������')
Else
	MsgBox(0, ' ', '������� 2 - �� ������')
EndIf

;!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

;��� ������������� ��������� � ������� ��������� ����� �� ��������� ���������
If Not ($k) Or (Not ($z = 4)) Then Exit

;!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

If $k = '' And $m = '' And $n = '' And $s = '' And $t = '' Then Exit
;�������� ��
If $k & $m & $n & $s & $t = '' Then Exit
;�������� ��
If Not ($k & $m & $n & $s & $t) Then Exit

;!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

If $k = '' Or $m = '' Or $n = '' Or $s = '' Or $t = '' Then Exit
;�������� ��
If Not ($k And $m And $n And $s And $t) Then Exit

;!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

If $k = 3 Or $k = 8 Or $k = 12 Or $k = 43 Or $k = 67 Then Exit
;�������� ��
Switch $k
	Case 3, 8, 12, 43, 67
		Exit
EndSwitch
; ������ ��������� ������� �������
