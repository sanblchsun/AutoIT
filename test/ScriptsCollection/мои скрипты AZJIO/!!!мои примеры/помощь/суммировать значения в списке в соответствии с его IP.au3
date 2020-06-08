; #include <Array.au3> ; для _ArrayDisplay
; формат списка:
; 07.06.2011 8:01 62.80.230.41 ХХХ.ХХХ.ХХХ.ХХХ TCP 3389 1875 0,022325 10
; 07.06.2011 8:01 81.23.3.110 ХХХ.ХХХ.ХХХ.ХХХ TCP 3389 1987 0,022293 10

$text = FileRead(@ScriptDir&'\список.txt')
If StringInStr($text, @LF) Then
	$aText=StringSplit(StringStripCR(StringStripWS($text, 7)), @LF) ; делим данные построчно в массив, удалив симовол @CR и повтор пробела
Else
	$aText=StringSplit(StringStripWS($text, 7), @CR)
EndIf

Global $aTable[$aText[0]+1][9] ; создаём новый массив с 9-ю колонками
$aTable[0][0]=$aText[0]

; заполняем массив 9-ти колоночный, раздробив строку на колонки по пробелам
For $i = 1 to $aText[0]
	$aTmp=StringSplit($aText[$i], ' ')
	For $j = 1 to $aTmp[0]
		$aTable[$i][$j-1]=$aTmp[$j]
	Next
Next

$aOut=_Calculate($aTable) ; функция подсчёта
; _ArrayDisplay($aOut, 'aOut')
$Out=''
For $i = 1 to $aOut[0][0] ; объединение массива в многострочный текст
	$aOut[$i][0]&=@TAB&$aOut[$i][1]
	$Out&=$aOut[$i][0]&@CRLF
Next

$file = FileOpen(@ScriptDir&'\новый список.txt',2) ; записываем в файл
FileWrite($file, $Out)
FileClose($file)

Func _Calculate($a)
	Local $k, $ind, $i
	If Not IsArray($a) Or UBound($a)<2 Then SetError(1, 0, 'проблема массива') ; проверка валидности массива

	$ind='_//' ; индекс для непересечения с переменными функции
	Assign($ind, 2, 1)

	$k=0
	For $i = 1 To $a[0][0]
		If Not IsDeclared($a[$i][2]&$ind) Then
			$k+=1
			$a[$k][0]=$a[$i][2]
		EndIf
		Assign($a[$i][2]&$ind, Eval($a[$i][2]&$ind)+StringReplace($a[$i][7], ',', '.'), 1) ; создаём локальные переменные или увеличиваем значение для уже созданных
	Next
	
	If $k = 0 Then Return SetError(1, 0, 'проблема массива')
	ReDim $a[$k+1][2]
	For $i = 1 to $k
		$a[$i][1]=Eval($a[$i][0]&$ind)
	Next
	$a[0][0]=$k
	Return $a
EndFunc