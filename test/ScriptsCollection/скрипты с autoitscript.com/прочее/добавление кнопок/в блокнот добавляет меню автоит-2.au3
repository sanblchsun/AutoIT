; http://www.autoitscript.com/forum/topic/108667-adding-a-menu-in-to-a-windows-program-an-using-it/
#include <WindowsConstants.au3>
#include <SendMessage.au3>
#include <GuiMenu.au3>

; Windows User Messages
Global Const $UM_ADDMESSAGE = $WM_USER + 0x100

Global $hWndTarget, $sSelection = ""
Global $aCmdID[6][2] = [ _
    ["SubItem &1", 0x2100], _
    ["SubItem &2", 0x2101], _
    ["Item &1", 0], _
    ["Item &2", 0x2001], _
    ["Item &3", 0x2002], _
    ["Item &4", 0x2003]]

; Insert menu into Notepad
_InsertMenu()

; Gather information...
$iPIDTarget = WinGetProcess($hWndTarget)
$iThreadIdTarget = _WinAPI_GetWindowThreadProcessId($hWndTarget, $iPIDTarget)

; Install Filter(s)
$hDll_hook = DllOpen("hook.dll") ;helper dll
DllCall($hDll_hook, "int", "InstallFilterDLL", "long", $WH_CALLWNDPROC, "long", $iThreadIdTarget, "hwnd", $hWndTarget) ; 0 = Ok
DllCall($hDll_hook, "int", "InstallFilterDLL", "long", $WH_GETMESSAGE, "long", $iThreadIdTarget, "hwnd", $hWndTarget) ; 0 = Ok

; Register WM_COMMAND
$hWndLocal = GUICreate("") ;Needed to receive Messages
_SendMessage($hWndTarget, $UM_ADDMESSAGE, $WM_COMMAND, $hWndLocal)
GUIRegisterMsg($WM_COMMAND, "_Filter")

; Keep running while target exists
While WinExists($hWndTarget)

    If $sSelection <> "" Then
        $sSelection = StringReplace($sSelection, "&", "")
        MsgBox(0, "New Menu", "You selected " & $sSelection)
    EndIf

    Sleep(10)

WEnd

; Uninstall Filter
DllCall($hDll_hook, "int", "UnInstallFilterDLL", "long", $iThreadIdTarget, "hwnd", $hWndTarget, "hwnd", $hWndLocal); 0 = ok
DllClose($hDll_hook)

Exit

; Process Callback
Func _Filter($hGUI, $iMsg, $wParam, $lParam)

    Switch $iMsg
        Case $WM_COMMAND
            $iCmdID = _WinAPI_LoWord($wParam)
            $sSelection = ""
            For $i = 0 To 5
                If $aCmdID[$i][1] = $iCmdID Then
                    $sSelection = $aCmdID[$i][0]
                EndIf
            Next
    EndSwitch

EndFunc   ;==>_Filter

Func _InsertMenu()

    Local $hItem1, $hItem2

    ; Open Notepad
    Run("Notepad.exe")
    WinWaitActive("[CLASS:Notepad]")
    $hWndTarget = WinGetHandle("[CLASS:Notepad]")
    $hMenu = _GUICtrlMenu_GetMenu($hWndTarget)

    ; Create subitem menu
    $hItem1 = _GUICtrlMenu_CreateMenu()
    _GUICtrlMenu_InsertMenuItem($hItem1, 0, $aCmdID[0][0], $aCmdID[0][1])
    _GUICtrlMenu_InsertMenuItem($hItem1, 1, $aCmdID[1][0], $aCmdID[1][1])

    ; Create menu
    $hItem2 = _GUICtrlMenu_CreateMenu()
    _GUICtrlMenu_InsertMenuItem($hItem2, 0, $aCmdID[2][0], $aCmdID[2][1], $hItem1)
    _GUICtrlMenu_InsertMenuItem($hItem2, 1, $aCmdID[3][0], $aCmdID[3][1])
    _GUICtrlMenu_InsertMenuItem($hItem2, 2, "", 0)
    _GUICtrlMenu_InsertMenuItem($hItem2, 3, $aCmdID[4][0], $aCmdID[4][1])
    _GUICtrlMenu_InsertMenuItem($hItem2, 4, $aCmdID[5][0], $aCmdID[5][1])

    ; Insert new menu into Notepad
    _GUICtrlMenu_InsertMenuItem($hMenu, 6, "&AutoIt", 0, $hItem2)
    _GUICtrlMenu_DrawMenuBar($hWndTarget)

EndFunc   ;==>_Insertmenu
 