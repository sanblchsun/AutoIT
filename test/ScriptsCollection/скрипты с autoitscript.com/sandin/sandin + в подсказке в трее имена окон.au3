#include <GuiConstantsEx.au3>
#include <Misc.au3>
#include <WindowsConstants.au3>
#include <ListboxConstants.au3>
#Include <SendMessage.au3>

Global Const $HSHELL_WINDOWACTIVATED = 4;
Global $bHook = 1
Global $previous_hwnd = "", $previous_title = ""
Global $current_hwnd = ""
Global $tooltip_display1 = ""
Global $tooltip_display2 = ""

Global $iGuiW = 400, $iGuiH = 50, $sTitle = "Shell Hooker", $aBtnText[2] = ["START", "STOP"]
$hGui = GUICreate($sTitle, $iGuiW, $iGuiH, -1, 0, $WS_POPUP+$WS_BORDER, $WS_EX_TOPMOST)

GUIRegisterMsg(RegisterWindowMessage("SHELLHOOK"), "HShellWndProc")
ShellHookWindow($hGui, $bHook)

GUISetState(@SW_HIDE)

While 1
    Sleep(1000)
WEnd

Func HShellWndProc($hWnd, $Msg, $wParam, $lParam)
    Switch $wParam
        Case $HSHELL_WINDOWACTIVATED
            Local $win_title = WinGetTitle($lParam)
            Local $win_handle = $lParam
            if $previous_hwnd <> "" Then $tooltip_display1 = "Previous window" & @CRLF & "Title: " & $previous_title & @CRLF & "Handle: " & $previous_hwnd & @CRLF
            $previous_hwnd = $win_handle
            $previous_title = $win_title
            $tooltip_display2 = $tooltip_display1 & @CRLF & "Current window" & @CRLF & "Title: " & $win_title & @CRLF & "Handle: " & $win_handle
            TrayTip("", $tooltip_display2, 30)
    EndSwitch
EndFunc

Func ShellHookWindow($hWnd, $bFlag)
    Local $sFunc = 'DeregisterShellHookWindow'
    If $bFlag Then $sFunc = 'RegisterShellHookWindow'
    Local $aRet = DllCall('user32.dll', 'int', $sFunc, 'hwnd', $hWnd)
    Return $aRet[0]
EndFunc
Func RegisterWindowMessage($sText)
    Local $aRet = DllCall('user32.dll', 'int', 'RegisterWindowMessage', 'str', $sText)
    Return $aRet[0]
EndFunc
