
;  @AZJIO ������ ��������� � �������� ��������� �������

#include <ComboConstants.au3>

;=============================================================
; ������ ��� �������� ����� En.lng � Ru.lng. � ������� ��� �� �����������, ����� ��� ����� �������.
If Not FileExists(@ScriptDir & '\Lang') Then DirCreate(@ScriptDir & '\Lang')
$file = FileOpen(@ScriptDir & '\Lang\En.lng', 2)
If $file <> -1 Then
	FileWrite($file, _
			'[lng]' & @CRLF & _
			'Title=My Programs' & @CRLF & _
			'But=Open' & @CRLF & _
			'ButH=Open File' & @CRLF & _
			'Lab=Example choice language' & @CRLF & _
			'Sl=Select' & @CRLF & _
			'Type=Language')
	FileClose($file)
EndIf

$file = FileOpen(@ScriptDir & '\Lang\Ru.lng', 2)
If $file <> -1 Then
	FileWrite($file, _
			'[lng]' & @CRLF & _
			'Title=��� ���������' & @CRLF & _
			'But=�������' & @CRLF & _
			'ButH=������� ����' & @CRLF & _
			'Lab=������ ������ �����' & @CRLF & _
			'Sl=�����' & @CRLF & _
			'Type=�������� ����')
	FileClose($file)
EndIf
;=============================================================

#NoTrayIcon
Global $LangPath, $Ini = @ScriptDir & '\prog_set.ini'

; ������ ���� �������� � �������� ����������. ������������ ��� ������ �������.
If Not FileExists($Ini) Then
	$file = FileOpen($Ini, 2)
	If $file <> -1 Then
		FileWrite($file, _
				'[Set]' & @CRLF & _
				'Lang=none')
		FileClose($file)
	EndIf
EndIf

; �� ��������� ������������� ������������ ���������, � ������ ���������� �������� ������.
Global $aLng0[7][2] = [[ _
		6, 6],[ _
		'Title', 'My Programs'],[ _
		'But', 'Open'],[ _
		'ButH', 'Open File'],[ _
		'Lab', 'Example choice language'],[ _
		'Sl', 'Select'],[ _
		'Type', 'Language']]

; Ru
; ���� ������� �����������, �� ������� ����
If @OSLang = 0419 Then
	Dim $aLng0[7][2] = [[ _
			6, 6],[ _
			'Title', '��� ���������'],[ _
			'But', '�������'],[ _
			'ButH', '������� ����'],[ _
			'Lab', '������ ������ �����'],[ _
			'Sl', '�����'],[ _
			'Type', '�������� ����']]
EndIf

; ���������� ���������� �������
For $i = 1 To $aLng0[0][0]
	If StringInStr($aLng0[$i][1], '\r\n') Then $aLng0[$i][1] = StringReplace($aLng0[$i][1], '\r\n', @CRLF) ; ��� ������ �������, ���� ������ \r\n ���������� @CRLF
	Assign('Lng' & $aLng0[$i][0], $aLng0[$i][1])
Next

; ��������� �������� ����, ���� ������.
; 1 - ���������� ����������� � ��������� "Lng", ������� ��� �� ����� ������������ � ����������� ������� �� ��� ����� ���������������
; 2 - ���������� ����������� �� ��������������, ������� �������� � ������ ��������������� ����������
$LangPath = IniRead($Ini, 'Set', 'Lang', 'none') ; ������ �������� ��������� lng � ����������� ���������� $LangPath
If $LangPath <> 'none' And FileExists(@ScriptDir & '\Lang\' & $LangPath) Then
	$aLng = IniReadSection(@ScriptDir & '\Lang\' & $LangPath, 'lng')
	If Not @error Then
		For $i = 1 To $aLng[0][0]
			If StringInStr($aLng[$i][1], '\r\n') Then $aLng[$i][1] = StringReplace($aLng[$i][1], '\r\n', @CRLF)
			If IsDeclared('Lng' & $aLng[$i][0]) Then Assign('Lng' & $aLng[$i][0], $aLng[$i][1])
		Next
	EndIf
EndIf

$Gui = GUICreate($LngTitle, 250, 100)
$Button = GUICtrlCreateButton($LngBut, 10, 60, 99, 22)
GUICtrlSetTip(-1, $LngButH)
$Label = GUICtrlCreateLabel($LngLab, 10, 5, 153, 15)
; $Checkbox = GUICtrlCreateCheckbox ($LngCh, 10, 50, 55, 22)

$LangList = 'none'
$search = FileFindFirstFile(@ScriptDir & '\Lang\*.lng')
If $search <> -1 Then
	While 1
		$file = FileFindNextFile($search)
		If @error Then ExitLoop
		$LangList &= '|' & $file
	WEnd
EndIf
FileClose($search)

GUICtrlCreateLabel('Language', 10, 33, 75, 17)
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
	Local $aLng
	$LangPath = GUICtrlRead($ComboLang)
	If $LangPath <> 'none' And FileExists(@ScriptDir & '\Lang\' & $LangPath) Then
		$aLng = IniReadSection(@ScriptDir & '\Lang\' & $LangPath, 'lng') ;������ ��� ��������� � ������ lng
		If Not @error Then
			For $i = 1 To $aLng[0][0]
				If StringInStr($aLng[$i][1], '\r\n') Then $aLng[$i][1] = StringReplace($aLng[$i][1], '\r\n', @CRLF); ������ ������ \r\n � ������ ������������� ������������� �������
				If IsDeclared('Lng' & $aLng[$i][0]) Then Assign('Lng' & $aLng[$i][0], $aLng[$i][1]) ; ��������� ����� ��������������� ����������
			Next
			_SetLang2()
			IniWrite($Ini, 'Set', 'Lang', $LangPath)
		EndIf
	Else ; ���� ��� ����� ��� ������ "none", �� ���������� ���� ���������� � ���������
		For $i = 1 To $aLng0[0][0]
			If StringInStr($aLng0[$i][1], '\r\n') Then $aLng0[$i][1] = StringReplace($aLng0[$i][1], '\r\n', @CRLF)
			Assign('Lng' & $aLng0[$i][0], $aLng0[$i][1])
		Next
		_SetLang2()
		IniWrite($Ini, 'Set', 'Lang', 'none')
	EndIf
EndFunc   ;==>_SetLang

; ������� ���������� ������� ����������
Func _SetLang2()
	; ������������ �������� ����� � ����������, �� ����� ������� � ������� ���������� ���������
	WinSetTitle($Gui, '', $LngTitle) ; ������� ��� ����, ���� ��� ���� ���������
	GUICtrlSetData($Label, $LngLab)
	GUICtrlSetData($Button, $LngBut)
	GUICtrlSetTip($Button, $LngButH)
	; ����� ����� ������������ �� ��������� ��������
	; If $TrCh = 0 Then
		; GUICtrlSetTip($Checkbox,  $LngCh1)
	; Else
		; GUICtrlSetTip($Checkbox,  $LngCh2)
	; EndIf
EndFunc   ;==>_SetLang2