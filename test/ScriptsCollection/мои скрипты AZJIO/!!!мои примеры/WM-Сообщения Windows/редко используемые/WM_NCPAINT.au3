Global $k=0
$Gui = GUICreate("��������� ������ ���� ������ �����", 390, 140)
GUICtrlCreateLabel('������� WM_NCPAINT ����������� � ������ ����������� ������� ���� ������ ��������. ����������� ��� ������������ �������, �� �� ��� ������������.', 5, 5, 360, 130)

GUISetState()

GUIRegisterMsg(0x0085 , "WM_NCPAINT")

Do
Until GUIGetMsg() = -3

Func WM_NCPAINT()
	$k+=1
	WinSetTitle($Gui, '', '����� ' &$k& ' ���')
EndFunc