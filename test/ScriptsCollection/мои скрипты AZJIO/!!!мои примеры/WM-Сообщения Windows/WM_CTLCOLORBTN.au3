Global $k=0
$Gui = GUICreate("������ ������� �� ������", 390, 140, -1, -1, 0x00040000+0x00020000)
GUICtrlCreateLabel('������� WM_CTLCOLORBTN ����������� � ������ ��������� ������� �� ������, ������ ����������� � ������.', 5, 5, 380, 34)
GUICtrlCreateButton('Button', 10, 40, 70, 25)

GUISetState()
GUIRegisterMsg (0x0135, "WM_CTLCOLORBTN")

Do
Until GUIGetMsg() = -3

Func WM_CTLCOLORBTN()
	$k+=1
	$GP = MouseGetPos()
	WinSetTitle($Gui, '', '����� ' &$k& ' ���, x='&$GP[0]&', y='&$GP[1])
EndFunc