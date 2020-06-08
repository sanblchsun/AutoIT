; Чтение сигнатуры AutoIt-файла. AU3!EA06. Для старых версий, ниже 3.2.12.1 может быть AU3!EA05, но ниже нет смысла использовать.
$hPath = @ScriptDir & '\AutoIt_Script.exe'
$hFile = FileOpen($hPath, 0)
FileSetPos($hFile, -8, 2) ; установка позиции с конца файла (2) назад -8 символов, чтобы прочитать их.
; FileSetPos($hFile, FileGetSize($hPath) - 8, 1) ; аналогичный вариант с использованием размера файла
$AU3EA = FileRead($hFile)
FileClose($hFile)
If $AU3EA = 'AU3!EA06' Then
	Run('"' & $hPath & '" /AutoIt3ExecuteLine "MsgBox(0, ""' & StringRegExpReplace($hPath, '(^.*)\\(.*)$', '\2') & ' (Ver. AutoIt3)"", @AutoItVersion)"')
Else
	MsgBox(0, 'Error', 'Error')
EndIf