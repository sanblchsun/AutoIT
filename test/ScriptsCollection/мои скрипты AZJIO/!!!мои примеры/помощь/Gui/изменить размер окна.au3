Opt("GUIResizeMode", 2 + 32 + 256 + 512) ; 802
$Gui=GUICreate('', 200, 200, 100, 100)
GUISetState()
Sleep(1000)
WinMove($Gui, '', Default, Default, 450, 450)
While 1
	$msg = GUIGetMsg()
	Switch $msg
		Case -3
		   Exit
	EndSwitch
WEnd