#include <GuiRichEdit.au3>
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <Constants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Include <GuiButton.au3>
#include <GuiMenu.au3>
#Include <GUIEdit.au3>
#include <Date.au3>
#include <File.au3>
#include <Array.au3>
#Include <Timers.au3>
#Include <Misc.au3>
#Include <Clipboard.au3>
#Include <String.au3>

Opt("GUIOnEventMode", 1)
Opt("TrayOnEventMode", 1)
Opt("SendAttachMode", 1)
Opt("TrayMenuMode", 3)
Opt("TrayAutoPause", 0)
Opt("WinWaitDelay", 0)
Opt("WinTextMatchMode", 2)
Opt("WinTitleMatchMode", 2)
Opt("WinSearchChildren", 1)
Opt("SendKeyDownDelay", 50)

Global $sCall_FuncName = "Link_Event"

TraySetOnEvent ($TRAY_EVENT_PRIMARYDOWN, "FastMenu")
TraySetClick (8)
$trayExit = TrayCreateItem("Выход")
TrayItemSetOnEvent(-1, "_Exit")

while(1)
    Sleep(50)
WEnd

;~ Меню быстрых ссылок
Func FastMenu()
    Local $hDlg, $cDummy, $nContextMenu, $hContextMenu, $nHide_MItem
    Local $aIni, $aMenuItems, $nExit_MItem, $hTimer, $aMousePos, $nResult
    Local $submenues
    Local $subMenuItems[1000][2]

    $hDlg = GUICreate("", 1, 1, 0, 0, $WS_POPUP, $WS_EX_TOOLWINDOW)
    $cDummy = GUICtrlCreateDummy()
    $nContextMenu = GUICtrlCreateContextMenu($cDummy)
    $hContextMenu = GUICtrlGetHandle($nContextMenu)

    $aIni = IniReadSection(@ScriptDir & "\1.ini", "БЫСТРЫЕ ССЫЛКИ")
    Dim $aMenuItems[$aIni[0][0]+1]
    $aMenuItems[0] = $aIni[0][0]
    For $i = 1 To $aIni[0][0]
        local $aMenu=StringRegExp ( $aIni[$i][0] ,"([^>]*)\s*>\s*([^>]*)\s*", 3)
        if @error = 0 Then
            If Not StringInStr ($submenues, $aMenu[0]) Then
                $hMenu=GUICtrlCreateMenu($aMenu[0], $nContextMenu)
                $submenues = $submenues & $aMenu[0]
            EndIf
            $aMenuItems[$i] = GUICtrlCreateMenuItem($aMenu[1], $hMenu)
        Else
            $aMenuItems[$i] = GUICtrlCreateMenuItem($aIni[$i][0], $nContextMenu)
        EndIf
    Next

    GUISetState(@SW_SHOW, $hDlg)

    $aMousePos = MouseGetPos()
    $hTimer = _Timer_SetTimer($hDlg, 100, "CheckPressed_Proc")
    $nResult = _GUICtrlMenu_TrackPopupMenu($hContextMenu, $hDlg, $aMousePos[0] - 27, $aMousePos[1] - 12, 1, 1, 2, 1)
    _Timer_KillTimer($hDlg, $hTimer)

    sleep(70)
    Switch $nResult
        Case $aMenuItems[1] To $aMenuItems[$aMenuItems[0]]
            For $i = 1 To $aMenuItems[0]
                If $nResult = $aMenuItems[$i] Then
                    Call($sCall_FuncName, $aIni[$i][1])
                    ExitLoop
                EndIf
            Next
        EndSwitch
EndFunc

;~ Нужно для меню быстрых ссылок
Func CheckPressed_Proc($hWnd, $Msg, $iIDTimer, $dwTime)
    If _IsPressed(01) Then $sCall_FuncName = "CopyLink"
EndFunc

;~ Нужно для меню быстрых ссылок
Func CopyLink($Msg)
    ClipPut($Msg)
    Say("Помещено в буфер: " & $Msg)
EndFunc

;~ Сообщение в трее
Func Say($Say, $SleepTime = 1500)
    TrayTip ("", $Say, 1)
    sleep($SleepTime)
    TrayTip("", "", 0)
EndFunc

Func _Exit()
    Exit
EndFunc


