#include <GuiMenu.au3> 
 
Run("Notepad.exe") 
WinWaitActive("[CLASS:Notepad]") 
 
$hWnd = WinGetHandle("[CLASS:Notepad]") 
 
$hMenu = _GUICtrlMenu_GetMenu($hWnd) 
$hHelp = _GUICtrlMenu_GetItemSubMenu($hMenu, 4) ;Help menu 
$iItemID = _GUICtrlMenu_GetItemID($hHelp, 0) ;First item 
 
_GUICtrlMenu_ClickMenuItem($hWnd, $iItemID) 
 
Func _GUICtrlMenu_ClickMenuItem($hWnd, $iItemID) 
    DllCall("user32.dll", "int", "SendMessage", "hwnd", $hWnd, "int", 0x0111, "int", $iItemID, "int", 0) ;$WM_COMMAND = 0x0111 
EndFunc 