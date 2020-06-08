#Include <_RegFunc.au3> ; для _RegExport_X


Func _Reg_Exists($sKey)
	RegRead($sKey, '')
	Return Not (@error > 0)
EndFunc   ;==>_Reg_Exists

Func _JumpRegistry($sKey)
	Local $hWnd, $hControl, $aKey, $i
	If Not ProcessExists("regedit.exe") Then
		Run(@WindowsDir & '\regedit.exe')
		If Not WinWaitActive('[CLASS:RegEdit_RegEdit]', '', 3) Then Return 1
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
EndFunc   ;==>_JumpRegistry

; вычисление координат дочернего окна
; 1 - дескриптор родительского окна
; 2 - ширина дочернего окна
; 3 - высота дочернего окна
; 4 - тип 0 - по центру, или 0 - к левому верхнему родительского окна
; 5 - отступ от краёв
Func _ChildCoor($Gui, $w, $h, $c = 0, $d = 0)
	Local $aWA = _WinAPI_GetWorkingArea(), _
			$GP = WinGetPos($Gui), _
			$wgcs = WinGetClientSize($Gui)
	Local $dLeft = ($GP[2] - $wgcs[0]) / 2, _
			$dTor = $GP[3] - $wgcs[1] - $dLeft
	If $c = 0 Then
		$GP[0] = $GP[0] + ($GP[2] - $w) / 2 - $dLeft
		$GP[1] = $GP[1] + ($GP[3] - $h - $dLeft - $dTor) / 2
	EndIf
	If $d > ($aWA[2] - $aWA[0] - $w - $dLeft * 2) / 2 Or $d > ($aWA[3] - $aWA[1] - $h - $dLeft + $dTor) / 2 Then $d = 0
	If $GP[0] + $w + $dLeft * 2 + $d > $aWA[2] Then $GP[0] = $aWA[2] - $w - $d - $dLeft * 2
	If $GP[1] + $h + $dLeft + $dTor + $d > $aWA[3] Then $GP[1] = $aWA[3] - $h - $dLeft - $dTor - $d
	If $GP[0] <= $aWA[0] + $d Then $GP[0] = $aWA[0] + $d
	If $GP[1] <= $aWA[1] + $d Then $GP[1] = $aWA[1] + $d
	$GP[2] = $w
	$GP[3] = $h
	Return $GP
EndFunc

Func _WinAPI_GetWorkingArea()
	Local Const $SPI_GETWORKAREA = 48
	Local $stRECT = DllStructCreate("long; long; long; long")

	Local $SPIRet = DllCall("User32.dll", "int", "SystemParametersInfo", "uint", $SPI_GETWORKAREA, "uint", 0, "ptr", DllStructGetPtr($stRECT), "uint", 0)
	If @error Then Return 0
	If $SPIRet[0] = 0 Then Return 0

	Local $sLeftArea = DllStructGetData($stRECT, 1)
	Local $sTopArea = DllStructGetData($stRECT, 2)
	Local $sRightArea = DllStructGetData($stRECT, 3)
	Local $sBottomArea = DllStructGetData($stRECT, 4)

	Local $aRet[4] = [$sLeftArea, $sTopArea, $sRightArea, $sBottomArea]
	Return $aRet
EndFunc

Func _FileAssociation($sExt)
	Local $aCall = DllCall("shlwapi.dll", "int", "AssocQueryStringW", _
			"dword", 0x00000040, _ ;$ASSOCF_VERIFY
			"dword", 2, _ ;$ASSOCSTR_EXECUTABLE
			"wstr", $sExt, _
			"ptr", 0, _
			"wstr", "", _
			"dword*", 65536)
	If @error Then Return SetError(1, 0, "")
	If Not $aCall[0] Then
		Return SetError(0, 0, $aCall[5])
	ElseIf $aCall[0] = 0x80070002 Then
		Return SetError(1, 0, "{unknown}")
	ElseIf $aCall[0] = 0x80004005 Then
		Return SetError(1, 0, "{fail}")
	Else
		Return SetError(2, $aCall[0], "")
	EndIf
EndFunc

Func _restart()
	Local $sAutoIt_File = @TempDir & "\~Au3_ScriptRestart_TempFile.au3"
	Local $sRunLine, $sScript_Content, $hFile

	$sRunLine = @ScriptFullPath
	If Not @Compiled Then $sRunLine = @AutoItExe & ' /AutoIt3ExecuteScript ""' & $sRunLine & '""'
	If $CmdLine[0] > 0 Then $sRunLine &= ' ' & $CmdLineRaw

	$sScript_Content &= '#NoTrayIcon' & @CRLF & _
			'While ProcessExists(' & @AutoItPID & ')' & @CRLF & _
			'   Sleep(10)' & @CRLF & _
			'WEnd' & @CRLF & _
			'Run("' & $sRunLine & '")' & @CRLF & _
			'FileDelete(@ScriptFullPath)' & @CRLF

	$hFile = FileOpen($sAutoIt_File, 2)
	FileWrite($hFile, $sScript_Content)
	FileClose($hFile)

	Run(@AutoItExe & ' /AutoIt3ExecuteScript "' & $sAutoIt_File & '"', @ScriptDir, @SW_HIDE)
	Sleep(1000)
	Exit
EndFunc

; Обновление кэша значков
; Не сработало на WIN7
; engine
; http://www.autoitscript.com/forum/topic/70433-rebuild-shell-icon-cache/page__view__findpost__p__531242
; _RebuildShellIconCache + _BroadcastChange
Func _RebuildShellIconCache()
	Local Const $sKeyName = "HKCU\Control Panel\Desktop\WindowMetrics"
	Local Const $sValue = "Shell Icon Size"

	$sDataRet = RegRead($sKeyName, $sValue)
	If @error Then Return SetError(1)

	RegWrite($sKeyName, $sValue, "REG_SZ", $sDataRet + 1)
	If @error Then Return SetError(1)

	$bcA = _BroadcastChange()

	RegWrite($sKeyName, $sValue, "REG_SZ", $sDataRet)

	$bcB = _BroadcastChange()

	If $bcA = 0 Or $bcB = 0 Then Return SetError(1)

	Return
EndFunc

Func _BroadcastChange()
	Local Const $HWND_BROADCAST = 0xffff
	Local Const $WM_SETTINGCHANGE = 0x1a
	Local Const $SPI_SETNONCLIENTMETRICS = 0x2a
	Local Const $SMTO_ABORTIFHUNG = 0x2

	$bcResult = DllCall("user32.dll", "lresult", "SendMessageTimeout", _
			"hwnd", $HWND_BROADCAST, _
			"uint", $WM_SETTINGCHANGE, _
			"wparam", $SPI_SETNONCLIENTMETRICS, _
			"lparam", 0, _
			"uint", $SMTO_ABORTIFHUNG, _
			"uint", 10000, _
			"dword*", "success")
	If @error Then Return 0

	Return $bcResult[0]
EndFunc

Func _RegExport_X($sKey, ByRef $Data)
	Local $aaaValue, $asValue0, $cmd, $DataErr, $hex, $i, $L, $line1, $Re, $sTemp, $sValue, $sValue0, $sValuename, $sValuetype

	$i = 0
	Do
		$i += 1
		; If $i=1 Then $Data &= @CRLF & '[' & $sKey & ']' & @CRLF
		$sValuename = RegEnumVal($sKey, $i)
		If @error Then ExitLoop
		$sValue = _RegRead($sKey, $sValuename, True)
		If @error Then ContinueLoop
		$sValuetype = @extended
		; $sValuename = StringRegExpReplace($sValuename, '[\\]', "\\$0") ; всегда заменяем в параметре наклонную черту на двойную
		$sValuename = StringReplace($sValuename, '\', "\\") ; всегда заменяем в параметре наклонную черту на двойную
		If $i=1 Then $Data &= @CRLF & '[' & $sKey & ']' & @CRLF ; если строку переместить к началу, то все разделы даже пустые добавятся
		; здесь для каждого типа данных свой алгоритм извлечения значений
		Switch $sValuetype
			Case 1
				$sValue = StringReplace(StringReplace(StringRegExpReplace($sValue, '["\\]', "\\$0"), '=\"\"', '="\"'), '\"\"', '\""')
				$Data &= '"' & $sValuename & '"="' & $sValue & '"' & @CRLF
			Case 7, 2
				$hex=_HEX($sValuetype, $sValue, $sValuename, $L)
				$Data &= '"' & $sValuename & '"=' & $L & $hex & @CRLF
			Case 4
				$Data &= '"' & $sValuename & '"=dword:' & StringLower(Hex(Int($sValue))) & @CRLF
			Case 3
				$hex=_HEX(3, $sValue, $sValuename, $L)
				$Data &= '"' & $sValuename & '"=' & $L & $hex & @CRLF
			Case 0, 8, 9, 10, 11 ; тип данных которые не распознаёт AutoIt3, поэтому используется экспорт консольной командой.
				; Вытаскиваем значение в консоль и читаем с неё
				$hex=_HEX($sValuetype, $sValue, $sValuename, $L)
				$Data &= '"' & $sValuename & '"=' & $L & $hex & @CRLF
			Case Else
				$DataErr &= '# error... Key:"' & $sKey & '" Valuename:"' & $sValuename & '" значение:"' & $sValue & '" type:"' & $sValuetype & '"' & @CRLF
		EndSwitch
	Until 0
	;рекурсия
	$i = 0
	While 1
		$i += 1
		$sTemp = RegEnumKey($sKey, $i)
		If @error Then ExitLoop
		$DataErr &= _RegExport_X($sKey & '\' & $sTemp, $Data)
	WEnd
	$Data = StringReplace($Data, '""=', '@=') ; заменяем в данных параметры по умолчанию на правильные
	Return $DataErr
EndFunc   ;==>_RegExport_X

; функция шестнадцатеричных данных, основное её значение - привести запись к формату reg-файла (перенос строк)
; данные подгонялись методом сравнения оригинального экспорта и reg-файлом полученным скриптом до полного совпадения.
Func _HEX($sValuetype, ByRef $sValue, $sValuename, ByRef $L)
	Local $aValue, $hex, $i, $k, $len, $lenVN, $r, $s, $s0
	$k = 0
	$lenVN = StringLen($sValuename) - 1
	Switch $sValuetype
		Case 0
			$L = 'hex(0):'
		Case 3
			$k = 1
			$L = 'hex:'
		Case 2
			$k = 1
			$L = 'hex(2):'
			$sValue = StringToBinary($sValue, 2)
			$sValue &= '0000'
			$lenVN = StringLen($sValuename) + 2
		Case 7
			$k = 1
			$L = 'hex(7):'
			; $sValue = StringToBinary($sValue, 2) ; строковый в бинарный вид
			; $sValue = StringReplace($sValue, '000a00', '000000') ; по какой то причине экспортированные и прочитанные данные разнятся этими блоками
			; $sValue &= '00000000' ; шестнадцатеричные данные заполнены окончания нулями, иногда не совпадает количество, автоит обрезает так как читает данные как текстовые
		Case 8
			$sValue = StringTrimLeft($sValue, 2)
			$L = 'hex(8):'
		Case 10
			$L = 'hex(a):'
		Case 11
			$L = 'hex(b):'
		Case 9
			; $k = -1
			$sValue = StringTrimLeft($sValue, 2)
			$L = 'hex(9):'
	EndSwitch
	$hex = ''
	$aValue=StringRegExp($sValue, '..', 3)
	$len = UBound($aValue) ; от колич. символов параметра зависит колич. бинарных данных первой строки
	If $lenVN >= 69 Then $lenVN = 66
	$s0 = 22 - ($lenVN - Mod($lenVN, 3)) / 3 ; количество символов для первой строки reg-данных
	Switch $sValuetype
		Case 7,8,9
			$s0 -= 1
	EndSwitch
	$s = 0
	$r = 0
	For $i = $k To $len-1 ; цикл формирует правильный перенос строк, и разделительные запятые
		If $s = $s0 Or $r = 24 Then
			$hex &= $aValue[$i] & ',\' & @CRLF & '  '
			$s = 24
			$r = 0
		Else
			$hex &= $aValue[$i] & ','
			$s += 1
			$r += 1
		EndIf
	Next
	$hex = StringTrimRight($hex, 1)
	If StringRight($hex, 5) = ',\' & @CRLF & ' ' Then $hex = StringTrimRight($hex, 5) ;обрезка конца значания
	$hex = StringLower($hex) ; преобразование в строчные
	Return $hex
EndFunc   ;==>_HEX