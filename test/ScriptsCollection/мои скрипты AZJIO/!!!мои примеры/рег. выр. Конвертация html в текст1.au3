$filehtm=@ScriptDir&'\Name.htm'

If Not FileExists($filehtm) Then
	MsgBox(0, 'Сообщение', 'Требуется файл htm, указываем в скрипте')
	Exit
EndIf
$file = FileOpen($filehtm, 0)
$text = FileRead($file)
FileClose($file)

$text = StringRegExpReplace($text,'<script[^>]*?>.*?</script>', '')
$text = StringRegExpReplace($text,'<[\/\!]*?[^<>]*?>', @CRLF)
$text = StringRegExpReplace($text, '&quot;', '"')
$text = StringRegExpReplace($text, '&amp;', '&')
$text = StringRegExpReplace($text, '&lt;', '<')
$text = StringRegExpReplace($text, '&gt;', '>')
$text = StringRegExpReplace($text, '&nbsp;', ' ')
$text = StringRegExpReplace($text, '&iexcl;', '&#161;')
$text = StringRegExpReplace($text, '&cent;', '&#162;')
$text = StringRegExpReplace($text, '&pound;', '&#163;')
$text = StringRegExpReplace($text, '&copy;', '&#169;')

; Заменям цифровой код символа на сам символ
$a = StringRegExp($text, '&#(\d+);', 3)
If Not @error Then
	$log &= UBound($a) & '   &#(\d+);' & @CRLF
	$a = _ArrayUnique($a)
	For $i = 1 To $a[0]
		$a[$i] = Number($a[$i])
	Next
	_ArraySort($a, 1, 1)
	_ArrayDisplay($a, "Массив после сортировки по убыванию")
	For $i = 1 To $a[0]
		$text = StringReplace($text, '&#' & $a[$i] & ';', ChrW($a[$i]))
	Next
EndIf
$text = StringRegExpReplace($text,'([\r\n])[\s]+', @CRLF)

$file = FileOpen(@ScriptDir&'\Name.txt',2)
FileWrite($file, $text)
FileClose($file)