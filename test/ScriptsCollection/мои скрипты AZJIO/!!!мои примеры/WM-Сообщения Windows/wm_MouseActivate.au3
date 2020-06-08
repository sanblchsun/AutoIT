Global $k=0
$Gui = GUICreate("активируй другое, и далее активируй это", 390, 140)
GUICtrlCreateLabel('Функция wm_MouseActivate выполняется при активации окна мышкой', 5, 5, 360, 130)

GUISetState()

GUIRegisterMsg(0x0021 , "wm_MouseActivate")

Do
Until GUIGetMsg() = -3

Func wm_MouseActivate()
	$k+=1
	WinSetTitle($Gui, '', 'Изменено состояние ' &$k& ' раз')
EndFunc