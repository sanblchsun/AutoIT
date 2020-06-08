#include '_RSA_crypt.au3'

Opt('MustDeclareVars', 1)

;Эти функции можно использовать не только для RSA-шифрования, но и для других целей.
;(в скомпилированном виде работает быстрее)
Global $iPrime, $iNumNoPrime, $iNumPrime, $iNum_1, $iNum_2, $iNum_3, $iStart, $sTime

;#cs
;генерируем простое число заданной длины от 2 до 12:
For $i = 2 To 12
	$iStart = TimerInit()
	$iPrime = _RSA_Generate_Prime($i)
	$sTime = StringFormat('%.2f ms', TimerDiff($iStart))
	MsgBox(64, 'Знаков: ' & $i, 'Простое число: ' & $iPrime & @LF & $sTime)
Next
;#ce

;#cs
;генерируем 10 простых чисел случайной (от 2 до 8) длины:
For $i = 1 To 10
	$iStart = TimerInit()
	$iPrime = _RSA_Generate_Prime()
	$sTime = StringFormat('%.2f ms', TimerDiff($iStart))
	MsgBox(64, $i & '. Знаков: 2-8', 'Простое число: ' & $iPrime & @LF & $sTime)
Next
;#ce

;#cs
;проверка чисел на простоту:
$iNumNoPrime = 123456789 ;составное число
$iNumPrime = 558678719;простое число
MsgBox(64, 'Простое', $iNumNoPrime & @LF & 'Простое число: ' & _RSA_IsPrime($iNumNoPrime))
MsgBox(64, 'Простое', $iNumPrime & @LF & 'Простое число: ' & _RSA_IsPrime($iNumPrime))
;#ce

;#cs
;проверка чисел на взаимную простоту:
$iNum_1 = 123456789012345
$iNum_2 = 123
$iNum_3 = 29137

MsgBox(64, 'Взаимно простые', $iNum_1 & ' и ' & $iNum_2 & @LF & 'Взаимно простые числа: ' & _
		_RSA_IsCoprime($iNum_1, $iNum_2))
MsgBox(64, 'Взаимно простые', $iNum_1 & ' и ' & $iNum_3 & @LF & 'Взаимно простые числа: ' & _
		_RSA_IsCoprime($iNum_1, $iNum_3))
;#ce