#include <GUIConstantsEx.au3>
#include <TabConstants.au3>

Opt('MustDeclareVars', 1)
Global $tab, $CurStyle='$GUI_SS_DEFAULT_TAB'

Example()

Func Example()
	Local $tab1combo, $msg, $Gui
	
	$Gui=GUICreate("������� (Tab) � GUI")  ; ������ ���� � ������ ������

	GUISetBkColor(0x00E0FFFF)
	GUISetFont(9, 300)

	_Tab()

	GUICtrlCreateLabel("������ �����", 20, 234, 250, 17)
	$tab1combo = GUICtrlCreateCombo("", 20, 250, 330, 120)
	GUICtrlSetData(-1, '$GUI_SS_DEFAULT_TAB|'& _
	'$TCS_BUTTONS+$TCS_VERTICAL+$TCS_RIGHT|'& _
	'$TCS_FLATBUTTONS+$TCS_BUTTONS|'& _
	'$TCS_FIXEDWIDTH|'& _
	'$TCS_FIXEDWIDTH+$TCS_FORCEICONLEFT|'& _
	'$TCS_FIXEDWIDTH+$TCS_FORCELABELLEFT|'& _
	'$TCS_BOTTOM', $CurStyle) ; �� ��������� ����������� �����

	GUICtrlCreateLabel('����� ��������� ������, ����� ����������'&@CRLF&'$TCS_MULTILINE - ������� � ��������� ����� (������ �������������� ���������)'&@CRLF&'$TCS_BUTTONS - ������� ��� ������'&@CRLF&'$TCS_FLATBUTTONS+$TCS_BUTTONS - ��������� �������', 20, 290, 370, 100)

	GUISetState()

	; ����������� ���� ������ GUI �� ��� ��� ���� ���� �� ����� �������
	While 1
		$msg = GUIGetMsg()
		Switch $msg
			Case $GUI_EVENT_CLOSE
				ExitLoop
			Case $tab
				; ���������� ��������� �������
				WinSetTitle($Gui, "", "������� (Tab) � GUI, ������� " & GUICtrlRead($tab))
			Case $tab1combo
				; GUICtrlSetStyle($tab, )
				$CurStyle=GUICtrlRead($tab1combo)
				_Tab(BitOr($GUI_SS_DEFAULT_TAB, Execute($CurStyle)))
		EndSwitch
	WEnd
EndFunc


Func _Tab($Style=-1)
	Local $tab1
	GUICtrlDelete($tab)
	$tab = GUICtrlCreateTab(10, 10, 380, 200, $Style)

	GUICtrlCreateTabItem("tab0")
	GUICtrlSetImage(-1, "shell32.dll", -222, 0) ; ������ �������
	GUICtrlCreateLabel("����� �� ������� 0", 35, 80, 250, 20)

	$tab1 = GUICtrlCreateTabItem("tab----1")
	GUICtrlCreateLabel("����� �� ������� 1", 30, 85, 250, 20)
	
	GUICtrlCreateTabItem("tab2")
	GUICtrlCreateLabel("����� �� ������� 2", 40, 90, 250, 20)

	GUICtrlCreateTabItem("") 	; ���������� ����� �������
	
	GUICtrlSetState($tab1, $GUI_SHOW) 	; ����� ������������ ���������
EndFunc