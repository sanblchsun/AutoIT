;Author: JScript - Snippet Version No. = 1.0
;Snippet was Created Using AutoIt Version = 3.3.8.1, Creation Date = 22/05/12.

ConsoleWrite("The truncated path: " & _TruncatePath(@SystemDir & "\Config\ProFiles", 140) & @CRLF)

Func _TruncatePath($sPath, $iValue)
    Local $sRet = DllCall("Shlwapi.dll", "BOOL", "PathCompactPath", "int", 0, "str", $sPath, "uint", $iValue)
    Return $sRet[2]
EndFunc   ;==>_TruncatePath