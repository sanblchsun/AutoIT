Global $k=0
$Gui = GUICreate("������ ������", 370, 140)
GUICtrlCreateLabel('������� WM_DEVICECHANGE ����������� �� ����� ��������� ������ � �������, �������� ������������ ������. � �������� ������� �� ������� USBMon.au3 �� rasim', 5, 5, 360, 130)

GUISetState()
GUIRegisterMsg(0x0219, "WM_DEVICECHANGE")

Do
Until GUIGetMsg() = -3

Func WM_DEVICECHANGE()
	$k+=1
	WinSetTitle($Gui, '', '����� ' &$k& ' ���')
EndFunc