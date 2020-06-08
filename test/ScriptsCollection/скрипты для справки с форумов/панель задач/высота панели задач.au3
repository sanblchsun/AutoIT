$aTray = WinGetPos('[CLASS:Shell_TrayWnd]')
MsgBox(0, 'Сообщение', $aTray[3])