#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <ListViewConstants.au3>
#include <WindowsConstants.au3>
$hGUI= GUICreate("���� ListView", 220, 180)
; ���� ������ ������� ����, ����� �������� ��������� �������, ��������� ��������� ��� ������ ������; �������������� ����� - ��������� ���� ��������� ������, �������� � ������
$hListView = GUICtrlCreateListView  ('---------------' ,5,5,210,70 , $LVS_NOCOLUMNHEADER + $LVS_SHOWSELALWAYS, $LVS_EX_FULLROWSELECT + $LVS_EX_CHECKBOXES+$WS_EX_CLIENTEDGE)
GUICtrlSetBkColor(-1,0xf0f0f0) ; 0xE0DFE3 - ���� ����������� �����
$item1=_GUICtrlListView_AddItem($hListView,'����' ) ; ������ ������
$item2=_GUICtrlListView_AddItem($hListView,'��' )
$item3=_GUICtrlListView_AddItem($hListView,'�����' )
$item4=_GUICtrlListView_AddItem($hListView,'��� ���' )
  
_GUICtrlListView_SetItemChecked($hListView,$item1) ; �������� �������� ��������
_GUICtrlListView_SetItemChecked($hListView, $item3)

$start=GUICtrlCreateButton ("���", 135,95,55,22)
$Pos=GUICtrlCreateButton ("������", 35,95,55,22)
GUICtrlCreateLabel ('� ������� �� ������� ��������� � ����, � ListView ���� ��������� � �����, ���� ������ �� ���������.', 5,125,210,50)

GUISetState   ()

While 1
	$msg = GUIGetMsg()
	Select
		Case $msg = $start ; ��������� ������� � ���������
			If _GUICtrlListView_GetItemChecked($hListView,$item1)=1 Then MsgBox(0, "���������",' "����" �������.', 4)
			If _GUICtrlListView_GetItemChecked($hListView,$item2)=1 Then MsgBox(0, "���������",' "��" �������.', 4)
			If _GUICtrlListView_GetItemChecked($hListView,$item3)=1 Then MsgBox(0, "���������",' "�����" �������.', 4)
			If _GUICtrlListView_GetItemChecked($hListView,$item4)=1 Then MsgBox(0, "���������",' "��� ���" �������.', 4)
		Case $msg = $Pos ; ������ ������ ��� �������� ������
			GUICtrlSetPos ($hListView, 5,5,210,80)
		Case $msg = -3
			ExitLoop
	EndSelect
WEnd