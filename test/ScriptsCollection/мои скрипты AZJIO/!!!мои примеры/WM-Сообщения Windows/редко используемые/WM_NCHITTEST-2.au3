Global $k=0
Global Const $WM_NCHITTEST = 0x0084
Global Const $GUI_RUNDEFMSG = 'GUI_RUNDEFMSG'
$Gui = GUICreate("���� �������� ����", 370, 190, -1, -1, 0x00040000+0x00020000)
GUICtrlCreateLabel('������� WM_NCHITTEST �� �����������, ����� ���� ���������, �� ����������� ��� ���������� �� ����������� ����. ���� ���� �������, �� ����������� � ��������� ��������, � ����������� ������� ������ ��� �������� �� �� ��������� ����������.', 5, 5, 360, 70)

GUISetState()

GUIRegisterMsg(0x0084, 'WM_NCHITTEST') 

Do
Until GUIGetMsg() = -3

Func WM_NCHITTEST($hWnd, $iMsg, $wParam, $lParam)
	Switch $hWnd
		Case $Gui
			Switch $iMsg
				Case $WM_NCHITTEST
					; ���������� ����, ���� � ��������� ������� ���� � ���� ������������
					Local $xClient = BitAND($lParam, 0xFFFF)
					Local $yClient = BitShift($lParam, 16)
					$k+=1
					WinSetTitle($Gui, '', '����� ' &$k& ' ���, x='&$xClient&', y='&$yClient)
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc