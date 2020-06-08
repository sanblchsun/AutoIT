Global $Ini = @ScriptDir&'\file.ini' ; путь к file.ini
;Проверка существования file.ini
If Not FileExists($Ini) And MsgBox(4, "Выгодное предложение", "Хотите создать необходимый file.ini"&@CRLF&"для сохранения вводимых параметров?") = "6" Then
$inifile = FileOpen($Ini,2)
FileWrite($inifile, '[general]' & @CRLF & _
'notepad=notepad.exe' & @CRLF & _
'url1=http://google.ru' )
FileClose($inifile)
EndIf