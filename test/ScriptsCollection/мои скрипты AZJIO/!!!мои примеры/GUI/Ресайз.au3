#include <WindowsConstants.au3>
; ��� ������� ����� ������������ WM-��������� WM_GETMINMAXINFO �������������� ���������� ���� ����� �������������� �������, � ����� ������������ � ����������.
; �������� ���������� GUICtrlSetResizing ������������� ������ ��������� ������� ���������.
; ����� GUIResizeMode ������������� ����� ��������� ��� ���� ���������, ��� ������� �� ������ GUICtrlSetResizing
; ���� ��������� ��������� ������ ��� ��������, ������� �� ������ ������� ����������� ��������, �� ���������� WM_SIZE, ������� ����������� �� ����� ��������� ������� ���� � ���������� ������� �� ������� �������������� ���������� � ������� ��������� ���������.

Opt("GUIResizeMode", 2 + 32 + 256 + 512) ; 802
GUIRegisterMsg(0x0024, "WM_GETMINMAXINFO")

$GUI=GUICreate("������", 300, 300, -1 , -1, $WS_OVERLAPPEDWINDOW)

$Button1=GUICtrlCreateButton('�����-�������', 10, 10, 100, 22)
GUICtrlSetResizing(-1,  2 + 32 + 256 + 512)

$Button2=GUICtrlCreateButton('������-�������', 190, 10, 100, 22)
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

$Button1=GUICtrlCreateButton('�����-������', 10, 268, 100, 22)
GUICtrlSetResizing(-1,  2 + 64 + 256 + 512)

$Button2=GUICtrlCreateButton('������-������', 190, 268, 100, 22)
GUICtrlSetResizing(-1, 4 + 64 + 256 + 512)


$Edit1=GUICtrlCreateEdit('', 10, 40, 280, 90)
GUICtrlSetResizing(-1, 2 + 4 + 32 + 512)

$Edit1=GUICtrlCreateEdit('', 10, 135, 280, 120)
GUICtrlSetResizing(-1, 2 + 4 + 32 + 64 + 512)

GUISetState ()
While 1
   $msg = GUIGetMsg()
   Select
       Case $msg = -3
           Exit
   EndSelect
WEnd

Func WM_GETMINMAXINFO($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $wParam
	If $hWnd = $GUI Then
		Local $tMINMAXINFO = DllStructCreate("int;int;" & _
				"int MaxSizeX; int MaxSizeY;" & _
				"int MaxPositionX;int MaxPositionY;" & _
				"int MinTrackSizeX; int MinTrackSizeY;" & _
				"int MaxTrackSizeX; int MaxTrackSizeY", _
				$lParam)
		DllStructSetData($tMINMAXINFO, "MaxTrackSizeX", 600)
		DllStructSetData($tMINMAXINFO, "MaxTrackSizeY", 500)
		DllStructSetData($tMINMAXINFO, "MinTrackSizeX", 250)
		DllStructSetData($tMINMAXINFO, "MinTrackSizeY", 250)
		DllStructSetData($tMINMAXINFO, "MaxSizeX", 800)
		DllStructSetData($tMINMAXINFO, "MaxSizeY", 500)
		DllStructSetData($tMINMAXINFO, "MaxPositionX", @DesktopWidth/2-300)
		DllStructSetData($tMINMAXINFO, "MaxPositionY", 0)
	EndIf
EndFunc