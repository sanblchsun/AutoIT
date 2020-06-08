#include <WinAPI.au3>

Global $hGui = GUICreate('_GuiCtrlSetPath by funkey', 600, 200)

Global $nPath1 = GUICtrlCreateLabel('', 10, 10, 300, 50)
GUICtrlSetBkColor(-1, 0xCCCCCC)
GUICtrlSetFont(-1, 30)
_GuiCtrlSetPath($nPath1, "C:\path1\path2\sample.txt")

Global $nPath2 = GUICtrlCreateLabel('', 10, 80, 580, 60)
GUICtrlSetBkColor(-1, 0xCCCCCC)
GUICtrlSetFont(-1, 40)
_GuiCtrlSetPath($nPath2, "C:\path1\path2\sample.txt")

GUICtrlCreateInput("", 10, 150, 200, 20)
_GuiCtrlSetPath(-1, "C:\path1\path2\path3\path4\path5\path6\sample.txt", 4)
GUISetState()

Do
Until GUIGetMsg() = -3

Func _GuiCtrlSetPath($nID, $sPath, $iFit = 0)
 ;coded by funkey
 ;2011, Nov 24th
 Local $hCtrl = GUICtrlGetHandle($nID)
 Local $hDC = _WinAPI_GetDC($hCtrl)
 Local $tPath = DllStructCreate("char[260]")
 Local $pPath = DllStructGetPtr($tPath)
 DllStructSetData($tPath, 1, $sPath)
 Local $hFont = _SendMessage($hCtrl, 49, 0, 0, 0, "wparam", "lparam", "hwnd") ;WM_GETFONT
 Local $hFont_old = _WinAPI_SelectObject($hDC, $hFont)
 Local $aPos = ControlGetPos($hCtrl, "", "")
 DllCall("Shlwapi.dll", "BOOL", "PathCompactPath", "handle", $hDC, "ptr", $pPath, "int", $aPos[2] - $iFit)
 _WinAPI_SelectObject($hDC, $hFont_old)
 _WinAPI_DeleteDC($hDC)
 GUICtrlSetData($nID, DllStructGetData($tPath, 1))
 Return DllStructGetData($tPath, 1)
EndFunc   ;==>_GuiCtrlSetPath