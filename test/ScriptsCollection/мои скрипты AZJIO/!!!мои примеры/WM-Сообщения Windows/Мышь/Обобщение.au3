Global $k=0, $Tmp=0
Global $arr2[22][5] = [[ _
21,0,0,0,0],[ _
1, 0x0203, 'WM_LBUTTONDBLCLK','������ ������� ����','������� WM_LBUTTONDBLCLK ����������� � ������ �������� ����� ���� � ��������� ������� ����.'],[ _
2, 0x0201,'WM_LBUTTONDOWN','������ ���� ������','������� WM_LBUTTONDOWN ����������� � ������ ������� ����� ������ ���� � ��������� ������� ����.'],[ _
3, 0x0202,'WM_LBUTTONUP','������ ���� ������','������� WM_LBUTTONUP ����������� � ������ ������� ����� ������ ���� � ��������� ������� ����.'],[ _
4, 0x0209,'WM_MBUTTONDBLCLK','������� ���� ������� ������� ����','������� WM_MBUTTONDBLCLK ����������� � ������ �������� ����� ���� ������� ������� � ��������� ������� ����.'],[ _
5, 0x0207,'WM_MBUTTONDOWN','���� ������� ������� ����','������� WM_MBUTTONDOWN ����������� � ������ ������� ������� ������ ���� � ��������� ������� ����.'],[ _
6, 0x0208,'WM_MBUTTONUP','���� ������� ������� ����','������� WM_MBUTTONUP ����������� � ������ ������� ������� ������ ���� � ��������� ������� ����.'],[ _
7, 0x0200,'WM_MOUSEMOVE','��������� ���� � ����','������� WM_MOUSEMOVE ����������� � ������ ����������� ���� � ��������� ������� ����.'],[ _
8, 0x0206,'WM_RBUTTONDBLCLK','������� ���� ������ ������� ����','������� WM_RBUTTONDBLCLK ����������� � ������ �������� ����� ���� ������ ������� � ��������� ������� ����.'],[ _
9, 0x0204,'WM_RBUTTONDOWN','���� ������ ������� ����','������� WM_RBUTTONDOWN ����������� � ������ ������� ������ ������ ���� � ��������� ������� ����.'],[ _
10, 0x0205,'WM_RBUTTONUP','���� ������ ������� ����','������� WM_RBUTTONUP ����������� � ������ ������� ������ ������ ���� � ��������� ������� ����.'],[ _
11, 0x020D,'WM_XBUTTONDBLCLK','������� ���� �������������� ������� ����','������� WM_XBUTTONDBLCLK ����������� � ������ �������� ����� ���� ������������� ������� � ��������� ������� ����.'],[ _
12, 0x020B,'WM_XBUTTONDOWN','���� �������������� ������� ����','������� WM_XBUTTONDOWN ����������� � ������ ������� ������������� ������ ���� � ��������� ������� ����.'],[ _
13, 0x020C,'WM_XBUTTONUP','���� �������������� ������� ����','������� WM_XBUTTONUP ����������� � ������ ������� ������������� ������ ���� � ��������� ������� ����.'],[ _
14, 0x00A3,'WM_NCLBUTTONDBLCLK','������� ���� �� ���������','������� WM_NCLBUTTONDBLCLK ����������� � ������ �������� ����� ����� ������ ���� � �� ��������� ������� ����, ������ �� ��������� � ����� ����, ����� ������ �������� �� ��������� �������� ����.'],[ _
15, 0x00A1,'WM_NCLBUTTONDOWN','������ �� ���������','������� WM_NCLBUTTONDOWN ����������� � ������ ������� ����� ������ ���� � �� ��������� ������� ����, ������ �� ��������� � ����� ����, ����� ������ �������� �� ��������� �������� ����.'],[ _
16, 0x00A9,'WM_NCMBUTTONDBLCLK','������� ���� ������� ������� ���� �� ���������','������� WM_NCMBUTTONDBLCLK ����������� � ������ �������� ����� ������� ������ ���� � �� ��������� ������� ����, ������ �� ��������� � ����� ����, ����� ������ �������� �� ��������� �������� ����.'],[ _
17, 0x00A7,'WM_NCMBUTTONDOWN','������ ������� ������� ���� �� ���������','������� WM_NCMBUTTONDOWN ����������� � ������ ������� ������� ������ ���� � �� ��������� ������� ����, ������ �� ��������� � ����� ����, ����� ������ �������� �� ��������� �������� ����.'],[ _
18, 0x00A8,'WM_NCMBUTTONUP','������ ������� ������� ���� �� ���������','������� WM_NCMBUTTONUP ����������� � ������ ���������� ������� ������ ���� � �� ��������� ������� ����, ������ �� ��������� � ����� ����, ����� ������ �������� �� ��������� �������� ����.'],[ _
19, 0x00A6,'WM_NCRBUTTONDBLCLK','������� ���� ������ ������� ���� �� ���������','������� WM_NCMBUTTONDBLCLK ����������� � ������ �������� ����� ������ ������ ���� � �� ��������� ������� ����, ������ �� ��������� � ����� ����, ����� ������ �������� �� ��������� �������� ����.'],[ _
20, 0x00A4,'WM_NCRBUTTONDOWN','������ ������ ������� ���� �� ���������','������� WM_NCMBUTTONDOWN ����������� � ������ ������� ������ ������ ���� � �� ��������� ������� ����, ������ �� ��������� � ����� ����, ����� ������ �������� �� ��������� �������� ����.'],[ _
21, 0x00A5,'WM_NCRBUTTONUP','������ ������ ������� ���� �� ���������','������� WM_NCMBUTTONUP ����������� � ������ ���������� ������ ������ ���� � �� ��������� ������� ����, ������ �� ��������� � ����� ����, ����� ������ �������� �� ��������� �������� ����.']]
$Gui = GUICreate("-", 500, 390, -1, -1, 0x00040000+0x00020000)
$Label=GUICtrlCreateLabel('-', 300, 10, 190, 114)
GUICtrlSetBkColor(-1, 0xffd7d7)
$Combo=GUICtrlCreateList('', 10, 10, 280, 340, 0x0100)
For $i = 1 to $arr2[0][0]
	GUICtrlSetData($Combo,$arr2[$i][0]&' - '&$arr2[$i][2])
	; GUICtrlSetData($Combo,$arr2[$i][0]&' - '&$arr2[$i][1]&' - '&$arr2[$i][2])
Next
_Combo(1)
GUISetState()

GUIRegisterMsg(0x0203, "WM_LBUTTONDBLCLK")

While 1
   $msg = GUIGetMsg()
   Select
       Case $msg = $Combo
           _Combo()
       Case $msg = -3
           Exit
   EndSelect
WEnd

Func MyFunc($hWndGui, $MsgId, $wParam, $lParam)
    $X = BitShift($lParam, 16)
    $Y = BitAND($lParam, 0xFFFF)
	$k+=1
	WinSetTitle($Gui, '', '������� ' &$k& ' ���, x='&$X&', y='&$Y)
EndFunc

Func _Combo($a=0)
    $Combo0=StringRegExpReplace(GUICtrlRead($Combo), '(\d+)( - )(.*)', '\1')
	If $a<>0 Then
		$Combo0=1
		GUICtrlSetData($Combo,$arr2[1][0]&' - '&$arr2[1][2])
	EndIf
	WinSetTitle($Gui, '', $arr2[$Combo0][3])
	GUICtrlSetData($Label, $arr2[$Combo0][4])
	GUIRegisterMsg ($arr2[$Tmp][1], '' )
	GUIRegisterMsg ($arr2[$Combo0][1], 'MyFunc' )
	$Tmp=$Combo0
	$k=0
EndFunc


