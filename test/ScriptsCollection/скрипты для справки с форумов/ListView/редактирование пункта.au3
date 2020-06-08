#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiListView.au3>

; Set flag to indicate double click in ListView
Global $fDblClk = False

$Gui = GUICreate("Test", 400, 250)

; This works with either type of ListView - just adjust the comment statements to change the type

;#cs
$hListView = GUICtrlCreateListView("Items", 2, 2, 220, 196, BitOR($LVS_EDITLABELS, $LVS_REPORT))
GUICtrlCreateListViewItem("Item 1", $hListView)
GUICtrlCreateListViewItem("Item 2", $hListView)
GUICtrlCreateListViewItem("Item 3", $hListView)
GUICtrlCreateListViewItem("Item 4", $hListView)
;#ce
#cs
$hListView = _GUICtrlListView_Create($Gui, "Items", 2, 2, 220, 196, BitOR($LVS_EDITLABELS, $LVS_REPORT))
_GUICtrlListView_AddItem($hListView, "Item 1",0)
_GUICtrlListView_AddItem($hListView, "Item 2",2)
_GUICtrlListView_AddItem($hListView, "Item 3",1)
_GUICtrlListView_AddItem($hListView, "Item 4",3)
#ce

GUISetState()

GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

While 1

    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            ExitLoop
    EndSwitch

    ; If an item was double clicked
    If $fDblClk Then
        $fDblClk = False
        If Not IsHWnd($hListView) Then $hListView = GUICtrlGetHandle($hListView)
        $iSelected = _GUICtrlListView_GetSelectedIndices($hListView)
        If $iSelected <> "" Then _GUICtrlListView_EditLabel($hListView, $iSelected)
    EndIf

WEnd

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
    Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR, $hWndListView
    $hWndListView = $hListView
    If Not IsHWnd($hListView) Then $hWndListView = GUICtrlGetHandle($hListView)

    $tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
    $hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
    $iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
    $iCode = DllStructGetData($tNMHDR, "Code")

    Switch $hWndFrom
        Case $hWndListView
            Switch $iCode
                Case $NM_DBLCLK
                    $fDblClk = True
                Case $LVN_BEGINLABELEDITW
                    Local $tInfo = DllStructCreate($tagNMLVDISPINFO, $ilParam)
                    Return False
                Case $LVN_ENDLABELEDITW
                    Local $tInfo = DllStructCreate($tagNMLVDISPINFO, $ilParam)
                    Local $tBuffer = DllStructCreate("char Text[" & DllStructGetData($tInfo, "TextMax") & "]", _
                        DllStructGetData($tInfo, "Text"))
                    Local $sNewText = DllStructGetData($tBuffer, "Text")
                    If StringLen($sNewText) Then Return True
            EndSwitch
    EndSwitch
    Return $GUI_RUNDEFMSG
EndFunc