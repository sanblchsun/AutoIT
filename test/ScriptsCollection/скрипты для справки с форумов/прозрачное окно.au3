#include <GUIConstantsEx.au3> 
#include <WindowsConstants.au3> 
#include <WinAPI.au3> 
; 

$hBk_GUI = GUICreate("Reading Ruler Demo", 600, 300, -1, -1, BitOR($WS_POPUP, $WS_SIZEBOX), $WS_EX_TOPMOST) 
WinSetTrans($hBk_GUI, "", 150) 
GUISetBkColor(0xFFFF80, $hBk_GUI) 
GUISetCursor(0, 1, $hBk_GUI) 

$hLine_GUI = GUICreate("", 602, 10, 0, 300-20, $WS_POPUP, $WS_EX_TOPMOST, $hBk_GUI) 
GUISetBkColor(0x4A4A4A, $hLine_GUI) 

$aBkGUI_Pos = WinGetPos($hBk_GUI) 
WinMove($hLine_GUI, "", $aBkGUI_Pos[0]+2, ($aBkGUI_Pos[1]+$aBkGUI_Pos[3])-13) 

GUISetState(@SW_SHOW, $hBk_GUI) 
GUISetState(@SW_SHOW, $hLine_GUI) 

GUIRegisterMsg($WM_NCHITTEST, "WM_NCHITTEST") 
GUIRegisterMsg($WM_GETMINMAXINFO, "WM_GETMINMAXINFO") 
GUIRegisterMsg($WM_MOVE, "WM_MOVE") 
GUIRegisterMsg($WM_SIZE, "WM_MOVE") 

While 1 
Switch GUIGetMsg() 
Case $GUI_EVENT_CLOSE 
Exit 
EndSwitch 
WEnd 

Func WM_NCHITTEST($hWnd, $iMsg, $iwParam, $ilParam) 
Local $iRet = _WinAPI_DefWindowProc($hWnd, $iMsg, $iwParam, $ilParam) 
If $iRet = 1 Then Return 2 

Return $iRet 
EndFunc 

Func WM_MOVE($hWndGUI, $MsgID, $WParam, $LParam) 
$aBkGUI_Pos = WinGetPos($hBk_GUI) 
$aLineGUI_Pos = WinGetPos($hLine_GUI) 

GUIRegisterMsg($WM_NCHITTEST, "") 
GUIRegisterMsg($WM_GETMINMAXINFO, "") 
GUIRegisterMsg($WM_MOVE, "") 
GUIRegisterMsg($WM_SIZE, "") 

If $hWndGUI = $hBk_GUI Then 
WinMove($hLine_GUI, "", $aBkGUI_Pos[0]+2, ($aBkGUI_Pos[1]+$aBkGUI_Pos[3])-13, $aBkGUI_Pos[2]-5) 
Else 
WinMove($hBk_GUI, "", $aLineGUI_Pos[0]-2, ($aLineGUI_Pos[1]-$aBkGUI_Pos[3])+13) 
EndIf 

GUIRegisterMsg($WM_NCHITTEST, "WM_NCHITTEST") 
GUIRegisterMsg($WM_GETMINMAXINFO, "WM_GETMINMAXINFO") 
GUIRegisterMsg($WM_MOVE, "WM_MOVE") 
GUIRegisterMsg($WM_SIZE, "WM_MOVE") 
EndFunc 

Func WM_GETMINMAXINFO($hWnd, $Msg, $wParam, $lParam) 
If $hWnd <> $hBk_GUI Then Return $GUI_RUNDEFMSG 

Local $MINGuiX = 600, $MINGuiY = 300, $MAXGuiX = @DesktopWidth, $MAXGuiY = @DesktopHeight 
Local $stMinMaxInfo = DllStructCreate("int;int;int;int;int;int;int;int;int;int", $lParam) 

DllStructSetData($stMinMaxInfo, 7, $MINGuiX) ; min X 
DllStructSetData($stMinMaxInfo, 8, $MINGuiY) ; min Y 
DllStructSetData($stMinMaxInfo, 9, $MAXGuiX) ; max X 
DllStructSetData($stMinMaxInfo, 10, $MAXGuiY) ; max Y 

Return $GUI_RUNDEFMSG 
EndFunc 