Global $Stack[50]
Global $Stack1[50]

$Text = ""
FileFindNextFirst("c:\windows")
While 1
  $tempname = FileFindNext()
  If $tempname = "" Then ExitLoop
  $Text &= $tempname & @CRLF
WEnd

MsgBox(4096, '', $Text)

Func FileFindNextFirst($FindCat)
  $Stack[0] = 1
  $Stack1[1] = $FindCat
  $Stack[$Stack[0]] = FileFindFirstFile($Stack1[$Stack[0]] & "\*.*")
  Return $Stack[$Stack[0]]
EndFunc   ;==>FileFindNextFirst

Func FileFindNext()
  While 1
    $file = FileFindNextFile($Stack[$Stack[0]])
    If @error Then
      FileClose($Stack[$Stack[0]])
      If $Stack[0] = 1 Then
        Return ""
      Else
        $Stack[0] -= 1
        ContinueLoop
      EndIf
    Else
      If StringInStr(FileGetAttrib($Stack1[$Stack[0]] & "\" & $file), "D") > 0 Then
        $Stack[0] += 1
        $Stack1[$Stack[0]] = $Stack1[$Stack[0] - 1] & "\" & $file
        $Stack[$Stack[0]] = FileFindFirstFile($Stack1[$Stack[0]] & "\*.*")
        ContinueLoop
      Else
        Return $Stack1[$Stack[0]] & "\" & $file
      EndIf
    EndIf
  WEnd
EndFunc   ;==>FileFindNext