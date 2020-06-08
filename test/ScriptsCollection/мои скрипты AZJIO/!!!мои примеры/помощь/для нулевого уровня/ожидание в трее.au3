HotKeySet('!{F1}', '_My_Func') ; Alt+F1
HotKeySet('{Esc}', '_Exit') ; Esc
While 1
   Sleep(100000)
WEnd

Func _My_Func()
	; тут вызываемая задача, например мессага
	MsgBox(0, 'Сообщение', 'Сработало ')
EndFunc

Func _Exit()
    Exit
EndFunc