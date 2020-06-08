; Пример показывает, что не обязательно использовать цикл проверки событий для однотипных элементов. Достаточно указать диапазон в конструкции Switch

$hGui = GUICreate('My Program', 450, 400)
GUICtrlCreateGroup("", 88, 20, 233, 273)

Opt("GUICoordMode", 0) ; Режим относительных координат
GUISetCoord(96, 36) ; Координаты блока
$iCount = 30 ; Количество пунктов
$iRows = 10 ; Количество строк
Global $BoxConfig[$iCount + 1] = [$iCount], $a[5] = [0, 0, $iRows, 26, 70]
; 0 - X-координата элемента
; 1 - Y-координата элемента
; 2 - Количество строк в блоке
; 3 - Вертикальный шаг в блоке
; 4 - Горизонтальный шаг в блоке
For $i = 1 To $iCount
	_NextItem($a, $i)
	$BoxConfig[$i] = GUICtrlCreateRadio("Check " & $i, $a[0], $a[1], 62, 17)
Next
$a = 0
Opt("GUICoordMode")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState()

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $BoxConfig[1] To $BoxConfig[$BoxConfig[0]]
			$j = $nMsg - $BoxConfig[1] + 1
			MsgBox(0, 'Check', $j, 0, $hGui)
		Case -3
			Exit
	EndSwitch
WEnd

Func _NextItem(ByRef $a, $i)
	If $i = 1 Then
		$a[0] = 0
		$a[1] = 0
	Else
		If Mod($i-1, $a[2]) Then
			$a[0] = 0
			$a[1] = $a[3]
		Else
			$a[0] = $a[4]
			$a[1] = -($a[2]-1) * $a[3]
		EndIf
	EndIf
EndFunc   ;==>_NextItem