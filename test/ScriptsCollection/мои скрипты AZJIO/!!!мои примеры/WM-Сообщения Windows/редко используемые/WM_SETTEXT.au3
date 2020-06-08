Global $k=0
Global $sTitle = "Нажми Изменить"

$hGui = GUICreate($sTitle, 370, 140)
GUICtrlCreateLabel('Функция WM_SETTEXT выполняется при изменении текста заголовка окна.', 5, 5, 360, 60)
$Start = GUICtrlCreateButton('Изменить', 10, 70, 70, 25)
GUIRegisterMsg(0x000C, "WM_SETTEXT")

GUISetState()

While 1
   Switch GUIGetMsg()
       Case $Start 
			$k+=1
           WinSetTitle($hGui, '', 'Вызов ' &$k& ' раз')
		   ; GUICtrlSetData($Fast, 'fff' )
		   ; ControlSetText($hGui, "", $Fast, "Новый")
       Case -3
           Exit
   EndSwitch
WEnd

Func WM_SETTEXT()
	MsgBox(0, 'Сообщение', 'Перед тем, как заголовок изменится')
	; Return 0 ; запрещает изменять текст заголовка
EndFunc