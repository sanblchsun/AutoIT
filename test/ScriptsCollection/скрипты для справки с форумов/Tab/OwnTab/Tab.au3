#include-once
#include <Constants.au3>
#include <GUIConstantsEx.au3>
#include "OwnTab.au3"
Global $MainForm = GUICreate("App Template", 800, 600, -1, -1, BitOR($WS_SIZEBOX, $WS_MINIMIZEBOX, $WS_MAXIMIZEBOX), 0)
GUISetBkColor(0xbbbbbb, $MainForm)
Local $aTabText[5] = ["Tab1", "Tab2 ", "Tab3", "Tab4", "Tab5"]
Local $aTabIcons[5][2] = [[""],[""],[""],[""],[""]]
Global $aCtrlTab = _OwnTab_Create($MainForm, $aTabText, 5, 40, 785, 460, 30, 0xD5D5D5, 0xCFE0E7, 0xCFE0E7, $aTabIcons)

#Region Tab1
_OwnTab_Add($aCtrlTab) ;Start controls tab1
Local $Button1= GUICtrlCreateButton("aaa",50,150,50,50)
#EndRegion Tab1

#Region Tab2
_OwnTab_Add($aCtrlTab) ;Start controls tab2
#EndRegion Tab2

#Region Tab3
_OwnTab_Add($aCtrlTab) ;Start controls tab3

#EndRegion Tab3

#Region Tab4
_OwnTab_Add($aCtrlTab) ;Start controls tab4
#EndRegion Tab4

#Region Tab5 and "Tab in Tab"
_OwnTab_Add($aCtrlTab) ;Start controls tab5
#EndRegion Tab5 and "Tab in Tab"

_OwnTab_End($aCtrlTab) ;new: end control-definition AND inizialize the OwnTab

_OwnTab_Hover($aCtrlTab, 0xFFFFFF) ;start hover-function if you want
GUISetState()

Global $GUI_Section1 = GUICreate("Configuration", 400, 300, -1, -1, -1, BitOR($WS_EX_TOOLWINDOW, $WS_EX_MDICHILD), $MainForm)

GUISetState(@SW_HIDE, $GUI_Section1)

;;ANTIFLICKER START
Global Const $WM_EXITSIZEMOVE = 0x0232
Global $g_IsResizing = False

GUIRegisterMsg($WM_SIZING, "WM_SIZING")
GUIRegisterMsg($WM_EXITSIZEMOVE, "WM_EXITSIZEMOVE")

Func WM_SIZING($hWnd, $Msg, $wParam, $lParam)
    #forceref $hWnd, $Msg, $wParam, $lParam
    Local $GUIStyle
    If Not $g_IsResizing Then
    ; resizing begins
        $GUIStyle = GUIGetStyle($MainForm)
        GUISetStyle(-1, BitOR($GUIStyle[1], $WS_EX_COMPOSITED), $MainForm)
        $g_IsResizing = True
    EndIf
    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_SIZING

Func WM_EXITSIZEMOVE($hWnd, $Msg, $wParam, $lParam)
    #forceref $hWnd, $Msg, $wParam, $lParam
    Local $GUIStyle
    If $g_IsResizing Then
        ; resizing ends
        $GUIStyle = GUIGetStyle($MainForm)
        GUISetStyle(-1, BitAND($GUIStyle[1], BitNOT($WS_EX_COMPOSITED)), $MainForm)
        $g_IsResizing = False
    EndIf
    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_EXITSIZEMOVE
;;ANTIFLICKER END

Local $msg

While 1
    $msg = GUIGetMsg(1)
    Switch $msg[1]
        Case $MainForm
            Switch $msg[0]
                Case $GUI_EVENT_CLOSE
                    exit
                Case $Button1
                    GUISetState(@SW_Show, $GUI_Section1)
                Case   $aCtrlTab[1][0]
                    _OwnTab_Switch($aCtrlTab, 1)
                Case  $aCtrlTab[2][0]
                    _OwnTab_Switch($aCtrlTab, 2)
                Case   $aCtrlTab[3][0]
                    _OwnTab_Switch($aCtrlTab, 3)
                Case   $aCtrlTab[4][0]
                    _OwnTab_Switch($aCtrlTab, 4)
                Case   $aCtrlTab[5][0]
                    _OwnTab_Switch($aCtrlTab, 5)
            EndSwitch
        Case $GUI_Section1
            Switch $msg[0]
            Case $GUI_EVENT_CLOSE
                    GUISetState(@SW_HIDE, $GUI_Section1)
                EndSwitch
    EndSwitch
    Sleep(15)
WEnd