#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <SendMessage.au3>

$SC_DRAGMOVE = 0xF012

$HWND = GUICreate("����", 220, 170, -1, -1, $WS_POPUP+$WS_SYSMENU)
GUISetBkColor(0x4f4f4f)
$ListView = GUICtrlCreateListView("col1    |col2|col3  ", 10, 10, 200, 150)
$item1 = GUICtrlCreateListViewItem("item2|col22|col23", $ListView)
$item2 = GUICtrlCreateListViewItem("item8|col12|col13", $ListView)

; ����������� ����
$contextMenu = GUICtrlCreateContextMenu($ListView)
$closeitem = GUICtrlCreateMenuItem("�������", $contextMenu)

GUISetState()

While 1
	$msg = GUIGetMsg()
	Switch $msg
		Case $GUI_EVENT_PRIMARYDOWN ; ������� ������� ����
			$a = GUIGetCursorInfo()
			; ���� �������� ������� $ListView �� ����� ���������� ���� �� �������� ����
			; ��� Label ����� ������������ $GUI_WS_EX_PARENTDRAG
			If $a[4] = $ListView Then _SendMessage($HWND, $WM_SYSCOMMAND, $SC_DRAGMOVE, 0)
		Case -3, $closeitem
			Exit
	EndSwitch
WEnd