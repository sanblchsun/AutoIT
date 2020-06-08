Run(@WindowsDir & "\Notepad.exe")
WinWait("[Class:Notepad]", "", 5)

;��������� ��������� (����������� ��������������) ���� � ������ ������ "Notepad" � ������ ��� � ���������� $hWnd
$hWnd = WinGetHandle("[Class:Notepad]")

;�������� ������� ��������� ���������� � ���� ��������
$nOld_Layout = _GetKeyboardLayout($hWnd)

Sleep(1000)

;������������ ��������� � ����, ������������ ���������� $hWnd
_SetKeyboardLayout("00000419", $hWnd)

;����� ������ � Edit-����
ControlSend($hWnd, "", "Edit1", "Ntcn")

Sleep(1000)

;����������� ��������� ������� �� ��������
_SetKeyboardLayout($nOld_Layout, $hWnd)

Func _SetKeyboardLayout($sLayoutID, $hWnd)
    Local $WM_INPUTLANGCHANGEREQUEST = 0x50

    If StringLen($sLayoutID) <= 3 Then $sLayoutID = "00000" & $sLayoutID
    Local $aRet = DllCall("user32.dll", "long", "LoadKeyboardLayout", "str", $sLayoutID, "int", 0)

    DllCall("user32.dll", "ptr", "SendMessage", "hwnd", $hWnd, "int", $WM_INPUTLANGCHANGEREQUEST, "int", 1, "int", $aRet[0])
EndFunc

Func _GetKeyboardLayout($hWnd)
    Local $aRet = DllCall("user32.dll", "long", "GetWindowThreadProcessId", "hwnd", $hWnd, "ptr", 0)
    $aRet = DllCall("user32.dll", "long", "GetKeyboardLayout", "long", $aRet[0])

    Return "0000" & Hex($aRet[0], 4)
EndFunc

#cs
    �������������� �����.

    "00000407" �������� (�����������)
    "00000409" ���������� (���)
    "0000040C" ����������� (�����������)
    "0000040D" �������
    "00000410" �����������
    "00000415" ��������
    "00000419" �������
    "00000422" ����������
    "00000423" �����������
    "00000425" ���������
    "00000426" ����������
    "00000427" ���������
#ce