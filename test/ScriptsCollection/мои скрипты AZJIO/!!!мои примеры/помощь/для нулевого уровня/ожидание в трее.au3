HotKeySet('!{F1}', '_My_Func') ; Alt+F1
HotKeySet('{Esc}', '_Exit') ; Esc
While 1
   Sleep(100000)
WEnd

Func _My_Func()
	; ��� ���������� ������, �������� �������
	MsgBox(0, '���������', '��������� ')
EndFunc

Func _Exit()
    Exit
EndFunc