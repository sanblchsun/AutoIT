; #Example# *********************************************************************************************************************
$search = _FileFindFirstFile("c:\Program Files\Internet Explorer\*.*")
If $search = -1 Then
    ConsoleWrite("No files/directories matched the search pattern" & @CRLF)
    Exit
EndIf
While 1
    $file = _FileFindNextFile($search)
    If @error Then ExitLoop
    ConsoleWrite("Find file -  " & $file & @CRLF)
WEnd
_FileFindClose($search)
;********************************************************************************************************************************

; #INDEX# =======================================================================================================================
; Title .........: FileFind
; AutoIt Version : 3.2.3++
; Language ......: Русский
; Description ...: Поиск файлов, включая подкаталоги, синтаксис и возвращаемое значение совпадают с FileFindFirstFile()
;                  FileFindNextFile(), отличие - ищутся только файлы
; Author(s) .....: Nikzzzz
; ===============================================================================================================================

Func _FileFindFirstFile($sFile)
    Local $avStack[4]
    $avStack[0] = 0
    $avStack[1] = StringMid($sFile, StringInStr($sFile, "\", 0, -1) + 1)
    $avStack[1] = StringRegExpReplace($avStack[1], "[\\\(\)\{\}\+\$\.]", "\\\0")
    $avStack[1] = StringReplace($avStack[1], "*", ".*")
    $avStack[1] = StringReplace($avStack[1], "?", ".")
    $avStack[2] = StringLeft($sFile, StringInStr($sFile, "\", 0, -1) - 1)
    $avStack[3] = FileFindFirstFile($avStack[2] & "\*.*")
    If $avStack[2] = -1 Then
        SetError(1)
        Return -1
    EndIf
    Return $avStack
EndFunc   ;==>_FileFindFirstFile

Func _FileFindNextFile(ByRef $avStack)
    Local $sFindFile
    While 1
        $sFindFile = FileFindNextFile($avStack[$avStack[0] + 3])
        If Not @error Then
            If StringInStr(FileGetAttrib($avStack[$avStack[0] + 2] & "\" & $sFindFile), "D") > 0 Then
                $avStack[0] += 2
                ReDim $avStack[$avStack[0] + 4]
                $avStack[$avStack[0] + 2] = $avStack[$avStack[0]] & "\" & $sFindFile
                $avStack[$avStack[0] + 3] = FileFindFirstFile($avStack[$avStack[0] + 2] & "\*.*")
                ContinueLoop
            Else
                If StringRegExpReplace($sFindFile, $avStack[1], "") = "" Then
                    SetError(0)
                    Return StringMid($avStack[$avStack[0] + 2] & "\" & $sFindFile, StringLen($avStack[2]) + 2)
                Else
                    ContinueLoop
                EndIf
            EndIf
        Else
            If $avStack[0] = 0 Then
                SetError(-1)
                Return ""
            Else
                FileClose($avStack[$avStack[0] + 3])
                $avStack[0] -= 2
                ReDim $avStack[$avStack[0] + 4]
            EndIf
        EndIf
    WEnd
EndFunc   ;==>_FileFindNextFile

Func _FileFindClose(ByRef $avStack)
    Local $iRetVaue
    While $avStack[0] >= 0
        $iRetVaue=FileClose($avStack[$avStack[0] + 3])
        $avStack[0] -= 2
    WEnd
    ReDim $avStack[1]
    Return $iRetVaue
EndFunc   ;==>_FileFindClose