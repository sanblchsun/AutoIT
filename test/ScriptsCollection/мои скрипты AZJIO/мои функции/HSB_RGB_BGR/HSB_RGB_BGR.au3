#include-once

; v 0.3

; _HSB_to_RGB
; _RGB_to_HSB
; _RGB_to_BGR
; _ColorToArray - конвертирование числового и строчного формата цвета  в массив.

; HSB = [0-360, 0-100, 0-100]
; RGB = [0-255, 0-255, 0-255]

; ============================================================================================
; Function Name ...: _ColorToArray
; Description ........: Convert colors from a number or string into an array
; Syntax.......: _ColorToArray ( $RGB[, $f=0] )
; Parameters:
;		$RGB - color as a string or a number
;		$f - defines the format of the data
;                  |0 - auto
;                  |1 - string, "C738B9" (Hex)
;                  |2 - array, [199, 56, 185] (Dec)
;                  |3 - number, 13056185 or 0xC738B9
;                  |4 - a string with a separator, "199, 56, 185" (Dec)
; Return values: Success - three-element array in the following format:
;						$Array[0] = [0-255] Red
;						$Array[1] = [0-255] Green
;						$Array[2] = [0-255] Blue
;					Failure - 0, and set @error
; Author(s) ..........: AZJIO
; ============================================================================================
; Имя функции ...: _ColorToArray
; Описание ........: Конвертирование цвета из числового или строчного формата в массив.
; Синтаксис.......: _ColorToArray ( $RGB[, $f=0] )
; Параметры:
;		$RGB - цвет в строковом, числовом формате
;		$f - определяет формат данных
;                  |0 - автоматически
;                  |1 - строка, например "C738B9" (шестнадцатеричное число в строке)
;                  |2 - массив, например [199, 56, 185] (имеет смысл только при $f = 0)
;                  |3 - число, например 13056185 или 0xC738B9
;                  |4 - строка с разделителем, например "199, 56, 185" (десятеричные числа)
; Возвращаемое значение: Успешно - трёх элементный массив следующего формата:
;						$Array[0] = [0-255] Красный
;						$Array[1] = [0-255] Зелёный
;						$Array[2] = [0-255] Синий
;					Неудачно - 0, устанавливает @error:
;                  |1 - не удалось парсить строку
;                  |3 - не удалось парсить число
;                  |4 - не удалось парсить строку
;                  |5 - неверный формат при автоопределении при $f = 0
; Автор ..........: AZJIO
; ============================================================================================
Func _ColorToArray($RGB, $f = 0)
	If Not $f Then ; Определяем тип данных
		Switch VarGetType($RGB)
			Case 'String'
				If StringInStr($RGB, ',') Then
					$f = 4
				Else
					$f = 1
				EndIf
			Case 'Array'
				$f = 2
			Case 'Int32'
				$f = 3
			Case Else
				Return SetError(5, 0, 0)
		EndSwitch
	EndIf

	Local $aRGB[3], $aTmp, $pattern = '(?i)([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})$'

	Switch $f
		Case 1
			$aRGB = StringRegExp($RGB, $pattern, 3) ; либо ошибка, либо 3-х элементный массив
			If @error Then Return SetError(1, 0, 0)
			__Arr3ToDec($aRGB)
		Case 2
			$aRGB = $RGB
		Case 3
			$aRGB = StringRegExp(Hex($RGB), $pattern, 3)
			If @error Then Return SetError(3, 0, 0)
			__Arr3ToDec($aRGB)
		Case 4
			$aRGB = StringRegExp(StringStripWS($RGB, 8), '^(\d{1,3}),(\d{1,3}),(\d{1,3})$', 3)
			If @error Then Return SetError(4, 0, 0)
			$aRGB[0] = Number($aRGB[0])
			$aRGB[1] = Number($aRGB[1])
			$aRGB[2] = Number($aRGB[2])
	EndSwitch

	Return $aRGB
EndFunc

Func __Arr3ToDec(ByRef $a)
	$a[0] = Dec($a[0])
	$a[1] = Dec($a[1])
	$a[2] = Dec($a[2])
EndFunc

; округляем опционально
Func _Round(ByRef $a)
	$a[0] = Round($a[0])
	$a[1] = Round($a[1])
	$a[2] = Round($a[2])
EndFunc

Func _RGB_BGR($aRGB)
	$pat = $aRGB[2]
	$aRGB[2] = $aRGB[0]
	$aRGB[0] = $pat

	; Return Dec($aRGB[2]&$aRGB[1]&$aRGB[0])
	Return $aRGB
EndFunc

; ============================================================================================
; Function Name ...: _HSB_to_RGB
; Description ........: Converting colors from RGB to HSB
; Syntax.......: _HSB_to_RGB ( $aHSB[, $i = 0[, $iScale1 = 360[, $iScale2 = 100[, $iScale3 = 100]]]] )
; Parameters:
;		$aHSB - three-element array in the following format:
;			$aHSB[0] = [0...$iScale1] Hue
;			$aHSB[1] = [0...$iScale2] Saturation
;			$aHSB[2] = [0...$iScale3] Brightness
;		$i - [optional] формат выходных данных:
;			0 - float
;			1 - an array of integers, [0 - 255]
;			2 - an array of strings in hex [00 - FF]
;			3 - hexadecimal string [000000 - FFFFFF]
;			4 - integer color [0x000000 - 0xFFFFFF]
;		$iScale1 - [optional] maximum Hue
;		$iScale2 - [optional] maximum Saturation
;		$iScale3 - [optional] maximum Brightness
; Return values: Success - three-element array, string or number, depending on the flag $i
;					Failure - @error = 1 - $aHSB is not a one-dimensional or three-element array
; Author(s) ..........: AZJIO, formula is taken from the wikipedia article (HSV (color model) - Wikipedia)
; ============================================================================================
; Имя функции ...: _HSB_to_RGB
; Описание ........: Конвертирование цвета из цветового пространства HSB в RGB
; Синтаксис.......: _HSB_to_RGB ( $aHSB[, $i = 0[, $iScale1 = 360[, $iScale2 = 100[, $iScale3 = 100]]]] )
; Параметры:
;		$aHSB - трёх элементный массив следующего формата:
;			$aHSB[0] = [0...$iScale1] Тон (цвет в цветовом спектре)
;			$aHSB[1] = [0...$iScale2] Насыщенность, Чистота цвета (серость или цветастость)
;			$aHSB[2] = [0...$iScale3] Яркость (тёмный или светлый)
;		$i - [необязательный] формат выходных данных:
;			0 - точные данные с плавающей точкой
;			1 - массив с целыми числами, [0 - 255]
;			2 - массив со строками в шестнадцатеричном виде [00 - FF]
;			3 - строка в шестнадцатеричном виде [000000 - FFFFFF]
;			4 - целое число цвета [0x000000 - 0xFFFFFF]
;		$iScale1 - [необязательный] максимальное значение Тон
;		$iScale2 - [необязательный] максимальное значение Насыщенность
;		$iScale3 - [необязательный] максимальное значение Яркость
; Возвращаемое значение: Успешно - трёх элементный массив, строка или число, взависимости от флага $i
;					Неудачно - устанавливает @error равным 1 - $aHSB не является одномерным или трёх элементным массивом
; Автор ..........: AZJIO, формула взята из wikipedia в статье (HSV (цветовая модель) — Википедия)
; Примечания ..: Для вывода в GUI округляйте выходные данные до целого значения. Внутри скрипта-программы используйте не округлённые данные, это избавит от неточности при многократном преобразовании.
; ============================================================================================
Func _HSB_to_RGB($aHSB, $i = 0, $iScale1 = 360, $iScale2 = 100, $iScale3 = 100)
	If UBound($aHSB) <> 3 Or UBound($aHSB, 0) <> 1 Then Return SetError(1, 0, 0)
	Local $aRGB[3], $f, $p, $q, $t, $Sector
	
	$aHSB[2] /= $iScale3
	
	If $aHSB[1] = 0 Then
		$aRGB[0] = $aHSB[2]
		$aRGB[1] = $aRGB[0]
		$aRGB[2] = $aRGB[0]
	Else
		While $aHSB[0] >= $iScale1
			$aHSB[0] -= $iScale1
		WEnd
		
		$aHSB[1] /= $iScale2
		$aHSB[0] /= $iScale1 / 6
		$Sector = Int($aHSB[0])
		
		$f = $aHSB[0] - $Sector
		$p = $aHSB[2] * (1 - $aHSB[1])
		$q = $aHSB[2] * (1 - $aHSB[1] * $f)
		$t = $aHSB[2] * (1 - $aHSB[1] * (1 - $f))
		
		Switch $Sector
			Case 0
				$aRGB[0] = $aHSB[2]
				$aRGB[1] = $t
				$aRGB[2] = $p
			Case 1
				$aRGB[0] = $q
				$aRGB[1] = $aHSB[2]
				$aRGB[2] = $p
			Case 2
				$aRGB[0] = $p
				$aRGB[1] = $aHSB[2]
				$aRGB[2] = $t
			Case 3
				$aRGB[0] = $p
				$aRGB[1] = $q
				$aRGB[2] = $aHSB[2]
			Case 4
				$aRGB[0] = $t
				$aRGB[1] = $p
				$aRGB[2] = $aHSB[2]
			Case Else
				$aRGB[0] = $aHSB[2]
				$aRGB[1] = $p
				$aRGB[2] = $q
		EndSwitch
	EndIf
	$aRGB[0] *= 255
	$aRGB[1] *= 255
	$aRGB[2] *= 255
	
	; В UDF Color.au3 - Global Const $__COLORCONSTANTS_RGBMAX = 255 ; устанавливает коэффициент RGB, но по умолчанию в большинстве случаев он равен 255 всегда.
	If $i Then
		$aRGB[0] = Round($aRGB[0]) ; если $aHSB[1] = 0 то можно сэкономить на вычислениях
		$aRGB[1] = Round($aRGB[1])
		$aRGB[2] = Round($aRGB[2])
		If $i > 1 Then
			$aRGB[0] = Hex($aRGB[0], 2)
			$aRGB[1] = Hex($aRGB[1], 2)
			$aRGB[2] = Hex($aRGB[2], 2)
			If $i > 2 Then
				$aRGB = $aRGB[0] & $aRGB[1] & $aRGB[2]
				If $i > 3 Then
					$aRGB = Dec($aRGB[0] & $aRGB[1] & $aRGB[2])
				EndIf
			EndIf
		EndIf
	EndIf
	
	Return $aRGB
EndFunc

; ============================================================================================
; Function Name ...: _RGB_to_HSB
; Description ........: Converting colors from RGB to HSB
; Syntax.......: _RGB_to_HSB ( $aRGB[, $iScale1 = 360[, $iScale2 = 100[, $iScale3 = 100]]] )
; Parameters:
;		$aRGB - three-element array in the following format:
;			$aRGB[0] = [0 - 255] Red
;			$aRGB[1] = [0 - 255] Green
;			$aRGB[2] = [0 - 255] Blue
;		$iScale1 - [optional] maximum Hue
;		$iScale2 - [optional] maximum Saturation
;		$iScale3 - [optional] maximum Brightness
; Return values: Success - three-element array in the following format:
;						$aHSB[0] = [0...$iScale1] Hue
;						$aHSB[1] = [0...$iScale2] Saturation
;						$aHSB[2] = [0...$iScale3] Brightness
;					Failure - @error = 1 - $aRGB нis not a one-dimensional or three-element array
; Author(s) ..........: AZJIO, formula is taken from the wikipedia article (HSV (color model) - Wikipedia)
; ============================================================================================
; Имя функции ...: _RGB_to_HSB
; Описание ........: Конвертирование цвета из цветового пространства RGB в HSB
; Синтаксис.......: _RGB_to_HSB ( $aRGB[, $iScale1 = 360[, $iScale2 = 100[, $iScale3 = 100]]] )
; Параметры:
;		$aRGB - трёх элементный массив следующего формата:
;			$aRGB[0] = [0 - 255] Красный
;			$aRGB[1] = [0 - 255] Зелёный
;			$aRGB[2] = [0 - 255] Синий
;		$iScale1 - [необязательный] максимальное значение Тон
;		$iScale2 - [необязательный] максимальное значение Насыщенность
;		$iScale3 - [необязательный] максимальное значение Яркость
; Возвращаемое значение: Успешно - трёх элементный массив следующего формата:
;						$aHSB[0] = [0...$iScale1] Тон (цвет в цветовом спектре)
;						$aHSB[1] = [0...$iScale2] Насыщенность, Чистота цвета (серость или цветастость)
;						$aHSB[2] = [0...$iScale3] Яркость (тёмный или светлый)
;					Неудачно - устанавливает @error равным 1 - $aRGB не является одномерным или трёх элементным массивом
; Автор ..........: AZJIO, формула взята из wikipedia в статье (HSV (цветовая модель) — Википедия)
; Примечания ..: Для вывода в GUI округляйте выходные данные до целого значения. Внутри скрипта-программы используйте не округлённые данные, это избавит от неточности при многократном преобразовании.
; ============================================================================================
Func _RGB_to_HSB($aRGB, $iScale1 = 360, $iScale2 = 100, $iScale3 = 100)
	If UBound($aRGB) <> 3 Or UBound($aRGB, 0) <> 1 Then Return SetError(1, 0, 0)
	Local $min, $max, $aHSB[3]
	
	$aRGB[0] /= 255
	$aRGB[1] /= 255
	$aRGB[2] /= 255
	
	If $aRGB[0] <= $aRGB[1] Then
		$min = $aRGB[0]
		$max = $aRGB[1]
	Else
		$min = $aRGB[1]
		$max = $aRGB[0]
	EndIf
	If $min > $aRGB[2] Then $min = $aRGB[2]
	If $max < $aRGB[2] Then $max = $aRGB[2]
	
	If $max = $min Then
		$aHSB[0] = 0
	ElseIf $max = $aRGB[0] Then
		$aHSB[0] = $iScale1 / 6 * ($aRGB[1] - $aRGB[2]) / ($max - $min)
		If $aRGB[1] < $aRGB[2] Then $aHSB[0] += $iScale1
	ElseIf $max = $aRGB[1] Then
		$aHSB[0] = $iScale1 / 6 * ($aRGB[2] - $aRGB[0]) / ($max - $min) + $iScale1 / 3
	ElseIf $max = $aRGB[2] Then
		$iScale1 /= 6
		$aHSB[0] = $iScale1 * ($aRGB[0] - $aRGB[1]) / ($max - $min) + $iScale1 * 4
	EndIf
	
	If $max = 0 Then
		$aHSB[1] = 0
	Else
		$aHSB[1] = (1 - $min / $max) * $iScale2
	EndIf
	
	$aHSB[2] = $max * $iScale3
	
	Return $aHSB
EndFunc