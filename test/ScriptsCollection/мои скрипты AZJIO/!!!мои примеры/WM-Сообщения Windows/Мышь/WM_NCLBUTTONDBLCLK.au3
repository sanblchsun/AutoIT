Global $k=0
$Gui = GUICreate("������� ���� �� ���������", 390, 140, -1, -1, 0x00040000+0x00020000)
GUICtrlCreateLabel('������� WM_NCLBUTTONDBLCLK ����������� � ������ �������� ����� ����� ������ ���� � �� ��������� ������� ����, ������ �� ��������� � ����� ����, ����� ������ �������� �� ��������� �������� ����.', 5, 5, 380, 74)
GUISetState()

GUIRegisterMsg(0x00A3, "WM_NCLBUTTONDBLCLK")

While 1
   $msg = GUIGetMsg()
   Select
       Case $msg = -3
           Exit
   EndSelect
WEnd

Func WM_NCLBUTTONDBLCLK($hWndGui, $MsgId, $wParam, $lParam)
    $X = BitShift($lParam, 16)
    $Y = BitAND($lParam, 0xFFFF)
	$k+=1
	WinSetTitle($Gui, '', '������� ���� ' &$k& ' ���, x='&$X&', y='&$Y)
EndFunc