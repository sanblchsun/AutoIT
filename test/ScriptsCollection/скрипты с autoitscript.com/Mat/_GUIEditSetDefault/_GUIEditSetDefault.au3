Global $EDIT_DEF_ITEMS[1][2] = [[0, 0]]

Func _GUIEditSetDefault ($hEdit, $sDef)
    If $hEdit = 0 Then Return SetError (1, 0, 0)

    If $EDIT_DEF_ITEMS[0][0] = 0 Then GUIRegisterMsg (0x0111, "EDIT_DEF_WM_COMMAND")

    If GUICtrlRead ($hEdit) = "" Then
        GUICtrlSetColor ($hEdit, 0x444444)
        GUICtrlSetData ($hEdit, $sDef)
    EndIf

    ReDim $EDIT_DEF_ITEMS[UBound ($EDIT_DEF_ITEMS) + 1][2]
    $EDIT_DEF_ITEMS[UBound ($EDIT_DEF_ITEMS) - 1][0] = $hEdit
    $EDIT_DEF_ITEMS[UBound ($EDIT_DEF_ITEMS) - 1][1] = $sDef

    Return 1
EndFunc ; ==> _GUIEditSetDefault

Func EDIT_DEF_WM_COMMAND ($hWnd, $msgID, $wParam, $lParam)
    Local $n = EDIT_DEF_GETINDEX (BitAND ($wParam, 0xFFFF))
    If $n = -1 Then Return "GUI_RUNDEFMSG"

    Local $nMsg = BitShift($wParam, 16)
    If $nMsg = 256 Then ; Gained focus (EN_SETFOCUS)
        If (GUICtrlRead ($EDIT_DEF_ITEMS[$n][0]) == $EDIT_DEF_ITEMS[$n][1]) Then
            GUICtrlSetColor ($EDIT_DEF_ITEMS[$n][0], 0x000000)
            GUICtrlSetData ($EDIT_DEF_ITEMS[$n][0], "")
        EndIf
    ElseIf $nMsg = 512 Then ; Lost Focus (EN_KILLFOCUS)
        If GUICtrlRead ($EDIT_DEF_ITEMS[$n][0]) = "" Then
            GUICtrlSetColor ($EDIT_DEF_ITEMS[$n][0], 0x444444)
            GUICtrlSetData ($EDIT_DEF_ITEMS[$n][0], $EDIT_DEF_ITEMS[$n][1])
        EndIf
    EndIf
EndFunc ; ==> EDIT_DEF_WM_COMMAND

Func EDIT_DEF_GETINDEX ($hEdit)
    For $i = 1 to UBound ($EDIT_DEF_ITEMS) - 1
        If $EDIT_DEF_ITEMS[$i][0] = $hEdit Then Return $i
    Next
    Return -1
EndFunc ; ==> EDIT_DEF_GETINDEX