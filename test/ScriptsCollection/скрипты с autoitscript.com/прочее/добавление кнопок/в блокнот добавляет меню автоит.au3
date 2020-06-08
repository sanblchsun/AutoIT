; http://www.autoitscript.com/forum/topic/108667-adding-a-menu-in-to-a-windows-program-an-using-it/
#include <GuiMenu.au3>
#include <GUIConstantsEx.au3>

Dim $hWnd, $hMain, $hItem1, $hItem2, $msg

Global Enum $h_Sub1 = 1000, $h_Sub2

Opt('MustDeclareVars', 1)

_Main()

Func _Main()

    ; Open Notepad
    Run("Notepad.exe")
    WinWaitActive("[CLASS:Notepad]")
    $hWnd = WinGetHandle("[CLASS:Notepad]")
    $hMain = _GUICtrlMenu_GetMenu($hWnd)

    ; Create subitem menu
    $hItem1 = _GUICtrlMenu_CreateMenu()
    _GUICtrlMenu_InsertMenuItem($hItem1, 0, "SubItem &1", $h_Sub1)
    _GUICtrlMenu_InsertMenuItem($hItem1, 1, "SubItem &2", $h_Sub2)

    ; Create menu
    $hItem2 = _GUICtrlMenu_CreateMenu()
    _GUICtrlMenu_InsertMenuItem($hItem2, 0, "Item &1", 0x2000, $hItem1)
    _GUICtrlMenu_InsertMenuItem($hItem2, 1, "Item &2", 0x2001)
    _GUICtrlMenu_InsertMenuItem($hItem2, 2, "", 0)
    _GUICtrlMenu_InsertMenuItem($hItem2, 3, "Item &3", 0x2002)
    _GUICtrlMenu_InsertMenuItem($hItem2, 4, "Item &4", 0x2003)

    ; Insert new menu into Notepad
    _GUICtrlMenu_InsertMenuItem($hMain, 6, "&AutoIt", 0, $hItem2)
    _GUICtrlMenu_DrawMenuBar($hWnd)

EndFunc   ;==>_Main



While WinExists($hWnd)
    $msg = GUIGetMsg()
    Select
        Case $msg = $h_Sub1
            MsgBox(0, "You selected...", "SubItem 1")
        Case $msg = $h_Sub2
            MsgBox(0, "You selected...", "SubItem 2")
            ; case ...
    EndSelect
WEnd
 