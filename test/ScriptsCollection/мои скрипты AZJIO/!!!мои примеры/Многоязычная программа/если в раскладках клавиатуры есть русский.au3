; ������� ���������, ��� ��� ����� ���������� ������������� ��� ������� � ���������� ���������� �����. �� ��������� ���� ����� �������������� � ���������� ��� �������� ��� ��� �����, �� �� ��� �� ��� ���� ����� ���� ������������.

; En
$LngAbout='About'
$LngVer='Version'

; Ru
; ���� ���� ������� � ���������� ����������, �� ������������ ���
For $i = 1 to 5
	$LngN = RegEnumVal("HKCU\Keyboard Layout\Preload", $i)
	If @error <> 0 Then ExitLoop
	If RegRead("HKCU\Keyboard Layout\Preload", $LngN) = 00000419 Then
		$LngAbout='� ���������'
		$LngVer='������'
		ExitLoop
	EndIf
Next