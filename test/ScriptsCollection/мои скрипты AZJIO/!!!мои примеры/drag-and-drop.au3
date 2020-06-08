#include <GUIConstants.au3>
#include <WindowsConstants.au3>

$Gui = GUICreate("�������� drag-and-drop", 420, 200, -1, -1, -1, $WS_EX_ACCEPTFILES) ; ����� drag-and-drop, (0x00000010)

$CatchDrop = GUICtrlCreateLabel("", 0, 0, 420, 40) ; ������ ������� Label, ������ ���������, ���� �� ����������� ���������, ������ ����� ������� �� �� ����
GUICtrlSetState(-1, $GUI_DISABLE + $GUI_DROPACCEPTED) ; ������������� ��������� ������� - ������� � drag-and-drop (128+8)

GUICtrlCreateLabel("����������� drag-and-drop", 120, 3, 200, 18)

$Label1 = GUICtrlCreateLabel("���� 1", 24, 40, 186, 17)
$Input1 = GUICtrlCreateInput("", 24, 57, 305, 21)
GUICtrlSetState(-1, $GUI_DROPACCEPTED) ; Input ��������� ��������� drag-and-drop (8)
$folder1 = GUICtrlCreateButton("�����...", 344, 56, 57, 23)

$Label2 = GUICtrlCreateLabel("���� 2", 24, 90, 186, 17)
$Input2 = GUICtrlCreateInput("", 24, 107, 305, 21)
GUICtrlSetState(-1, $GUI_DROPACCEPTED) ; Input ��������� ��������� drag-and-drop (8)
$folder2 = GUICtrlCreateButton("�����...", 344, 106, 57, 23)

$Label3 = GUICtrlCreateLabel("���� 3", 24, 140, 186, 17)
$Input3 = GUICtrlCreateInput("", 24, 157, 305, 21)
GUICtrlSetState(-1, $GUI_DROPACCEPTED) ; Input ��������� ��������� drag-and-drop (8)
$folder3 = GUICtrlCreateButton("�����...", 344, 156, 57, 23)

GUISetState()

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_DROPPED ;������� ������������ �� drag-and-drop (-13)
			If @GUI_DropId = $Input1 Then GUICtrlSetData($Input1, @GUI_DragFile)
			If @GUI_DropId = $Input2 Then GUICtrlSetData($Input2, @GUI_DragFile)
			If @GUI_DropId = $Input3 Then GUICtrlSetData($Input3, @GUI_DragFile)
			If @GUI_DropId = $CatchDrop Then MsgBox(0, "� ������� drag-and-drop ����� ����", @GUI_DragFile)
			; ������ �����
		Case $folder1
			$folder01 = FileOpenDialog("������� ����", @WorkingDir & "", "����� (*.*)", 1 + 4)
			If @error Then ContinueLoop
			GUICtrlSetData($Input1, $folder01)
		Case $folder2
			$folder02 = FileOpenDialog("������� ����", @WorkingDir & "", "����� (*.*)", 1 + 4)
			If @error Then ContinueLoop
			GUICtrlSetData($Input2, $folder02)
		Case $folder3
			$folder03 = FileOpenDialog("������� ����", @WorkingDir & "", "����� (*.*)", 1 + 4)
			If @error Then ContinueLoop
			GUICtrlSetData($Input3, $folder03)
		Case $GUI_EVENT_CLOSE ; ������� (-3)
			Exit
	EndSwitch
WEnd

#cs
	������� $GUI_EVENT_DROPPED ����� �������, �� �������� ���������������. ���� ������� ���� ������� "�����..." � ����� ������ ���� � Input, �� ���� ������������ � ���� ������ ���������������. ������ $GUI_EVENT_DROPPED ��������� ��� �������� ���������� ���� � ������� GUICtrlSetData.
#ce
