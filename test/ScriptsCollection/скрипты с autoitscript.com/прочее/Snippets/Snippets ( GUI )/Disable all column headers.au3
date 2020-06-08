#include <GuiConstantsEx.au3>
#include <GuiListView.au3>
 
_Main()
 
Func _Main()
 
    Local $hGUI = GUICreate("ListView Set Column Width", 400, 300)
    Local $hListView = GUICtrlCreateListView("Column 1|Column 2|Column 3|Column 4", 2, 2, 394, 268)
    GUISetState()
 
    ; Prevent resizing of columns
    ControlDisable($hGUI, "", HWnd(_GUICtrlListView_GetHeader($hListView)))
 
    ; Loop until user exits
    Do
    Until GUIGetMsg() = $GUI_EVENT_CLOSE
 
EndFunc   ;==>_Main