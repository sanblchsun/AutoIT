Global $k=0
GUIRegisterMsg(0x0112 , "WM_SYSCOMMAND")
$Gui = GUICreate("������ �� ���������", 370, 180)
GUICtrlCreateLabel('������� WM_SYSCOMMAND ����������� � ������ ����� �� ��������� ����, ��������� �������� ���� (����������), ��� ������������.'&@CRLF&'��� ������������ ������� ������ � �����. ����� ���� �������� ������ ���� ���� ��� � ������ ����� �� ���������. ����� ������ ��� ���������� �������� WM_MOVE '&@CRLF&'����� ������������ ��� ���������� �������� ���� � ������ ������������, ����� ��� �������� ��������� � ������ ����� ����� ��������� ��������� ����������.', 5, 5, 360, 150)
$condition = GUICtrlCreateLabel('', 10, 155, 360, 17)

GUISetState()

Do
Until GUIGetMsg() = -3

Func WM_SYSCOMMAND($hWnd, $Msg, $wParam, $lParam)
	$k+=1
	WinSetTitle($Gui, '', '������� �� ��������� ' &$k& ' ���')

	#forceref $Msg, $wParam
	Local $MouseX, $MouseY

	; ���������� ���� ������������ ������ ��������.
	$MouseX = BitAND($lParam, 0xFFFF)
	$MouseY = BitShift($lParam, 16)

	$k+=1
	GUICtrlSetData($condition,'MouseX='&$MouseX&', MouseY='&$MouseY)

	Return 'GUI_RUNDEFMSG'
EndFunc