Global $k=0
Global $L=0

Global Const $NM_FIRST = 0
Global Const $NM_DBLCLK = $NM_FIRST - 3
Global Const $NM_CLICK = $NM_FIRST - 2

Global Const $tagNMHDR = "hwnd hWndFrom;uint_ptr IDFrom;INT Code"
Global Const $LVN_FIRST = -100
Global Const $LVN_COLUMNCLICK = ($LVN_FIRST - 8)
Global Const $tagNMLISTVIEW = $tagNMHDR & ";int Item;int SubItem;uint NewState;uint OldState;uint Changed;" & _
		"long ActionX;long ActionY;lparam Param"
Global Const $GUI_RUNDEFMSG = 'GUI_RUNDEFMSG'

$Gui = GUICreate("��������� ListView", 430, 150)
GUICtrlCreateLabel('������� WM_NOTIFY �������� � ListView, ������������ � UDF.'&@CRLF&@CRLF&'��������:'&@CRLF&'1. ���� �� ������'&@CRLF&'2. ������� ���� �� ������'&@CRLF&'3. ���� �� �������', 180, 10, 230, 140)
$Input=GUICtrlCreateInput("������ �������", 10, 10, 160, 21)
$ListView=GUICtrlCreateListView('���� 1|���� 2', 10, 40, 160, 90)
GUICtrlCreateListViewItem('Text1|����3',$ListView)
GUICtrlCreateListViewItem('Text2|����4',$ListView)

GUISetState()
GUIRegisterMsg(0x004E, "WM_NOTIFY")

Do
Until GUIGetMsg() = -3

Func WM_NOTIFY($hWnd, $Msg, $wParam, $lParam)
	$L+=1
	$GP = MouseGetPos()
	WinSetTitle($Gui, '', '������� ' &$k& ', ����� '&$L& ' ���, x='&$GP[0]&', y='&$GP[1])
	
	Local $tNMHDR, $iIDFrom, $iCode
	
	$tNMHDR = DllStructCreate($tagNMHDR, $lParam)
	$iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
	$iCode = DllStructGetData($tNMHDR, "Code")
	
	Switch $iIDFrom
		Case $ListView
			Switch $iCode
				Case $LVN_COLUMNCLICK
					Local $tInfo = DllStructCreate($tagNMLISTVIEW, $lParam)
					GUICtrlSetData($Input, DllStructGetData($tInfo, "Item")&', '&DllStructGetData($tInfo, "IDFrom")&', '&DllStructGetData($tInfo, "Code")&', '&DllStructGetData($tInfo, "SubItem")&' - �������')
					$k+=1
					WinSetTitle($Gui, '', '������� ' &$k& ', ����� '&$L& ' ���, x='&$GP[0]&', y='&$GP[1])
				Case $NM_DBLCLK
					Local $tInfo = DllStructCreate($tagNMLISTVIEW, $lParam)
					GUICtrlSetData($Input, DllStructGetData($tInfo, "Item")&', '&DllStructGetData($tInfo, "IDFrom")&', '&DllStructGetData($tInfo, "Code")&', '&DllStructGetData($tInfo, "SubItem")&' - ���� ������� ����')
					$k+=1
					WinSetTitle($Gui, '', '������� ' &$k& ', ����� '&$L& ' ���, x='&$GP[0]&', y='&$GP[1])
				Case $NM_CLICK
					Local $tInfo = DllStructCreate($tagNMLISTVIEW, $lParam)
					GUICtrlSetData($Input, DllStructGetData($tInfo, "Item")&', '&DllStructGetData($tInfo, "IDFrom")&', '&DllStructGetData($tInfo, "Code")&', '&DllStructGetData($tInfo, "SubItem")&' - ���� ����')
					$k+=1
					WinSetTitle($Gui, '', '������� ' &$k& ', ����� '&$L& ' ���, x='&$GP[0]&', y='&$GP[1])
			EndSwitch
	EndSwitch
	
	Return $GUI_RUNDEFMSG
EndFunc