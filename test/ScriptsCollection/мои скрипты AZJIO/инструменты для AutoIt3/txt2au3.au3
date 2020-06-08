;  @AZJIO
; обновления: добавлена защита от размера переменной более 4085 симолов, скорректированы переходы строк, замена апострофа ' в тексте двойным апострофом. Теперь результат является точной копией исходника.
; В эту версию добавлена ком-строка для работы с Notepad++. Выделенный текст легко передаётся скрипту в качестве ком-строки. Если возникнет проблема, то копируем его в буфер обмена и ничего не выделяя выполняем горячую клавишу назначенную скрипту в Notepad++, при этом в буфере происходит замена текста и можно ставлять его в окно редактора Notepad++ или SciTE.
;Правильная команда для Notepad++ все пути и "$(CURRENT_WORD)" обрамляются кавычками, иначе параметр воспринимается как множество параметров.
;"C:\Program Files\AutoIt3AutoIt3.exe" "C:\Program Files\AutoIt3\txt2au3.au3" "$(CURRENT_WORD)"

#NoTrayIcon
$bufer_read = 1 ; если 1 то читаем из буфера, если 0 то диалог выбора файла
$bufer_write = 1 ; если 1 то результат в буфер, если 0 то сохраняем в файл file_0.au3 в каталоге конвертора
$Msg_FW = 0 ; если 1 то в выходном скрите запись в файл, если 0 то выдача сообщения

If $CmdLine[0] <> 0 And $CmdLine[1] <> '' Then
	$text = $CmdLine[1]
Else
	If $bufer_read = 1 Then
		$text = ClipGet()
	Else
		$Path = FileOpenDialog("Выбор файла.", @WorkingDir & "", "Скрипт (*.*)", 1 + 4)
		If @error Then Exit
		$file = FileOpen($Path, 0)
		$text = FileRead($file)
		FileClose($file)
	EndIf
EndIf

;==============================
;кусок кода из UDF File.au3 для разделения образца построчно в массив
If StringInStr($text, @LF) Then
	$aFiletext = StringSplit(StringStripCR($text), @LF)
ElseIf StringInStr($text, @CR) Then ;; @LF does not exist so split on the @CR
	$aFiletext = StringSplit($text, @CR)
Else ;; unable to split the file
	If StringLen($text) Then
		Dim $aFiletext[2] = [1, $text]
	Else
		MsgBox(0, "Сообщение", "нет данных")
		Exit
	EndIf
EndIf
; подготовка переменной $text
$text = '$text= _' & @CRLF
; $Kol=1
$Kol2 = ''
$ostatok = ''
$Kol3 = ''
$Kol4 = 0
$trkol = 0
$trkol2 = 0
$Limit = 4070 ; лимит 4085, но лучше чуть меньше, так как в объеденяющей переменной не более 4084 ($text&=)
For $i = 1 To UBound($aFiletext) - 1
	$aFiletext[$i] = StringReplace($aFiletext[$i], "'", "''")
	; если в строке более 4084 символа, то разделить строку на объединяющие переменные ($text&=)
	If StringLen($aFiletext[$i]) > $Limit Then
		$trkol = 1
		$trkol2 = 1
		$text = StringTrimRight($text, 6) & @CRLF
		$Kol2 = StringLen($aFiletext[$i])
		$Kol4 += $Kol2
		$ostatok = Mod($Kol2, $Limit)
		$Kol3 = Int($Kol2 / $Limit)
		If $ostatok <> 0 Then $Kol3 += 1
		For $z = 1 To $Kol3
			If $z = $Kol3 Then
				$text &= '$text&= ' & '"' & StringMid($aFiletext[$i], 1) & '" & @CRLF & _' & @CRLF
			Else
				$text &= '$text&= ' & '"' & StringMid($aFiletext[$i], 1, $Limit) & '"' & @CRLF
				$aFiletext[$i] = StringTrimLeft($aFiletext[$i], $Limit)
			EndIf
		Next
	EndIf
	
	If $trkol2 = 1 Then
		$trkol2 = 0
		ContinueLoop
	EndIf
	
	; если в сумме коротких строк более 4084 символа, то разделить строку на объединяющие переменные ($text&=), в данном случае вставляем разделитель.
	; а также если сработал предыдущий участок "строка более 4084 символа"
	If StringLen($text) > $Limit + $Kol4 Or $trkol = 1 Then
		$trkol = 0
		$text = StringTrimRight($text, 6) & @CRLF & '$text&= _' & @CRLF
		$Kol4 = StringLen($text)
	EndIf
	
	If $aFiletext[$i] = '' Then
		$text &= '@CRLF & _' & @CRLF
	Else
		$text &= '''' & $aFiletext[$i] & ''' & @CRLF & _' & @CRLF
	EndIf
Next
$text = StringTrimRight($text, 14)
If StringRight($text, 3) = ' & ' Then $text = StringTrimRight($text, 3) ; если текст в конце с переходами строк, то дополнительная подрезка 3-х симовлов

If $Msg_FW = 0 Then
	$text &= @CRLF & 'MsgBox(0, "Сообщение", $text)'
Else
	$text &= @CRLF & '$file = FileOpen(@ScriptDir&"\file.txt",2)' & @CRLF & 'FileWrite($file, $text)' & @CRLF & 'FileClose($file)'
EndIf
;==============================

If $bufer_write = 1 Then
	ClipPut($text)
Else
	$filetxt = @ScriptDir & '\file_'
	$i = 0
	While FileExists($filetxt & $i & '.au3')
		$i = $i + 1
	WEnd
	$filetxt = $filetxt & $i & '.au3'

	$file = FileOpen($filetxt, 2)
	FileWrite($file, $text)
	FileClose($file)
EndIf