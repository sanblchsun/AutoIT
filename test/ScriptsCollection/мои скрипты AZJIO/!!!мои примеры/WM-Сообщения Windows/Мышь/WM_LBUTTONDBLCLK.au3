Global $k=0
$Gui = GUICreate("������ ������� ����", 400, 150)
GUICtrlCreateLabel('������� WM_LBUTTONDBLCLK ����������� � ������ �������� ����� ���� � ��������� ������� ����.', 5, 5, 380, 34)
GUISetState()

GUIRegisterMsg(0x0203, "WM_LBUTTONDBLCLK")

While 1
   $msg = GUIGetMsg()
   Select
       Case $msg = -3
           Exit
   EndSelect
WEnd

Func WM_LBUTTONDBLCLK($hWndGui, $MsgId, $wParam, $lParam)
    $X = BitShift($lParam, 16)
    $Y = BitAND($lParam, 0xFFFF)
	$k+=1
	WinSetTitle($Gui, '', '������� ' &$k& ' ���, x='&$X&', y='&$Y)
EndFunc