#include <GUIToolTip.au3>
#include <FontConstants.au3>

Global $aInfo[6][2] = [[ _
		'Задание', '1'],[ _
		'Номер ошибки', '2'],[ _
		'Время начала', '3'],[ _
		'Время окончания', '4'],[ _
		'Время выполнения', '5'],[ _
		'Описание ошибки', '6']]

$sText = ''
For $i = 0 To 5
	_StringFormat($sText, $aInfo[$i][0], $aInfo[$i][1])
Next
$sText = StringTrimRight($sText, 1)

Func _StringFormat(ByRef $sText, $sString1, $sString2)
	$sText &= StringFormat("%-18s: %s\n", $sString1, $sString2)
EndFunc   ;==>_StringFormat
; MsgBox(0, 'Сообщение', $sText)

; Получает дескриптор иконки
$hIcon = _WinAPI_LoadShell32Icon(15)

$hTool = _ToolTip($sText, 500, 300, 'Информация', $hIcon, $TTS_NOPREFIX  + $TTS_BALLOON, 16, 'Consolas', 0x1EBFFF, 0x395A00)
$hFont = @extended
; _ToolTip($sText, 500, 300)
Sleep(1500)

For $i = 1 To StringLen($sText) - 1
	_GUIToolTip_UpdateTipText($hTool, 0, 0, StringTrimRight($sText, $i))
	Sleep(10)
Next
Sleep(500)
_GUIToolTip_UpdateTipText($hTool, 0, 0, $sText)
If $hFont Then _WinAPI_DeleteObject($hFont) ; удаление объекта шрифта (обратите внимание, что шрифт не работает после удаления объекта)

For $i = 1 To 5
	; Устанавливает позицию подсказки
	_GUIToolTip_TrackPosition($hTool, Random(0, @DesktopWidth, 1), Random(0, @DesktopHeight, 1))
	Sleep(400)
Next

_GUIToolTip_TrackPosition($hTool, 500, 300)
For $i = 1 To 4
	; Принудительно показывает подсказку
	_GUIToolTip_TrackActivate($hTool, False)
	Sleep(500)

	; Принудительно показывает подсказку
	_GUIToolTip_TrackActivate($hTool)
	Sleep(500)
Next

_GUIToolTip_Destroy($hTool) ; Удалить подсказку

; #FUNCTION# ;=================================================================================
; Function Name ...: _ToolTip
; Description ........: ToolTip extended
; Syntax................: _ToolTip ( $sText[, $iX = 0[, $iY = 0[, $iTitle = ''[, $hIcon = 0[, $iStyle = 0[, $iFontSize = 0[, $iFontFamily = 'Arial'[, $iFontColor = 0[, $iBkColor = 0]]]]]]]]] )
; Parameters:
;		$sText - The text of the tooltip
;		$iX - The x position of the tooltip
;		$iY - The y position of the tooltip
;		$iTitle - The title for the tooltip
;		$hIcon - Pre-defined icon to show next to the title: Requires a title.
;			0 = No icon, 1 = Info icon, 2 = Warning icon, 3 = Error Icon, Handle to the Icon
;		$iStyle - ToolTip style (_GUIToolTip_Create)
;		$iFontSize - height of font.
;		$iFontFamily - typeface name.
;		$iFontColor - text color.
;		$iBkColor - background color.
; Return values ....: Success - The handle to the Tooltip window, @extended = $hFont
;					Failure - 0, @error:
;					-1 - $hTool = 0, ToolTip will not be displayed
;					1 - error of the font
;					2 - error of the title
;					3 - error 1 and 2 together
; Author(s) ..........: AZJIO
; Remarks ..........: When you no longer need the font, call the _WinAPI_DeleteObject function to delete it
; ============================================================================================
; Имя функции ...: _ToolTip
; Описание ........: Всплывающая подсказка с расширенными установками.
; Синтаксис.......: _ToolTip ( $sText[, $iX = 0[, $iY = 0[, $iTitle = ''[, $hIcon = 0[, $iStyle = 0[, $iFontSize = 0[, $iFontFamily = 'Arial'[, $iFontColor = 0[, $iBkColor = 0]]]]]]]]] )
; Параметры:
;		$sText - Текст всплывающей подсказки
;		$iX - X-координата всплывающей подсказки
;		$iY - Y-координата всплывающей подсказки
;		$iTitle - Заголовок всплывающей подсказки
;		$hIcon - Иконка, отображаемая рядом с заголовком. Требует указания параметра $iTitle.
;					| 0 - Без иконки (по умолчанию)
;					| 1 - Иконка "Информация"
;					| 2 - Иконка "Предупреждение"
;					| 3 - Иконка "Ошибка
;					| Дескриптор иконки
;		$iStyle - Стиль. Значения соответствуют параметрам _GUIToolTip_Create.
;		$iFontSize - Размер шрифта.
;		$iFontFamily - Имя шрифта.
;		$iFontColor - Цвет шрифта.
;		$iBkColor - Фон всплывающей подсказки.
; Возвращаемое значение: Успешно - Возвращает дескриптор ToolTip, @extended содержит дескриптор шрифта
;					Неудачно - Возвращает 0 и устанавливает @error = 1
;					-1 - $hTool не создан, подсказка не будет отображаться
;					1 - ошибка установки шрифта
;					2 - ошибка устновки заголовка
;					3 - ошибка 1 и 2 вместе
; Автор ..........: AZJIO
; Примечания ..: После завершения использования _ToolTip удалите объект $hFont
; ============================================================================================
Func _ToolTip($sText, $iX = 0, $iY = 0, $iTitle = '', $hIcon = 0, $iStyle = 0, $iFontSize = 0, $iFontFamily = 'Arial', $iFontColor = 0, $iBkColor = 0)
	; If BitAND($iStyle, 1) Then $iStyle += $TTS_BALLOON

	; Создаёт ToolTip
	Local $hFont = 0, $iError = 0
	Local $hTool = _GUIToolTip_Create(0, $iStyle)
	If Not $hTool Then Return SetError(-1, 0, 0)

	; Устанавливает ширину ToolTip
	_GUIToolTip_SetMaxTipWidth($hTool, @DesktopWidth)
	; Кроме того это позволяет отображать текст с переносом строки. Иначе @CRLF не будет иметь эффекта.

	; Устанавливает шрифт для ToolTip
	If $iFontSize Then
		$hFont = _WinAPI_CreateFont($iFontSize, 0, 0, 0, 400, False, False, False, $DEFAULT_CHARSET, $OUT_DEFAULT_PRECIS, $CLIP_DEFAULT_PRECIS, $DEFAULT_QUALITY, 0, $iFontFamily)
		If $hFont Then
			_WinAPI_SetFont($hTool, $hFont)
		Else
			$iError += 1
		EndIf
	EndIf

	; Устанавливает цвет
	If $iFontColor Then _GUIToolTip_SetTipTextColor($hTool, $iFontColor) ; Цвет текста (BGR) всплывающей подсказки
	If $iBkColor Then _GUIToolTip_SetTipBkColor($hTool, $iBkColor) ; Цвет фона (BGR) всплывающей подсказки

	; Назначает подсказку элементу и стиль с координатами
	If Not _GUIToolTip_AddTool($hTool, 0, $sText, 0, 0, 0, 0, 0, 8 + $TTM_TRACKPOSITION) Then Return SetError(1, 0, 0)

	; Устанавливает заголовок подсказки
	If $iTitle And Not _GUIToolTip_SetTitle($hTool, $iTitle, $hIcon) Then $iError += 2

	; Устанавливает позицию подсказки
	_GUIToolTip_TrackPosition($hTool, $iX, $iY)

	; Принудительно показывает подсказку
	_GUIToolTip_TrackActivate($hTool)
	Return SetError($iError, $hFont, $hTool)
EndFunc   ;==>_ToolTip