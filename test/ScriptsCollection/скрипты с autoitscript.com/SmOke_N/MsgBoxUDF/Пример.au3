#include <MsgBoxUDF.au3>
#region 3 piece function call
; Regardless of Coords, if a handle is passed, it will center messagebox to window of handle
_MsgBox_SetWindowPos(200, 100)

; The same flag passed for buttons 0-6 should be set for both messagebox and setbuttontext
_MsgBox_SetButtonText(4, "Button1", "Button2")

_MsgBox(4 + 262144, "Title", "Hello World One")

Sleep(250)
; See now that it reset back to default
_MsgBox(4 + 262144, "Title", "Hello World Two")
#endregion 3 piece function call

#region stand alone all in one call
Sleep(250)
; Change buton 1 to Button1; Move to top left corner of desktop
_MsgBoxEx(4 + 262144, "Title", "Hello World Three", -1, -1, "Button1", -1, -1, 0, 0)

Sleep(250)
; Center to active window
_MsgBoxEx(4 + 262144, "Title", "Hello World Four", -1, WinGetHandle(""), -1, "Button2", -1, 0, 0)
#endregion stand alone all in one call