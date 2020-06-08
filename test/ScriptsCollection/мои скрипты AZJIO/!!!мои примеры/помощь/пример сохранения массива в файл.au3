#include <Array.au3>

$a = StringRegExp('qwertyuiop[]asdfghjkl;zxcvbnmйцукенгшщзхъфывапролджэ\€чсмитьбю.1234567890','(.{3})',3)
Dim $b[UBound($a)][3]
For $i = 0 to UBound($b)-1
	$tmp = StringSplit($a[$i], '')
	$b[$i][0]=$tmp[1]
	$b[$i][1]=$tmp[2]
	$b[$i][2]=$tmp[3]
Next
_ArrayDisplay($b, 'массив сейчас')

; конвертируем массив в текст
; $sep1='#'
$sep1='}ЧХЧ{' ; разделитель не должен находитс€ в тексте/массиве
$sep2=@CRLF ; перенос строки в качестве разделител€ создаЄт читабельный текст
$L1=StringLen($sep1) ; определ€ем длинну разделител€ дл€ обрезки в конце строки
$L2=StringLen($sep2) ; определ€ем длинну разделител€ дл€ обрезки в конце текста
$txt='' ; нека€ переменна€, котора€ будет содержать готовые данные дл€ записи в файл
For $i = 0 to UBound($b)-1
	For $j = 0 to 2 ; число колонок нам известно - 3
		$txt&=$b[$i][$j]&$sep1 ; присоедин€ем очередную €чеку и $sep1 - разделитель
	Next
	$txt=StringTrimRight($txt, $L1) ; обрезаем конечный разделитель строки
	$txt&=$sep2 ; добавл€ем разделитель строки
Next
$txt=StringTrimRight($txt, $L2) ; обрезаем конечный разделитель

; записываем в файл
$file = FileOpen(@ScriptDir&'\file.txt',2)
FileWrite($file, $txt)
FileClose($file)

MsgBox(0, '—мотрим что получилось', $txt)

; !i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

; читаем файл
$text = FileRead(@ScriptDir&'\file.txt')
$aText = StringSplit($text, $sep2, 1)
; Dim $new[$aText[0]+1][3] =[[$aText[0]]] ; можно с количеством в первой €чейке
Dim $new[$aText[0]][3] ; объ€вл€ем массив по размеру прочитанного

For $i = 0 to $aText[0]-1
	$tmp = StringSplit($aText[$i+1], $sep1, 1)
	$new[$i][0]=$tmp[1]
	$new[$i][1]=$tmp[2]
	$new[$i][2]=$tmp[3]
Next
_ArrayDisplay($new, 'прочитаный массив')