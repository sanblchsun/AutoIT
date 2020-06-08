#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiListView.au3>

Opt('GUIOnEventMode', 1)

$Gui = GUICreate("Test (F2 or double clicked)", 330, 250)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")

$hListView = GUICtrlCreateListView("Items", 2, 2, 220, 196, BitOR($LVS_EDITLABELS, $LVS_REPORT))
GUICtrlCreateListViewItem("Item 1", $hListView)
GUICtrlCreateListViewItem("Item 2", $hListView)
GUICtrlCreateListViewItem("Item 3", $hListView)
GUICtrlCreateListViewItem("Item 4", $hListView)

$hDummy = GUICtrlCreateDummy()
GUICtrlSetOnEvent(-1, "_EditItem")

Dim $AccelKeys[1][2]=[["{F2}", $hDummy]]
GUISetAccelerators($AccelKeys)

GUISetState()
GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

While 1
	Sleep(10000000)
WEnd

Func _EditItem()
	If Not IsHWnd($hListView) Then $hListView = GUICtrlGetHandle($hListView)
	$iSelected = _GUICtrlListView_GetSelectedIndices($hListView)
	If $iSelected <> "" Then _GUICtrlListView_EditLabel($hListView, $iSelected)
EndFunc

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
					_EditItem()
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

Func _Exit()
	Exit
EndFunc 