Global $k=0
$Gui = GUICreate("������ ������ ����", 370, 140, -1, -1, 0x00040000+0x00020000+0x00010000)
GUICtrlCreateLabel('������� WM_SIZE ����������� ������ � ������ ��������� �������� ����. ����� ������� ������ ��������� ��������� ��������� ��������� ���������� � ������ ��������� �������� ����', 5, 5, 360, 130)

GUISetState()

GUIRegisterMsg(0x05 , "WM_SIZE") ; �� �� 0x0005

Do
Until GUIGetMsg() = -3

Func WM_SIZE($hWnd, $Msg, $wParam, $lParam)
	#forceref $Msg, $wParam
	Local $xClient, $yClient

	; ���������� ������� ��������� �����.
	$xClient = BitAND($lParam, 0xFFFF) ; _WinAPI_LoWord
	$yClient = BitShift($lParam, 16) ; _WinAPI_HiWord
	
	$k+=1
	WinSetTitle($Gui, '', '����� ' &$k& ' ���, x='&$xClient&', y='&$yClient)

	Return 'GUI_RUNDEFMSG'
EndFunc