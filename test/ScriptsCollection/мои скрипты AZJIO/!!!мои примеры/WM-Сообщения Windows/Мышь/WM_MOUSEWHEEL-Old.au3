Global $k1=0
Global $k2=0
GUIRegisterMsg(0x020A , "WM_MOUSEWHEEL")
$Gui = GUICreate("����� ������ ���� ���� / �����",  370, 100)
GUICtrlCreateLabel('������� WM_MOUSEWHEEL ����������� � ������ �������� ������� ����. ����� ������������ ��� ��������� �������� ���������� � ������� c GUICtrlCreateUpdown.', 5, 5, 360, 50)
$Label1 = GUICtrlCreateLabel("������ ���� ���������� ����� 0 ���", 10, 60, 226, 17)
$Label2 = GUICtrlCreateLabel("������ ���� ���������� ���� 0 ���", 10, 80, 226, 17)
$Input=GUICtrlCreateInput("", 240, 65, 100, 21)
GUISetState ()

While 1
	$msg = GUIGetMsg()
	Select
		Case $msg = -3
			Exit
	EndSelect
WEnd

Func WM_MOUSEWHEEL($hWnd,$nMsg,$wParam,$lParam)
	; MsgBox(0, '���������', $hWnd&@CRLF&$nMsg&@CRLF&$wParam&@CRLF&$lParam)
	If $wParam=0x00780000 Then
		$k1+=1
		GUICtrlSetData($Label1, '������ ���� ���������� ����� '&$k1&' ���')
		WinSetTitle($Gui, '', '����� '&$k1&' ���, ���� '&$k2&' ���')
		GUICtrlSetData($Input, $k1&' - '&$k2&' = '&$k1-$k2)
	EndIf
	If $wParam=0xFF880000 Then
		$k2+=1
		GUICtrlSetData($Label2, '������ ���� ���������� ���� '&$k2&' ���')
		WinSetTitle($Gui, '', '����� '&$k1&' ���, ���� '&$k2&' ���')
		GUICtrlSetData($Input, $k1&' - '&$k2&' = '&$k1-$k2)
	EndIf
EndFunc