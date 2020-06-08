
;  @AZJIO ������ ��������� � �������� ��������� �������

#include <ComboConstants.au3>

;=============================================================
; ������ ��� �������� ����� En.lng � Ru.lng. � ������� ��� �� �����������, ����� ��� ����� �������. �������� ���� 32, ����� �������� ��������� �������
If Not FileExists(@ScriptDir & '\Lang') Then DirCreate(@ScriptDir & '\Lang')
$hFile = FileOpen(@ScriptDir & '\Lang\En.lng', 2 + 32)
If $hFile <> -1 Then
	FileWrite($hFile, _
			'[lng]' & @CRLF & _
			'1=My Programs' & @CRLF & _
			'2=Open' & @CRLF & _
			'3=Open File' & @CRLF & _
			'4=Example choice language' & @CRLF & _
			'5=Select' & @CRLF & _
			'6=Language')
	FileClose($hFile)
EndIf

$hFile = FileOpen(@ScriptDir & '\Lang\Ru.lng', 2 + 32)
If $hFile <> -1 Then
	FileWrite($hFile, _
			'[lng]' & @CRLF & _
			'1=��� ���������' & @CRLF & _
			'2=�������' & @CRLF & _
			'3=������� ����' & @CRLF & _
			'4=������ ������ �����' & @CRLF & _
			'5=�����' & @CRLF & _
			'6=�������� ����')
	FileClose($hFile)
EndIf
;=============================================================

#NoTrayIcon
Global $LangPath, $Ini = @ScriptDir & '\prog_set.ini'

; ������ ���� �������� � �������� ����������. ������������ ��� ������ �������.
If Not FileExists($Ini) Then
	$hFile = FileOpen($Ini, 2)
	If $hFile <> -1 Then
		FileWrite($hFile, _
				'[Set]' & @CRLF & _
				'Lang=none')
		FileClose($hFile)
	EndIf
EndIf

; �� ��������� ������������� ������������ ���������, � ������ ���������� �������� ������.
Global $aLngDef[7][2] = [[ _
		6, 6],[ _
		'1', 'My Programs'],[ _
		'2', 'Open'],[ _
		'3', 'Open File'],[ _
		'4', 'Example choice language'],[ _
		'5', 'Select'],[ _
		'6', 'Language']]

; Ru
; ���� ������� �����������, �� ������� ����. ��� ����� �������������, �� �������� � ���, ����� �� ������ ����� �� ���������� ���� �����������
If @OSLang = 0419 Then
	Dim $aLngDef[7][2] = [[ _
			6, 6],[ _
			'1', '��� ���������'],[ _
			'2', '�������'],[ _
			'3', '������� ����'],[ _
			'4', '������ ������ �����'],[ _
			'5', '�����'],[ _
			'6', '�������� ����']]
EndIf

Global $aLng[7] = [6]

_SetLangCur($aLngDef) ; ���������� ������������� �� ���������, �� ������ ���� �������� ���� �������� ������������ � �� ���������� �� ���� ���������

; ��������� �������� ����, ���� ������.
$LangPath = IniRead($Ini, 'Set', 'Lang', 'none') ; ������ �������� ��������� lng � ���������� ���������� $LangPath
If $LangPath <> 'none' And FileExists(@ScriptDir & '\Lang\' & $LangPath) Then ; ���� �� �� ��������� � ���� ����������, ��
	$aLngINI = IniReadSection(@ScriptDir & '\Lang\' & $LangPath, 'lng')
	If Not @error Then _SetLangCur($aLngINI)
EndIf
$aLngINI = 0

$hGui = GUICreate($aLng[1], 250, 100)
$Button = GUICtrlCreateButton($aLng[2], 10, 60, 99, 22)
GUICtrlSetTip(-1, $aLng[3])
$Label = GUICtrlCreateLabel($aLng[4], 10, 5, 153, 15)
; $Checkbox = GUICtrlCreateCheckbox ($aLng[5], 10, 50, 55, 22)

; ����� �������� ������, ��� ���������� � ������ Combo
$LangList = 'none'
$search = FileFindFirstFile(@ScriptDir & '\Lang\*.lng')
If $search <> -1 Then
	While 1
		$hFile = FileFindNextFile($search)
		If @error Then ExitLoop
		$LangList &= '|' & $hFile
	WEnd
EndIf
FileClose($search)

GUICtrlCreateLabel('Language', 10, 33, 75, 17) ; ������ ���� ����� �� ������������� ����������, ��� ��� ��������� ������������ �� ���������� ���� ������� � ���������� �������������� ������� �����, ��� ��� �� ������� ����� ����� � ���� �������.
$ComboLang = GUICtrlCreateCombo('', 85, 30, 70, 22, $CBS_DROPDOWNLIST)
GUICtrlSetData(-1, $LangList, $LangPath)

GUISetState()

While 1
	Switch GUIGetMsg()
		Case $ComboLang
			_SetLang()
		Case -3
			Exit
	EndSwitch
WEnd

; ������� ����� �����
Func _SetLang()
	Local $aLngINI
	$LangPath = GUICtrlRead($ComboLang)
	If $LangPath <> 'none' And FileExists(@ScriptDir & '\Lang\' & $LangPath) Then ; ���� �� ��������� � ���� ����������, ��
		$aLngINI = IniReadSection(@ScriptDir & '\Lang\' & $LangPath, 'lng')
		If Not @error Then
			_SetLangCur($aLngINI)
			_SetLang2()
			IniWrite($Ini, 'Set', 'Lang', $LangPath)
		EndIf
	Else ; ���� ��� ����� ��� ������ "none", �� ���������� ���� ���������� � ���������
		_SetLangCur($aLngDef)
		_SetLang2()
		$LangPath = 'none'
		IniWrite($Ini, 'Set', 'Lang', 'none')
	EndIf
EndFunc   ;==>_SetLang

Func _SetLangCur($aLng2D)
	; ���������� ���������� �������
	Local $tmp
	For $i = 1 To $aLng2D[0][0]
		If StringInStr($aLng2D[$i][1], '\n') Then $aLng2D[$i][1] = StringReplace($aLng2D[$i][1], '\n', @CRLF) ; ������������ ������� �����, ������� �� ������������ ini
		$tmp = Number($aLng2D[$i][0])
		If $tmp > 0 And $tmp <= $aLng[0] Then $aLng[$tmp] = $aLng2D[$i][1] ; ���������� ������, ���� ��� �������� �������� ����� ������������ ��� ������ �������
		; ���������� ���� ���������� � $tmp �������� �� �������� ������ � ��������� �������� �������, �� �� ����� ��������. ������ �� �������� ������, ��� ��� ����� �� �������� ���������� ��������� �������.
	Next
EndFunc   ;==>_SetLangCur

; ������� ���������� ������� ����������
Func _SetLang2()
	; ������������ �������� ����� � ����������, �� ����� ������� � ������� ���������� ���������
	WinSetTitle($hGui, '', $aLng[1]) ; ������� ��� ����, ���� ��� ���� ���������
	GUICtrlSetData($Label, $aLng[4])
	GUICtrlSetData($Button, $aLng[2])
	GUICtrlSetTip($Button, $aLng[3])
	; ����� ����� ������������ �� ��������� ��������
	; If $TrCh = 0 Then
		; GUICtrlSetTip($Checkbox, $aLng[5])
	; Else
		; GUICtrlSetTip($Checkbox, $aLng[6])
	; EndIf
EndFunc   ;==>_SetLang2