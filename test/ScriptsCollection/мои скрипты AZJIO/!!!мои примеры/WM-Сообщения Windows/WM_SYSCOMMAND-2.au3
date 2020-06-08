Global $k=0
GUIRegisterMsg(0x0112, "WM_SYSCOMMAND")
$Gui = GUICreate("Измени размер окна вправо, потом вниз", 440, 170, -1, -1, 0x00040000+0x00020000)
GUICtrlCreateLabel('Функция WM_SYSCOMMAND срабатывает только в момент клика по заголовку окна или изменении размеров окна. В данном случае используется проверка возвращаемых параметров направления изменения размеров окна.'&@CRLF&@CRLF&'Размер возможно изменять только по горизонтали.', 5, 5, 430, 130)
GUISetState()

While GUIGetMsg() <> -3
WEnd

Func WM_SYSCOMMAND($hWnd, $Msg, $wParam, $lParam)
	$k+=1
	WinSetTitle($Gui, '', 'Попытка ' &$k& ' раз')
    If $wParam = 0xF003 Or $wParam = 0xF004 Or $wParam = 0xF005 Or $wParam = 0xF006 Or $wParam = 0xF007 Or $wParam = 0xF008 Then Return 0
	;$wParam = 0xF001 Or $wParam = 0xF002 - а эти запрещают по горизонтали
EndFunc


