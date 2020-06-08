OnAutoItExitRegister('_Exit')
$gui = GUICreate("Анимационный старт", 300, 230)
$lg=GUICtrlCreateLabel("Плавно нарастающая прозрачность", 20, 30, 200, 17)

WinSetTrans($gui,"",0)
GUISetState()

For $i = 0 to 255 Step 3
	WinSetTrans($gui,"",$i)
	Sleep(1)
Next

While 1
	$msg = GUIGetMsg()
	Select
		Case $msg = -3
			Exit
	EndSelect
WEnd

Func _Exit()
	For $i = 255 to 0 step -3
		WinSetTrans("","",$i)
		Sleep(1)
	Next
EndFunc