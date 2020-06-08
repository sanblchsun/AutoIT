
; ============================================================================================
; Function Name ...: _NumberNumToName
; AutoIt Version ....: 3.2.12.1+
; Description ........: Converts a number to text consisting of words
; Syntax................: _NumberNumToName($iNum, $iRusLng = 0)
; Parameters:
;		$iNumber - любое целое число от 0 до 9223372036854775806
;		$iRusLng - (0, 1) language settings
;                  |0 - in English (Default)
;                  |1 - in Russian
; Return values ....: Success - Returns a string
;					Failure - empty string, @error = 1, if the string contains no numbers
; Author(s) ..........: AZJIO, G.Sandler (CreatoR) (transformation and modernization of the VBS-script found in Google)
; link ..................: http://forum.oszone.net/post-1900913.html#post1900913 discussion and adding CreatoR'om English language support
; ============================================================================================
; Имя функции ...: _NumberNumToName
; Описание ........: Преобразует число в запись прописью
; Синтаксис.......: _NumberNumToName($iNum, $iRusLng = 0)
; Параметры:
;		$iNumber - любое целое число от 0 до 9223372036854775806
;		$iRusLng - (0, 1) языковые установки
;                  |0 - на английском языке (по умолчанию)
;                  |1 - на русском языке
; Возвращаемое значение: Успешно - число прописью
;					Неудачно - пустая строка, @error = 1, если строка содержит не цифры
; Автор ..........: AZJIO, G.Sandler (CreatoR), преобразование и модернизация VBS-скрипта, найденного в Google
; Ссылка ..........: http://forum.oszone.net/post-1900913.html#post1900913 обсуждение и добавление CreatoR'ом поддержки английского языка
; ============================================================================================
Func _NumberNumToName($iNum, $iRusLng = 0)
	Local $aN, $aNum, $c, $i, $j, $n, $r, $sText

	$iNum = StringStripWS($iNum, 8) ; удаляем пробелы

	If $iNum = '0' Then
		If $iRusLng Then Return 'Ноль'
		Return 'Zero'
	EndIf

	$iNum = Int($iNum) ; берём целую часть числа
	If Not StringIsDigit($iNum) Or $iNum > 9223372036854775806 Or $iNum = 0 Then Return SetError(1, 0, '') ; если не цифры или огромное число, то вылет

	$iNum = StringRegExpReplace($iNum, '(\A\d{1,3}(?=(\d{3})+\z)|\d{3}(?=\d))', '\1 ') ; dwerf
	$aNum = StringSplit($iNum, ' ')

	If $iRusLng Then
		Dim $a[4][10] = _
				[ _
				[' десять', ' одиннадцать', ' двенадцать', ' тринадцать', ' четырнадцать', ' пятнадцать', ' шестнадцать', ' семнадцать', ' восемнадцать', ' девятнадцать'], _
				['', ' сто', ' двести', ' триста', ' четыреста', ' пятьсот', ' шестьсот', ' семьсот', ' восемьсот', ' девятьсот'], _
				['', '', ' двадцать', ' тридцать', ' сорок', ' пятьдесят', ' шестьдесят', ' семьдесят', ' восемьдесят', ' девяносто'], _
				['', '', '', ' три', ' четыре', ' пять', ' шесть', ' семь', ' восемь', ' девять'] _
				]

		Dim $aBitNum[7] = ['', ' тысяч', ' миллион', ' миллиард', ' триллион', ' квадриллион', ' квинтиллион']
	Else
		Dim $a[4][10] = _
				[ _
				[' ten', ' eleven', ' twelve', ' thirteen', ' fourteen', ' fifteen', ' sixteen', ' seventeen', ' eighteen', ' nineteen'], _
				['', 'hundred', ' two hundred', ' three hundred', ' four hundred', ' five hundred', ' six hundred', ' seven hundred', ' eight hundred', ' nine hundred'], _
				['', '', ' twenty', ' thirty', ' forty', ' fifty', ' sixty', ' seventy', ' eighty', ' ninety'], _
				['', '', '', ' three', ' four', ' five', ' six', ' seven', ' eight', ' nine'] _
				]

		Dim $aBitNum[7] = ['', ' thousand', ' million', ' billion', ' trillion', ' quadrillion', ' quintillion']
	EndIf

	$aNum[1] = StringFormat('%03s', $aNum[1]) ; дополняем нулями недостающие разряды
	$sText = ''

	For $i = 1 To $aNum[0]
		If $aNum[$i] = '000' Then ContinueLoop

		$aN = StringSplit($aNum[$i], '')
		$r = $aNum[0] - $i

		For $j = 1 To $aN[0]
			$n = Number($aN[$j])
			If Not $n Then ContinueLoop

			$c = $j

			Switch $j
				Case 3
					Switch $n ; для чисел 1 или 2
						Case 1
							If $iRusLng Then
								If $r = 1 Then ; разряд единиц (не десятков и сотен)
									$sText &= " одна"
								Else
									$sText &= " один"
								EndIf
							Else
								$sText &= " one"
							EndIf
						Case 2
							If $iRusLng Then
								If $r = 1 Then
									$sText &= " две"
								Else
									$sText &= " два"
								EndIf
							Else
								$sText &= " two"
							EndIf
					EndSwitch
				Case 2 ; для чисел от 10 до 19
					If $n = 1 Then
						$c = 0
						$n = Number($aN[3])
						$aN[3] = 0
					EndIf
			EndSwitch

			$sText &= $a[$c][$n] ; присоединения числа из массива
		Next

		$sText &= $aBitNum[$r]

		Switch $n ; окончания для раряда кратного 1000, при $j=3 в конце цикла
			Case 1
				If $r = 1 And $iRusLng Then ; одна тысяч<а>
					$sText &= "а"
				EndIf
			Case 2, 3, 4
				If $r = 1 Then ; 2,3,4 тысяч<и>
					If $iRusLng Then
						$sText &= "и"
					Else
						$sText &= "s"
					EndIf
				ElseIf $r > 1 Then ; 2,3,4 милион<а>
					If $iRusLng Then
						$sText &= "а"
					Else
						$sText &= "s"
					EndIf
				EndIf
			Case Else
				If $r > 1 Then ; 5-9 милион<ов>
					If $iRusLng Then
						$sText &= "ов"
					Else
						$sText &= "s"
					EndIf
				EndIf
		EndSwitch
	Next

	Return StringStripWS($sText, 3)
EndFunc