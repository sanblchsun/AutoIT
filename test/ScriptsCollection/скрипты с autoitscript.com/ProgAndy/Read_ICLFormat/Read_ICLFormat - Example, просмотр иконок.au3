;Supported dropfiles: cpl, dll, exe, icl, ocx
;ICL is view only, no extraction!!!

#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiListView.au3>
#include <WinAPI.au3>
#include "Read_ICLFormat.au3"

Opt("GUIOnEventMode", 1)

Global $sIn = @SystemDir & "\shell32.dll"
Global $hGui, $LV, $Extract, $LHT, $IHM

$hGui = GUICreate("", 500, 400, -1, -1, -1, BitOR($WS_EX_TOPMOST, $WS_EX_ACCEPTFILES))
GUISetOnEvent($GUI_EVENT_DROPPED, "GuiEvent", $hGui)
GUISetOnEvent($GUI_EVENT_CLOSE, "GuiEvent", $hGui)
$LV = GUICtrlCreateListView("", 5, 5, 490, 390, $LVS_ICON)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)
GUICtrlSetTip(-1, "Drop a supported file here to view it's icons." & @LF & "Double Click an icon to extract.")
_GUICtrlListView_SetView($LV, 1)
Update()
GUISetState(@SW_SHOW, $hGui)

GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

While 1
    Sleep(100)
    ChkExtract()
WEnd

Func GuiEvent()
    Switch @GUI_CtrlId
        Case $GUI_EVENT_CLOSE
            Exit
        Case $GUI_EVENT_DROPPED
            If StringRegExp(@GUI_DragFile, "(?i)\.(cpl|dll|exe|icl|ocx)", 0) Then
                _GUICtrlListView_DeleteAllItems($LV)
                $sIn = @GUI_DragFile
                Update()
            EndIf
    EndSwitch
EndFunc   ;==>GuiEvent

Func ChkExtract()
    If $Extract Then
        $Extract = 0
        Local $FOD = FileSaveDialog("Save extracted icon as..", "", "Icon file (*.ico)", 18, DefName(), $hGui)
        If Not @error And $FOD <> "" Then
            WinSetTitle($hGui, "", "Extracting...")
            _ICL_ExtractIcon($sIn, $LHT, $FOD)
            If @error Then
                WinSetTitle($hGui, "", "Error extracting icon - Error Code: " & @error)
            Else
                WinSetTitle($hGui, "", "Done - Icons found in " & StringMid($sIn, StringInStr($sIn, "\", 0, -1) + 1) & ": " & $IHM)
            EndIf
        EndIf
    EndIf
EndFunc   ;==>ChkExtract

Func Update()
    $IHM = _WinAPI_ExtractIconEx($sIn, -1, 0, 0, 0)
    WinSetTitle($hGui, "", "Icons found in " & StringMid($sIn, StringInStr($sIn, "\", 0, -1) + 1) & ": " & $IHM)
    For $i = 1 To $IHM
        GUICtrlCreateListViewItem("-" & $i, $LV)
        GUICtrlSetImage(-1, $sIn, -$i, 1)
    Next
EndFunc   ;==>Update

Func DefName()
    Local $FN = StringFormat("%0" & StringLen($IHM) & "d", $LHT+1)
    Return $FN & "_" & StringTrimRight(StringMid($sIn, StringInStr($sIn, "\", 0, -1) + 1), 3) & "ico"
EndFunc   ;==>DefName

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
    Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR, $hWndLV, $tInfo
    $hWndLV = GUICtrlGetHandle($LV)

    $tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
    $hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
    $iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
    $iCode = DllStructGetData($tNMHDR, "Code")
    Switch $hWndFrom
        Case $hWndLV
            Switch $iCode
                Case $NM_DBLCLK
                    Local $LVHT = _GUICtrlListView_HitTest($hWndLV)
                    If $LVHT[0] <> -1 And StringRight($sIn, 4) = ".icl" Then
                        $Extract = 1
                        $LHT = ($LVHT[0])
                    EndIf
            EndSwitch
    EndSwitch
    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY
