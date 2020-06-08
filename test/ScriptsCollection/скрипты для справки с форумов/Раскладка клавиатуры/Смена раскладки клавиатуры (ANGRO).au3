Run("notepad.exe")
Sleep(500)
;установка режима поиска окон по указателям (Advanced mode)
Opt("WinTitleMatchMode",4)
;получение указателя (уникального идентификатора) окна с именем класса "Notepad" и запись его в переменную $hWnd
$hWnd = WinGetHandle("classname=Notepad")
;переключение раскладки в окне, определяемом указателем $hWnd
_SetKeyboardLayout("00000409", $hWnd)

Func _SetKeyboardLayout($sLayoutID, $hWnd)
Local $WM_INPUTLANGCHANGEREQUEST = 0x50
Local $ret = DllCall("user32.dll", "long", "LoadKeyboardLayout", "str", $sLayoutID, "int", 0)
DllCall("user32.dll", "ptr", "SendMessage", "hwnd", $hWnd, "int", $WM_INPUTLANGCHANGEREQUEST, "int", 1, "int", $ret[0])
EndFunc
Exit
#cs
Дополнительные языки.
"00000407" Немецкий (стандартный)
"00000409" Английский (США)
"0000040C" Французский (стандартный)
"0000040D" Финский
"00000410" Итальянский
"00000415" Польский
"00000419" Русский
"00000422" Украинский"00000423" Белорусский
"00000425" Эстонский
"00000426" Латвийский
"00000427" Литовский
#ce