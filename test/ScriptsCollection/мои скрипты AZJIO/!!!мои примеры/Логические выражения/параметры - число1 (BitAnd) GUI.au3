$a=StringSplit('CHECKE|INDETERMINATE|UNCHECKED|DROPACCEPTED|SHOW|HIDE|ENABLE|DISABLE|FOCUS|DEFBUTTON|EXPAND|ONTOP|NODROPACCEPTED|NOFOCUS', '|')
$Gui = GUICreate("My Program", 250, 110)
$element1=GUICtrlCreateButton('Получить состояние', 10, 10, 120, 22)
$element2=GUICtrlCreateButton('Тестовая кнопка', 10, 40, 120, 22)
GUICtrlSetState(-1, 128)
$element3=GUICtrlCreateLabel('Done', 10, 70, 120, 17)
GUICtrlSetState(-1, 8+8192)
$element4=GUICtrlCreateLabel('Скрытая', 10, 90, 120, 17)
GUICtrlSetState(-1, 32)

GUISetState ()
While 1
   $msg = GUIGetMsg()
   Select
   
       Case $msg = $element1
	   
			For $j = 1 to 10
				$bt0=GUICtrlRead(Eval('element' & $j))
				If $bt0='' Then ContinueLoop
				; MsgBox(0, 'Сообщение', GUICtrlGetState(Eval('element' & $j)))
				$aA=_ArrGetVal(GUICtrlGetState(Eval('element' & $j))) ; получить массив параметров
				$T=''
				For $i = 1 to $aA[0]
					If $aA[$i]+1>$a[0] Then
						$r='???'
					Else
						$r='$GUI_'&$a[$aA[$i]+1]
					EndIf
					$T&=2^$aA[$i]&' - '&StringFormat("0x%X", 2^$aA[$i])&' - '&$r&@CRLF
				Next
				MsgBox(0, 'Состояние "' &$bt0&'"', $T)
			Next

       Case $msg = -3
           Exit
   EndSelect
WEnd

Func _ArrGetVal($Value)
	If $Value = 0 Then Return
	Local $s, $aV[1]=[0]
	$s=Int(Log($Value) / Log(2)) ; преобразование к логарифму по основанию 2
	$c=1
	For $i = 1 to $s
		$s=2^$i
		If BitAnd($Value, $s) Then
			$c +=1
			ReDim $aV[$c]
			$aV[$c-1]=$i
		EndIf
	Next
	$aV[0]=$c-1
    Return $aV
EndFunc