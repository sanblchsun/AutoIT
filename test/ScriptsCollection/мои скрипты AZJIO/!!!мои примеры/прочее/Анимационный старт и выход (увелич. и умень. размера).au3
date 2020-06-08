
Opt("GUIResizeMode", 0x0322)
OnAutoItExitRegister('_Exit')
Global $x=300, $y=230
$gui = GUICreate("Анимационный старт", $x/5, $y/5)
$lg=GUICtrlCreateLabel("Плавно нарастающая прозрачность", 10, 10, 200, 17)
GUICtrlSetResizing(-1, 102+256)
GUISetState()
_Start($x, $y)

While 1
	$msg = GUIGetMsg()
	Select
		Case $msg = -3
			Exit
	EndSelect
WEnd

Func _Exit($x, $y)
$xD=@DesktopWidth
$yD=@DesktopHeight
$x0=$x/100
$y0=$y/100
	For $i = 100 to 20 step -1
		WinMove($Gui, '', $xD/2-$x0*$i/2, $yD/2-$y0*$i/2, $x0*$i , $y0*$i)
		Sleep(1)
	Next
EndFunc

Func _Start($x, $y)
$xD=@DesktopWidth
$yD=@DesktopHeight
$x0=$x/100
$y0=$y/100
	For $i = 20 to 100
		WinMove($Gui, '', $xD/2-$x0*$i/2, $yD/2-$y0*$i/2, $x0*$i , $y0*$i)
		Sleep(1)
	Next
EndFunc