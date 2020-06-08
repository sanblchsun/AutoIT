DisplayChangeRes(1024, 768, 32, 85)

Func DisplayChangeRes($WIDTH, $HEIGHT, $BPP, $FREQ)
	$DM_PELSWIDTH = 0x00080000
	$DM_PELSHEIGHT = 0x00100000
	$DM_BITSPERPEL = 0x00040000
	$DM_DISPLAYFREQUENCY = 0x00400000
	$CDS_TEST = 0x00000002
	$CDS_UPDATEREGISTRY = 0x00000001
	$DISP_CHANGE_RESTART = 1
	$DISP_CHANGE_SUCCESSFUL = 0
	$HWND_BROADCAST = 0xffff
	$WM_DISPLAYCHANGE = 0x007E
	$DEVMODE = DllStructCreate("byte[32];int[10];byte[32];int[6]")
	$B = DllCall("user32.dll", "int", "EnumDisplaySettings", "ptr", 0, "long", 0, "ptr", DllStructGetPtr($DEVMODE))
	If @error Then
		$B = 0
	Else
		$B = $B[0]
	EndIf
	If $B <> 0 Then
		DllStructSetData($DEVMODE, 2, BitOR($DM_PELSWIDTH, $DM_PELSHEIGHT, $DM_BITSPERPEL, $DM_DISPLAYFREQUENCY), 5)
		DllStructSetData($DEVMODE, 4, $WIDTH, 2)
		DllStructSetData($DEVMODE, 4, $HEIGHT, 3)
		DllStructSetData($DEVMODE, 4, $BPP, 1)
		DllStructSetData($DEVMODE, 4, $FREQ, 5)
		$B = DllCall("user32.dll", "int", "ChangeDisplaySettings", "ptr", DllStructGetPtr($DEVMODE), "int", $CDS_TEST)
		If @error Then
			$B = -1
		Else
			$B = $B[0]
		EndIf
		Select
			Case $B = $DISP_CHANGE_RESTART
				$DEVMODE = ""
				Return 2
			Case $B = $DISP_CHANGE_SUCCESSFUL
				DllCall("user32.dll", "int", "ChangeDisplaySettings", "ptr", DllStructGetPtr($DEVMODE), "int", $CDS_UPDATEREGISTRY)
				DllCall("user32.dll", "int", "SendMessage", "hwnd", $HWND_BROADCAST, "int", $WM_DISPLAYCHANGE, _
						"int", $BPP, "int", $HEIGHT * 2 ^ 16 + $WIDTH)
				$DEVMODE = ""
				Return 1
			Case Else
				$DEVMODE = ""
				Return $B
		EndSelect
	EndIf
EndFunc   ;==>DisplayChangeRes