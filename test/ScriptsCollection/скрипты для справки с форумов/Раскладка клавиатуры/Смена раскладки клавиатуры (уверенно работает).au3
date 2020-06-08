Run ("notepad.exe")
WinWaitActive ("Безымянный - Блокнот")
$win_handle = WinGetHandle ("Безымянный - Блокнот")

;~ переключение в английскую раскладку
_SetKeyboardLayout("00000409", $win_handle)
Send ("English")

;~ переключение в русскую раскладку
_SetKeyboardLayout("00000419", $win_handle)
Send (@CRLF & "Русский")
    Sleep (200)

WinClose ("Безымянный - Блокнот")
WinWaitActive ("Блокнот", "Текст в файле Безымянный был изменен.")
$win_handle = WinGetHandle ("Блокнот", "Текст в файле Безымянный был изменен.")
    Sleep (200)

;~ выбор кнопки нет вызовом ALT+н (буква Н - русская)
Send ("!{н}")

Func _SetKeyboardLayout($sLayoutID, $hWnd)
    Local $WM_INPUTLANGCHANGEREQUEST = 0x50
    Local $ret = DllCall("user32.dll", "long", "LoadKeyboardLayout", "str", $sLayoutID, "int", 0)
    DllCall("user32.dll", "int", "SendMessage", "hwnd", $hWnd, _
                                                "int", $WM_INPUTLANGCHANGEREQUEST, _
                                                "int", 1, _
                                                "int", $ret[0])
EndFunc
