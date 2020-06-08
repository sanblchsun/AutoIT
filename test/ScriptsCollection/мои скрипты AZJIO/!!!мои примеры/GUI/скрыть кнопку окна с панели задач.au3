#NoTrayIcon
$hMainWin     = GUICreate('Main Win')
$hChildWin    = GUICreate('Child Win', 400, 400, -1, -1, 0x00040000+0x00020000+0x00010000, -1, $hMainWin) ; с стилях максимизация, ресайз, чтоб все кнопки отображались
GUISetState(@SW_SHOW, $hChildWin)
Do
Until GUIGetMsg() = -3