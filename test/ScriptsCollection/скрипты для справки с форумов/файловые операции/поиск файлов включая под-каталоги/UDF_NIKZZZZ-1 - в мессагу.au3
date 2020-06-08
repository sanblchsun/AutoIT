; #Example# *********************************************************************************************************************
$search = _FileFindFirstFile("c:\Program Files\Internet Explorer\*.exe",1)
If $search = -1 Then
    ConsoleWrite("No files/directories matched the search pattern" & @CRLF)
    Exit
EndIf
$z=''
While 1
    $file = _FileFindNextFile($search)
    If @error Then ExitLoop
    $z&=$file & @CRLF
WEnd
_FileFindClose($search)
MsgBox(0, 'Сообщение', $z)
;********************************************************************************************************************************

; #INDEX# =======================================================================================================================
; Title .........: FileFind
; AutoIt Version : 3.2.3++
; Language ......: Русский
; Description ...: Поиск файлов, включая подкаталоги, синтаксис и возвращаемое значение совпадают с FileFindFirstFile()
;                  FileFindNextFile(), в FileFindFirstFile("filename" [,flag]) добавлен необязатенльный параметр flag
;                  flag=1 - поиск файлов
;                  flag=2 - поиск каталогов , по умолчанию flag=3
; Author(s) .....: Nikzzzz
; ===============================================================================================================================

Func _FileFindFirstFile($sFile,$iMode=3)
    Local $avStack[5]
    $avStack[0] = 0
    $avStack[1] = StringMid($sFile, StringInStr($sFile, "\", 0, -1) + 1)
    $avStack[1] = StringRegExpReplace($avStack[1], "[\\\(\)\{\}\+\$\.]", "\\\0")
    $avStack[1] = StringReplace($avStack[1], "*", ".*")
    $avStack[1] = StringReplace($avStack[1], "?", ".")
    $avStack[2] = $iMode
    $avStack[3] = StringLeft($sFile, StringInStr($sFile, "\", 0, -1) - 1)
    $avStack[4] = FileFindFirstFile($avStack[3] & "\*.*")
    If $avStack[4] = -1 Then
        SetError(1)
        Return -1
    EndIf
    Return $avStack
EndFunc   ;==>_FileFindFirstFile

Func _FileFindNextFile(ByRef $avStack)
    Local $sFindFile
    While 1
        $sFindFile = FileFindNextFile($avStack[$avStack[0] + 4])
        If Not @error Then
            If StringInStr(FileGetAttrib($avStack[$avStack[0] + 3] & "\" & $sFindFile), "D") > 0 Then
                $avStack[0] += 2
                ReDim $avStack[$avStack[0] + 5]
                $avStack[$avStack[0] + 3] = $avStack[$avStack[0]+1] & "\" & $sFindFile
                $avStack[$avStack[0] + 4] = FileFindFirstFile($avStack[$avStack[0] + 3] & "\*.*")
                If BitAND($avStack[2],2) Then Return StringMid($avStack[$avStack[0] + 3], StringLen($avStack[3]) + 2)
                ContinueLoop
            Else
                If StringRegExpReplace($sFindFile, $avStack[1], "") = "" Then
                    SetError(0)
                    If BitAND($avStack[2],1) Then Return StringMid($avStack[$avStack[0] + 3] & "\" & $sFindFile, StringLen($avStack[3]) + 2)
                Else
                    ContinueLoop
                EndIf
            EndIf
        Else
            If $avStack[0] = 0 Then
                SetError(-1)
                Return ""
            Else
                FileClose($avStack[$avStack[0] + 4])
                $avStack[0] -= 2
                ReDim $avStack[$avStack[0] + 5]
            EndIf
        EndIf
    WEnd
EndFunc   ;==>_FileFindNextFile

Func _FileFindClose(ByRef $avStack)
    Local $iRetVaue
    While $avStack[0] >= 0
        $iRetVaue=FileClose($avStack[$avStack[0] + 4])
        $avStack[0] -= 2
    WEnd
    ReDim $avStack[1]
    Return $iRetVaue
EndFunc   ;==>_FileFindClose