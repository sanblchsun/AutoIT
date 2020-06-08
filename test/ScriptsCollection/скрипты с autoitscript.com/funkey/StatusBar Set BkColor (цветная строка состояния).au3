#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Global $hGUI, $hStatus
Global $aParts[3] = [75, 150, -1]

$hGUI = GUICreate("StatusBar Set BkColor", 400, 300)
GUIRegisterMsg($WM_DRAWITEM, "_WM_DRAWITEM")
$hStatus = _GUICtrlStatusBar_Create($hGUI)
GUISetState()

;~ _GUICtrlStatusBar_SetBkColor($hStatus, 0x5555DD)

_GUICtrlStatusBar_SetParts($hStatus, $aParts)
_GUICtrlStatusBar_SetText($hStatus, "Part 1", 0, $SBT_OWNERDRAW)
_GUICtrlStatusBar_SetText($hStatus, "Part 2", 1, $SBT_OWNERDRAW)
_GUICtrlStatusBar_SetText($hStatus, "Part 3", 2, $SBT_OWNERDRAW)

Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
GUIDelete()

Func _WM_DRAWITEM($hWnd, $Msg, $wParam, $lParam)
    #forceref $Msg, $wParam, $lParam
    Local $tDRAWITEMSTRUCT = DllStructCreate("uint CtlType;uint CtlID;uint itemID;uint itemAction;uint itemState;HWND hwndItem;HANDLE hDC;long rcItem[4];ULONG_PTR itemData", $lParam)
    Local $itemID = DllStructGetData($tDRAWITEMSTRUCT, "itemID")    ;part number
    Local $hDC = DllStructGetData($tDRAWITEMSTRUCT, "hDC")
    Local $tRect = DllStructCreate("long left;long top;long right; long bottom", DllStructGetPtr($tDRAWITEMSTRUCT, "rcItem"))
    Local $iTop = DllStructGetData($tRect, "top")
    Local $iLeft = DllStructGetData($tRect, "left")
    Local $hBrush

    Switch $itemID
        Case 0
            $hBrush = _WinAPI_CreateSolidBrush(0xFFFF00)
            _WinAPI_FillRect($hDC, DllStructGetPtr($tRect), $hBrush)
            _WinAPI_SetBkMode($hDC, $TRANSPARENT)
            DllStructSetData($tRect, "top", $iTop + 1)
            DllStructSetData($tRect, "left", $iLeft + 1)
            _WinAPI_DrawText($hDC, "Part 1", $tRect, $DT_LEFT)
            _WinAPI_DeleteObject($hBrush)
        Case 1
            $hBrush = _WinAPI_CreateSolidBrush(0x00FF00)
            _WinAPI_FillRect($hDC, DllStructGetPtr($tRect), $hBrush)
            _WinAPI_SetBkMode($hDC, $TRANSPARENT)
            DllStructSetData($tRect, "top", $iTop + 1)
            DllStructSetData($tRect, "left", $iLeft + 1)
            _WinAPI_DrawText($hDC, "Part 2", $tRect, $DT_LEFT)
            _WinAPI_DeleteObject($hBrush)
        Case 2
            $hBrush = _WinAPI_CreateSolidBrush(0xABCDEF)
            _WinAPI_FillRect($hDC, DllStructGetPtr($tRect), $hBrush)
            _WinAPI_SetBkMode($hDC, $TRANSPARENT)
            DllStructSetData($tRect, "top", $iTop + 1)
            DllStructSetData($tRect, "left", $iLeft + 1)
            _WinAPI_DrawText($hDC, "Part 3", $tRect, $DT_LEFT)
            _WinAPI_DeleteObject($hBrush)
        EndSwitch

    $tDRAWITEMSTRUCT = 0
    Return $GUI_RUNDEFMSG
EndFunc   ;==>_WM_DRAWITEM