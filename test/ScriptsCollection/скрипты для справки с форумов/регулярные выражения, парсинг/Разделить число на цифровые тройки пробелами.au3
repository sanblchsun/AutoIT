$timer = TimerInit()
$n2=''
$n1=''
For $i = 1 to 30
	$n2&=$i
	$n1 &=StringRegExpReplace($n2, '(\A\d{1,3}(?=(\d{3})+\z)|\d{3}(?=\d))', '\1 ')&@CRLF ; dwerf (71 мсек)
	; $n1 &=StringRegExpReplace($n2, '(^\d{1,3}(?=(\d{3})+$)|\d{3}(?=\d))', '\1 ')&@CRLF ; dwerf, с заменой границ на ^ и $
	; $n1 &=StringRegExpReplace($n2, '(^\d+?(?=(?>(?:\d{3})+)(?!\d))|\G\d{3}(?=\d))', '\1 ')&@CRLF ; (84 мсек)
	; $n1 &=StringRegExpReplace($n2, '(?!^\d{3})(\d{3})(?=(\d{3})*$)', ' \1')&@CRLF ; мой вариант (265 мсек)
	; $n1 &=StringRegExpReplace($n2, '(?<=\d)(?=(\d{3})+\z)', ' ')&@CRLF ; в книге Дж.Фридла (860 мсек)
	; $n1 &=StringRegExpReplace($n2, '(?<=\d)(?=(\d{3})+(?!\d))', ' ')&@CRLF ; (1000 мсек) http://ru2.php.net/manual/ru/function.number-format.php
	; $n1 &=StringRegExpReplace($n2, '(\d)\s?(\d?)\s?(\d?)(?=((\d\s?){3})*\z)', "\1\2\3 ")&@CRLF ; (927 мсек)
	; $n1 &=StringRegExpReplace($n2, '(\d{3}(?=\d)|^\d{1,3}(?=(\d{3})+$))', '\1 ')&@CRLF ; нерабочий вариант, попытка ускорить сменой условий у dwerf .
Next
MsgBox(0, 'Message', $n1 &@CRLF&Round(TimerDiff($timer), 2)&' мсек') ; установите цикл 30 (просмотр валидности)
; MsgBox(0, 'Message', Round(TimerDiff($timer), 2)&' мсек') ; установите цикл 300 (тест скорости)