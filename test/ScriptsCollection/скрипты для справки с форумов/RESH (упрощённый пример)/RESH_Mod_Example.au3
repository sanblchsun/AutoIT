#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiRichEdit.au3>
#include <RESH_Mod.au3>

OnAutoItExitRegister("_Exit") ; обязательно, на случай ошибки освобождает ресурсы избаляя от зависания
Func _Exit()
    GUIDelete()
EndFunc

Global $hGUI, $hRichEdit, $sRTFCode

$hGUI = GUICreate('Подсвечивает слова оканчивающиеся на "у" и "ю"', 720, 570)
$hRichEdit = _GUICtrlRichEdit_Create($hGUI, "", 8, 8, 701, 510, BitOR($ES_MULTILINE, $WS_VSCROLL, $ES_AUTOVSCROLL))

$Button = GUICtrlCreateButton("Подсветить вставленный текст", 530, 530, 180, 30)

; вставляет текст заменяя собой предыдущий текст
_GUICtrlRichEdit_SetText($hRichEdit, 'Однажды в студёную зимнюю пору я из лесу вышел, был сильный мороз. Смотрю подымается медленно в гору...')
$sRTFCode = _RESH_SyntaxHighlight($hRichEdit) ; Подсвечивает текст в RichEdit

GUISetState()

While 1
	Switch GUIGetMsg()
		Case $Button
			$sText = _GUICtrlRichEdit_GetText($hRichEdit) ; Получает текст из RichEdit
			If Not @error And $sText Then $sRTFCode = _RESH_SyntaxHighlight($hRichEdit) ; Подсвечивает текст в RichEdit
		Case $GUI_EVENT_CLOSE
			_GUICtrlRichEdit_Destroy($hRichEdit)
			Exit
	EndSwitch
WEnd