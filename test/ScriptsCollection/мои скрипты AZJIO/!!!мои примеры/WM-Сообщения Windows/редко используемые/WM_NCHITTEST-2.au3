Global $k=0
Global Const $WM_NCHITTEST = 0x0084
Global Const $GUI_RUNDEFMSG = 'GUI_RUNDEFMSG'
$Gui = GUICreate("Тест движения мыши", 370, 190, -1, -1, 0x00040000+0x00020000)
GUICtrlCreateLabel('Функция WM_NCHITTEST не выполняется, когда окно неактивно, но срабатывает при скольжении по неактивному окну. Если окно активно, то выполняется с некоторой частотой, с увеличением частоты вызова при движении не по элементам интерфейса.', 5, 5, 360, 70)

GUISetState()

GUIRegisterMsg(0x0084, 'WM_NCHITTEST') 

Do
Until GUIGetMsg() = -3

Func WM_NCHITTEST($hWnd, $iMsg, $wParam, $lParam)
	Switch $hWnd
		Case $Gui
			Switch $iMsg
				Case $WM_NCHITTEST
					; координаты мыши, если в клиенской области окна и мышь перемещается
					Local $xClient = BitAND($lParam, 0xFFFF)
					Local $yClient = BitShift($lParam, 16)
					$k+=1
					WinSetTitle($Gui, '', 'Вызов ' &$k& ' раз, x='&$xClient&', y='&$yClient)
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc