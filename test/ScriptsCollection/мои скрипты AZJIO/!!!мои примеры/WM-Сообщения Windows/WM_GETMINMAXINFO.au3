Global $k=0
$Gui = GUICreate("»змени размер окна, максимизируй", 390, 140, -1, -1, 0x00040000+0x00020000+0x00010000)
GUICtrlCreateLabel('‘ункци€ WM_GETMINMAXINFO срабатывает во врем€ перемещени€ окна, сворачивани€ и изменени€ размеров. ѕозвол€ет установить пределы увеличени€ и уменьшени€ окна как по горизонтали так и по вертикали индивидуально. ј также позицию и размеры развЄрнутого состо€ни€. ”становочные параметры можно игнорировать указав только необходимые параметры.', 5, 5, 360, 130)

GUISetState()

GUIRegisterMsg(0x0024, "WM_GETMINMAXINFO")

Do
Until GUIGetMsg() = -3

Func WM_GETMINMAXINFO($hWnd, $iMsg, $wParam, $lParam)
	$k+=1
	WinSetTitle($Gui, '', 'ѕопытка ' &$k& ' раз')
	#forceref $iMsg, $wParam
	If $hWnd = $GUI Then
		Local $tMINMAXINFO = DllStructCreate("int;int;" & _
				"int MaxSizeX; int MaxSizeY;" & _
				"int MaxPositionX;int MaxPositionY;" & _
				"int MinTrackSizeX; int MinTrackSizeY;" & _
				"int MaxTrackSizeX; int MaxTrackSizeY", _
				$lParam)
		DllStructSetData($tMINMAXINFO, "MinTrackSizeX", 360) ; минимальные размеры окна
		DllStructSetData($tMINMAXINFO, "MinTrackSizeY", 130)
		DllStructSetData($tMINMAXINFO, "MaxTrackSizeX", 460) ; максимальные размеры окна
		DllStructSetData($tMINMAXINFO, "MaxTrackSizeY", 180)
		DllStructSetData($tMINMAXINFO, "MaxSizeX", 400) ; размеры развЄрнутого состо€ни€ ( просто удали строку, чтоб игнорировать критерий)
		DllStructSetData($tMINMAXINFO, "MaxSizeY", 180)
		DllStructSetData($tMINMAXINFO, "MaxPositionX", 400) ; позици€ в развЄрнутом состо€нии
		DllStructSetData($tMINMAXINFO, "MaxPositionY", 450)
	EndIf
EndFunc