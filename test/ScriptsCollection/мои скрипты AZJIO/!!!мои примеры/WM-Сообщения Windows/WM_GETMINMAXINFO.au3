Global $k=0
$Gui = GUICreate("������ ������ ����, ������������", 390, 140, -1, -1, 0x00040000+0x00020000+0x00010000)
GUICtrlCreateLabel('������� WM_GETMINMAXINFO ����������� �� ����� ����������� ����, ������������ � ��������� ��������. ��������� ���������� ������� ���������� � ���������� ���� ��� �� ����������� ��� � �� ��������� �������������. � ����� ������� � ������� ����������� ���������. ������������ ��������� ����� ������������ ������ ������ ����������� ���������.', 5, 5, 360, 130)

GUISetState()

GUIRegisterMsg(0x0024, "WM_GETMINMAXINFO")

Do
Until GUIGetMsg() = -3

Func WM_GETMINMAXINFO($hWnd, $iMsg, $wParam, $lParam)
	$k+=1
	WinSetTitle($Gui, '', '������� ' &$k& ' ���')
	#forceref $iMsg, $wParam
	If $hWnd = $GUI Then
		Local $tMINMAXINFO = DllStructCreate("int;int;" & _
				"int MaxSizeX; int MaxSizeY;" & _
				"int MaxPositionX;int MaxPositionY;" & _
				"int MinTrackSizeX; int MinTrackSizeY;" & _
				"int MaxTrackSizeX; int MaxTrackSizeY", _
				$lParam)
		DllStructSetData($tMINMAXINFO, "MinTrackSizeX", 360) ; ����������� ������� ����
		DllStructSetData($tMINMAXINFO, "MinTrackSizeY", 130)
		DllStructSetData($tMINMAXINFO, "MaxTrackSizeX", 460) ; ������������ ������� ����
		DllStructSetData($tMINMAXINFO, "MaxTrackSizeY", 180)
		DllStructSetData($tMINMAXINFO, "MaxSizeX", 400) ; ������� ����������� ��������� ( ������ ����� ������, ���� ������������ ��������)
		DllStructSetData($tMINMAXINFO, "MaxSizeY", 180)
		DllStructSetData($tMINMAXINFO, "MaxPositionX", 400) ; ������� � ���������� ���������
		DllStructSetData($tMINMAXINFO, "MaxPositionY", 450)
	EndIf
EndFunc