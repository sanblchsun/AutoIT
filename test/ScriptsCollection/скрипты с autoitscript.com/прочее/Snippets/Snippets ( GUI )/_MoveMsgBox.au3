; Move Message Box

$sTitle = 'Сообщение'
MsgBox(0, $sTitle, 'text')
Opt("WinTitleMatchMode", 3)
WinMove($sTitle, '', 11, 33)
 
_MoveMsgBox(0, "testTitle", "testText", 0, 10)
 
Func _MoveMsgBox($MBFlag, $MBTitle, $MBText, $x, $y)
    Local $file = FileOpen(EnvGet("temp") & "\MoveMB.au3", 2)
    If $file = -1 Then Return;if error, give up on the move
 
    Local $line1 = 'AutoItSetOption(' & '"WinWaitDelay", 0' & ')'
    Local $line2 = 'WinWait("' & $MBTitle & '", "' & $MBText & '")'
    Local $line3 = 'WinMove("' & $MBTitle & '", "' & $MBText & '"' & ', ' & $x & ', ' & $y & ')'
    FileWrite($file, $line1 & @CRLF & $line2 & @CRLF & $line3)
    FileClose($file)
 
    Run(@AutoItExe & " /AutoIt3ExecuteScript " & EnvGet("temp") & "\MoveMB.au3")
 
	Local $result = MsgBox($MBFlag, $MBTitle, $MBText)
;~     MsgBox($MBFlag, $MBTitle, $MBText)
 
    FileDelete(EnvGet("temp") & "\MoveMB.au3")
	Return ($result)
EndFunc;==>_MoveMsgBox