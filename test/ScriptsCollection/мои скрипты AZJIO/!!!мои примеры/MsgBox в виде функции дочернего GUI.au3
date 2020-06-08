#include <WindowsConstants.au3>
$Gui = GUICreate('My program', 420, 250)

$MsgBox = GUICtrlCreateButton("Button", 20, 20, 90, 30)
GUISetState()

While 1
	Switch GUIGetMsg()
		Case $MsgBox
			_MsgBox()
		Case -3
			Exit
	EndSwitch
WEnd

Func _MsgBox()
	Local $EditBut, $Gui1, $msg, $StrBut
	GUISetState(@SW_DISABLE, $Gui)
	
	$Gui1 = GUICreate('Сообщение', 200, 70, -1, -1, $WS_CAPTION + $WS_SYSMENU + $WS_POPUP, -1, $Gui)
	GUICtrlCreateLabel('Что будем делать сейчас?', 20, 10, 180, 23)
	$EditBut = GUICtrlCreateButton('Редактор', 10, 40, 80, 22)
	$StrBut = GUICtrlCreateButton('Калькулятор', 100, 40, 80, 22)
	GUISetState(@SW_SHOW, $Gui1)
	While 1
		Switch GUIGetMsg()
			Case $EditBut
				Run('Notepad.exe')
			Case $StrBut
				ShellExecute('Calc.exe')
			Case -3
				GUISetState(@SW_ENABLE, $Gui)
				GUIDelete($Gui1)
				ExitLoop
		EndSwitch
	WEnd
EndFunc   ;==>_MsgBox