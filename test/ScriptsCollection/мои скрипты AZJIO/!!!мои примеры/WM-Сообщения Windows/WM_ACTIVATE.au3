Global Const $WA_ACTIVE = 1
Global Const $WA_CLICKACTIVE = 2
Global Const $WA_INACTIVE = 0

Global $k = 0
$Gui = GUICreate("WM_ACTIVATE", 550, 140)
GUICtrlCreateLabel('Функция WM_ACTIVATE выполняется при изменении активности окна (сворачиваие, активирование иного окна).', 5, 5, 360, 130)

GUISetState()

GUIRegisterMsg(0x0006, "WM_ACTIVATE")

Do
Until GUIGetMsg() = -3

Func WM_ACTIVATE($hWnd, $Msg, $wParam, $lParam)
	Local $xClient, $yClient
	$Active = BitAND($wParam, 0xFFFF) ; _WinAPI_LoWord
	$Minimized = BitShift($wParam, 16) ; _WinAPI_HiWord
	$k += 1
	If $Minimized Then
		ToolTip('минимизация = ' & $Minimized, Default, Default, 'Минимизировано', 1, 4 + 1)
	Else
		ToolTip('')
	EndIf
	WinSetTitle($Gui, '', 'Вызов ' & $k & ' раз, Флаги: активация = ' & $Active & ', минимизация = ' & $Minimized)
EndFunc