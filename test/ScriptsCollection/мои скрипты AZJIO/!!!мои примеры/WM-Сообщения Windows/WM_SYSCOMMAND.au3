Global $k=0
GUIRegisterMsg(0x0112 , "WM_SYSCOMMAND")
$Gui = GUICreate(" ликни по заголовку", 370, 180)
GUICtrlCreateLabel('‘ункци€ WM_SYSCOMMAND срабатывает в момент клика по заголовку окна, изменении размеров окна (однократно), при сворачивании.'&@CRLF&'ћне понадобилось сделать магнит к окнам. Ќужно было получить список окон один раз в момент клика по заголовку. ƒалее список уже провер€лс€ командой WM_MOVE '&@CRLF&'ћожно использовать дл€ сохранение размеров окна в момент сворачивани€, тогда при закрытии программы с панели задач будут сохранены последние координаты.', 5, 5, 360, 150)
$condition = GUICtrlCreateLabel('', 10, 155, 360, 17)

GUISetState()

Do
Until GUIGetMsg() = -3

Func WM_SYSCOMMAND($hWnd, $Msg, $wParam, $lParam)
	$k+=1
	WinSetTitle($Gui, '', ' ликнул по заголовку ' &$k& ' раз')

	#forceref $Msg, $wParam
	Local $MouseX, $MouseY

	;  оординаты мыши относительно экрана монитора.
	$MouseX = BitAND($lParam, 0xFFFF)
	$MouseY = BitShift($lParam, 16)

	$k+=1
	GUICtrlSetData($condition,'MouseX='&$MouseX&', MouseY='&$MouseY)

	Return 'GUI_RUNDEFMSG'
EndFunc