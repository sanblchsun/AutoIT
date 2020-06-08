#include <DllCallBack.au3>

_FileCopyEx("C:\BigFile.avi", @ScriptDir & "\BigFile.avi")

Func _FileCopyEx($Source, $Dest)
    If Not FileExists($Source) Then Return SetError(1)
    ProgressOn("_FileCopyEx() Demo", "Копирование, ждите плиз...")
    $pCopyProgressRoutine = _DllCallBack("_CopyProgressRoutine", "uint64;uint64;uint64;uint64;dword;dword;ptr;ptr;ptr")
    DllCall("kernel32.dll", "int", "CopyFileExA", _
        "str", $Source, _
        "str", $Dest, _
        "ptr", $pCopyProgressRoutine, _
        "ptr", 0, _
        "int", 0, _
        "int", 0)
    _DllCallBack_Free($pCopyProgressRoutine)
    Sleep(1000)
    ProgressOff()
EndFunc

Func _CopyProgressRoutine($TotalFileSize, $TotalBytesTransferred, $StreamSize, $StreamBytesTransferred, $dwStreamNumber, $dwCallbackReason, $hSourceFile, $hDestinationFile, $lpData)
    $Precent = $TotalBytesTransferred/$TotalFileSize*100
    ProgressSet($Precent, "Проценты: " & Round($Precent, 1) & " %")
    Return 0
EndFunc   ;==>_CopyProgressRoutine