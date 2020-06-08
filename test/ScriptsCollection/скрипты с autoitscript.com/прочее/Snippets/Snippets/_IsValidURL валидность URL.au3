;Author: JScript - Snippet Version No. = 1.0
;Snippet was Created Using AutoIt Version = 3.3.8.1, Creation Date = 22/05/12.

ConsoleWrite("Is Valid URL? " & _IsValidURL("http:\\www.autoitscript.com") & @CRLF)
ConsoleWrite("Is Valid URL? " & _IsValidURL("www.autoitscript.com") & @CRLF)

Func _IsValidURL($sPath)
    Local $sRet = DllCall("Shlwapi.dll", "BOOL", "PathIsURL", "str", $sPath)
    Return $sRet[0]
EndFunc   ;==>_IsValidURL