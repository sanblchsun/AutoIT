Global $k=0
HotKeySet('!{ESC}', '_Enable')
$Gui = GUICreate("������� ������ 'Disable'", 370, 170, -1, -1, 0x00040000+0x00020000)
GUICtrlCreateLabel('������� WM_ENABLE ����������� � ������ ��������� ������� � ���� (ENABLE / DISABLE). ������� ������ "Disable", � ����� ������� �������� Alt+Esc ��������� ������ � ����.', 5, 5, 360, 54)
$Disable = GUICtrlCreateButton('Disable', 10, 70, 70, 25)
GUICtrlCreateLabel('Alt+Esc', 100, 70, 70, 25)
GUICtrlSetColor(-1,0xff0000)
GUICtrlSetFont(-1,14)

GUISetState()
GUIRegisterMsg (0x000A, "WM_ENABLE")

While 1
   $msg = GUIGetMsg()
   Select
       Case $msg = $Disable
			GUISetState(@SW_DISABLE)
       Case $msg = -3
           Exit
   EndSelect
WEnd

Func _Enable()
	GUISetState(@SW_ENABLE)
	WinSetTitle($Gui, '', '����� ' &$k& '. ���������')
EndFunc

Func WM_ENABLE($hWnd, $Msg, $wParam, $lParam)
	$k+=1
	WinSetTitle($Gui, '', '����� ' &$k& '. ���������')
EndFunc