#NoTrayIcon

Global $Stack[50]
Global $Stack1[50]

$Source1="C:\PePrograms"
$Out1="C:\PePrograms1"

If FileExists($Source1) Then
  FileFindNextFirst($Source1)
  While 1 
	 $tempname = FileFindNext()
	 If $tempname = "" Then ExitLoop
	 $sTarget = StringTrimLeft($tempname, StringLen($Source1))
	 $aPath = StringRegExp($Out1&$sTarget, "(^.*)\\(.*)$", 3)
     If Not FileExists($aPath[0]) Then DirCreate($aPath[0])
	 _FileCopyEx($tempname, $Out1&$sTarget)
  WEnd
 EndIf



 
Func _FileCopyEx($sSource, $sDest) 
    If Not FileExists($sSource) Then Return SetError(1) 
    ProgressOn("Копируем", "Копирование, ждите плиз...") 
 
    Local $hCopyProgressRoutine = DllCallbackRegister("_CopyProgressRoutine", "int", _ 
        "uint64;uint64;uint64;uint64;dword;dword;ptr;ptr;ptr") 
 
    DllCall("kernel32.dll", "int", "CopyFileExA", _ 
        "str", $sSource, _ 
        "str", $sDest, _ 
        "ptr", DllCallbackGetPtr($hCopyProgressRoutine), _ 
        "ptr", 0, _ 
        "int", 0, _ 
        "int", 0) 
 
    DllCallBackFree($hCopyProgressRoutine) 
 
    Sleep(1000) 
 
    ProgressOff() 
EndFunc 
 
Func _CopyProgressRoutine($TotalFileSize, $TotalBytesTransferred, $StreamSize, $StreamBytesTransferred, $dwStreamNumber, $dwCallbackReason, $hSourceFile, $hDestinationFile, $lpData) 
 
    Local $iPrecent = $TotalBytesTransferred/$TotalFileSize * 100 
    ProgressSet($iPrecent, "Проценты: " & Round($iPrecent, 1) & " %") 
 
    Return 0 
EndFunc


; функция поиска всех файлов в каталоге
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