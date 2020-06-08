; Извлекает уникальные строки из второго файла, которых нет в первом файле. Причём строки будут в единственном экземпляре, даже если они повторялись во втором файле.

; данный способ Assign имеет проблему со спец-символом "[", поэтому в функцию добавлен участок кода, временно заменяющий этот символ на любой другой из 256 символов, который отсутствует в текстах, а в результирующем тексте символ будет востановлен. Остальные спец-символы !@#$%^&*()-+<>?/\|{}] не имеют проблем.

; http://www.autoitscript.com/forum/topic/141761-autoit-masters-need-assistance-comparing-and-deleting/#entry997445
; http://autoit-script.ru/index.php/topic,4861.msg35292.html#msg35292
; http://autoit-script.ru/index.php?topic=2930.msg21226#msg21226
; http://autoit-script.ru/index.php?topic=4861.new#new

$Path_In1 = @ScriptDir & '\test_in1.txt'
$Path_In2 = @ScriptDir & '\test_in2.txt'
$Path_Out = @ScriptDir & '\test_Out.txt'
$sText1 = FileRead($Path_In1)
$sText2 = FileRead($Path_In2)

$sText_Out = _Unique_Lines_Text2($sText1, $sText2)
If @error Then
	MsgBox(0, 'Error', 'Error = ' & @error)
	Exit
Else
	$hFile = FileOpen($Path_Out, 2) ; пишем в файл
	FileWrite($hFile, $sText_Out)
	FileClose($hFile)
EndIf

; @error = 2 - Not found
; @error = 2 - Не найдено
; не учитывает регистр String = StRiNg = STRING
; not case sensitive, String = StRiNg = STRING
Func _Unique_Lines_Text2($sText1, $sText2, $sep = @CRLF)
	Local $i, $k, $aText, $s, $Trg = 0, $LenSep

	If StringInStr($sText1 & $sText2, '[') And $sep <> '[' Then ; если сбойный символ есть до заменяем его
		For $i = 0 To 255
			$s = Chr($i)
			If Not StringInStr($sText1 & $sText2, $s) Then
				If StringInStr($sep, $s) Then ContinueLoop
				$sText1 = StringReplace($sText1, '[', $s)
				$sText2 = StringReplace($sText2, '[', $s)
				$Trg = 1
				ExitLoop
			EndIf
		Next
		If Not $Trg Then Return SetError(1, 0, '')
	EndIf

	$LenSep = StringLen($sep)

	$aText = StringSplit($sText1, $sep, 1) ; Создаём переменные первого файла
	For $i = 1 To $aText[0]
		Assign($aText[$i] & '/', 2, 1)
	Next
	Assign('/', 2, 1)

	$aText = StringSplit($sText2, $sep, 1)

	$k = 0
	$sText1 = ''
	For $i = 1 To $aText[0]
		Assign($aText[$i] & '/', Eval($aText[$i] & '/') + 1, 1) ; создаём локальные переменные или увеличиваем значение для уже созданных
		If Eval($aText[$i] & '/') = 1 Then
			$sText1 &= $aText[$i] & $sep
			$k += 1
		EndIf
	Next
	If $k = 0 Then Return SetError(2, 0, '')
	If $Trg Then $sText1 = StringReplace($sText1, $s, '[')
	Return StringTrimRight($sText1, $LenSep)
EndFunc