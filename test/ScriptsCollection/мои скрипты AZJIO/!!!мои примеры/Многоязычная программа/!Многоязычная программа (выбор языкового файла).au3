
;  @AZJIO ������ ��������� � �������� ��������� �������

;=============================================================
; ������ ��� �������� ����� En.lng � Ru.lng. � ������� ��� �� �����������, ����� ��� ����� �������.
$file = FileOpen(@ScriptDir & '\En.lng', 2)
FileWrite($file, _
		'[lng]' & @CRLF & _
		'LngTitle=My Programs' & @CRLF & _
		'LngBut=Open LNG' & @CRLF & _
		'LngButH=Open File LNG' & @CRLF & _
		'LngLab=Example choice language' & @CRLF & _
		'LngSl=Select' & @CRLF & _
		'LngType=Language')
FileClose($file)

$file = FileOpen(@ScriptDir & '\Ru.lng', 2)
FileWrite($file, _
		'[lng]' & @CRLF & _
		'LngTitle=��� ���������' & @CRLF & _
		'LngBut=������� LNG' & @CRLF & _
		'LngButH=������� ���� LNG' & @CRLF & _
		'LngLab=������ ������ �����' & @CRLF & _
		'LngSl=�����' & @CRLF & _
		'LngType=�������� ����')
FileClose($file)
;=============================================================

#NoTrayIcon
Global $lng, $Ini = @ScriptDir & '\prog_set.ini'

; �� ��������� ������������� ������������ ���������, � ������ ���������� �������� ������.
$LngTitle = 'My Programs'
$LngBut = 'Open LNG'
$LngButH = 'Open File LNG'
$LngLab = 'Example choice language'
$LngSl = 'Select'
$LngType = 'Language'

; ������ ���� �������� � �������� ����������. ������������ ��� ������ �������.
; ����� ��������� ����� ��� ini, �������������� ��� ������ ���� �������� � �������� "������ ������"
If Not FileExists($Ini) Then
	$file = FileOpen($Ini, 2)
	If $file <> -1 Then
		FileWrite($file, _
				'[setting]' & @CRLF & _
				'lng=')
		FileClose($file)
	EndIf
EndIf

$lng = IniRead($Ini, 'setting', 'lng', '') ; ������ �������� ��������� lng � ����������� ���������� $lng

$Gui = GUICreate($LngTitle, 250, 100)
$Button = GUICtrlCreateButton($LngBut, 10, 30, 99, 22)
GUICtrlSetTip(-1, $LngButH)
$Label = GUICtrlCreateLabel($LngLab, 10, 5, 153, 15)
; $Checkbox = GUICtrlCreateCheckbox ($LngCh, 10, 50, 55, 22)

; ���� ���������� ����� �������� � ���� ����� ����� � ���������� ���� ����, �� �������� ������� ����� �����
If $lng <> '' And FileExists(@ScriptDir & '\' & $lng) Then _OpenLng($lng)

GUISetState()

While 1
	$msg = GUIGetMsg()
	Select
		Case $msg = $Button
			$tmp = FileOpenDialog($LngSl, @WorkingDir & "", $LngType & " (*.lng)", 1)
			If @error Then ContinueLoop
			$tmp = StringRegExpReplace($tmp, '(^.*)\\(.*)$', '\2')
			_OpenLng($tmp)
		Case $msg = -3
			IniWrite($Ini, 'setting', 'lng', $lng)
			Exit
	EndSelect
WEnd

; ������� ����� �����
Func _OpenLng($Path)
	;������ ��� ��������� � ������ lng
	$aLng = IniReadSection(@ScriptDir & '\' & $Path, 'lng')
	If @error Then ; � ������ ������ ������ �����
		$lng = ''
		Return
	Else ; � ������ ���������� ������ ��������� ����� ����������
		For $i = 1 To $aLng[0][0]
			If StringInStr($aLng[$i][1], '\r\n') <> 0 Then $aLng[$i][1] = StringReplace($aLng[$i][1], '\r\n', @CRLF) ; ������ ������ \r\n � ������ ������������� ������������� �������
			Assign($aLng[$i][0], $aLng[$i][1]) ; ��������� ����� ����������
		Next
		$lng = $Path ; ��������� ��� ������������
		
		; ������������ �������� ����� � ����������, �� ����� ������� � ������� ���������� ���������
		ControlSetText($Gui, '', $Gui, $LngTitle, 1)
		GUICtrlSetData($Label, $LngLab)
		GUICtrlSetData($Button, $LngBut)
		GUICtrlSetTip($Button, $LngButH)
		
		; ����� ����� ������������ �� ��������� ��������
		; If $TrCh = 0 Then
			; GUICtrlSetTip($Checkbox,  $LngCh1)
		; Else
			; GUICtrlSetTip($Checkbox,  $LngCh2)
		; EndIf

	EndIf
EndFunc   ;==>_OpenLng