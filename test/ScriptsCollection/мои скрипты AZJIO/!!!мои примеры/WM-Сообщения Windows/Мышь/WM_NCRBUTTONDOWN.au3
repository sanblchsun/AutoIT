Global $k=0
$Gui = GUICreate("������ ������ ������� ���� �� ���������", 450, 140, -1, -1, 0x00040000+0x00020000)
GUICtrlCreateLabel('������� WM_NCRBUTTONDOWN ����������� � ������ ������� ������ ������ ���� � �� ��������� ������� ����, ������ �� ��������� � ����� ����, ����� ������ �������� �� ��������� �������� ����.', 5, 5, 440, 54)
GUISetState()

GUIRegisterMsg(0x00A4, "WM_NCRBUTTONDOWN")

While 1
   $msg = GUIGetMsg()
   Select
       Case $msg = -3
           Exit
   EndSelect
WEnd

Func WM_NCRBUTTONDOWN($hWndGui, $MsgId, $wParam, $lParam)
    $X = BitShift($lParam, 16)
    $Y = BitAND($lParam, 0xFFFF)
	$k+=1
	WinSetTitle($Gui, '', '������� ' &$k& ' ���, x='&$X&', y='&$Y)
EndFunc