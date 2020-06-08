#include <GuiEdit.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>
#include <WinAPI.au3>
#include <GuiListView.au3>;Added by DiscoEd
#include <GUIConstantsEx.au3>;Added by DiscoEd

Opt("GuiCloseOnESC", 0)

Global $hEdit, $hDC, $hBrush, $Item = -1, $SubItem = 0, $LVHit = 0

Global $Style = BitOR($WS_CHILD, $WS_VISIBLE, $ES_AUTOHSCROLL, $ES_LEFT)

$hGUI = GUICreate("ListView Subitems edit in place", 300, 500)

$hListView = _GUICtrlListView_Create ($hGUI, "Items|SubItems|SubItems2", 2, 2, 296, 196, BitOR($LVS_EDITLABELS, $LVS_REPORT))
_GUICtrlListView_SetExtendedListViewStyle ($hListView, $LVS_EX_GRIDLINES)

$hListView2 = _GUICtrlListView_Create ($hGUI, "Items|SubItems|SubItems2", 2, 210, 296, 196, BitOR($LVS_EDITLABELS, $LVS_REPORT))
_GUICtrlListView_SetExtendedListViewStyle ($hListView2, $LVS_EX_GRIDLINES)


For $i = 1 To 10
    _GUICtrlListView_AddItem ($hListView, "Item " & $i)
    _GUICtrlListView_AddSubItem ($hListView, $i - 1, "SubItem " & $i, 1)
    _GUICtrlListView_AddSubItem ($hListView, $i - 1, "SubItem " & $i, 2)
    _GUICtrlListView_AddItem ($hListView2, "Item " & $i)
    _GUICtrlListView_AddSubItem ($hListView2, $i - 1, "SubItem " & $i, 1)
    _GUICtrlListView_AddSubItem ($hListView2, $i - 1, "SubItem " & $i, 2)

Next

GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")

GUISetState()

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
    Local $tNMHDR, $hWndFrom, $iCode

    $tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
    $hWndFrom = DllStructGetData($tNMHDR, "hWndFrom")
    $iCode = DllStructGetData($tNMHDR, "Code")

    Switch $hWndFrom
        Case $hListView,$hListView2
            Switch $iCode
                Case $NM_DBLCLK
                    Local $aHit = _GUICtrlListView_SubItemHitTest ($hWndFrom)
                    If ($aHit[0] <> -1) And ($aHit[1] > 0) Then
                        $LVHit = $hWndFrom
                        $Item = $aHit[0]
                        $SubItem = $aHit[1]
                        Local $CGP = ControlGetPos($hGUI, "", $hWndFrom)
                        Local $iSubItemText = _GUICtrlListView_GetItemText ($hWndFrom, $Item, $SubItem)
                        Local $iLen = _GUICtrlListView_GetStringWidth ($hWndFrom, $iSubItemText)
                        Local $aRect = _GUICtrlListView_GetSubItemRect ($hWndFrom, $Item, $SubItem)
                        $hEdit = _GUICtrlEdit_Create ($hGUI, $iSubItemText, $CGP[0] + $aRect[0] + 3, ($CGP[1] + $aRect[1]) - 1, $iLen + 10, 16, $Style)
                        _GUICtrlEdit_SetSel ($hEdit, 0, -1)
                        _WinAPI_SetFocus ($hEdit)
                        $hDC = _WinAPI_GetWindowDC ($hEdit)
                        $hBrush = _WinAPI_CreateSolidBrush (0)
                        FrameRect($hDC, 0, 0, $iLen + 10, 16, $hBrush)
                        _WinAPI_DeleteObject ($hBrush)
                        _WinAPI_ReleaseDC ($hEdit, $hDC)
                    EndIf
            EndSwitch
    EndSwitch
    Return $GUI_RUNDEFMSG
EndFunc  ;==>WM_NOTIFY

Func FrameRect($hDC, $nLeft, $nTop, $nRight, $nBottom, $hBrush)
    Local $stRect = DllStructCreate("int;int;int;int")

    DllStructSetData($stRect, 1, $nLeft)
    DllStructSetData($stRect, 2, $nTop)
    DllStructSetData($stRect, 3, $nRight)
    DllStructSetData($stRect, 4, $nBottom)

    DllCall("user32.dll", "int", "FrameRect", "hwnd", $hDC, "ptr", DllStructGetPtr($stRect), "hwnd", $hBrush)
EndFunc  ;==>FrameRect

Func WM_COMMAND($hWnd, $Msg, $wParam, $lParam)
    Local $iCode = BitShift($wParam, 16)
    Switch $lParam
        Case $hEdit
            Switch $iCode
                Case $EN_KILLFOCUS
                    Local $iText = _GUICtrlEdit_GetText ($hEdit)
                    _GUICtrlListView_SetItemText ($LVHit, $Item, $iText, $SubItem)
                    _WinAPI_DestroyWindow ($hEdit)

                    $Item = -1
                    $SubItem = 0
                    $LVHit = 0
            EndSwitch
    EndSwitch
    Return $GUI_RUNDEFMSG
EndFunc  ;==>WM_COMMAND
