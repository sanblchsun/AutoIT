Global $k=0
$Gui = GUICreate("Вставь флешку", 370, 140)
GUICtrlCreateLabel('Функция WM_DEVICECHANGE срабатывает во время изменения железа в системе, например подключенная флешка. В качестве примера на офсайте USBMon.au3 от rasim', 5, 5, 360, 130)

GUISetState()
GUIRegisterMsg(0x0219, "WM_DEVICECHANGE")

Do
Until GUIGetMsg() = -3

Func WM_DEVICECHANGE()
	$k+=1
	WinSetTitle($Gui, '', 'Вызов ' &$k& ' раз')
EndFunc