; http://www.autoitscript.com/forum/topic/144281-ideas-for-a-better-guictrlcombobox-autocomplete
#include <WindowsConstants.au3>
#include <GuiConstants.au3>
#include <GuiComboBox.au3>

Global $lock2, $lock3
$list = "Aaron|Ada|Adams|Adamsville|Addams|Adell|Adelman|Adenson|Akron|Appleton|Bannock|Bear Lake|Benewah|Bingham|Blaine|Boise|Bonner|Bonneville|" & _
"Boundary|Butte|Camas|Canyon|Caribou|Cassia|Clark|Clearwater|Custer|Elmore|Franklin|Fremont|Gem|Gooding|Idaho|Jefferson|Jerome|" & _
"Kootenai|Latah|Lemhi|Lewis|Lincoln|Madison|Minidoka|Oneida|Owyhee|Payette|Power|Shoshone|Test11|Test22|Testing|Teton|Twin Falls|Valley|Washington"

GUICreate("_GUICtrlComboBox_AutoComplete comparison",430,320)
GUICtrlCreateLabel(StringReplace($list,"|"," "), 10, 10, 400, 100)

GUICtrlCreateLabel("PRODUCTION VERSION:", 20, 110, 130)
$Ctrl_Combo1 = GUICtrlCreateCombo("", 160, 107, 180)
GUICtrlSetData($Ctrl_Combo1, $list)

GUICtrlCreateLabel("MODIFIED VERSION:", 20, 145, 130)
$Ctrl_Combo2 = GUICtrlCreateCombo("", 160, 142, 180)
GUICtrlSetData($Ctrl_Combo2, $list)
$hCombo2 = GUICtrlGetHandle($Ctrl_Combo2)
$Ctrl_Check2 = GUICtrlCreateCheckbox("LOCK", 350, 142, 50, 20)

GUICtrlCreateLabel("TROUBLED VERSION:", 20, 180, 130)
$Ctrl_Combo3 = GUICtrlCreateCombo("", 160, 177, 180)
GUICtrlSetData($Ctrl_Combo3, $list)
$hCombo3 = GUICtrlGetHandle($Ctrl_Combo3)
$Ctrl_Check3 = GUICtrlCreateCheckbox("LOCK", 350, 177, 50, 20)

GUICtrlCreateLabel("Behaviors to test:", 20, 220, 400)
GUICtrlCreateLabel("> Backspace and delete keys", 20, 240, 400)
GUICtrlCreateLabel("> Inserting and ovewriting characters", 20, 260, 400)
GUICtrlCreateLabel("> Arrow up and arrow down keys", 20, 280, 400)
GUISetState()
GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")

While 1
    $msg = GUIGetMsg()
    Switch $msg
        Case $Ctrl_Check2
            $lock2 = (Not $lock2)
            _GUICtrlComboBox_SetEditText($hCombo2, "")
            GUICtrlSetState($Ctrl_Combo2, $GUI_FOCUS)
        Case $Ctrl_Check3
            $lock3 = (Not $lock3)
            _GUICtrlComboBox_SetEditText($hCombo3, "")
         GUICtrlSetState($Ctrl_Combo3, $GUI_FOCUS)
        Case $GUI_EVENT_CLOSE
            Exit
    EndSwitch
WEnd

;-------------------------------------------------------------------------
Func _GUICtrlComboBox_AutoComplete2($hWnd, $iLock = 0)
    Local $ret, $sEditText, $sEditSel
    If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
    $sEditSel = _GUICtrlComboBox_GetEditSel($hWnd)
    If IsArray($sEditSel) Then
        $sEditSel = $sEditSel[0] ; characters left of cursor
    EndIf
    $sEditText = StringLeft(_GUICtrlComboBox_GetEditText($hWnd), $sEditSel)
    _GUICtrlComboBox_SetEditText($hWnd, $sEditText)
    If StringLen($sEditText) Then
        $ret = _GUICtrlComboBox_FindString($hWnd, $sEditText)
     If ($ret <> $CB_ERR) Then ; found
            _GUICtrlComboBox_SetCurSel($hWnd, $ret)
        Else
            If $iLock Then
                $sEditSel -= 1
                $sEditText = StringLeft($sEditText, $sEditSel)
             $ret = _GUICtrlComboBox_FindString($hWnd, $sEditText)
               _GUICtrlComboBox_SetCurSel($hWnd, $ret)
            EndIf
        EndIf
        _GUICtrlComboBox_SetEditSel($hWnd, $sEditSel, $sEditSel) ; place cursor
    EndIf
EndFunc ;==>_GUICtrlComboBox_AutoComplete2

;-------------------------------------------------------------------------
Func _GUICtrlComboBox_AutoComplete3($hWnd, $iLock = 0)
    Local $ret, $sEditText, $sEditSel
    If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
    $sEditSel = _GUICtrlComboBox_GetEditSel($hWnd)
    If IsArray($sEditSel) Then
        $sEditSel = $sEditSel[0] ; characters left of cursor
    EndIf
    $sEditText = StringLeft(_GUICtrlComboBox_GetEditText($hWnd), $sEditSel)
    _GUICtrlComboBox_SetEditText($hWnd, $sEditText)
    If StringLen($sEditText) Then
        $ret = _GUICtrlComboBox_FindString($hWnd, $sEditText)
        If ($ret <> $CB_ERR) Then ; found
            _GUICtrlComboBox_SetCurSel($hWnd, $ret)
            If __GUICtrlComboBox_IsPressed('08') Then
                $sEditSel -= 1
                $sEditText = StringLeft($sEditText, $sEditSel)
            EndIf
        Else
            If $iLock Then
                $sEditSel -= 1
             $sEditText = StringLeft($sEditText, $sEditSel)
             $ret = _GUICtrlComboBox_FindString($hWnd, $sEditText)
             _GUICtrlComboBox_SetCurSel($hWnd, $ret)
            EndIf
        EndIf
        _GUICtrlComboBox_SetEditSel($hWnd, $sEditSel, -1) ; place cursor
    EndIf
EndFunc ;==>_GUICtrlComboBox_AutoComplete3

;-------------------------------------------------------------------------
Func WM_COMMAND($hWnd, $Msg, $wParam, $lParam)
    $nNotifyCode = BitShift($wParam, 16) ; HiWord
    $nID = BitAnd($wParam, 0x0000FFFF) ; LoWord
    Switch $nID
        Case $Ctrl_Combo1
            Switch $nNotifyCode
                Case $CBN_EDITCHANGE
                 _GUICtrlComboBox_AutoComplete($Ctrl_Combo1)
            EndSwitch
        Case $Ctrl_Combo2
         Switch $nNotifyCode
;              Case $CBN_EDITUPDATE
                Case $CBN_EDITCHANGE
                   _GUICtrlComboBox_AutoComplete2($Ctrl_Combo2, $lock2)
            EndSwitch
        Case $Ctrl_Combo3
            Switch $nNotifyCode
;              Case $CBN_EDITUPDATE
                Case $CBN_EDITCHANGE
                    _GUICtrlComboBox_AutoComplete3($Ctrl_Combo3, $lock3)
            EndSwitch
    EndSwitch
EndFunc