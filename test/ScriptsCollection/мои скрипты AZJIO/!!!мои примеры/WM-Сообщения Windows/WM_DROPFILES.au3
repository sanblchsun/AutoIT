Global $k=0
GUIRegisterMsg(0x0233 , "WM_DROPFILES")
$Gui = GUICreate("���� ���� � ����",  620, 90, -1, -1, -1, 0x00000010)
GUICtrlCreateLabel('������� WM_DROPFILES ����������� � ������ ������������� ����� � ����.', 10, 40, 360, 40)

$Input1 = GUICtrlCreateInput("���� ���� ����", 10, 10, 600, 21)
; GUICtrlSetState(-1, 8) 

GUISetState()

Do
Until GUIGetMsg() = -3

Func WM_DROPFILES($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $lParam
	; $k+=1
	; WinSetTitle($Gui, '', '����� ' &$k)
	$xClient = BitAND($wParam, 0xFFFF)
	$yClient = BitShift($wParam, 16)

	$k+=1
	WinSetTitle($Gui, '', '����� ' &$k& ' ���, x='&$wParam&', y='&$lParam)
EndFunc