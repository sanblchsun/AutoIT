Run(@WindowsDir & "\Notepad.exe")
WinWait("[Class:Notepad]", "", 5)

;получение указателя (уникального идентификатора) окна с именем класса "Notepad" и запись его в переменную $hWnd
$hWnd = WinGetHandle("[Class:Notepad]")

;Получаем текущую раскладку клавиатуры в окне блокнота
$nOld_Layout = _GetKeyboardLayout($hWnd)

Sleep(1000)

;Переключение раскладки в окне, определяемом указателем $hWnd
_SetKeyboardLayout("00000419", $hWnd)

;Пишем данные в Edit-поле
ControlSend($hWnd, "", "Edit1", "Ntcn")

Sleep(1000)

;Переключаем раскладку обратно на исходную
_SetKeyboardLayout($nOld_Layout, $hWnd)

Func _SetKeyboardLayout($sLayoutID, $hWnd)
    Local $WM_INPUTLANGCHANGEREQUEST = 0x50

    If StringLen($sLayoutID) <= 3 Then $sLayoutID = "00000" & $sLayoutID
    Local $aRet = DllCall("user32.dll", "long", "LoadKeyboardLayout", "str", $sLayoutID, "int", 0)

    DllCall("user32.dll", "ptr", "SendMessage", "hwnd", $hWnd, "int", $WM_INPUTLANGCHANGEREQUEST, "int", 1, "int", $aRet[0])
EndFunc

Func _GetKeyboardLayout($hWnd)
    Local $aRet = DllCall("user32.dll", "long", "GetWindowThreadProcessId", "hwnd", $hWnd, "ptr", 0)
    $aRet = DllCall("user32.dll", "long", "GetKeyboardLayout", "long", $aRet[0])

    Return "0000" & Hex($aRet[0], 4)
EndFunc

#cs
    Дополнительные языки.

    "00000407" Немецкий (стандартный)
    "00000409" Английский (США)
    "0000040C" Французский (стандартный)
    "0000040D" Финский
    "00000410" Итальянский
    "00000415" Польский
    "00000419" Русский
    "00000422" Украинский
    "00000423" Белорусский
    "00000425" Эстонский
    "00000426" Латвийский
    "00000427" Литовский
#ce