
; Функции для TextReplace


; Функции индивидуальные, но законченные

; _CRLF


; Функции общего назначения

; _SetCoor
; _restart
; _FileAssociation
; _ConvertFileSize
; _ProcessGetPath
; _WinAPI_LoadKeyboardLayout
; _ChildCoor
; _WinAPI_GetWorkingArea


; валидность координат проверяем при запуске
; Func _SetCoor1(ByRef $WHXY)
	; Local $Xtmp, $Ytmp
	; $Xtmp=Number($WHXY[2])
	; $Ytmp=Number($WHXY[3])
	; If $Xtmp < 0 And $Xtmp <>-1 Then $Xtmp=0
	; If $Xtmp > @DesktopWidth-$WHXY[0] Then $Xtmp=@DesktopWidth-$WHXY[0]
	; If $WHXY[2]='' Then $Xtmp=-1
	; If $Ytmp < 0 And $Ytmp <>-1 Then $Ytmp=0
	; If $Ytmp > @DesktopHeight-$WHXY[1] Then $Ytmp=@DesktopHeight-$WHXY[1]
	; If $WHXY[3]='' Then $Ytmp=-1
	; $WHXY[2]=$Xtmp
	; $WHXY[3]=$Ytmp
; EndFunc

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

; замена подстановочных символов переносами строк в шаблонах поиска и замены
Func _CRLF($CRLF, ByRef $Search, ByRef $Replace)
	Switch StringLen($CRLF)
		Case 1
			$Search=StringReplace($Search, $CRLF, @CRLF)
			$Replace=StringReplace($Replace, $CRLF, @CRLF)
		Case 2 To 255
			$CRLF = StringSplit($CRLF, '')
			If $CRLF[1] = $CRLF[2] Then
				$Search=StringReplace($Search, $CRLF[1], @CRLF)
				$Replace=StringReplace($Replace, $CRLF[1], @CRLF)
			Else
				$Search=StringReplace($Search, $CRLF[1], @CR)
				$Search=StringReplace($Search, $CRLF[2], @LF)
				$Replace=StringReplace($Replace, $CRLF[1], @CR)
				$Replace=StringReplace($Replace, $CRLF[2], @LF)
			EndIf
	EndSwitch
EndFunc

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
EndFunc  ;==>_FileAssociation

Func _ConvertFileSize($iBytes)
	Local Const $iConst = 0.0000234375 ; (1024 / 1000 - 1) / 1024
    Switch $iBytes
        Case 110154232090684 To 1125323453007766
            $iBytes = Round($iBytes / (1099511627776 + $iBytes * $iConst)) & ' TB'
        Case 1098948684577 To 110154232090683
            $iBytes = Round($iBytes / (1099511627776 + $iBytes * $iConst), 1) & ' TB'
        Case 107572492277 To 1098948684576
            $iBytes = Round($iBytes / (1073741824 + $iBytes * $iConst)) & ' GB'
        Case 1073192075 To 107572492276
            $iBytes = Round($iBytes / (1073741824 + $iBytes * $iConst), 1) & ' GB'
        Case 105156613 To 1073192074
            $iBytes = Round($iBytes / (1048576 + $iBytes * $iConst)) & ' MB'
        Case 1048040 To 105156612
            $iBytes = Round($iBytes / (1048576 + $iBytes * $iConst), 1) & ' MB'
        Case 102693 To 1048039
            $iBytes = Round($iBytes / (1024 + $iBytes * $iConst)) & ' KB'
        Case 1024 To 102692
            $iBytes = Round($iBytes / (1024 + $iBytes * $iConst), 1) & ' KB'
        Case 0 To 1023
            $iBytes = Int($iBytes / 1.024)
    EndSwitch
    Return $iBytes
EndFunc   ;==>_ConvertFileSize

;извлечь путь процесса зная PID
Func _ProcessGetPath($PID)
    If IsString($PID) Then $PID = ProcessExists($PID)
    $Path = DllStructCreate('char[1000]')
    $dll = DllOpen('Kernel32.dll')
    $handle1 = DllCall($dll, 'int', 'OpenProcess', 'dword', 0x0400 + 0x0010, 'int', 0, 'dword', $PID)
    $ret = DllCall('Psapi.dll', 'long', 'GetModuleFileNameEx', 'long', $handle1[0], 'int', 0, 'ptr', DllStructGetPtr($Path), 'long', DllStructGetSize($Path))
    $ret = DllCall($dll, 'int', 'CloseHandle', 'hwnd', $handle1[0])
    DllClose($dll)
    Return DllStructGetData($Path, 1)
EndFunc  ;==>_ProcessGetPath

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