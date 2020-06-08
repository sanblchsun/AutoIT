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

Func WM_KEYUP($hWnd, $Msg, $wParam, $lParam)
	$aRet = DllCall('user32.dll', 'int', 'GetKeyNameText', 'int', $lParam, 'str', "", 'int', 256)
	WinSetTitle($Gui, '', $aRet[2]&'  - Отпущена')
EndFunc

Func WM_KEYDOWN($hWnd, $Msg, $wParam, $lParam)
	$aRet = DllCall('user32.dll', 'int', 'GetKeyNameText', 'int', $lParam, 'str', "", 'int', 256)
	WinSetTitle($Gui, '',  $aRet[2]&'  - Нажата')
EndFunc