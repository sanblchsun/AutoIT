Global $k=0
Global $sTitle = "����� ��������"

$hGui = GUICreate($sTitle, 370, 140)
GUICtrlCreateLabel('������� WM_SETTEXT ����������� ��� ��������� ������ ��������� ����.', 5, 5, 360, 60)
$Start = GUICtrlCreateButton('��������', 10, 70, 70, 25)
GUIRegisterMsg(0x000C, "WM_SETTEXT")

GUISetState()

While 1
   Switch GUIGetMsg()
       Case $Start 
			$k+=1
           WinSetTitle($hGui, '', '����� ' &$k& ' ���')
		   ; GUICtrlSetData($Fast, 'fff' )
		   ; ControlSetText($hGui, "", $Fast, "�����")
       Case -3
           Exit
   EndSwitch
WEnd

Func WM_SETTEXT()
	MsgBox(0, '���������', '����� ���, ��� ��������� ���������')
	; Return 0 ; ��������� �������� ����� ���������
EndFunc