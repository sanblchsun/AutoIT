_FileCopyEx(@WindowsDir & "\system32\shell32.dll", @ScriptDir & "\shell32.dll") 
 
Func _FileCopyEx($sSource, $sDest) 
    If Not FileExists($sSource) Then Return SetError(1) 
    ProgressOn("_FileCopyEx() Demo", "Копирование, ждите плиз...") 
 
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