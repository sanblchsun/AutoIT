$sOrg = "C:\Some.Folder\some.file.ext"
$sAdd = "_backup"
 
$sNew = _PathAppendToFilename($sOrg, $sAdd)
 
$sStripped = _PathStripRightFromFilename($sNew, $sAdd)
 
MsgBox(0, "", $sOrg & @CRLF & $sAdd & @CRLF & $sNew & @CRLF & $sStripped)
 
Func _PathAppendToFilename($sName, $sAppend)
    ; Author: ProgAndy
    If StringRegExp($sAppend, '[\/\\:\?"<>\|\*]') Then Return SetError(1, 0, $sName)
    Return StringRegExpReplace($sName, "(\.[^\\/\.]+)$", $sAppend & "\1", 1)
EndFunc
 
Func _PathStripRightFromFilename($sName, $sStrip)
    ; Author: ProgAndy
    If StringRegExp($sStrip, '[\/\\:\?"<>\|\*]') Then Return SetError(1, 0, $sName)
    Return StringRegExpReplace($sName, "\Q" & $sStrip & "\E(\.[^\\/\.]+)$", "\1", 1)
EndFunc