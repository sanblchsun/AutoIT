;  @AZJIO

#Include<Array.au3>
$bufer_read = 0 ; если 1 то читаем из буфера, если 0 то диалог выбора файла
$bufer_write = 0 ; если 1 то результат в буфер, если 0 то сохраняем в файл file_0.txt в каталоге конвертора
Global $text, $Info_Edit1

If $bufer_read = 1 Then
	$text = ClipGet()
Else
	$Path = FileOpenDialog("Выбор файла.", @WorkingDir & "", "Журнал (*.log)", 1 + 4)
	$file = FileOpen($Path, 0)
	$text = FileRead($file)
	FileClose($file)
EndIf
$text=_ReadAU3($text)


	$pos = 30

$Main_Gui = GUICreate("IP", 150, $pos * 17 + 90, -1, -1, 786432, 0x00000010)
$CatchDrop = GUICtrlCreateLabel("", 0, 0, 150, $pos * 17 + 120)
GUICtrlSetState(-1, 128 + 8)
$Info_Edit1 = GUICtrlCreateEdit($text, 8, 10, 134, $pos * 17 + 40)
;GUICtrlSetData(-1, $text)
;GUICtrlSetResizing(-1, 1)
GUICtrlSetResizing(-1, 102+256)

GUISetState()

Send('^{HOME}')

While 1
	Sleep(10)
	$msg = GUIGetMsg()
	Select
		Case $msg = -13
			$file = FileOpen(@GUI_DragFile, 0)
			$text = FileRead($file)
			FileClose($file)
			_ReadAU3($text)
		Case $msg = -3
			Exit
	EndSelect
WEnd
;=====================================

If $bufer_write = 1 Then
	ClipPut($text)
Else
	$filetxt = @ScriptDir & '\file_'
	$i = 0
	While FileExists($filetxt & $i & '.txt')
		$i = $i + 1
	WEnd
	$filetxt = $filetxt & $i & '.txt'

	$file = FileOpen($filetxt, 2)
	FileWrite($file, $text)
	FileClose($file)
EndIf


Func _ReadAU3($text)
$aIP=StringRegExp($text,'\d{2,3}\.\d{2,3}\.\d{1,3}\.\d{1,3}',3)
$text = ''
_ArraySort($aIP) ; сортировка массива

For $i = 1 to UBound($aIP) - 1
	$text &= $aIP[$i]&@CRLF
Next


	For $i = 1 To UBound($aIP) - 1
		$text = StringRegExpReplace($text, StringRegExpReplace($aIP[$i], "[][{}()*+?.\\^$|=<>#]", "\\$0") & @CRLF, @CRLF)
		If @extended > 0 Then $text &= @CRLF & $aIP[$i] ; добавляем удалённые переменные в конец списка, такой сбособ исключит повтора переменных в списке $text
	Next
	$text = StringRegExpReplace($text, '(\n\r)+', '') ;удаление пустых строк
	GUICtrlSetData($Info_Edit1, $text)
	Return $text
EndFunc   ;==>_ReadAU3


