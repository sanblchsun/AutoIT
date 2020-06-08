Global $k=0
$Gui = GUICreate("Тест движения мыши", 370, 140, -1, -1, 0x00040000+0x00020000)
GUICtrlCreateLabel('Функция WM_NCMOUSELEAVE срабатывает в момент пересечения границ клиенской области окна, и не реагирует на скольжение по границе.', 5, 5, 360, 130)

GUISetState()
GUIRegisterMsg(0x02A2 , "WM_NCMOUSELEAVE")

Do
Until GUIGetMsg() = -3

Func WM_NCMOUSELEAVE()
	$k+=1
	WinSetTitle($Gui, '', 'Попытка ' &$k& ' раз')
EndFunc