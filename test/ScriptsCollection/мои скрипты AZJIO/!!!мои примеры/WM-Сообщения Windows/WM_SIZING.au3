Global $k=0
$Gui = GUICreate("������ ������ ����", 370, 140, -1, -1, 0x00040000+0x00020000)
GUICtrlCreateLabel('������� WM_SIZING ����������� ������ � ������ ��������� �������� ����. ���������� �� WM_SIZE ���, ��� ����������� � ������ ������� ����. ����� ������� ������ ��������� ��������� ��������� ��������� ���������� � ������ ��������� �������� ����', 5, 5, 360, 130)

GUISetState()

GUIRegisterMsg(0x0214 , "WM_SIZING")

Do
Until GUIGetMsg() = -3

Func WM_SIZING($hWnd, $iMsg, $wparam, $lparam)
	; �������� ���������� ������ ����
	Local $sRect = DllStructCreate("Int[4]", $lparam), _
	$left = DllStructGetData($sRect, 1, 1), _
	$top = DllStructGetData($sRect, 1, 2), _
	$Right = DllStructGetData($sRect, 1, 3), _
	$bottom = DllStructGetData($sRect, 1, 4)

	$k+=1
	WinSetTitle($Gui, '', '����� ' &$k& ' ���, x='&$Right-$left&', y='&$bottom-$top)

	Return 'GUI_RUNDEFMSG'
EndFunc