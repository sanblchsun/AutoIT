#include <GUIConstantsEx.au3>
#NoTrayIcon

GUICreate("����������������",318,123) 
GUISetBkColor (0xF9F9F9)

GUICtrlCreateLabel ("��������� �������� �� ����� �:",  45,13,260,20)
$start1=GUICtrlCreateButton ("V", 5,5,33,33)
GUICtrlSetTip(-1, "��������� �������� �� ����� �:.")

GUICtrlCreateLabel ("������� ������������ ������ (��������� ������)",  45,53,260,20)
$start2=GUICtrlCreateButton ("V", 5,45,33,33)
GUICtrlSetTip(-1, "������� ������������ ������ (��������� ������).")

GUICtrlCreateLabel ("���������� ������� �������� ��� ������", 45,93,260,20)
$start3=GUICtrlCreateButton ("V", 5,85,33,33)
GUICtrlSetTip(-1, "���������� ������� �������� ��� ������.")


GUISetState ()

	While 1
		$msg = GUIGetMsg()
		Select
            Case $msg = $start1
			   If FileExists('C:\PROGRAMS\profiles\personal.cmd') Then
				Run ( 'C:\PROGRAMS\profiles\personal.cmd', 'C:\PROGRAMS\profiles', @SW_HIDE )
				Else
				MsgBox(0, "������", "���� C:\PROGRAMS\profiles\personal.cmd �� ����������")
				Endif
            Case $msg = $start2
			   If FileExists('C:\PROGRAMS\profiles\personal.exe') Then
				Run ( 'C:\PROGRAMS\profiles\personal.exe', '', @SW_HIDE )
				Else
				MsgBox(0, "������", "���� C:\PROGRAMS\profiles\personal.exe �� ����������")
				Endif
            Case $msg = $start3
			   RunWait ( @ScriptDir&'\personal.cmd', @ScriptDir, @SW_HIDE )
			   Run ( @ScriptDir&'\lan.cmd', @ScriptDir, @SW_HIDE )
			   Exit
			Case $msg = $GUI_EVENT_CLOSE
				ExitLoop
		EndSelect
	WEnd