Global $k = 0
$Gui = GUICreate("������ ������ ������� ����", 370, 240, -1, -1, 0x00040000 + 0x00020000)
$statist = GUICtrlCreateLabel('������� WM_CONTEXTMENU ����������� ��� ������ ������������ ���� ������ ������� ����.', 5, 5, 360, 68)
$contextmenu = GUICtrlCreateContextMenu()

$button = GUICtrlCreateButton("OK", 100, 100, 70, 20)
$button0 = GUICtrlGetHandle($button)
$buttoncontext = GUICtrlCreateContextMenu($button)
$buttonitem = GUICtrlCreateMenuItem("� ������", $buttoncontext)

$newsubmenu = GUICtrlCreateMenu("�����", $contextmenu)
$textitem = GUICtrlCreateMenuItem("�����", $newsubmenu)

$fileitem = GUICtrlCreateMenuItem("�������", $contextmenu)
$saveitem = GUICtrlCreateMenuItem("���������", $contextmenu)
GUICtrlCreateMenuItem("", $contextmenu) ; �����������

$infoitem = GUICtrlCreateMenuItem("����������", $contextmenu)
GUISetState()
GUIRegisterMsg(0x007B, "WM_CONTEXTMENU")

Do
Until GUIGetMsg() = -3

Func WM_CONTEXTMENU($hWnd, $Msg, $wParam, $lParam)
	$x = BitAND($lParam, 0xFFFF) ; _WinAPI_LoWord
	$y = BitShift($lParam, 16) ; _WinAPI_HiWord
	$k += 1
	WinSetTitle($Gui, '', '����� ' & $k)
	GUICtrlSetData($statist, '���������= ' & $wParam & @LF & 'x=' & $x & @LF & 'y=' & $y)
EndFunc