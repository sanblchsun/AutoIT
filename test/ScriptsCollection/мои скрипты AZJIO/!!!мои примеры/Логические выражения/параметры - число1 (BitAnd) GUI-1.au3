$Gui = GUICreate("My Program", 250, 110)
$element1=GUICtrlCreateButton('Получить состояние', 10, 10, 120, 22)
$element2=GUICtrlCreateButton('Тестовая кнопка', 10, 40, 120, 22)
GUICtrlSetState(-1, 128)
$element3=GUICtrlCreateLabel('Done', 10, 70, 120, 17)
GUICtrlSetState(-1, 8)
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
				
				$aA=_ArrGetVal(GUICtrlGetState(Eval('element' & $j))) ; получить массив параметров
				$aA=_ArrBackOrderS($aA) ; обратныйы порядок массива
				$T=''
				For $i = 1 to $aA[0]
					$T&=$aA[$i]&' - '&_St($aA[$i])&@CRLF
				Next
				MsgBox(0, 'Состояние "' &$bt0&'"', $T)
			Next

       Case $msg = -3
           Exit
   EndSelect
WEnd


Func _St($St)
	Switch $St
		Case 1
		   $r='$GUI_CHECKED'
		Case 2
		   $r='$GUI_INDETERMINATE'
		Case 4
		   $r='$GUI_UNCHECKED'
		Case 8
		   $r='$GUI_DROPACCEPTED'
		Case 16
		   $r='$GUI_SHOW'
		Case 32
		   $r='$GUI_HIDE'
		Case 64
		   $r='$GUI_ENABLE'
		Case 128
		   $r='$GUI_DISABLE'
		Case 256
		   $r='$GUI_FOCUS'
		Case 512
		   $r='$GUI_DEFBUTTON '
		Case 1024
		   $r='$GUI_EXPAND'
		Case 2048
		   $r='$GUI_ONTOP'
		Case 4096
		   $r='$GUI_NODROPACCEPTED'
		Case 8192
		   $r='$GUI_NOFOCUS'
		Case Else
		   $r='???'
	EndSwitch
	Return $r
EndFunc



Func _ArrGetVal($Value)
	Local $k=0, $aV[15], $aN=StringSplit('1|2|4|8|16|32|64|128|256|512|1024|2048|4096|8192', '|')
	For $i = $aN[0] to 1 Step -1
		If BitAnd($Value,$aN[$i]) Then
			$k+=1
			$aV[$k]=$aN[$i]
		EndIf
	Next
	ReDim $aV[$k+1]
	$aV[0]=$k
    return $aV
EndFunc

; Func _ArrGetVal($Value)
	; Local $k=0, $aV[15], $aN=StringSplit('1|2|4|8|16|32|64|128|256|512|1024|2048|4096|8192', '|')
	; For $i = $aN[0] to 1 Step -1
		; If $Value >= $aN[$i] Then
			; $Value=Mod($Value,$aN[$i])
			; $k+=1
			; $aV[$k]=$aN[$i]
		; EndIf
		; If $Value = 0 Then ExitLoop
	; Next
	; ReDim $aV[$k+1]
	; $aV[0]=$k
    ; return $aV
; EndFunc


Func _ArrBackOrderS($a)
	Local $b[$a[0]+1]
	$b[0]=$a[0]
	$a[0]+=1
	For $i = 1 to $a[0]-1
		$b[$i]=$a[$a[0]-$i]
	Next
    return $b
EndFunc