Global $k=0
$Gui = GUICreate("Кликни заголовок", 370, 140, -1, -1, 0x00040000+0x00020000)
GUICtrlCreateLabel('Функция WM_CAPTURECHANGED выполняется при изменении размеров окна, перемещении и отпуске заголовка.', 5, 5, 360, 130)

GUISetState()
GUIRegisterMsg(0x0215 , "WM_CAPTURECHANGED")

Do
Until GUIGetMsg() = -3

Func WM_CAPTURECHANGED()
	$k+=1
	$GP = WinGetPos($Gui)
	WinSetTitle($Gui, '',  'Попытка ' &$k& ' раз')
EndFunc
