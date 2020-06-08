#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiListView.au3>
#include <HeaderConstants.au3>

; The 0-based column to be disabled
Global $iFix_Col

_Main()

Func _Main()

    Local $hGUI = GUICreate("ListView Fix Column Width", 400, 300)
    Local $hListView = GUICtrlCreateListView("Column 0|Column 1|Column 2|Column 3", 2, 2, 394, 268)
    GUISetState()

    ; Prevent resizing of column 1
    $iFix_Col = 1

    GUIRegisterMsg($WM_NOTIFY, "_WM_NOTIFY")

    ; Loop until user exits
    Do
    Until GUIGetMsg() = $GUI_EVENT_CLOSE

EndFunc   ;==>_Main

Func _WM_NOTIFY($hWnd, $iMsg, $wParam, $lParam)

    #forceref $hWnd, $iMsg, $wParam

    ; Get details of message
    Local $tNMHEADER = DllStructCreate($tagNMHEADER, $lParam)
    ; Look for header resize code
    Local $iCode = DllStructGetData($tNMHEADER, "Code")
    Switch $iCode
        Case $HDN_BEGINTRACKW
            ; Now get column being resized
            Local $iCol = DllStructGetData($tNMHEADER, "Item")
            If $iCol = $iFix_Col Then
                ; Prevent resizing
                Return True
            Else
                ; Allow resizing
                Return False
            EndIf
    EndSwitch

EndFunc   ;==>_WM_NOTIFY