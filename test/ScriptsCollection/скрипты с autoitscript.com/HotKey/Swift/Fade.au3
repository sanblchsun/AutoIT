Func Fadein($GUI)
    DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $GUI, "int", 1000, "long", 0x00080000)
EndFunc
Func Fadeout($GUI)
    DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $GUI, "int", 1000, "long", 0x00090000)
EndFunc