#include <GUIConstantsEx.au3>
#include <EditConstants.au3>
#include <WindowsConstants.au3>

$hGUI = GUICreate("Scrollable Label Imitation Example", 300, 200)

$sLabelData = ""

For $i = 1 To 22
    $sLabelData &= "This is my Label Line #" & $i & @CRLF
Next

$nDummyCtrl = GUICtrlCreateLabel("", -100, -100)
$nCntxtMenu = GUICtrlCreateContextMenu($nDummyCtrl)
$nCopy_CntxtMenuItem = GUICtrlCreateMenuItem("Copy", $nCntxtMenu)

$nEdit = GUICtrlCreateEdit($sLabelData, 20, 20, 260, 150, BitOr(BitAND($GUI_SS_DEFAULT_EDIT, BitNOT($WS_HSCROLL)), $ES_READONLY), $WS_EX_TRANSPARENT)
GUICtrlSetCursor($nEdit, 2)

GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")
GUISetState(@SW_SHOW, $hGUI)

While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            Exit
        Case $GUI_EVENT_SECONDARYDOWN
            $aCursorInfo = GUIGetCursorInfo($hGUI)

            If $aCursorInfo[4] = $nEdit Then
                _ShowContextMenu($hGUI, $nCntxtMenu)
            EndIf
        Case $nCopy_CntxtMenuItem
;~             ClipPut(GUICtrlRead($nEdit))
    EndSwitch
WEnd

Func _ShowContextMenu($hWnd, $nContextID)
    Local $hMenu = GUICtrlGetHandle($nContextID)
    Local $arPos = MouseGetPos()
    DllCall("user32.dll", "int", "TrackPopupMenuEx", "hwnd", $hMenu, "int", 0, "int", $arPos[0], "int", $arPos[1], "hwnd", $hWnd, "ptr", 0)
EndFunc

Func WM_COMMAND($hWnd, $nMsg, $wParam, $lParam)
    Local $nNotifyCode = BitShift($wParam, 16)
    Local $nID = BitAND($wParam, 0xFFFF)
    Local $hCtrl = $lParam

    Switch $nID
        Case $nEdit
            Switch $nNotifyCode
                Case $EN_CHANGE, $EN_UPDATE

                Case $EN_SETFOCUS
                    ControlFocus($hWnd, "", $nDummyCtrl)
                Case $EN_KILLFOCUS

            EndSwitch
    EndSwitch

    Return $GUI_RUNDEFMSG
EndFunc
