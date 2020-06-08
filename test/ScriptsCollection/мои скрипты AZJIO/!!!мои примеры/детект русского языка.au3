


; Вариант1 - если русская локализация, то русский язык
; но проблема, если английская версия с установленным MUI-пакетом.
If @OSLang = 0419 Then
	; здесь языковые переменные
	$LngTitle='Моя программа'
		MsgBox(0, 'Сообщение', 'У вас русская локализация Windows')
EndIf


; Вариант2 - включает русский, если один из 5 установленных языковых раскладок русский.
For $i = 1 to 5
	$LngN = RegEnumVal("HKCU\Keyboard Layout\Preload", $i)
	If @error Then ExitLoop
	If RegRead("HKCU\Keyboard Layout\Preload", $LngN) = 00000419 Then
		; здесь языковые переменные
		$LngTitle='Моя программа'
		MsgBox(0, 'Сообщение', 'У вас русский язык присутствует в раскладках')
		ExitLoop
	EndIf
Next