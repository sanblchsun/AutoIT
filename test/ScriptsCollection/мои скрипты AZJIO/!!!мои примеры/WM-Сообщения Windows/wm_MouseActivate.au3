Global $k=0
$Gui = GUICreate("��������� ������, � ����� ��������� ���", 390, 140)
GUICtrlCreateLabel('������� wm_MouseActivate ����������� ��� ��������� ���� ������', 5, 5, 360, 130)

GUISetState()

GUIRegisterMsg(0x0021 , "wm_MouseActivate")

Do
Until GUIGetMsg() = -3

Func wm_MouseActivate()
	$k+=1
	WinSetTitle($Gui, '', '�������� ��������� ' &$k& ' ���')
EndFunc