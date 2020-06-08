#AutoIt3Wrapper_Au3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <GuiRichEdit.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Color.au3>

OnAutoItExitRegister("Error") ; RichEdit имеет проблемы - если вылетает с ошибкой то виснет напрягая проц, поэтому обязательно регистрация удаления гуи при ошибке
Func Error()
	GUIDelete()
EndFunc

	$hGui = GUICreate("Example", 320, 350)
	$hRichEdit = _GUICtrlRichEdit_Create($hGui, "", 10, 10, 300, 220, $ES_MULTILINE)
	
	$btn1 = GUICtrlCreateButton("автоцвет фона", 10, 235, 150, 25)
	$btn2 = GUICtrlCreateButton("автоцвет шрифта", 10, 265, 150, 25)
	$btn3 = GUICtrlCreateButton("Изменить фон выделенного", 10, 295, 150, 25)
	
	$btn4 = GUICtrlCreateButton("Изменить цвет выделенного шрифта", 10, 325, 220, 25)
	$btn5 = GUICtrlCreateButton("Выделить", 170, 235, 140, 25)
	$btn6 = GUICtrlCreateButton("Отменить выделение", 170, 265, 140, 25)
	$btn7 = GUICtrlCreateButton("Сброс", 170, 295, 140, 25)
	GUISetState()

	_GUICtrlRichEdit_SetText($hRichEdit, "Очень удобный вариант подцвечивания текста, например при выполнении поиска текста StringInStr, когда функция возвращает позицию найденного. Позиция конца вычисляется из суммы количества символов искомого текста и его начальной позиции.")
	While True
		$iMsg = GUIGetMsg()
		Select
			Case $iMsg = -3
				GUIDelete()
				Exit
			Case $iMsg = $btn1
				_GuiCtrlRichEdit_SetSel($hRichEdit, 14, 35)
				_GuiCtrlRichEdit_SetCharBkColor($hRichEdit, 0x6666FF)
				_GUICtrlRichEdit_Deselect($hRichEdit)
			Case $iMsg = $btn2
				_GUICtrlRichEdit_SetSel($hRichEdit, 21, 42)
				_GUICtrlRichEdit_SetCharColor($hRichEdit, 0x00eeee)
				_GUICtrlRichEdit_Deselect($hRichEdit)
			Case $iMsg = $btn3
				$a=_GUICtrlRichEdit_GetSel($hRichEdit)
				If $a[0]=$a[1] Then
					MsgBox(0, 'Сообщение', 'Нужно выделить текст')
					ContinueLoop
				EndIf
				_GuiCtrlRichEdit_SetCharBkColor($hRichEdit, 0x00FFFF)
			Case $iMsg = $btn4
				$a=_GUICtrlRichEdit_GetSel($hRichEdit)
				If $a[0]=$a[1] Then
					MsgBox(0, 'Сообщение', 'Нужно выделить текст')
					ContinueLoop
				EndIf
				_GUICtrlRichEdit_SetCharColor($hRichEdit, 0xFF00FF)
			Case $iMsg = $btn5
				_GUICtrlRichEdit_SetSel($hRichEdit, 6, 13)
			Case $iMsg = $btn6
				_GUICtrlRichEdit_Deselect($hRichEdit)
			Case $iMsg = $btn7
				_GUICtrlRichEdit_SetSel($hRichEdit, -1, -1)
				_GuiCtrlRichEdit_SetCharBkColor($hRichEdit)
				_GUICtrlRichEdit_SetCharColor($hRichEdit)
				_GUICtrlRichEdit_Deselect($hRichEdit)
		EndSelect
	WEnd