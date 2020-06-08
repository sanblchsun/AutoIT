#include <GUIConstantsEx.au3>
#NoTrayIcon

GUICreate("Автоконфигуратор",318,123) 
GUISetBkColor (0xF9F9F9)

GUICtrlCreateLabel ("Выполнить сценарий на диске С:",  45,13,260,20)
$start1=GUICtrlCreateButton ("V", 5,5,33,33)
GUICtrlSetTip(-1, "Выполнить сценарий на диске С:.")

GUICtrlCreateLabel ("Извлечь персональные данные (требуется пароль)",  45,53,260,20)
$start2=GUICtrlCreateButton ("V", 5,45,33,33)
GUICtrlSetTip(-1, "Извлечь персональные данные (требуется пароль).")

GUICtrlCreateLabel ("Стартовать готовый сценарий как пример", 45,93,260,20)
$start3=GUICtrlCreateButton ("V", 5,85,33,33)
GUICtrlSetTip(-1, "Стартовать готовый сценарий как пример.")


GUISetState ()

	While 1
		$msg = GUIGetMsg()
		Select
            Case $msg = $start1
			   If FileExists('C:\PROGRAMS\profiles\personal.cmd') Then
				Run ( 'C:\PROGRAMS\profiles\personal.cmd', 'C:\PROGRAMS\profiles', @SW_HIDE )
				Else
				MsgBox(0, "Ошибка", "Файл C:\PROGRAMS\profiles\personal.cmd не существует")
				Endif
            Case $msg = $start2
			   If FileExists('C:\PROGRAMS\profiles\personal.exe') Then
				Run ( 'C:\PROGRAMS\profiles\personal.exe', '', @SW_HIDE )
				Else
				MsgBox(0, "Ошибка", "Файл C:\PROGRAMS\profiles\personal.exe не существует")
				Endif
            Case $msg = $start3
			   RunWait ( @ScriptDir&'\personal.cmd', @ScriptDir, @SW_HIDE )
			   Run ( @ScriptDir&'\lan.cmd', @ScriptDir, @SW_HIDE )
			   Exit
			Case $msg = $GUI_EVENT_CLOSE
				ExitLoop
		EndSelect
	WEnd