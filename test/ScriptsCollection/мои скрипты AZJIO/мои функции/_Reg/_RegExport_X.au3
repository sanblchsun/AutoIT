#Include <_RegFunc.au3>

; v0.2

$Key = 'HKEY_LOCAL_MACHINE\HARDWARE'

$timer = TimerInit()
$sData='Windows Registry Editor Version 5.00'&@CRLF&@CRLF
; $sData='' ; здесь можно указать "шапку" reg-файла
$DataErr = _RegExport_X($Key, $sData)
$timer = Round(TimerDiff($timer), 2)


If MsgBox(4, '_RegExport_X + _RegFunc', 'Time : ' & $timer &@LF&@LF& $DataErr &@LF&@LF& 'Сохранить?')=6 Then
	$file = FileOpen(@ScriptDir&'\Export.reg',2)
	FileWrite($file, $sData)
	FileClose($file)
EndIf

; #FUNCTION# ;=================================================================================
; Имя функции ...: _RegExport_X
; Описание ........: Возвращает экспортируемые из реестра данные.
; Синтаксис.......: _RegExport_X ( $sKey, ByRef $Data )
; Параметры:
;		$sKey - Полный путь к разделу, который будет экспортирован
;		$Data - Переменная, к которой присоединяется результат
; Возвращаемое значение: Экспортируемые данные (без "шапки")
; Автор ..........: AZJIO
; Примечания ..:В $Data можно вставить "шапку", возвращаемые данные будут присоединены. При многократном вызове данные присоединяются, а не перезаписываются.
; Спасибо NIKZZZZ за пример рекурсивного вызова http://forum.ru-board.com/topic.cgi?forum=5&topic=29240&start=3080#12
; Спасибо Erik Pilsits, чья _RegFunc.au3 используется в функции
; ============================================================================================
Func _RegExport_X($sKey, ByRef $Data)
	Local $aaaValue, $asValue0, $cmd, $DataErr, $hex, $i, $L, $line1, $Re, $sTemp, $sValue, $sValue0, $sValueName, $sValuetype

	$i = 0
	Do
		$i += 1
		; If $i=1 Then $Data &= @CRLF & '[' & $sKey & ']' & @CRLF
		$sValueName = RegEnumVal($sKey, $i)
		If @error Then ExitLoop
		$sValue = _RegRead($sKey, $sValueName, True)
		If @error Then ContinueLoop
		$sValuetype = @extended
		; $sValueName = StringRegExpReplace($sValueName, '[\\]', "\\$0") ; всегда заменяем в параметре наклонную черту на двойную
		$sValueName = StringReplace($sValueName, '\', "\\") ; всегда заменяем в параметре наклонную черту на двойную
		If $i=1 Then $Data &= @CRLF & '[' & $sKey & ']' & @CRLF ; если строку переместить к началу, то все разделы даже пустые добавятся
		; здесь для каждого типа данных свой алгоритм извлечения значений
		Switch $sValuetype
			Case 1
				$sValue = StringReplace(StringReplace(StringRegExpReplace($sValue, '["\\]', "\\$0"), '=\"\"', '="\"'), '\"\"', '\""')
				$Data &= '"' & $sValueName & '"="' & $sValue & '"' & @CRLF
			Case 7, 2
				$hex=_HEX($sValuetype, $sValue, $sValueName, $L)
				$Data &= '"' & $sValueName & '"=' & $L & $hex & @CRLF
			Case 4
				$Data &= '"' & $sValueName & '"=dword:' & StringLower(Hex(Int($sValue))) & @CRLF
			Case 3
				$hex=_HEX(3, $sValue, $sValueName, $L)
				$Data &= '"' & $sValueName & '"=' & $L & $hex & @CRLF
			Case 0, 8, 9, 10, 11 ; тип данных которые не распознаёт AutoIt3, поэтому используется экспорт консольной командой.
				; Вытаскиваем значение в консоль и читаем с неё
				$hex=_HEX($sValuetype, $sValue, $sValueName, $L)
				$Data &= '"' & $sValueName & '"=' & $L & $hex & @CRLF
			Case Else
				$DataErr &= '# error... Key:"' & $sKey & '" Valuename:"' & $sValueName & '" значение:"' & $sValue & '" type:"' & $sValuetype & '"' & @CRLF
		EndSwitch
	Until 0
	;рекурсия
	$i = 0
	While 1
		$i += 1
		$sTemp = RegEnumKey($sKey, $i)
		If @error Then ExitLoop
		$DataErr &= _RegExport_X($sKey & '\' & $sTemp, $Data)
	WEnd
	$Data = StringReplace($Data, '""=', '@=') ; заменяем в данных параметры по умолчанию на правильные
	Return $DataErr
EndFunc   ;==>_RegExport_X

; функция шестнадцатеричных данных, основное её значение - привести запись к формату reg-файла (перенос строк)
; данные подгонялись методом сравнения оригинального экспорта и reg-файлом полученным скриптом до полного совпадения.
Func _HEX($sValuetype, ByRef $sValue, $sValueName, ByRef $L)
	Local $aValue, $hex, $i, $k, $len, $lenVN, $r, $s, $s0
	$k = 0
	$lenVN = StringLen($sValueName) - 1
	Switch $sValuetype
		Case 0
			$L = 'hex(0):'
		Case 3
			$k = 1
			$L = 'hex:'
		Case 2
			$k = 1
			$L = 'hex(2):'
			$sValue = StringToBinary($sValue, 2)
			$sValue &= '0000'
			$lenVN = StringLen($sValueName) + 2
		Case 7
			$k = 1
			$L = 'hex(7):'
			; $sValue = StringToBinary($sValue, 2) ; строковый в бинарный вид
			; $sValue = StringReplace($sValue, '000a00', '000000') ; по какой то причине экспортированные и прочитанные данные разнятся этими блоками
			; $sValue &= '00000000' ; шестнадцатеричные данные заполнены окончания нулями, иногда не совпадает количество, автоит обрезает так как читает данные как текстовые
		Case 8
			$sValue = StringTrimLeft($sValue, 2)
			$L = 'hex(8):'
		Case 10
			$L = 'hex(a):'
		Case 11
			$L = 'hex(b):'
		Case 9
			; $k = -1
			$sValue = StringTrimLeft($sValue, 2)
			$L = 'hex(9):'
	EndSwitch
	$hex = ''
	$aValue=StringRegExp($sValue, '..', 3)
	$len = UBound($aValue) ; от колич. символов параметра зависит колич. бинарных данных первой строки
	If $lenVN >= 69 Then $lenVN = 66
	$s0 = 22 - ($lenVN - Mod($lenVN, 3)) / 3 ; количество символов для первой строки reg-данных
	Switch $sValuetype
		Case 7,8,9
			$s0 -= 1
	EndSwitch
	$s = 0
	$r = 0
	For $i = $k To $len-1 ; цикл формирует правильный перенос строк, и разделительные запятые
		If $s = $s0 Or $r = 24 Then
			$hex &= $aValue[$i] & ',\' & @CRLF & '  '
			$s = 24
			$r = 0
		Else
			$hex &= $aValue[$i] & ','
			$s += 1
			$r += 1
		EndIf
	Next
	$hex = StringTrimRight($hex, 1)
	If StringRight($hex, 5) = ',\' & @CRLF & ' ' Then $hex = StringTrimRight($hex, 5) ;обрезка конца значания
	$hex = StringLower($hex) ; преобразование в строчные
	Return $hex
EndFunc   ;==>_HEX