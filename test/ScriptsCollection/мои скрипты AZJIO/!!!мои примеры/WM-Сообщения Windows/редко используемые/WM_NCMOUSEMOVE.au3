Global $k=0
$Gui = GUICreate("���� �������� ����", 370, 140, -1, -1, 0x00040000+0x00020000)
GUICtrlCreateLabel('������� WM_NCMOUSEMOVE ����������� ��� ����������� ������ ���� � ���������� �� �������.'&@CRLF&'���������� �� WM_NCHITTEST ���, ��� ��������� ������ �� ����������� ������ ��������� ������� ����, � ��� ������������� ���������� �� ���������.', 5, 5, 360, 130)

GUISetState()
GUIRegisterMsg(0x00A0 , "WM_NCMOUSEMOVE")

Do
Until GUIGetMsg() = -3

Func WM_NCMOUSEMOVE($hWnd, $Msg, $wParam, $lParam)
	; ���������� ����, ���� � ��������� � ����� ����
	Local $xClient = BitAND($lParam, 0xFFFF)
	Local $yClient = BitShift($lParam, 16)
	Local $hit = BitAND($wParam, 0xFFFF)
	$k+=1
	WinSetTitle($Gui, '', '����� ' &$k& ' ���, x='&$xClient&', y='&$yClient&', '&$hit)
EndFunc 