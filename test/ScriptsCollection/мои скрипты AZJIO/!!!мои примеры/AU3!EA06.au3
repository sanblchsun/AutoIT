; ������ ��������� AutoIt-�����. AU3!EA06. ��� ������ ������, ���� 3.2.12.1 ����� ���� AU3!EA05, �� ���� ��� ������ ������������.
$hPath = @ScriptDir & '\AutoIt_Script.exe'
$hFile = FileOpen($hPath, 0)
FileSetPos($hFile, -8, 2) ; ��������� ������� � ����� ����� (2) ����� -8 ��������, ����� ��������� ��.
; FileSetPos($hFile, FileGetSize($hPath) - 8, 1) ; ����������� ������� � �������������� ������� �����
$AU3EA = FileRead($hFile)
FileClose($hFile)
If $AU3EA = 'AU3!EA06' Then
	Run('"' & $hPath & '" /AutoIt3ExecuteLine "MsgBox(0, ""' & StringRegExpReplace($hPath, '(^.*)\\(.*)$', '\2') & ' (Ver. AutoIt3)"", @AutoItVersion)"')
Else
	MsgBox(0, 'Error', 'Error')
EndIf