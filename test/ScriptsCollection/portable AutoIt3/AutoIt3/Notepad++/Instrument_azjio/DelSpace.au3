;  @AZJIO
; ������������ ��� �������� �������� � �������� ������������� � ���������� ������ ru-board
; ������ �� ������� ������� � Notepad++ � ��� ����������� ����� ��������� ��������� �������������� � ������ � ��������� � Notepad++ ��� ������������.
;"C:\Program Files\AutoIt3\AutoIt3.exe" "C:\Program Files\AutoIt3\DelSpace.au3" - ������� ��� Notepad++

$bufer_read=1 ; ���� 1 �� ������ �� ������, ���� 0 �� ������ ������ �����
$bufer_write=1 ; ���� 1 �� ��������� � �����, ���� 0 �� ��������� � ���� file_0.au3 � �������� ����������

If $bufer_read=1 Then
$text = ClipGet()
Else
$Path = FileOpenDialog("����� �����.", @WorkingDir & "", "������ (*.au3)", 1 + 4 )
$file = FileOpen($Path, 0)
$text= FileRead($file)
FileClose($file)
EndIf

$text = StringRegExpReplace($text&@CRLF, "[ ]+\r\n", @CRLF) ; �������� �������� � ����� �����

If $bufer_write=1 Then
ClipPut ( $text )
Else
$filetxt=@ScriptDir&'\file_'
$i = 0
While FileExists($filetxt&$i&'.au3')
    $i = $i + 1
WEnd
$filetxt=$filetxt&$i&'.au3'

$file = FileOpen($filetxt ,2)
FileWrite($file, $text)
FileClose($file)
EndIf