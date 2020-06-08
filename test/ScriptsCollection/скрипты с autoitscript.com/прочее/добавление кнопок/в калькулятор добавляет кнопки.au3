; http://www.autoitscript.com/forum/topic/108667-adding-a-menu-in-to-a-windows-program-an-using-it/
#include <WindowsConstants.au3>
#Include <GuiButton.au3>
#include <ButtonConstants.au3>
#include <StaticConstants.au3>
#include <SendMessage.au3>
#include <GuiMenu.au3>

; Windows User Messages
Global Const $UM_ADDMESSAGE = $WM_USER + 0x100, $BS_PUSHBUTTON = 0x0

Global $hWndTarget, $sMenuSelection = "", $sButtonPressed = ""
Global $aCmdID_Menu[6][2] = [ _
    ["SubItem &1", 0x2100], _
    ["SubItem &2", 0x2101], _
    ["Item &1", 0], _
    ["Item &2", 0x2001], _
    ["Item &3", 0x2002], _
    ["Item &4", 0x2003]]

Global $aCmdID_Button[6][2] = [ _
    ["Button 1", 0x3000], _
    ["Button 2", 0x3001], _
    ["Button 3", 0x3002], _
    ["Button 4", 0x3003], _
    ["Button 5", 0x3004], _
    ["Button 6", 0x3005]]

; Open Calc
Run("Calc.exe")
WinWaitActive("[CLASS:SciCalc]")
$hWndTarget = WinGetHandle("[CLASS:SciCalc]")

; Insert menu
_InsertMenu()

; Make room for buttons
WinMove($hWndTarget, "", 50,50,600,200)

; Add buttons
_AddButtons()

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

    If $sMenuSelection <> "" Then
        $sMenuSelection = StringReplace($sMenuSelection, "&", "")
        MsgBox(0, "New Menu", "You selected " & $sMenuSelection)
        $sMenuSelection = ""
    EndIf

    If $sButtonPressed <> "" Then
        MsgBox(0, "New Button", "You clicked " & $sButtonPressed)
        $sButtonPressed = ""
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
            For $i = 0 To 5
                If $aCmdID_Menu[$i][1] = $iCmdID Then
                    $sMenuSelection = $aCmdID_Menu[$i][0]
                EndIf
            Next
            For $i = 0 To 5
                If $aCmdID_Button[$i][1] = $iCmdID Then
                    $sButtonPressed = $aCmdID_Button[$i][0]
                EndIf
            Next
    EndSwitch

EndFunc   ;==>_Filter

Func _InsertMenu()

    Local $hItem1, $hItem2


    $hMenu = _GUICtrlMenu_GetMenu($hWndTarget)

    ; Create subitem menu
    $hItem1 = _GUICtrlMenu_CreateMenu()
    _GUICtrlMenu_InsertMenuItem($hItem1, 0, $aCmdID_Menu[0][0], $aCmdID_Menu[0][1])
    _GUICtrlMenu_InsertMenuItem($hItem1, 1, $aCmdID_Menu[1][0], $aCmdID_Menu[1][1])

    ; Create menu
    $hItem2 = _GUICtrlMenu_CreateMenu()
    _GUICtrlMenu_InsertMenuItem($hItem2, 0, $aCmdID_Menu[2][0], $aCmdID_Menu[2][1], $hItem1)
    _GUICtrlMenu_InsertMenuItem($hItem2, 1, $aCmdID_Menu[3][0], $aCmdID_Menu[3][1])
    _GUICtrlMenu_InsertMenuItem($hItem2, 2, "", 0)
    _GUICtrlMenu_InsertMenuItem($hItem2, 3, $aCmdID_Menu[4][0], $aCmdID_Menu[4][1])
    _GUICtrlMenu_InsertMenuItem($hItem2, 4, $aCmdID_Menu[5][0], $aCmdID_Menu[5][1])

    ; Insert new menu into Notepad
    _GUICtrlMenu_InsertMenuItem($hMenu, 4, "&AutoIt", 0, $hItem2)
    _GUICtrlMenu_DrawMenuBar($hWndTarget)

EndFunc   ;==>_Insertmenu

Func _AddButtons()

    Local $hButton

    For $i = 0 To 5
        $hButton = _WinAPI_CreateWindowEx(0, "Button", $aCmdID_Button[$i][0], BitOR($BS_PUSHBUTTON, $WS_CHILD, $WS_VISIBLE), _
                490, 10 + ($i * 40), 80, 30, $hWndTarget, $aCmdID_Button[$i][1])
        _SendMessage($hButton, $__BUTTONCONSTANT_WM_SETFONT, _WinAPI_GetStockObject($__BUTTONCONSTANT_DEFAULT_GUI_FONT), True)
    Next

EndFunc
 