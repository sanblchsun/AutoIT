; ������������� UDF �� Beege (RESH.au3) ��� ���� (AZJIO), �������� ��� �������������� �������������
; http://www.autoitscript.com/forum/topic/128918-au3-syntax-highlight-for-richedit-updated-21912/page__hl__reshv2__st__0

#include-once
#include <GuiRichEdit.au3>

; #FUNCTION# =========================================================
; ��������....:	�������� ��� � RichEdit � ����������
; ��������.....:	$hRichEdit - ���������� Richedit
; ������������ ��������..:	������� - ���������� ��������������� RTF-���
; ====================================================================
Func _RESH_SyntaxHighlight($hRichEdit)
	Local $aScroll, $iStart, $sCode, $sText
	$iStart = _GUICtrlRichEdit_GetFirstCharPosOnLine($hRichEdit)
	$aScroll = _GUICtrlRichEdit_GetScrollPos($hRichEdit) ; �������� ������� �������

	_GUICtrlRichEdit_PauseRedraw($hRichEdit) ; ���������������� ����������� RichEdit

	$sText = _GUICtrlRichEdit_GetText($hRichEdit)
	If Not @error And $sText Then
		$sCode = _RESH_GenerateRTFCode($sText)
	Else
		Return
	EndIf
	
	_GUICtrlRichEdit_SetText($hRichEdit, $sCode) ; ��������� ����� � RichEdit, ������� ����� ���������� �����
	_GUICtrlRichEdit_GotoCharPos($hRichEdit, $iStart) ; ������������ � ������ � �������
	_GUICtrlRichEdit_SetScrollPos($hRichEdit, $aScroll[0], $aScroll[1]) ; ������������ � �������
	_GUICtrlRichEdit_ResumeRedraw($hRichEdit) ; ��������������� ����������� RichEdit

	Return $sCode
EndFunc

; #FUNCTION# =========================================================
; ��������....:	���������� RTF-��� � ����������
; ��������.....:	$sAu3Code - ����� ��� �����������
; ������������ ��������..:	������� - ���������� ��������������� RTF-���
;					������ -	������ �� ���������� (?????)
; ====================================================================
Func _RESH_GenerateRTFCode($sAu3Code)

	Local $sRTFCode = $sAu3Code & @CRLF

	; ================================
	; �������� ����� ���� RichEdit, ������� ��������� � ����.
	Local $aRicheditTags = StringRegExp($sRTFCode, '\\+par|\\+tab|\\+cf\d+', 3) ; ���������� ���� � �����
	If Not @error Then
		$aRicheditTags = _ArrayRemoveDuplicates($aRicheditTags) ; ������� ��������� �� ������� �������� ���������� (���� ��� _ArrayUnique)
		For $i = 0 To UBound($aRicheditTags) - 1
			$sRTFCode = StringReplace($sRTFCode, $aRicheditTags[$i], StringReplace($aRicheditTags[$i], '\', '#', 0, 2), 0, 2) ; ��������� ����, ����� ��� ������������ ����� ����������� ������
		Next
	EndIf
	; =================================

	; ������� ��������� ���� - ����� ����� ��������������� �� "�" � ������� ��� ������ ��������� \cf1 � ����������� \cf0
	; �� ������ "\" �������� ����������� Chr(1), ���� �������� escape-������� �� ��������� ����
	$sRTFCode = StringRegExpReplace($sRTFCode, '([�-���]+�)', Chr(1) & 'cf1 \0' & Chr(1) & 'cf0 ') ; ����� ����� ��������������� �� "�" � ������� ��������
	$sRTFCode = StringRegExpReplace($sRTFCode, '([�-���]+�)', Chr(1) & 'cf2 \0' & Chr(1) & 'cf0 ') ; ����� ����� ��������������� �� "�" � ������� ������
	; \cf1 � \cf2 � �.�. ������� �� ������� ������ $g_RESH_sColorTable, ��� �� ���, � ����� ��������� ������ � ������������ \cf4 ... \cf13 � �.�.

	; ��������� escape-������� ��� RTF ����
	$sRTFCode = StringReplace($sRTFCode, '\', '\\', 0, 2)
	$sRTFCode = StringReplace($sRTFCode, '{', '\{', 0, 2)
	$sRTFCode = StringReplace($sRTFCode, '}', '\}', 0, 2)
	$sRTFCode = StringReplace($sRTFCode, @CR, '\par ' & @CRLF, 0, 2)
	$sRTFCode = StringReplace($sRTFCode, @TAB, '\tab ', 0, 2)
	$sRTFCode = StringReplace($sRTFCode, Chr(1), '\', 0, 2) ; ���������� "\" ������ Chr(1)
	; ClipPut($sRTFCode)

	__RESH_HeaderFooter($sRTFCode) ; ��������� ����� (��������� ������: ������ � ��� ������, ������� ������)

	Return $sRTFCode
EndFunc

; ������������� ����� RTF � ������-����
Func __RESH_HeaderFooter(ByRef $sCode)
	Local $g_RESH_sColorTable = _
			'\red255\green0\blue0;' & _ ; �������
			'\red0\green0\blue255;' & _ ; �����
			'\red99\green99\blue99;' ; �����

	$sCode = "{\rtf\ansi\ansicpg1251\deff0\deflang1033{\fonttbl{\f0\fnil\fcharset0 Arial;}}" & _ ; ����� �����
			"{\colortbl;" & $g_RESH_sColorTable & "}{\*\generator Msftedit 5.41.21.2510;}\viewkind4\uc1\pard\f0\fs18" & _ ; ������ ������ 18
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