#include <String.au3>
#include <WinAPI.au3>
#include <GuiEdit.au3>
#include <GuiListView.au3>

HotKeySet("{F2}", "_VistaRename")

While 1
    Sleep(100)
WEnd

Func _VistaRename()
    HotKeySet("{F2}")
    Local $sClass = _WinAPI_GetClassName(WinGetHandle("[ACTIVE]")), $sFile, $hListView, $hFileEdit
    If StringInstr("|ExploreWClass|CabinetWClass|Progman|", "|" & $sClass & "|") > 0 Then
        $hActiveControl = ControlGetHandle("[ACTIVE]", "", ControlGetFocus("[ACTIVE]"))
        If _WinAPI_GetClassName($hActiveControl) = "SysListView32" Then
            $hFileEdit = _GUICtrlListView_EditLabel($hActiveControl, _GUICtrlListView_GetNextItem($hActiveControl))
            $sFile = _GUICtrlEdit_GetText($hFileEdit)
            _GUICtrlEdit_SetSel($hFileEdit, 0, StringInStr($sFile, ".", 0, -1) - 1)
        Else
            Send("{F2}")
        EndIf
    Else
        Send("{F2}")
    EndIf
    HotKeySet("{F2}", "_VistaRename")
EndFunc   ;==>_VistaRename
