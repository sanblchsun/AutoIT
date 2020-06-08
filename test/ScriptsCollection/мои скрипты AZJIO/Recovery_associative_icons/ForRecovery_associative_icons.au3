
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

Func _AssotFile($Type)
	If $Type = '' Then Return
	
	$TypeNR = RegRead('HKEY_CLASSES_ROOT\.' & $Type, '') ; класс
	If @error Then
		$TypeNR = RegEnumVal('HKEY_CLASSES_ROOT\.' & $Type & '\OpenWithProgids', 1)
		If @error Then Return SetError(1, 0, '') ; ненайдено
	EndIf
	
	$ProgidR = RegRead('HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.' & $Type, 'Progid')
	If Not @error And $ProgidR <> '' Then $TypeNR = $ProgidR
	
	$ico1 = RegRead('HKEY_CLASSES_ROOT\' & $TypeNR & '\DefaultIcon', '')
	If Not @error Then
		$sExt = StringReplace($ico1, '"', '')
		$sExt = StringSplit($sExt, ',')
		Opt('ExpandEnvStrings', 1)
		$sExt[1] = $sExt[1]
		Opt('ExpandEnvStrings', 0)
		Return SetError(0, 0, $sExt)
	EndIf
EndFunc

; валидность координат проверяем при запуске
Func _SetCoor(ByRef $XYPos)
	$Xtmp = Number($XYPos[2])
	$Ytmp = Number($XYPos[3])
	If $Xtmp < 0 And $Xtmp <> -1 Then $Xtmp = 0
	If $Xtmp > @DesktopWidth - $XYPos[0] Then $Xtmp = @DesktopWidth - $XYPos[0]
	If $XYPos[2] = '' Then $Xtmp = -1
	If $Ytmp < 0 And $Ytmp <> -1 Then $Ytmp = 0
	If $Ytmp > @DesktopHeight - $XYPos[1] Then $Ytmp = @DesktopHeight - $XYPos[1]
	If $XYPos[3] = '' Then $Ytmp = -1
	$XYPos[2] = $Xtmp
	$XYPos[3] = $Ytmp
EndFunc