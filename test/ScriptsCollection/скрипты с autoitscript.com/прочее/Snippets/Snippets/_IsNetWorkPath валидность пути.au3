;Author: JScript - Snippet Version No. = 1.0
;Snippet was Created Using AutoIt Version = 3.3.8.1, Creation Date = 22/05/12.

ConsoleWrite("Is NetWork Path? " & _IsNetWorkPath("C:\windows") & @CRLF)
ConsoleWrite("Is NetWork Path? " & _IsNetWorkPath("\\server\temp") & @CRLF)

Func _IsNetWorkPath($sPath)
    Local $sRet = DllCall("Shlwapi.dll", "BOOL", "PathIsNetworkPath", "str", $sPath)
    Return $sRet[0]
EndFunc   ;==>_IsNetWorkPath