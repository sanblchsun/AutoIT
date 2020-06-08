Global $k=0
$Gui = GUICreate("Наведи курсора на элемент Edit", 390, 280, -1, -1, 0x00040000+0x00020000)
GUICtrlCreateLabel('Функция WM_CTLCOLOREDIT срабатывает в момент наведения курсора на элемент Edit, вернее пересечения её границ.', 5, 5, 380, 34)
GUICtrlCreateEdit('', 10, 40, 280, 180)

GUISetState()
GUIRegisterMsg (0x0133, "WM_CTLCOLOREDIT")

Do
Until GUIGetMsg() = -3

Func WM_CTLCOLOREDIT()
	$k+=1
	$GP = MouseGetPos()
	WinSetTitle($Gui, '', 'Вызов ' &$k& ' раз, x='&$GP[0]&', y='&$GP[1])
EndFunc