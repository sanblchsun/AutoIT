#include <GUIConstants.au3>
AutoItSetOption("TrayIconHide", 1) ;������ � ��������� ������ ��������� AutoIt

GUICreate("����������",230,60) ; ������ ����
GUISetFont(9, 300)
$tab=GUICtrlCreateTab (10,10, 210,40) ; ������ �������


$tabBut001=GUICtrlCreateButton ("��", 20,20,20,20)
GUICtrlSetTip(-1, "��")
$tabBut002=GUICtrlCreateButton ("��", 45,20,20,20)
GUICtrlSetTip(-1, "�����")
$tabBut003=GUICtrlCreateButton ("��", 70,20,20,20)
GUICtrlSetTip(-1, "��")
$tabBut004=GUICtrlCreateButton ("��", 95,20,20,20)
GUICtrlSetTip(-1, "��")
$tabBut005=GUICtrlCreateButton ("����", 120,20,40,20)
GUICtrlSetTip(-1, "����")
$tabBut006=GUICtrlCreateButton ("��", 165,20,20,20)
GUICtrlSetTip(-1, "�����")
$tabBut007=GUICtrlCreateButton ("��", 190,20,20,20)
GUICtrlSetTip(-1, "��")

GUICtrlCreateTabitem ("")   ; ����� �������

GUISetState ()

	While 1
		$msg = GUIGetMsg()
		Select
			Case $msg = $tabBut001
				Beep(2092, 500)
            Case $msg = $tabBut002
				Beep(2349, 500)
            Case $msg = $tabBut003
				Beep(2637, 500)
            Case $msg = $tabBut004
				Beep(2793, 500)
            Case $msg = $tabBut005
				Beep(3135, 500)
            Case $msg = $tabBut006
				Beep(3520, 500)
            Case $msg = $tabBut007
				Beep(3951, 500)
			Case $msg = $GUI_EVENT_CLOSE
				ExitLoop
		EndSelect
	WEnd