; #Include <Misc.au3>
; Global $dll = DllOpen("user32.dll") ; для _IsPressed
Global $DW=@DesktopWidth, $DH=@DesktopHeight
Global $t[2]=[2,2], $Tr=0, $s[2]=[$DW/2, $DH/2], $m, $Tr2=0
AdlibRegister('_Exit', 40000) ; выход через 40 секунд работы
HotKeySet('{ESC}', '_Exit')


While 1
	Sleep(50)
	$m=MouseGetPos() ; получаем координаты курсора
	If $m[0]=$t[0] And $m[1]=$t[1] Then ; если координаты не изменились
		; ToolTip('цикл да', 0, 0)
		If Not $Tr Then
			$Tr=1 ; тригер скрутия устанавливаем в True
			If Not $Tr2 Then AdlibRegister('_Wait_and_block', 700) ; регистрируем функцию ожидания
			; ToolTip('цикл 1', 0, 0)
		EndIf
	Else ; иначе, если координаты изменились
		$t=$m
		; ToolTip('цикл нет', 0, 0)
		If $Tr2 Then _Free() ; если курсор скрыт то освобождаем его
	EndIf
WEnd

Func _Wait_and_block()
	AdlibUnRegister('_Wait_and_block')
	$m=MouseGetPos()
	; If _IsPressed("01", $dll) Then Return ; не прятать если удерживается нажатой кнопка мыши
	; если после 700 милисек координаты не изменились, то запускаем скрытие мыши
	If $m[0]=$t[0] And $m[1]=$t[1] Then
		; ToolTip('блокировка', 0, 0)
		$s=$t ; сохраняем координаты для восстановления
		$t[0]=$DW-1 ; устанавливаем координаты скрытия для $t и $m
		$t[1]=$DH-1
		$m=$t
		MouseMove($DW-1, $DH-1, 0) ; перемещаем курсор в скрытую область - край экрана
		$Tr2=1
	Else
		$Tr=0
	EndIf
EndFunc

Func _Free()
	; ToolTip('освобождение', 0, 0)
	MouseMove($s[0], $s[1], 0)
	$Tr=0
	$Tr2=0
EndFunc

Func _Exit()
	MouseMove($s[0], $s[1], 0)
	DllClose($dll)
	Exit
EndFunc