
; http://www.firststeps.ru/mfc/winapi/win/r.php?152
; #include <WindowsConstants.au3>
Global $k=0
HotKeySet('!{ESC}', '_Show')
$Gui = GUICreate("Нажмите кнопку 'Скрыть'", 370, 170) ; , -1, -1, $WS_OVERLAPPEDWINDOW
GUICtrlCreateLabel('Функция WM_SHOWWINDOW срабатывает в момент скрытия и отображения окна, например после скрытия. Нажмите кнопку "Скрыть", и далее горячей клавишей Alt+Esc отобразите окно.', 5, 5, 360, 54)
$Hide = GUICtrlCreateButton('Скрыть', 10, 70, 70, 25)
GUICtrlCreateLabel('Alt+Esc', 100, 70, 70, 25)
GUICtrlSetColor(-1,0xff0000)
GUICtrlSetFont(-1,14)

GUISetState()
GUIRegisterMsg (0x0018, "WM_SHOWWINDOW")

While 1
   $msg = GUIGetMsg()
   Select
       Case $msg = $Hide 
           GUISetState(@SW_HIDE)
       Case $msg = -3
           Exit
   EndSelect
WEnd

Func _Show()
	GuiSetState(@SW_SHOW)
EndFunc

Func WM_SHOWWINDOW($hWnd, $Msg, $wParam, $lParam)
	$k+=1
	If $k Then
		ToolTip('Вызов = ' & $k, Default, Default, 'Отображение = ' & Number($wParam)&', Состояние = '& $lParam, 1, 4 + 1)
	Else
		ToolTip('')
	EndIf
	WinSetTitle($Gui, '', 'Вызов ' &$k)
EndFunc