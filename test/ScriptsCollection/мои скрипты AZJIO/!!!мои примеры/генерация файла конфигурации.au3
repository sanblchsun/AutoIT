Global $Ini = @ScriptDir&'\file.ini' ; ���� � file.ini
;�������� ������������� file.ini
If Not FileExists($Ini) And MsgBox(4, "�������� �����������", "������ ������� ����������� file.ini"&@CRLF&"��� ���������� �������� ����������?") = "6" Then
$inifile = FileOpen($Ini,2)
FileWrite($inifile, '[general]' & @CRLF & _
'notepad=notepad.exe' & @CRLF & _
'url1=http://google.ru' )
FileClose($inifile)
EndIf