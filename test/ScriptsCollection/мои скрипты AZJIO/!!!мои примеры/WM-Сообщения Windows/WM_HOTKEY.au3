Global $k=0

Global Const $HOTKEYF_SHIFT = 0x01
Global Const $HOTKEYF_CONTROL = 0x02
Global Const $HOTKEYF_ALT = 0x04
Global Const $MOD_ALT = 0x1
Global Const $MOD_SHIFT = 0x4

$hGUI = GUICreate("Вызови хоткей Ctrl+Alt+С", 390, 150)
GUICtrlCreateLabel('Функция WM_HOTKEY срабатывает при вызове зарегистрированных горячих клавиш. Каждой горячей клавише назначается ID от 1001 и далее. В функции указывается условие проверки ID. Переменная $sModKey содержит сумму модификаторов (Shift=1, Ctrl=2, Alt=4), а переменная $sVirtKey - номер кливиши клавиатуры. Этот пример взят при разборе GuiHotKey.au3 и GuiHotKey_Example.au3 от rasim.'&@CRLF&'Горячая клавиша действует даже когда окно неактивно, но при условии, что клавиша не была занята другим приложением первоначально.', 5, 5, 360, 140)
GUISetState()

GUIRegisterMsg(0x312, "WM_HOTKEY")

$sID=1001
$sVirtKey=67
$sModKey=6
$iModKey = 0
If BitAND($sModKey, $HOTKEYF_SHIFT) Then $iModKey = BitOR($iModKey, $MOD_SHIFT)
If BitAND($sModKey, $HOTKEYF_CONTROL) Then $iModKey = BitOR($iModKey, $HOTKEYF_CONTROL)
If BitAND($sModKey, $HOTKEYF_ALT) Then $iModKey = BitOR($iModKey, $MOD_ALT)
$aRet = DllCall("user32.dll", "int", "RegisterHotKey", "hwnd", $hGUI, "int", $sID, "int", $iModKey, "int", "0x" & Hex($sVirtKey, 2))


Do
Until GUIGetMsg() = -3

Func WM_HOTKEY($hWnd, $Msg, $wParam, $lParam)
	$k+=1
	WinSetTitle($hGUI, '', 'Вызов ' &$k& ' раз')
	; Local $iKeyID = BitAND($wParam, 0xFFFF)
	; If $iKeyID = 1001 Then Run("calc.exe")
EndFunc   ;==>WM_HOTKEY
