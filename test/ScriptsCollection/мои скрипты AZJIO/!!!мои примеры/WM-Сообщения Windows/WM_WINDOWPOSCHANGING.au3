Global $k=0
$Gui = GUICreate("������ ������ ����", 370, 220, -1, -1, 0x00040000+0x00020000)
GUICtrlCreateLabel('������� WM_WINDOWPOSCHANGING ����������� � ������ ��������� �������� ����, �����������, ����� �� ���������. ����� ������� ������ ��������� ��������� ��������� ��������� ���������� � ������ ��������� �������� ����', 5, 5, 360, 70)
$condition = GUICtrlCreateLabel('', 10, 75, 360, 135)

GUISetState()

GUIRegisterMsg(0x0046 , "WM_WINDOWPOSCHANGING")

Do
Until GUIGetMsg() = -3

Func WM_WINDOWPOSCHANGING($hWnd, $Msg, $wParam, $lParam)
	; �������� ���������� ������ ����
	Local $sRect = DllStructCreate("Int[6]", $lparam), _
	$ykazatel = DllStructGetData($sRect, 1, 1), _
	$otpysk = DllStructGetData($sRect, 1, 2), _
	$left = DllStructGetData($sRect, 1, 3), _
	$top = DllStructGetData($sRect, 1, 4), _
	$WinSizeX = DllStructGetData($sRect, 1, 5), _
	$WinSizeY = DllStructGetData($sRect, 1, 6)

	$k+=1
	GUICtrlSetData($condition,'����� ' &$k& ' ���'&@CRLF&'�����='&$ykazatel&@CRLF&'������='&$otpysk&@CRLF& 'Left='&$left&@CRLF&'Top='&$top&@CRLF& 'WinSizeX='&$WinSizeX&@CRLF&'WinSizeY='&$WinSizeY)
	WinSetTitle($Gui, '', '����� ' &$k& ' ���, x='&$WinSizeX&', y='&$WinSizeY)

	Return 'GUI_RUNDEFMSG'
EndFunc