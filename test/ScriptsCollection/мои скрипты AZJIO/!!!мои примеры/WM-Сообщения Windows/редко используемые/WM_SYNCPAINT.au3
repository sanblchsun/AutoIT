Global $k=0
$Gui = GUICreate("��������� ������ ���� ������ �����", 390, 140)
GUICtrlCreateLabel('������� WM_SYNCPAINT ����������� � ������ ����������� ������� ���� ������ ��������. ����������� ��� ������������ �������, �� �� ��� ������������.', 5, 5, 360, 130)

GUISetState()

GUIRegisterMsg(0x0088 , "WM_SYNCPAINT")

Do
Until GUIGetMsg() = -3

Func WM_SYNCPAINT()
	$k+=1
	WinSetTitle($Gui, '', '����� ' &$k& ' ���')
EndFunc