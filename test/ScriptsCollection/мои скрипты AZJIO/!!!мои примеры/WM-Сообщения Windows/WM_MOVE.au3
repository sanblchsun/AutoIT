Global $k=0
GUIRegisterMsg(0x0003 , "WM_MOVE")
$Gui = GUICreate("������ ������ ����", 370, 140, -1, -1, 0x00040000+0x00020000)
GUICtrlCreateLabel('������� WM_MOVE ����������� ������ � ������ ����������� ����. ����� ������� ������ � ����� ������, ������� ������������� ������ � ������ ����������� ����', 5, 5, 360, 130)

GUISetState()

Do
Until GUIGetMsg() = -3

Func WM_MOVE($hWnd, $Msg, $wParam, $lParam)
	; ���������� ��������� ����� ����
	Local $xClient = BitAND($lParam, 0xFFFF)
	Local $yClient = BitShift($lParam, 16)
	$k+=1
	WinSetTitle($Gui, '', '����� ' &$k& ' ���, x='&$xClient&', y='&$yClient)
EndFunc