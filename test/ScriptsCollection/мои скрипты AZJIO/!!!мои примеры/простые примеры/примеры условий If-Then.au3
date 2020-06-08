Exit

; Работа над ошибками

;!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

; избавление от вложенности условий
If $k = 8 Then
	If $z = 5 Then
		Exit
	EndIf
EndIf
; Заменяем на одно условие
If $k = 8 And $z = 5 Then
	Exit
EndIf
; при использовании оператора And если первый критерий $k=8 неверный, то остальные условия ($z=5 и пр.) не проверяются, поэтому используйте наиболее маловероятное равенство первым, чтоб в большинстве случаев проверять минимальное количество равенств.

;!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

; двойное последовательное условие с одинаковым результатом
If $k = 8 Then
	Exit
EndIf
If $z = 5 Then
	Exit
EndIf
; Заменяем на одно условие
If $k = 8 Or $z = 5 Then
	Exit
EndIf

;!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

; сложное логическое условие можно составить понимая суть операторов.
If ($k = 8 And $z = 5) Or ($f = 8 And Not $y = 5) Then
	MsgBox(0, '1', 'да')
Else
	MsgBox(0, '0', 'нет')
EndIf
; Здесь скобки объединяют участки условий. Сначала вычисляются результат скобок и как известно в логике ответ либо Да=1=True, либо Нет=0=False
; Все числа кроме 0 приравниваются к Да=1=True, поэтому для числовых переменных запись вида:
If $k <> 0 Then Exit
; Заменяем на
If $k Then Exit

; Аналогично со строковыми переменными - "пустая строка"=Нет=0=False, "не пустая строка"=Да=1=True, поэтому для строковых переменных запись вида:
If $k <> '' Then Exit
; Заменяем на
If $k Then Exit

; или
If $k = '' Then Exit
; аналогично
If Not $k Then Exit

;!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

; Излишнее приравнивание
; вычисляется верность условия 1=1(верно, и результат 1) или 0=1(не верно, и результат 0), но возврат успешности функции FileExists уже является результатом верности.
If FileExists($path) = 1 Then Exit
; Заменить на
If FileExists($path) Then Exit

; Здесь инверсное условие, которое можно заменить на "Не нет"="да" (Не ноль"="один" в двоичной системе)
If FileExists($path) = 0 Then Exit
; Заменить на
If Not FileExists($path) Then Exit

;!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

$l = '1'
$m = '5'

If Not ($l = "1" And $m = "5") And $l <> "" And $l <> "2" And $l <> "3" Then
	MsgBox(0, ' ', 'условие 1 прошёл')
Else
	MsgBox(0, ' ', 'условие 2 - не прошёл')
EndIf

;!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

;При использовании выражений в скобках операторы можно не разделять пробелами
If Not ($k) Or (Not ($z = 4)) Then Exit

;!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

If $k = '' And $m = '' And $n = '' And $s = '' And $t = '' Then Exit
;заменить на
If $k & $m & $n & $s & $t = '' Then Exit
;заменить на
If Not ($k & $m & $n & $s & $t) Then Exit

;!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

If $k = '' Or $m = '' Or $n = '' Or $s = '' Or $t = '' Then Exit
;заменить на
If Not ($k And $m And $n And $s And $t) Then Exit

;!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

If $k = 3 Or $k = 8 Or $k = 12 Or $k = 43 Or $k = 67 Then Exit
;заменить на
Switch $k
	Case 3, 8, 12, 43, 67
		Exit
EndSwitch
; причём последний вариант быстрее
