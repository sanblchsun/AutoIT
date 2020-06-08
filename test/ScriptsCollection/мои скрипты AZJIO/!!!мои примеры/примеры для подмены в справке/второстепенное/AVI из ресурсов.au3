$Gui = GUICreate("AVI из ресурсов", 450, 260)
$ani=GUICtrlCreateAvi( @SystemDir&'\shell32.dll',165, 10, 110)
$Button1=GUICtrlCreateButton('Стоп', 10, 10, 120, 22)
GUISetFont (33)
$Button2=GUICtrlCreateButton('Старт', 10, 40)
GUISetState ()
While 1
   $msg = GUIGetMsg()
   Select
       Case $msg = $Button2
		   GUICtrlSetState($ani, 1)
       Case $msg = $Button1
		GUICtrlSetState($ani, 0)
       Case $msg = -3
           Exit
   EndSelect
WEnd


