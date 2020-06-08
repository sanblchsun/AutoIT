#include <GUIConstants.au3>

; Here's an awesome list of virtual key codes -> http://delphi.about.com/od/objectpascalide/l/blvkc.htm

; Manadar
; http://www.autoitscript.com/forum/topic/70401-hotkeyset-registerhotkey/

$MOD_ALT = 0x0001
$MOD_CONTROL = 0x0002
$MOD_SHIFT = 0x0004
$MOD_WIN = 0x0008

$hWnd = GUICreate("Nothing", 100, 100)
GUIRegisterMsg(0x0312, "WM_HOTKEY")

; Shift + 1    , 2 etc
For $i = 0x30 To 0x5A
    DllCall("user32.dll", "short", "RegisterHotKey", "hwnd", $hWnd, "int", "1337" & Dec($i) , "uint", $MOD_SHIFT, "uint", $i)
Next
For $i = 0x30 To 0x5A
    DllCall("user32.dll", "short", "RegisterHotKey", "hwnd", $hWnd, "int", "1338" & Dec($i) , "uint", 0, "uint", $i)
Next

While 1
    Sleep(100)
WEnd

Func WM_HOTKEY($hWnd, $Msg, $wParam, $lParam)
    $n = Chr(Dec(StringMid($lParam,5,2)))
    $caps = StringRight($lParam,1)
    If $caps = "4" Then
        $n = "+" & StringLower($n)
    EndIf
    MsgBox(0, "", "You pressed " & $n )
EndFunc