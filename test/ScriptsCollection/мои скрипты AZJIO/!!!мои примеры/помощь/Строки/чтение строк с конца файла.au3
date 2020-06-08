
; http://www.autoitscript.com/forum/topic/143295-filereadline-can-you-read-second-last-line/page__st__20#entry1009463
; Вариант 1
#include <FileConstants.au3>
$Pos = 200

$hFile = FileOpen(@ScriptFullPath)

FileSetPos($hFile, -$Pos, $FILE_END)
$sText = FileRead($hFile)
FileClose($hFile)

While 1
	$string = _ReadString($Pos)
	MsgBox(0, '', $string)
	; ClipPut($string)
	If $Pos < 1 Then ExitLoop
WEnd

Func _ReadString(ByRef $Pos)
	$TmpPos = StringInStr($sText, @CRLF, 0, -1, $Pos, $Pos)
	$string = StringMid($sText, $TmpPos + 2, $Pos - $TmpPos - 2)
	$Pos = $TmpPos
	Return $string
EndFunc

; Вариант 2
$aString = StringSplit(FileRead(@ScriptFullPath), @CRLF, 1) ; деление на строки
For $i = 0 To 4
	MsgBox(0, $i & ' строка с конца', $aString[$aString[0] - $i])
Next