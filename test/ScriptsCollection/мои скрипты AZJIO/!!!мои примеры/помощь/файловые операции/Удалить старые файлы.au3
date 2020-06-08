; Удалить старые файлы
; http://www.autoitscript.com/forum/topic/141609-old-files/#entry996385
; http://www.autoitscript.com/forum/topic/141837-script-to-remove-folders-older-than-x-days/#entry997949
#include <Array.au3>
#include <FileOperations.au3>

Global $TimeDiff = 3600 * 24 * 30
$TimeCurrent = _NowCalc()

$FileList = _FO_FileSearch(@WindowsDir, '*.tmp|*.log')
If @error Then Exit
_ArrayDisplay($FileList, 'File = *.tmp|*.log')

$c = 0
For $i = 1 To $FileList[0]
	$t = FileGetTime($FileList[$i], 1)
	$sTime = $t[0] & '/' & $t[1] & '/' & $t[2] & ' ' & $t[3] & ':' & $t[4] & ':' & $t[5]
	If _DateDiff('s', $sTime, $TimeCurrent) > $TimeDiff Then
		$c += 1
		$FileList[$c] = $FileList[$i]
	EndIf
Next
ReDim $FileList[$c + 1]
$FileList[0] = $c
_ArrayDisplay($FileList, '>month')

If MsgBox(4, '???', 'FileDelete ?') = 6 Then
	$err = ''
	For $i = 1 To $FileList[0]
		If Not FileDelete($FileList[$i]) Then
			If Not (FileSetAttrib($FileList[$i], '-RST') And FileDelete($FileList[$i])) Then
				$err &= $FileList[$i] & @CRLF
			EndIf
		EndIf
	Next
	If $err Then MsgBox(0, 'Error', $err)
EndIf