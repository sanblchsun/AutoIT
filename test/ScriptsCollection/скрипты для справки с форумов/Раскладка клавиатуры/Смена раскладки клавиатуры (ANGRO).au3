Run("notepad.exe")
Sleep(500)
;��������� ������ ������ ���� �� ���������� (Advanced mode)
Opt("WinTitleMatchMode",4)
;��������� ��������� (����������� ��������������) ���� � ������ ������ "Notepad" � ������ ��� � ���������� $hWnd
$hWnd = WinGetHandle("classname=Notepad")
;������������ ��������� � ����, ������������ ���������� $hWnd
_SetKeyboardLayout("00000409", $hWnd)

Func _SetKeyboardLayout($sLayoutID, $hWnd)
Local $WM_INPUTLANGCHANGEREQUEST = 0x50
Local $ret = DllCall("user32.dll", "long", "LoadKeyboardLayout", "str", $sLayoutID, "int", 0)
DllCall("user32.dll", "ptr", "SendMessage", "hwnd", $hWnd, "int", $WM_INPUTLANGCHANGEREQUEST, "int", 1, "int", $ret[0])
EndFunc
Exit
#cs
�������������� �����.
"00000407" �������� (�����������)
"00000409" ���������� (���)
"0000040C" ����������� (�����������)
"0000040D" �������
"00000410" �����������
"00000415" ��������
"00000419" �������
"00000422" ����������"00000423" �����������
"00000425" ���������
"00000426" ����������
"00000427" ���������
#ce