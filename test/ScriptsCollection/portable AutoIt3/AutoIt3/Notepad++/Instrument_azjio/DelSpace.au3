;  @AZJIO
; предназначен для удаления пробелов в скриптах скопированных в сообщениях форума ru-board
; ставим на горячую клавишу в Notepad++ и при копировании одним движением выполняем преобразование в буфере и вставляем в Notepad++ уже исправленным.
;"C:\Program Files\AutoIt3\AutoIt3.exe" "C:\Program Files\AutoIt3\DelSpace.au3" - команда для Notepad++

$bufer_read=1 ; если 1 то читаем из буфера, если 0 то диалог выбора файла
$bufer_write=1 ; если 1 то результат в буфер, если 0 то сохраняем в файл file_0.au3 в каталоге конвертора

If $bufer_read=1 Then
$text = ClipGet()
Else
$Path = FileOpenDialog("Выбор файла.", @WorkingDir & "", "Скрипт (*.au3)", 1 + 4 )
$file = FileOpen($Path, 0)
$text= FileRead($file)
FileClose($file)
EndIf

$text = StringRegExpReplace($text&@CRLF, "[ ]+\r\n", @CRLF) ; удаление пробелов в конце строк

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