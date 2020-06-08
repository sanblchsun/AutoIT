Global $k=0
$Gui = GUICreate("Тест движения мыши", 370, 140, -1, -1, 0x00040000+0x00020000)
GUICtrlCreateLabel('Функция WM_NCMOUSEMOVE выполняется при пересечении границ окна и скольжении по границе.'&@CRLF&'Отличается от WM_NCHITTEST тем, что реагирует только на пересечение границ клиенской области окна, а при непересечении совершенно не реагирует.', 5, 5, 360, 130)

GUISetState()
GUIRegisterMsg(0x00A0 , "WM_NCMOUSEMOVE")

Do
Until GUIGetMsg() = -3

Func WM_NCMOUSEMOVE($hWnd, $Msg, $wParam, $lParam)
	; координаты мыши, если в заголовке и краях окна
	Local $xClient = BitAND($lParam, 0xFFFF)
	Local $yClient = BitShift($lParam, 16)
	Local $hit = BitAND($wParam, 0xFFFF)
	$k+=1
	WinSetTitle($Gui, '', 'Вызов ' &$k& ' раз, x='&$xClient&', y='&$yClient&', '&$hit)
EndFunc 