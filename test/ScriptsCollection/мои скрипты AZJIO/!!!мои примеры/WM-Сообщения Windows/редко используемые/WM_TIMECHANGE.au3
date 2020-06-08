Global $k=0
GUIRegisterMsg(0x001E , "WM_TIMECHANGE")
$Gui = GUICreate("Измени системную дату или время", 390, 180, -1, -1, 0x00040000+0x00020000)
GUICtrlCreateLabel('Функция WM_TIMECHANGE срабатывает в момент изменения системной даты, времени. Можно использовать как один из критериев защиты программы в триальном режиме.', 5, 5, 360, 55)
$Label = GUICtrlCreateLabel('Время: '&@HOUR&':'&@MIN&':'&@SEC&@CRLF&'Дата: '&@MDAY&':'&@MON&':'&@YEAR, 10, 60, 226, 34)

GUISetState()

Do
Until GUIGetMsg() = -3

Func WM_TIMECHANGE()
	$k+=1
	WinSetTitle($Gui, '', 'Смена ' &$k& ' раз')
	GUICtrlSetData($Label, 'Время: '&@HOUR&':'&@MIN&':'&@SEC&@CRLF&'Дата: '&@MDAY&':'&@MON&':'&@YEAR)
EndFunc