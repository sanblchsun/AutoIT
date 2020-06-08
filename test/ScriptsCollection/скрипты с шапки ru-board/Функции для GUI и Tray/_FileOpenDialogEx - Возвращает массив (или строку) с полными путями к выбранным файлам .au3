$aAllFiles = _FileOpenDialogEx("Select all files", @ScriptDir & "\system\", "Все файлы (*.*)", 1+4)

If Not @error Then
    $iFileCount = $aAllFiles[0]

    For $i = 1 To $aAllFiles[0]
        IniWrite(@ScriptDir & "\NoFileCheck.ini", "files", $i, $aAllFiles[$i])
    Next
EndIf

;$iReturnMode = -1 (default) - Return array of selected files
;$iReturnMode = 1 (default) - Return string of selected files (all files returned as full file pathes)
Func _FileOpenDialogEx($sTitle, $sInitDir, $sFilter, $iOptions=0, $iReturnMode=-1, $sDefaultName='', $hWnd=0)
    Local $sFOD_Ret = FileOpenDialog($sTitle, $sInitDir, $sFilter, $iOptions, $sDefaultName, $hWnd)
    If @error Then Return SetError(@error, @extended, $sFOD_Ret)

    Local $sRet = ''
    Local $aSplit_Str = StringSplit($sFOD_Ret, '|')

    If @error Or $aSplit_Str[0] < 2 Then
        If $iReturnMode > 0 Then Return $sFOD_Ret
        Return $aSplit_Str
    EndIf

    Local $sInit_Path = StringRegExpReplace($aSplit_Str[1], '([^\\])\\*$', '\1')

    For $i = 2 To $aSplit_Str[0]
        $sRet &= $sInit_Path & '\' & $aSplit_Str[$i] & '|'
    Next

    $sRet = StringRegExpReplace($sRet, '\|+$', '')
    If $iReturnMode > 0 Then Return $sRet

    Return StringSplit($sRet, '|')
EndFunc