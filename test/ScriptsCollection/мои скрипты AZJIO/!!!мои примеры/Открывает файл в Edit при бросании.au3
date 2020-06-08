#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiEdit.au3>

$hGui = GUICreate("Окно редактирования в GUI", 400, 500, -1, -1, -1, $WS_EX_ACCEPTFILES) ; Создаёт окно в центре экрана

$iEdit = GUICtrlCreateEdit("Первая строка" & @CRLF & "Вторая строка", 3, 3, 400 - 6, 500 - 6, $ES_AUTOVSCROLL + $WS_VSCROLL + $ES_NOHIDESEL + $ES_WANTRETURN)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)
GUICtrlSendMsg(-1, $EM_LIMITTEXT, -1, 0) ; снимает ограничение на количество символов 30 000
GUISetState()

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_DROPPED
			If $iEdit = @GUI_DropId Then
				$sPos = _GUICtrlEdit_GetSel($iEdit) ; Получает выделенный текст в результате перетаскивания файлов
				$sText = StringMid(GUICtrlRead($iEdit), $sPos[0] + 1) ; Чтение текста и извлечение текста, который был выделен.
				$sPath = StringRegExpReplace($sText, '(?s)^(.+?)(?:\R.*)', '\1') ; Извлекаем только первую строку
				WinSetTitle($hGui, '', StringRegExpReplace($sPath, '^(?:.*\\)([^\\]*?)(?:\.[^.]+)?$', '\1')) ; проверка имени файла, вставка в заголовок
				If FileExists($sPath) And Not StringInStr(FileGetAttrib($sPath), "D") Then
					GUICtrlSetData($iEdit, FileRead($sPath)) ; заключительная вставка прочитанных из файла данных
				Else
					_GUICtrlEdit_ReplaceSel($iEdit, '') ; делаем отмену вставки
				EndIf
			EndIf
		Case $GUI_EVENT_CLOSE
			Exit
	EndSwitch
WEnd

; Задача: Открыть файл в окне редактирования при бросании файла в окно.
; Проблемы: при перетаскивании нескольких файлов в окно, в котором уже находился текст, файлы вставлялись к концу текста в несколько строк, что вызвало сложности с извлечением первого файла из перетаскиваемых. Так как якорный файл оказывается на верху списка, то именно он открывается в Edit.
; Если использовать @GUI_DragFile, то он возвращает файл, предстоящий в списке выше того, на котором находилась мышь в момент перетаскивания, то есть возвращается ни первый, ни якорный, а тот что перед якорным.
; Если не отменить ограничение ($EM_LIMITTEXT), то для больших файлов вставка в конец невозможна, соответственно не работает Drag & Drop
; При поиске информации в UDF выяснилось, что WM_COMMAND не ловит событие DROP и для Edit даже нет констант таких уведомлений (хотя должно быть).