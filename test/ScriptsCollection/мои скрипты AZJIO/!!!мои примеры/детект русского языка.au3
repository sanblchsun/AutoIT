


; �������1 - ���� ������� �����������, �� ������� ����
; �� ��������, ���� ���������� ������ � ������������� MUI-�������.
If @OSLang = 0419 Then
	; ����� �������� ����������
	$LngTitle='��� ���������'
		MsgBox(0, '���������', '� ��� ������� ����������� Windows')
EndIf


; �������2 - �������� �������, ���� ���� �� 5 ������������� �������� ��������� �������.
For $i = 1 to 5
	$LngN = RegEnumVal("HKCU\Keyboard Layout\Preload", $i)
	If @error Then ExitLoop
	If RegRead("HKCU\Keyboard Layout\Preload", $LngN) = 00000419 Then
		; ����� �������� ����������
		$LngTitle='��� ���������'
		MsgBox(0, '���������', '� ��� ������� ���� ������������ � ����������')
		ExitLoop
	EndIf
Next