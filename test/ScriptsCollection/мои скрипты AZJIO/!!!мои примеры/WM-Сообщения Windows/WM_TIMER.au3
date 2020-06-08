Global $k=0
$Gui = GUICreate("Нажми Старт", 370, 140)
GUICtrlCreateLabel('Функция WM_TIMER запускает счётчик времени, который выполняет событие через указанный интервал многократно, пока не будет остановлен. Интервал вызова можно изменить, текущий 300 мсек.', 5, 5, 360, 60)
$Start = GUICtrlCreateButton('Старт', 10, 70, 70, 25)
$Fast = GUICtrlCreateButton('Быстрей', 90, 70, 70, 25)
$Stop = GUICtrlCreateButton('Стоп', 170, 70, 70, 25)

GUISetState()

While 1
   Switch GUIGetMsg()
       Case $Start 
           _Start()
       Case $Fast
           _Fast()
       Case $Stop
           _Stop()
       Case -3
           Exit
   EndSwitch
WEnd

Func _Start()
	GUIRegisterMsg(0x0113, "WM_TIMER")
	DllCall("User32.dll", "int", "SetTimer", "hwnd", $Gui, "int", 50, "int", 300, "int", 0) ; здесь 300 - установка интервала вызова WM_TIMER
EndFunc

Func _Fast()
	DllCall("User32.dll", "int", "SetTimer", "hwnd", $Gui, "int", 50, "int", 30, "int", 0)
EndFunc

Func _Stop()
	GUIRegisterMsg(0x0113, '')
    DllCall("user32.dll", "int", "KillTimer", "hwnd", $Gui, "int*", 50)
EndFunc

Func WM_TIMER()
	$k+=1
	WinSetTitle($Gui, '', 'Вызов ' &$k& ' раз')
EndFunc