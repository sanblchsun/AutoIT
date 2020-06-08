#include <GUIConstants.au3>
#include <Constants.au3>
#include <WindowsConstants.au3>
#include <WinAPI.au3>
;

$hGUI = GUICreate("Set Cursor Test GUI", 300, 200)
GUISetState()

$hCursor = _WinAPI_LoadImage(0, @WindowsDir & "\Cursors\3dgarro.cur", $IMAGE_CURSOR, 0, 0, BitOR($LR_LOADFROMFILE, $LR_DEFAULTSIZE))

GUIRegisterMsg($WM_MOUSEMOVE, "WM_SETCURSOR")

While GUIGetMsg() <> $GUI_EVENT_CLOSE
WEnd

Func WM_SETCURSOR($hWnd, $iMsg, $iwParam, $ilParam)
    _WinAPI_SetCursor($hCursor)
EndFunc
