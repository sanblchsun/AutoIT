Global $k = 0
$Gui = GUICreate("Кликни правой кнопкой мыши", 370, 240, -1, -1, 0x00040000 + 0x00020000)
$statist = GUICtrlCreateLabel('Функция WM_CONTEXTMENU выполняется при вызове контекстного меню правой кнопкой мыши.', 5, 5, 360, 68)
$contextmenu = GUICtrlCreateContextMenu()

$button = GUICtrlCreateButton("OK", 100, 100, 70, 20)
$button0 = GUICtrlGetHandle($button)
$buttoncontext = GUICtrlCreateContextMenu($button)
$buttonitem = GUICtrlCreateMenuItem("О кнопке", $buttoncontext)

$newsubmenu = GUICtrlCreateMenu("Новое", $contextmenu)
$textitem = GUICtrlCreateMenuItem("Текст", $newsubmenu)

$fileitem = GUICtrlCreateMenuItem("Открыть", $contextmenu)
$saveitem = GUICtrlCreateMenuItem("Сохранить", $contextmenu)
GUICtrlCreateMenuItem("", $contextmenu) ; разделитель

$infoitem = GUICtrlCreateMenuItem("Информация", $contextmenu)
GUISetState()
GUIRegisterMsg(0x007B, "WM_CONTEXTMENU")

Do
Until GUIGetMsg() = -3

Func WM_CONTEXTMENU($hWnd, $Msg, $wParam, $lParam)
	$x = BitAND($lParam, 0xFFFF) ; _WinAPI_LoWord
	$y = BitShift($lParam, 16) ; _WinAPI_HiWord
	$k += 1
	WinSetTitle($Gui, '', 'Вызов ' & $k)
	GUICtrlSetData($statist, 'Дескритор= ' & $wParam & @LF & 'x=' & $x & @LF & 'y=' & $y)
EndFunc