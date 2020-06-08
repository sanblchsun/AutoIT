; ������ ����������, ��� �� ����������� ������������ ���� �������� ������� ��� ���������� ���������. ���������� ������� �������� � ����������� Switch
; The example shows that it isn't obligatory to use separate events in a loop for the same elements. Sufficient to indicate the range in design Switch

$hGui = GUICreate('My Program', 450, 400)
GUICtrlCreateGroup("", 88, 20, 233, 273)
	
$iCount = 30 ; ���������� �������		(The number of items)
$iRows = 10 ; ���������� �����		(The number of rows)
Global $BoxConfig[$iCount + 1] = [$iCount], $a[10] = [0, 0, $iRows, 96, 36, 26, 70, -1, 1]
; a[0] - X-���������� ��������		(The X-coordinate of the element)
; a[1] - Y-���������� ��������		(The Y-coordinate of the element)
; a[2] - ���������� ����� � �����		(The number of rows in the block)
; a[3] - X-���������� �����		(The X-coordinate of the box)
; a[4] - Y-���������� �����		(The Y-coordinate of the box)
; a[5] - ������������ ��� � �����		(Vertical step in block)
; a[6] - �������������� ��� � �����		(Horizontal step in block)
; a[7] - ������ ������� �������		(The index of the current column)
; a[8] - ������ ������ ��������� �������		(Index of item of the next column)
For $i = 1 To $iCount
	_NextItem($a, $i)
	$BoxConfig[$i] = GUICtrlCreateRadio("Check " & $i, $a[0], $a[1], 62, 17)
Next
$a = 0
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
	If $i = $a[8] Then
		$a[8] += $a[2]
		$a[7] += 1
	EndIf
	$a[0] = $a[7] * $a[6] + $a[3] ; X
	$a[1] = $a[4] + Mod($i - 1, $a[2]) * $a[5] ; Y
EndFunc   ;==>_NextItem

; Func _NextItem2(ByRef $a, $i)
	; $a[0] = (Ceiling($i / $a[2]) - 1) * $a[6] + $a[3] ; X
	; $a[1] = $a[4] + Mod($i - 1, $a[2]) * $a[5] ; Y
; EndFunc   ;==>_NextItem2