; модифицировал UDF от Beege (RESH.au3) для себя (AZJIO), упростив для универсального использования
; http://www.autoitscript.com/forum/topic/128918-au3-syntax-highlight-for-richedit-updated-21912/page__hl__reshv2__st__0

#include-once
#include <GuiRichEdit.au3>

; #FUNCTION# =========================================================
; Описание....:	Заменяет код в RichEdit с подсветкой
; Параметр.....:	$hRichEdit - Дескриптор Richedit
; Возвращаемое значение..:	Успешно - Возвращает сгенерированный RTF-код
; ====================================================================
Func _RESH_SyntaxHighlight($hRichEdit)
	Local $aScroll, $iStart, $sCode, $sText
	$iStart = _GUICtrlRichEdit_GetFirstCharPosOnLine($hRichEdit)
	$aScroll = _GUICtrlRichEdit_GetScrollPos($hRichEdit) ; получает позицию курсора

	_GUICtrlRichEdit_PauseRedraw($hRichEdit) ; приостанавливает перерисовку RichEdit

	$sText = _GUICtrlRichEdit_GetText($hRichEdit)
	If Not @error And $sText Then
		$sCode = _RESH_GenerateRTFCode($sText)
	Else
		Return
	EndIf
	
	_GUICtrlRichEdit_SetText($hRichEdit, $sCode) ; вставляет текст в RichEdit, заменяя собой предыдущий текст
	_GUICtrlRichEdit_GotoCharPos($hRichEdit, $iStart) ; устанавлвает в курсор в позицию
	_GUICtrlRichEdit_SetScrollPos($hRichEdit, $aScroll[0], $aScroll[1]) ; прокручивает к курсору
	_GUICtrlRichEdit_ResumeRedraw($hRichEdit) ; восстанавливает перерисовку RichEdit

	Return $sCode
EndFunc

; #FUNCTION# =========================================================
; Описание....:	генерирует RTF-код с подсветкой
; Параметр.....:	$sAu3Code - текст для конвертации
; Возвращаемое значение..:	Успешно - Возвращает сгенерированный RTF-код
;					Ошибка -	Ничего не возвращает (?????)
; ====================================================================
Func _RESH_GenerateRTFCode($sAu3Code)

	Local $sRTFCode = $sAu3Code & @CRLF

	; ================================
	; изменяет любые теги RichEdit, которые находятся в коде.
	Local $aRicheditTags = StringRegExp($sRTFCode, '\\+par|\\+tab|\\+cf\d+', 3) ; отправляем теги в масив
	If Not @error Then
		$aRicheditTags = _ArrayRemoveDuplicates($aRicheditTags) ; удаляем дубликаты из массива оставляя уникальные (тоже что _ArrayUnique)
		For $i = 0 To UBound($aRicheditTags) - 1
			$sRTFCode = StringReplace($sRTFCode, $aRicheditTags[$i], StringReplace($aRicheditTags[$i], '\', '#', 0, 2), 0, 2) ; обрамляем теги, чтобы они представляли собой литеральный символ
		Next
	EndIf
	; =================================

	; правило подсветки кода - найти слово заканчивающееся на "ю" и обраить его тегами подсветки \cf1 и закрывающий \cf0
	; но вместо "\" временно вставляется Chr(1), дабы обрамляя escape-символы не испортить теги
	$sRTFCode = StringRegExpReplace($sRTFCode, '([А-яЁё]+ю)', Chr(1) & 'cf1 \0' & Chr(1) & 'cf0 ') ; найти слова заканчивающееся на "ю" и сделать красными
	$sRTFCode = StringRegExpReplace($sRTFCode, '([А-яЁё]+у)', Chr(1) & 'cf2 \0' & Chr(1) & 'cf0 ') ; найти слова заканчивающееся на "у" и сделать синими
	; \cf1 и \cf2 и т.д. берутся из таблицы цветов $g_RESH_sColorTable, там их три, а можно добавлять больше и использовать \cf4 ... \cf13 и т.д.

	; обрамляем escape-символы для RTF кода
	$sRTFCode = StringReplace($sRTFCode, '\', '\\', 0, 2)
	$sRTFCode = StringReplace($sRTFCode, '{', '\{', 0, 2)
	$sRTFCode = StringReplace($sRTFCode, '}', '\}', 0, 2)
	$sRTFCode = StringReplace($sRTFCode, @CR, '\par ' & @CRLF, 0, 2)
	$sRTFCode = StringReplace($sRTFCode, @TAB, '\tab ', 0, 2)
	$sRTFCode = StringReplace($sRTFCode, Chr(1), '\', 0, 2) ; возвращаем "\" вместо Chr(1)
	; ClipPut($sRTFCode)

	__RESH_HeaderFooter($sRTFCode) ; вставляем шапку (параметры текста: размер и имя шрифта, таблица цветов)

	Return $sRTFCode
EndFunc

; Присоединение шапки RTF к тексту-коду
Func __RESH_HeaderFooter(ByRef $sCode)
	Local $g_RESH_sColorTable = _
			'\red255\green0\blue0;' & _ ; красный
			'\red0\green0\blue255;' & _ ; синий
			'\red99\green99\blue99;' ; серый

	$sCode = "{\rtf\ansi\ansicpg1251\deff0\deflang1033{\fonttbl{\f0\fnil\fcharset0 Arial;}}" & _ ; шрифт Ариал
			"{\colortbl;" & $g_RESH_sColorTable & "}{\*\generator Msftedit 5.41.21.2510;}\viewkind4\uc1\pard\f0\fs18" & _ ; размер шрифта 18
			StringStripWS($sCode, 2) & '}'
EndFunc

Func _ArrayRemoveDuplicates(Const ByRef $aArray)
	If Not IsArray($aArray) Then Return SetError(1, 0, 0)
	Local $oSD = ObjCreate("Scripting.Dictionary")
	For $i In $aArray
		$oSD.Item($i) ; shown by wraithdu
	Next
	Return $oSD.Keys()
EndFunc