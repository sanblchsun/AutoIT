Run ("notepad.exe")
WinWaitActive ("���������� - �������")
$win_handle = WinGetHandle ("���������� - �������")

;~ ������������ � ���������� ���������
_SetKeyboardLayout("00000409", $win_handle)
Send ("English")

;~ ������������ � ������� ���������
_SetKeyboardLayout("00000419", $win_handle)
Send (@CRLF & "�������")
    Sleep (200)

WinClose ("���������� - �������")
WinWaitActive ("�������", "����� � ����� ���������� ��� �������.")
$win_handle = WinGetHandle ("�������", "����� � ����� ���������� ��� �������.")
    Sleep (200)

;~ ����� ������ ��� ������� ALT+� (����� � - �������)
Send ("!{�}")

Func _SetKeyboardLayout($sLayoutID, $hWnd)
    Local $WM_INPUTLANGCHANGEREQUEST = 0x50
    Local $ret = DllCall("user32.dll", "long", "LoadKeyboardLayout", "str", $sLayoutID, "int", 0)
    DllCall("user32.dll", "int", "SendMessage", "hwnd", $hWnd, _
                                                "int", $WM_INPUTLANGCHANGEREQUEST, _
                                                "int", 1, _
                                                "int", $ret[0])
EndFunc
