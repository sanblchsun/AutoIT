
; ===============================================================================
; Function Name ...: _HSB_to_RGB
; AutoIt Version ....: 3.2.12.1+
; Description ........: Конвертирование цветового пространства из HSB в RGB
; Parameters .......: Массив
; Return values ....: Массив
; Author(s) ..........: AZJIO
; ===============================================================================
Func _HSB_to_RGB($aHSB)
	If UBound($aHSB) <> 3 Or UBound($aHSB, 0) <> 1 Then Return SetError(1, 0, 0)
	Local $aRGB[3], $f, $p, $q, $t, $Sector
	
	$aHSB[2] /= 100
	
	If $aHSB[1] = 0 Then
		$aRGB[0] = $aHSB[2]
		$aRGB[1] = $aRGB[0]
		$aRGB[2] = $aRGB[0]
	Else
		While $aHSB[0] >= 360
			$aHSB[0] -= 360
		WEnd
		
		$aHSB[1] /= 100
		$aHSB[0] /= 60
		$Sector = Int($aHSB[0])
		
		$f = $aHSB[0] - $Sector
		$p = $aHSB[2] * (1 - $aHSB[1])
		$q = $aHSB[2] * (1 - $aHSB[1] * $f)
		$t = $aHSB[2] * (1 - $aHSB[1] * (1 - $f))
		
		Switch $Sector
			Case 0
				$aRGB[0] = $aHSB[2]
				$aRGB[1] = $t
				$aRGB[2] = $p
			Case 1
				$aRGB[0] = $q
				$aRGB[1] = $aHSB[2]
				$aRGB[2] = $p
			Case 2
				$aRGB[0] = $p
				$aRGB[1] = $aHSB[2]
				$aRGB[2] = $t
			Case 3
				$aRGB[0] = $p
				$aRGB[1] = $q
				$aRGB[2] = $aHSB[2]
			Case 4
				$aRGB[0] = $t
				$aRGB[1] = $p
				$aRGB[2] = $aHSB[2]
			Case Else
				$aRGB[0] = $aHSB[2]
				$aRGB[1] = $p
				$aRGB[2] = $q
		EndSwitch
	EndIf
	
	$aRGB[0] = Round($aRGB[0] * 255)
	$aRGB[1] = Round($aRGB[1] * 255)
	$aRGB[2] = Round($aRGB[2] * 255)
	
	Return $aRGB
EndFunc

; вычисление координат дочернего окна
Func _ChildCoor($Gui, $w, $h, $c = 0, $d = 0)
	Local $aWA = _WinAPI_GetWorkingArea(), _
			$GP = WinGetPos($Gui), _
			$wgcs = WinGetClientSize($Gui), _
			$dLeft = ($GP[2] - $wgcs[0]) / 2, _
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