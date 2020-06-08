
; Вариант 1 неидеален, только для 0 и 1
MsgBox(0, 'Message', '1 vs 1 = '&BitXOR(1, 1)&@CRLF& '0 vs 1 = '&BitXOR(0, 1))


; Вариант 2 - идеален, для чисел более 1 и менее -1
$rezyltat=''
For $i = 1 to 10
	$z=$i-5
	$rezyltat&=$z&' - '&Number(Not ($z))&@CRLF
Next
$rezyltat&=@CRLF&'Инвертирование для текста (первый - пустая строка,'&@CRLF&'последние два числа как строковые переменые.)'&@CRLF&@CRLF
$text=StringSplit('|текст|0|1', '|')
For $i = 1 to $text[0]
	$rezyltat&=$text[$i]&' - '&Number(Not ($text[$i]))&@CRLF
Next

MsgBox(0, '', 'Результат инвертирования'&@CRLF&'для указанных чисел'&@CRLF&@CRLF&$rezyltat)