Global $k1=0
Global $k2=0
Global Const $WM_MOUSEWHEEL = 0x020A

GUIRegisterMsg(0x020A , "WM_MOUSEWHEEL")
$Gui = GUICreate("����� ������ ���� ���� / �����",  370, 160)
GUICtrlCreateLabel('������� WM_MOUSEWHEEL ����������� � ������ �������� ������� ����. ���������� ���������� Ctrl, Shift, ������ ���� ��� �������� �������, ��� ����-������ ���� ������������. ����� ������������ ��� ��������� �������� ���������� � ������� c GUICtrlCreateUpdown.', 5, 5, 360, 75)
$Label1 = GUICtrlCreateLabel("������ ���� ���������� ����� 0 ���", 10, 90, 226, 17)
$Label2 = GUICtrlCreateLabel("������ ���� ���������� ���� 0 ���", 10, 110, 226, 17)
$Label3 = GUICtrlCreateLabel("", 10, 130, 226, 17)
$Input=GUICtrlCreateInput("", 240, 95, 100, 21)
GUISetState ()

While 1
	$msg = GUIGetMsg()
	Select
		Case $msg = -3
			Exit
	EndSelect
WEnd

Func WM_MOUSEWHEEL($hWndGui, $MsgId, $wParam, $lParam)
    If $MsgId = $WM_MOUSEWHEEL Then
        $Delta = BitShift($wParam, 16)
        $KeysHeld = BitAND($wParam, 0xFFFF)
        $X = BitShift($lParam, 16)
        $Y = BitAND($lParam, 0xFFFF)
		GUICtrlSetData($Label3, "Delta: "&$Delta&", �������: "&$KeysHeld&",     X: "&$X&", Y: "&$Y)
		
        If $Delta > 0 Then
			$k1+=1
			GUICtrlSetData($Label1, '������ ���� ���������� ����� '&$k1&' ���')
			WinSetTitle($Gui, '', '����� '&$k1&' ���, ���� '&$k2&' ���')
			GUICtrlSetData($Input, $k1&' - '&$k2&' = '&$k1-$k2)
        Else
			$k2+=1
			GUICtrlSetData($Label2, '������ ���� ���������� ���� '&$k2&' ���')
			WinSetTitle($Gui, '', '����� '&$k1&' ���, ���� '&$k2&' ���')
			GUICtrlSetData($Input, $k1&' - '&$k2&' = '&$k1-$k2)
        EndIf
    EndIf
EndFunc