; ¬ариант неидеален, так как выбор происходит принудительно при наличии в раскладках указанного €зыка. Ќо указанный €зык может присутствовать в раскладках дл€ изучени€ или дл€ теста, но ни как не дл€ того чтобы быть доминирующим.

; En
$LngAbout='About'
$LngVer='Version'

; Ru
; если есть русский в раскладках клавиатуры, то использовать его
For $i = 1 to 5
	$LngN = RegEnumVal("HKCU\Keyboard Layout\Preload", $i)
	If @error <> 0 Then ExitLoop
	If RegRead("HKCU\Keyboard Layout\Preload", $LngN) = 00000419 Then
		$LngAbout='ќ программе'
		$LngVer='¬ерси€'
		ExitLoop
	EndIf
Next