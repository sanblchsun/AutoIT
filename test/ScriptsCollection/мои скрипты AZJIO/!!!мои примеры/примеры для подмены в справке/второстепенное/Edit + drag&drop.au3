#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
GUICreate('���� ���� ������ ������', 470, 280, -1, -1, $WS_OVERLAPPEDWINDOW,  $WS_EX_ACCEPTFILES)
GUICtrlCreateEdit("������� Edit ��������� ���� ������ ��� ������������� �����", 5, 5, 460, 270)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)
GUISetState()
Do
Until GUIGetMsg() = -3