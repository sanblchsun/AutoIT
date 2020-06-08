#include <GUIConstantsEx.au3>
#include <TabConstants.au3>

$w = 270 ; ������ ����
$h = 180 ; ������ ����
$wBt = 60 ; ������ ������
$BkCol1 = 0x83B493 ; ���� �������
$BkCol2 = 0xB4A663
$BkCol3 = 0x9C9C9C

$Gui1 = GUICreate('������ ��� �������', $w, $h)
GUISetBkColor($BkCol1)
$vk1 = GUICtrlCreateButton('������� 1', 0, 0, $wBt, 20)
$vk2 = GUICtrlCreateButton('������� 2', 0, 20, $wBt, 20)
$vk3 = GUICtrlCreateButton('������� 3', 0, 40, $wBt, 20)

GUICtrlCreateTab($wBt, 0, $w - $wBt, $h + 35, $TCS_BUTTONS + $TCS_BOTTOM)

$tab1 = GUICtrlCreateTabItem('1')
GUICtrlCreateLabel('', $wBt, 0, $w - $wBt, $h) ; ��������
GUICtrlSetBkColor(-1, $BkCol1)
GUICtrlSetState(-1, $GUI_DISABLE)

GUICtrlCreateLabel('������� ����������� ��������', $wBt + 10, 20)
GUICtrlSetColor(-1, 0xa21a10)

$tab2 = GUICtrlCreateTabItem('2')
GUICtrlCreateLabel('', $wBt, 0, $w - $wBt, $h) ; ��������
GUICtrlSetBkColor(-1, $BkCol2)
GUICtrlSetState(-1, $GUI_DISABLE)

GUICtrlCreateEdit('', $wBt + 10, 10, $w - $wBt - 20, $h - 20)

$tab3 = GUICtrlCreateTabItem('3')
GUICtrlCreateLabel('', $wBt, 0, $w - $wBt, $h) ; ��������
GUICtrlSetBkColor(-1, $BkCol3)
GUICtrlSetState(-1, $GUI_DISABLE)

GUICtrlCreateCheckbox('CheckBox1', $wBt + 10, 10, 120, 17)

GUICtrlCreateTabItem('')

GUISetState()

While 1
	Switch GUIGetMsg()
		Case $vk1
			GUICtrlSetState($tab1, $GUI_SHOW) ; ��������� ������� ��������� ������
			GUISetBkColor($BkCol1)
		Case $vk2
			GUICtrlSetState($tab2, $GUI_SHOW)
			GUISetBkColor($BkCol2)
		Case $vk3
			GUICtrlSetState($tab3, $GUI_SHOW)
			GUISetBkColor($BkCol3)
		Case -3
			Exit
	EndSwitch
WEnd