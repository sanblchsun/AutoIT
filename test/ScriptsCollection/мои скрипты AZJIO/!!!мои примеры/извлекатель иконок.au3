
; »спользу€ скрипт по ссылке
; http://www.autoitscript.com/forum/index.php?showtopic=74565&st=20&p=670142&#entry670142
;сделал автоматическое извлечение иконок из системных dll

#NoTrayIcon
#AutoIt3Wrapper_Change2CUI=y
Global $aEN[1]

If MsgBox(4, '—ообщение', '—рипт создаст несколько каталогов в текущей папке '&@CRLF&'и извлекЄт в них иконки из *.dll, вы согласны?')<>6 Then Exit

Dim $dll[42] = [41, _
'shell32.dll', _
'rasdlg.dll', _
'fontext.dll', _
'msgina.dll', _
'mshtml.dll', _
'mstask.dll', _
'netshell.dll', _
'setupapi.dll', _
'shimgvw.dll', _
'webcheck.dll', _
'xpsp2res.dll', _
'stobject.dll', _
'mydocs.dll', _
'moricons.dll', _
'url.dll', _
'mpcicons.dll', _
'assot.dll', _
'explorer.exe', _
'iexplore.exe', _
'sndvol32.exe', _
'shutdown.exe', _
'charmap.exe', _
'wordpad.exe', _
'taskmgr.exe', _
'wmplayer.exe', _
'wscript.exe', _
'spider.exe', _
'sol.exe', _
'freecell.exe', _
'regedit.exe', _
'winmine.exe', _
'notepad.exe', _
'calc.exe', _
'mspaint.exe', _
'main.cpl', _
'mmsys.cpl', _
'sysdm.cpl', _
'joy.cpl', _
'telephon.cpl', _
'timedate.cpl', _
'desk.cpl']


$tr=0
For $i = 1 to $dll[0]
	If FileExists(@SystemDir&'\'&$dll[$i]) Then
		$tr=1
		DirCreate(StringTrimRight(@ScriptDir&'\'&$dll[$i],4))
		_ExtractICO(@SystemDir&'\'&$dll[$i], StringTrimRight(@ScriptDir&'\'&$dll[$i],4)&'\')
	EndIf
	
	If FileExists(@WindowsDir&'\'&$dll[$i]) and $tr=0 Then
		DirCreate(StringTrimRight(@ScriptDir&'\'&$dll[$i],4))
		_ExtractICO(@WindowsDir&'\'&$dll[$i], StringTrimRight(@ScriptDir&'\'&$dll[$i],4)&'\')
	EndIf
	$tr=0
Next

Func _ExtractICO($dll, $icoPath)
	For $i = 1 to 300
			_ExtractIconToFile($dll, $i, $icoPath&$i&'.ico')
			If @error = 1 then ExitLoop
	Next
EndFunc


;=====================================================================
; http://www.autoitscript.com/forum/index.php?showtopic=74565&st=20&p=670142&#entry670142

Func _ExtractIconToFile($sInFile, $iIcon, $sOutIco, $iPath = 0)
        Local Const $LOAD_LIBRARY_AS_DATAFILE = 0x00000002
        Local Const $RT_ICON = 3
        Local Const $RT_GROUP_ICON = 14
        Local $hInst, $iGN = "", $sData, $sHdr, $aHdr, $iCnt, $Offset, $FO, $FW, $iCrt = 18
        If $iPath = 1 Then $iCrt = 26
        If Not FileExists($sInFile) Then Return SetError(1, 0, 0)
        If Not IsInt($iIcon) Then Return SetError(2, 0, 0)
        $hInst = _LoadLibraryEx($sInFile, $LOAD_LIBRARY_AS_DATAFILE)
        If Not $hInst Then Return SetError(3, 0, 0)
        _ResourceEnumNames($hInst, $RT_GROUP_ICON)
        For $i = 1 To $aEN[0]
                If $i = StringReplace($iIcon, "-", "") Then
                        $iGN = $aEN[$i]
                        ExitLoop
                EndIf
        Next
        Dim $aEN[1]
        If $iGN = "" Then
                _FreeLibrary($hInst)
                Return SetError(4, 0, 0)
        EndIf
        $sData = _GetIconResource($hInst, $iGN, $RT_GROUP_ICON)
    If @error Then
            _FreeLibrary($hInst)
                Return SetError(5, 0, 0)
        EndIf
        $sHdr = BinaryMid($sData, 1, 6)
        $aHdr = StringRegExp(StringTrimLeft(BinaryMid($sData, 7), 2), "(.{28})", 3)
        $iCnt = UBound($aHdr)
        $Offset = ($iCnt * 16) + 6
        For $i = 0 To $iCnt -1
                Local $sDByte = Dec(_RB(StringMid($aHdr[$i], 17, 8)))
                $sHdr &= StringTrimRight($aHdr[$i], 4) & _RB(Hex($Offset))
                $Offset += $sDByte               
        Next
        For $i = 0 To $iCnt -1
                $sData = _GetIconResource($hInst, "#" & Dec(_RB(StringRight($aHdr[$i], 4))), $RT_ICON)
                If @error Then
                    _FreeLibrary($hInst)
                        Return SetError(6, 0, 0)
                EndIf
                $sHdr &= StringTrimLeft($sData, 2)
        Next        
        _FreeLibrary($hInst)
        $FO = FileOpen($sOutIco, $iCrt)
        If $FO = -1 Then Return SetError(7, 0, 0)
        $FW = FileWrite($FO, $sHdr)
        If $FW = 0 Then
            FileClose($FO)
                Return SetError(8, 0, 0)
        EndIf
        FileClose($FO)
        Return SetError(0, 0, 1)
EndFunc   ;==>_ExtractIconToFile

; ========================================================================================================
; Internal Helper Functions from this point on
; ========================================================================================================
Func _GetIconResource($hModule, $sResName, $iResType)
        Local $hFind, $aSize, $hLoad, $hLock, $tRes, $sRet
        $hFind = DllCall("kernel32.dll", "int", "FindResourceA", "int", $hModule, "str", $sResName, "long", $iResType)
        If @error Or Not $hFind[0] Then Return SetError(1, 0, 0)
        $aSize = DllCall("kernel32.dll", "dword", "SizeofResource", "int", $hModule, "int", $hFind[0])
        If @error Or Not $aSize[0] Then Return SetError(2, 0, 0)
        $hLoad = DllCall("kernel32.dll", "int", "LoadResource", "int", $hModule, "int", $hFind[0])
        If @error Or Not $hLoad[0] Then Return SetError(3, 0, 0)
        $hLock = DllCall("kernel32.dll", "int", "LockResource", "int", $hLoad[0])
        If @error Or Not $hLock[0] Then
                _FreeResource($hLoad[0])
                Return SetError(4, 0, 0)
        EndIf
        $tRes = DllStructCreate("byte[" & $aSize[0] & "]", $hLock[0])
        If Not IsDllStruct($tRes) Then
                _FreeResource($hLoad[0])
                Return SetError(5, 0, 0)
        EndIf
        $sRet = DllStructGetData($tRes, 1)
        If $sRet = "" Then
                _FreeResource($hLoad[0])
                Return SetError(6, 0, 0)
        EndIf
        _FreeResource($hLoad[0])
        Return $sRet
EndFunc        

; Just a Reverse string byte function (smashly style..lol)
Func _RB($sByte)
        Local $aX = StringRegExp($sByte, "(.{2})", 3), $sX = ''
        For $i = UBound($aX) - 1 To 0 Step -1
                $sX &= $aX[$i]
        Next
        Return $sX
EndFunc   ;==>_RB

Func _LoadLibraryEx($sFile, $iFlag)
        Local $aRet = DllCall("Kernel32.dll", "hwnd", "LoadLibraryExA", "str", $sFile, "hwnd", 0, "int", $iFlag)
        Return $aRet[0]
EndFunc   ;==>_LoadLibraryEx

Func _FreeLibrary($hModule)
        DllCall("Kernel32.dll", "hwnd", "FreeLibrary", "hwnd", $hModule)
EndFunc   ;==>_FreeLibrary        

Func _FreeResource($hglbResource)
        DllCall("kernel32.dll", "int", "FreeResource", "int", $hglbResource)
EndFunc   ;==>_FreeResource

Func _ResourceEnumNames($hModule, $iType)
        Local $aRet, $xCB
        If Not $hModule Then Return SetError(1, 0, 0)
        $xCB = DllCallbackRegister('___EnumResNameProc', 'int', 'int_ptr;int_ptr;int_ptr;int_ptr')
        $aRet = DllCall('kernel32.dll', 'int', 'EnumResourceNamesW', 'ptr', $hModule, 'int', $iType, 'ptr', DllCallbackGetPtr($xCB), 'ptr', 0)
        DllCallbackFree($xCB)
        If $aRet[0] <> 1 Then Return SetError(2, 0, 0)
        Return SetError(0, 0, 1)
EndFunc   ;==>_ResourceEnumNames

Func ___EnumResNameProc($hModule, $pType, $pName, $lParam)
        Local $aSize = DllCall('kernel32.dll', 'int', 'GlobalSize', 'ptr', $pName), $tBuf
        If $aSize[0] Then
                $tBuf = DllStructCreate('wchar[' & $aSize[0] & ']', $pName)
                ReDim $aEN[UBound($aEN) + 1]
                $aEN[0] += 1
                $aEN[UBound($aEN) - 1] = DllStructGetData($tBuf, 1)
        Else
                ReDim $aEN[UBound($aEN) + 1]
                $aEN[0] += 1
                $aEN[UBound($aEN) - 1] = "#" & $pName
        EndIf
        Return 1
EndFunc   ;==>___EnumResNameProc
