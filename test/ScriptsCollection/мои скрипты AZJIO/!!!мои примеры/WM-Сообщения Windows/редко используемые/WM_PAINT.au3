Global $k=0
$Gui = GUICreate("��������� ������ ���� ������ �����", 390, 140)
GUICtrlCreateLabel('������� WM_PAINT ����������� � ������ ����������� ������� ���� ������ ��������. ����������� ��� ������������ �������, �� �� ��� ������������.', 5, 5, 360, 130)

GUISetState()

GUIRegisterMsg(0x000F , "WM_PAINT")

Do
Until GUIGetMsg() = -3

Func WM_PAINT()
	$k+=1
	WinSetTitle($Gui, '', '����� ' &$k& ' ���')
EndFunc