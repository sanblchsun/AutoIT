
; Функции для JumpReg

; Функции общего назначения

; _Reg_Exists
; _JumpRegistry
; _SetCoor
; _restart
; _WinAPI_LoadKeyboardLayout
; _ChildCoor
; _WinAPI_GetWorkingArea


Func _Reg_Exists($sKey)
	RegRead($sKey, '')
	Return Not (@error > 0)
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

Func _SetCoor(ByRef $WHXY, $d=0)
; _ArrayDisplay($WHXY, 'Размер')
	Local $Xtmp, $Ytmp, $aWA
	$Frm=_WinAPI_GetSystemMetrics(32)*2
	$CpT=_WinAPI_GetSystemMetrics(4) + _WinAPI_GetSystemMetrics(33)*2
	$WHXY[0] = $WHXY[0] + $Frm
	$WHXY[1] = $WHXY[1] + $CpT - $d
	$aWA = _WinAPI_GetWorkingArea()
	ReDim $aWA[6]
	$aWA[4] = $aWA[2]-$aWA[0] ; ширина
	$aWA[5] = $aWA[3]-$aWA[1] ; высота
	; $sLeftArea, $sTopArea, $sRightArea, $sBottomArea
	$Xtmp=Number($WHXY[2])
	$Ytmp=Number($WHXY[3])
	If $Xtmp < 0 And $Xtmp <>-1 Then $Xtmp=0
	If $WHXY[0] >= $aWA[4] Then
		$WHXY[0] = $aWA[4]
		$Xtmp=0
	EndIf
	If $Xtmp > $aWA[4]-$WHXY[0] Then $Xtmp=$aWA[4]-$WHXY[0]
	If $WHXY[2]='' Then $Xtmp=-1
	
	If $Ytmp < 0 And $Ytmp <>-1 Then $Ytmp=0
	If $WHXY[1] >= $aWA[5] Then
		$WHXY[1] = $aWA[5]
		$Ytmp=0
	EndIf
	If $Ytmp > $aWA[5]-$WHXY[1] Then $Ytmp=$aWA[5]-$WHXY[1] ; проблема поправки на заголовок
	If $WHXY[3]='' Then $Ytmp=-1
	$WHXY[0] = $WHXY[0] - $Frm
	$WHXY[1] = $WHXY[1] - $CpT + $d
	$WHXY[2]=$Xtmp+$aWA[0]
	$WHXY[3]=$Ytmp+$aWA[1]
; _ArrayDisplay($WHXY, 'Размер')
EndFunc

Func _TypeGetPath($type)
	Local $aPath = ''
	Local $typefile = RegRead('HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.' & $type, 'Progid')
	If @error Or $typefile = '' Then
		$typefile = RegRead('HKCR\.' & $type, '')
		If @error Then
			$aPath = RegRead('HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.' & $type & '\OpenWithList', 'a')
			If @error Or $aPath = '' Then Return SetError(1)
		EndIf
	EndIf
	If $aPath = '' Then
		Local $Open = RegRead('HKCR\' & $typefile & '\shell', '')
		If @error Or $Open = '' Then $Open = 'open'
		$typefile = RegRead('HKCR\' & $typefile & '\shell\' & $Open & '\command', '')
		If @error Then
			$aPath = RegRead('HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.' & $type & '\OpenWithList', 'a')
			If @error Or $aPath = '' Then
				Return SetError(1)
			Else
				$typefile = $aPath
			EndIf
		EndIf
	Else
		$typefile = $aPath
	EndIf
	Local $aPath = StringRegExp($typefile, '(?i)(^.*)(\.exe.*)$', 3)
	If @error Then Return SetError(1)
	$aPath = StringReplace($aPath[0], '"', '') & '.exe'
	Opt('ExpandEnvStrings', 1)
	If FileExists($aPath) Then
		$aPath = $aPath
		Opt('ExpandEnvStrings', 0)
		Return $aPath
	EndIf
	Opt('ExpandEnvStrings', 0)
	If FileExists(@SystemDir & '\' & $aPath) Then
		Return @SystemDir & '\' & $aPath
	ElseIf FileExists(@WindowsDir & '\' & $aPath) Then
		Return @WindowsDir & '\' & $aPath
	EndIf
	Return SetError(1)
EndFunc   ;==>_TypeGetPath

Func _restart()
	; _saveini()
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
EndFunc   ;==>_restart

Func _WinAPI_LoadKeyboardLayout($sLayoutID, $hWnd = 0)
    Local Const $WM_INPUTLANGCHANGEREQUEST = 0x50
    Local $aRet = DllCall("user32.dll", "long", "LoadKeyboardLayoutW", "wstr", Hex($sLayoutID, 8), "int", 0)

    If Not @error And $aRet[0] Then
        If $hWnd = 0 Then
            $hWnd = WinGetHandle(AutoItWinGetTitle())
        EndIf

        DllCall("user32.dll", "ptr", "SendMessage", "hwnd", $hWnd, "int", $WM_INPUTLANGCHANGEREQUEST, "int", 1, "int", $aRet[0])
        Return 1
    EndIf

    Return SetError(1)
EndFunc

Func _ChildCoor($Gui, $w, $h, $c=0, $d=0)
	Local $aWA = _WinAPI_GetWorkingArea(), _
	$GP = WinGetPos($Gui), _
	$wgcs=WinGetClientSize($Gui), _
	$dLeft=($GP[2]-$wgcs[0])/2, _
	$dTor=$GP[3]-$wgcs[1]-$dLeft
	If $c = 0 Then
		$GP[0]=$GP[0]+($GP[2]-$w)/2-$dLeft
		$GP[1]=$GP[1]+($GP[3]-$h-$dLeft-$dTor)/2
	EndIf
	If $d>($aWA[2]-$aWA[0]-$w-$dLeft*2)/2 Or $d>($aWA[3]-$aWA[1]-$h-$dLeft+$dTor)/2 Then $d=0
	If $GP[0]+$w+$dLeft*2+$d>$aWA[2] Then $GP[0]=$aWA[2]-$w-$d-$dLeft*2
	If $GP[1]+$h+$dLeft+$dTor+$d>$aWA[3] Then $GP[1]=$aWA[3]-$h-$dLeft-$dTor-$d
	If $GP[0]<=$aWA[0]+$d Then $GP[0]=$aWA[0]+$d
	If $GP[1]<=$aWA[1]+$d Then $GP[1]=$aWA[1]+$d
	$GP[2]=$w
	$GP[3]=$h
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