MsgBox(0, '���������', _IsTaskbarHidden())

; ����������, �������� �� ������ ����� ������ ��� ���.
; ������ ������� �� ����� ����������� ������ �����
Func _IsTaskbarHidden()
    Local Const $ABS_AUTOHIDE = 0x01, $ABM_GETSTATE = 0x00000004
    Local $aReturn = DllCall('shell32.dll', 'uint', 'SHAppBarMessage', 'dword', $ABM_GETSTATE, 'ptr*', 0)
    If @error Then
        Return SetError(1, 0, 0)
    EndIf
    Return BitAND($aReturn[0], $ABS_AUTOHIDE) = $ABS_AUTOHIDE
EndFunc   ;==>_IsTaskbarHidden