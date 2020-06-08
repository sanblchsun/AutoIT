$Gui = GUICreate('My program',  420, 250, -1, 30)

$a1 = GUICtrlCreateButton("угол", 5, 5, 50, 30)
$b1 = GUICtrlCreateButton("центр", 5, 45, 50, 30)

$a2 = GUICtrlCreateButton("угол", 360, 170, 50, 30)
$b2 = GUICtrlCreateButton("центр", 360, 210, 50, 30)


$yzit = GUICtrlCreateButton("уменьшить", 170, 110, 70, 30)
GUISetState ()

While 1
	$msg = GUIGetMsg()
	Switch $msg
		Case $a1, $a2
			_MsgFile(1)
		Case $b1, $b2
			_MsgFile()
		Case $yzit
			WinMove($Gui, '', Default, Default, 200, 100)
			GUICtrlSetPos($a1, 5, 3)
			GUICtrlSetPos($b1, 5, 35)
			GUICtrlSetPos($a2, 140, 3)
			GUICtrlSetPos($b2, 140, 35)
			GUICtrlSetPos($yzit, 60, 30)
		Case -3
			Exit
	EndSwitch
WEnd

Func _MsgFile($t=0)
$GP = _ChildCoor($Gui, 270, 180, $t, 30)
Local $EditBut, $Gui1, $msg, $StrBut
	GUISetState(@SW_DISABLE, $Gui)
	
    $Gui1 = GUICreate('Сообщение', $GP[2], $GP[3],$GP[0], $GP[1], -1, 0x00000080,$Gui)
	GUICtrlCreateLabel('Что будем делать сейчас?', 20, 10, 180, 23)
	$EditBut=GUICtrlCreateButton('Редактор', 10, 40, 80, 22)
	$StrBut=GUICtrlCreateButton ('Калькулятор', 100, 40, 80, 22)
	GUISetState(@SW_SHOW, $Gui1)
	While 1
	  $msg = GUIGetMsg()
	  Select
		Case $msg = $EditBut
			Run('Notepad.exe')
		Case $msg = $StrBut
			ShellExecute('Calc.exe')
		Case $msg = -3
			GUISetState(@SW_ENABLE, $Gui)
			GUIDelete($Gui1)
			ExitLoop
		EndSelect
    WEnd
EndFunc

; вычисление координат дочернего окна
Func _ChildCoor($Gui, $w, $h, $c=0, $d=0)
	Local $GP = WinGetPos($Gui)
	$DX=@DesktopWidth
	$DY=@DesktopHeight
	If $c = 0 Then
		$GP[0]=$GP[0]+($GP[2]-$w)/2
		$GP[1]=$GP[1]+($GP[3]-$h)/2
	EndIf
	If $GP[0]+$w+$d>$DX Then $GP[0]=$DX-$w-10-$d
	If $GP[1]+$h+60+$d>$DY Then $GP[1]=$DY-$h-70-$d
	If $GP[0]<=$d Then $GP[0]=$d
	If $GP[1]<=$d Then $GP[1]=$d
	$GP[2]=$w
	$GP[3]=$h
	Return $GP
EndFunc