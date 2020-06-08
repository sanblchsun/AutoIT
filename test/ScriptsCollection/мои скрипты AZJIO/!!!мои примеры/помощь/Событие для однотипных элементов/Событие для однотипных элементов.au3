; ѕример показывает, что не об€зательно использовать цикл проверки событий дл€ однотипных элементов. ƒостаточно указать диапазон в конструкции Switch

$hGui = GUICreate('My Program', 250, 300)
GUICtrlCreateGroup("", 8, 0, 233, 273)

Global $BoxConfig[31] = [30]
$x = 16
$y = 26
For $i = 1 To 30
	If $i = 11 Then
		$x += 70
		$y = 286
	EndIf
	If $i = 21 Then
		$x += 80
		$y = 546
	EndIf
	$BoxConfig[$i] = GUICtrlCreateRadio("Check " & $i, $x, 16 + $i * 26 - $y, 62, 17)
Next
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