#include <WindowsConstants.au3>
; ���� ��������� ��������� ������ ��� ��������, ������� �� ������ ������� ����������� ��������, �� ���������� WM_SIZE, ������� ����������� �� ����� ��������� ������� ���� � ���������� ������� �� ������� �������������� ���������� � ������� ��������� ���������.

$GUI=GUICreate("������", 500, 150, -1 , -1, $WS_OVERLAPPEDWINDOW)

$Edit1=GUICtrlCreateEdit('', 10, 10, 293, 130)
GUICtrlSetResizing(-1,  802)

$Edit2=GUICtrlCreateEdit('', 313, 10, 177, 130)
GUICtrlSetResizing(-1, 802)

GUISetState ()
GUIRegisterMsg($WM_SIZE, "WM_SIZE")
While 1
   $msg = GUIGetMsg()
   Select
       Case $msg = -3
           Exit
   EndSelect
WEnd

Func WM_SIZE($hWnd, $iMsg, $wparam, $lparam)
	$w = BitAND($lParam, 0x0000FFFF)
	$h = BitShift($lParam, 16)
	$x=Int($w*6/10)
	GUICtrlSetPos($Edit1, 10, 10, $x-10, $h-20)
	GUICtrlSetPos($Edit2, $x+10, 10, $w-$x-25, $h-20)
	GUICtrlSetData($Edit1, $x)
	Return 'GUI_RUNDEFMSG'
EndFunc