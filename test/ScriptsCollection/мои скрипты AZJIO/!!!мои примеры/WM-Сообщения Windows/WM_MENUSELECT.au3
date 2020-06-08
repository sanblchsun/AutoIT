Global $k=0
GUIRegisterMsg (0x011F, "WM_MENUSELECT")
$Gui = GUICreate("Выбери пункт главного меню", 390, 170)
GUICtrlCreateLabel('Функция WM_MENUSELECT срабатывает в момент выбора главного или контекстного меню и его пунктов.', 5, 5, 380, 34)
$filemenu=GUICtrlCreateMenu('&File')
GUICtrlCreateMenuitem('Open',$filemenu)
GUICtrlCreateMenuitem('Save',$filemenu)
$helpmenu=GUICtrlCreateMenu('&Help')
GUICtrlCreateMenuitem('Web',$helpmenu)
GUICtrlCreateMenuitem('Support',$helpmenu)
$statist=GUICtrlCreateLabel('', 205, 40, 190, 134)

$ContMenu = GUICtrlCreateContextMenu()
GUICtrlCreateMenuitem('Del',$ContMenu)
GUICtrlCreateMenuitem('Exit',$ContMenu)

GUISetState()

Do
Until GUIGetMsg() = -3

Func WM_MENUSELECT($hWnd, $Msg, $wParam, $lParam)
	Local $IDsubitem = BitAND($wParam, 0xFFFF)
	Local $16 = BitShift($lParam, 16)
	Local $lParam1 = BitAND($lParam, 0xFFFF)
	Local $lParam2 = BitShift($lParam, 16)
	$k+=1
	WinSetTitle($Gui, '', 'Вызов ' &$k)
	GUICtrlSetData($statist, 'ID подпункта='&$IDsubitem&@CRLF&'16='&$16&@CRLF&'lParam1='&Hex(Int($lParam1),4)&@CRLF&'lParam2='&$lParam2)
EndFunc