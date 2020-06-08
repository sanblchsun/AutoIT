$Gui = GUICreate("Нажимай клавиши клавиатуры", 400, 50)
GUISetState()

GUIRegisterMsg(0x0100, "WM_KEYDOWN")
GUIRegisterMsg(0x0101, "WM_KEYUP")

While 1
   $msg = GUIGetMsg()
   Select
       Case $msg = -3
           Exit
   EndSelect
WEnd

Func WM_KEYDOWN($hWnd, $msg, $wParam, $lParam)
    Local $Tus = Chr(BitAND($wParam, 0xFF))
	WinSetTitle($Gui, '',  $Tus & "(" & BitAND($wParam, 0xFF) & ") Нажата" )
EndFunc

Func WM_KEYUP($hWnd, $msg, $wParam, $lParam)
    Local $Tus = Chr(BitAND($wParam, 0xFF))
	WinSetTitle($Gui, '', $Tus & "(" & BitAND($wParam, 0xFF) & ") Отпущена")
EndFunc