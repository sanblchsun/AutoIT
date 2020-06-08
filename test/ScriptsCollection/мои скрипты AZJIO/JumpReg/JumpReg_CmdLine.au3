; En
$LngMs1 = 'Message'
$LngMs10 = 'Submitted text must contain a registry key'
$LngMs5 = 'Error'
$LngMs7 = 'Error: invalid name for the root registry key'
$LngMs8 = 'The key does not exist. The nearest key is:'
$LngMs9 = 'Do you want to jump to it?'

; Ru
; если русская локализация, то русский язык
If @OSLang = 0419 Then
	$LngMs1 = 'Сообщение'
	$LngMs10 = 'Переданный текст должен содержать раздел реестра'
	$LngMs5 = 'Ошибка'
	$LngMs7 = 'Ошибка имени корневого раздела'
	$LngMs8 = 'Раздел не существует.' & @CRLF & 'Ближайший доступный раздел:'
	$LngMs9 = 'Перейти в него?'
EndIf

If $CmdLine[0] Then
	$key = StringRegExpReplace($CmdLine[1], '(?s)[\[\s-]*(HK[^\]]+[^\]\s\\])[\]\s\\]*$', '\1') ; Wrapper для строки с [HK....] и с переносом строк
	If @extended Then
		_Jump($key)
	Else
		MsgBox(0, $LngMs1, $LngMs10)
	EndIf
	Exit
EndIf

Func _Jump($sKey)
	Local $hWnd, $hControl, $aKey, $i
	If StringRight($sKey, 1) = '\' Then $sKey = StringTrimRight($sKey, 1)

	Switch StringMid($sKey, 3, 2)
		Case 'LM'
			$sKey = 'HKEY_LOCAL_MACHINE' & StringTrimLeft($sKey, 4)
		Case 'U\'
			$sKey = 'HKEY_USERS\' & StringTrimLeft($sKey, 4)
		Case 'CU'
			$sKey = 'HKEY_CURRENT_USER' & StringTrimLeft($sKey, 4)
		Case 'CR'
			$sKey = 'HKEY_CLASSES_ROOT' & StringTrimLeft($sKey, 4)
		Case 'CC'
			$sKey = 'HKEY_CURRENT_CONFIG' & StringTrimLeft($sKey, 4)
	EndSwitch
	;проверяем существование раздела реестра
	If Not _Reg_Exists($sKey) Then
		Do
			$sKey = StringRegExpReplace($sKey, '(.*)\\.*', '\1')
			If Not @extended Then
				MsgBox(0, $LngMs5, $LngMs7)
				Return
			EndIf
		Until _Reg_Exists($sKey)
		If MsgBox(4, $LngMs5, $LngMs8 & @CRLF & $sKey & @CRLF & @CRLF & $LngMs9) = 7 Then Return
	EndIf

	_JumpRegistry($sKey)
EndFunc

Func _JumpRegistry($sKey)
	Local $hWnd, $hControl, $aKey, $i
	If Not ProcessExists("regedit.exe") Then
		Run(@WindowsDir & '\regedit.exe')
		If Not WinWaitActive('[CLASS:RegEdit_RegEdit]', '', 3) Then Return
	EndIf
	If Not WinActive('[CLASS:RegEdit_RegEdit]') Then WinActivate('[CLASS:RegEdit_RegEdit]')

	$hWnd = WinGetHandle("[CLASS:RegEdit_RegEdit]")
	$hControl = ControlGetHandle($hWnd, "", "[CLASS:SysTreeView32; INSTANCE:1]")

	$aKey = StringSplit($sKey, '\')
	$sKey = '#0'
	For $i = 1 To $aKey[0]
		ControlTreeView($hWnd, "", $hControl, "Expand", $sKey)
		$sKey &= '|' & $aKey[$i]
	Next
	ControlTreeView($hWnd, "", $hControl, "Expand", $sKey)
	ControlTreeView($hWnd, "", $hControl, "Select", $sKey)
EndFunc

Func _Reg_Exists($sKey)
	RegRead($sKey, '')
	Return Not (@error > 0)
EndFunc