; ��������� ������� � ���������� ���������������� ����� ���������� OS. ���������� � ������ ���� ������ ��� ��������� ���������� ������������ ������ ��� ��������� ���������� ������.

; En
$LngAbout='About'
$LngVer='Version'

; $UserIntLang=DllCall('kernel32.dll', 'int', 'GetUserDefaultUILanguage')
; If Not @error Then $UserIntLang=Hex($UserIntLang[0],4)

; Ru
; ���� ������� �����������, �� ������� ����
; If $UserIntLang = 0419 Then
If @OSLang = 0419 Then
	$LngAbout='� ���������'
	$LngVer='������'
EndIf

MsgBox(0, $LngAbout, $LngVer)