#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiTab.au3>

Global $aDisabled_hTabs[1]

$hGUI = GUICreate("Tab Control Create", 400, 300)

$hTab = GUICtrlCreateTab(2, 2, 396, 296)

$Tab1 = GUICtrlCreateTabItem("Tab 1")
$Tab2 = GUICtrlCreateTabItem("Tab 2")
$Tab3 = GUICtrlCreateTabItem("Tab 3")

_GUICtrlTab_SetDsable(1) ;1 is the second tab item (by zero-based index)

GUISetState()

GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            Exit
    EndSwitch
WEnd

Func _GUICtrlTab_SetDsable($nTabItem, $iDisable=True)
    If $iDisable Then
        $aDisabled_hTabs[0] += 1
        ReDim $aDisabled_hTabs[$aDisabled_hTabs[0]+1]

        $aDisabled_hTabs[$aDisabled_hTabs[0]] = $nTabItem
    Else
        Local $aTmpArr[1]

        For $i = 1 To $aDisabled_hTabs[0]
            If $aDisabled_hTabs[$i] <> $nTabItem Then
                $aTmpArr[0] += 1
                ReDim $aTmpArr[$aTmpArr[0]+1]

                $aTmpArr[$aTmpArr[0]] = $aDisabled_hTabs[$i]
            EndIf
        Next

        $aDisabled_hTabs = $aTmpArr
    EndIf
EndFunc

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
    Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR, $hWndTab

    $hWndTab = GUICtrlGetHandle($hTab)

    $tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
    $hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
    $iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
    $iCode = DllStructGetData($tNMHDR, "Code")

    If $iIDFrom <> $hTab Then Return $GUI_RUNDEFMSG

    Switch $iCode
        Case $NM_CLICK  ; The user has clicked the left mouse button within the control
            ;Return 1 ; nonzero to not allow the default processing
            ;Return 0 ; zero to allow the default processing
        Case $NM_DBLCLK  ; The user has double-clicked the left mouse button within the control

        Case $NM_RCLICK  ; The user has clicked the right mouse button within the control

        Case $NM_RDBLCLK  ; The user has clicked the right mouse button within the control

        Case $NM_RELEASEDCAPTURE ; control is releasing mouse capture

        Case $TCN_SELCHANGING
            Local $iOldOpt_MCM = Opt("MouseCoordMode", 2)

            Local $aMousePos = MouseGetPos()

            Local $aHitItem1 = _GUICtrlTab_HitTest($hTab, $aMousePos[0], $aMousePos[1])
            Local $aHitItem2 = _GUICtrlTab_HitTest($hTab, $aMousePos[0]-2, $aMousePos[1]-5)
            Local $aHitItem3 = _GUICtrlTab_HitTest($hTab, $aMousePos[0]-5, $aMousePos[1])

            For $i = 1 To $aDisabled_hTabs[0]
                If $aDisabled_hTabs[$i] = $aHitItem1[0] Or $aDisabled_hTabs[$i] = $aHitItem2[0] Or _
                    $aDisabled_hTabs[$i] = $aHitItem3[0] Then Return 1
            Next

            Opt("MouseCoordMode", $iOldOpt_MCM)
    EndSwitch

    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY