Global $k=0
GUIRegisterMsg(0x001E , "WM_TIMECHANGE")
$Gui = GUICreate("������ ��������� ���� ��� �����", 390, 180, -1, -1, 0x00040000+0x00020000)
GUICtrlCreateLabel('������� WM_TIMECHANGE ����������� � ������ ��������� ��������� ����, �������. ����� ������������ ��� ���� �� ��������� ������ ��������� � ��������� ������.', 5, 5, 360, 55)
$Label = GUICtrlCreateLabel('�����: '&@HOUR&':'&@MIN&':'&@SEC&@CRLF&'����: '&@MDAY&':'&@MON&':'&@YEAR, 10, 60, 226, 34)

GUISetState()

Do
Until GUIGetMsg() = -3

Func WM_TIMECHANGE()
	$k+=1
	WinSetTitle($Gui, '', '����� ' &$k& ' ���')
	GUICtrlSetData($Label, '�����: '&@HOUR&':'&@MIN&':'&@SEC&@CRLF&'����: '&@MDAY&':'&@MON&':'&@YEAR)
EndFunc