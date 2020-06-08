#include <SendMessage.au3>

Global Const $WM_AU3_USR = 0x0400 ;$WM_USER

$hWnd = WinGetHandle("[CLASS:AutoIt v3 GUI;TITLE:_MYAPP_]")

_SendMessage($hWnd, $WM_AU3_USR, 0, 1001)
Sleep(1500)
_SendMessage($hWnd, $WM_AU3_USR, 0, 1002)
Sleep(1500)
_SendMessage($hWnd, $WM_AU3_USR, 0, 1003)