; Удалить старые папки
; http://www.autoitscript.com/forum/topic/141837-script-to-remove-folders-older-than-x-days/#entry997949
; http://www.autoitscript.com/forum/topic/141609-old-files/#entry996385

#include <Array.au3>
#include <FileOperations.au3>

Global $TimeDiff = 3600 * 24 * 3
$TimeCurrent = _NowCalc()

$FolderList = _FO_FolderSearch(@TempDir, '*')
If @error Then Exit
_ArrayDisplay($FolderList, 'Folder = *')

$c = 0
For $i = 1 To $FolderList[0]
	$t = FileGetTime($FolderList[$i], 1)
	$sTime = $t[0] & '/' & $t[1] & '/' & $t[2] & ' ' & $t[3] & ':' & $t[4] & ':' & $t[5]
	If _DateDiff('s', $sTime, $TimeCurrent) > $TimeDiff Then
		$c += 1
		$FolderList[$c] = $FolderList[$i]
	EndIf
Next
ReDim $FolderList[$c + 1]
$FolderList[0] = $c
_ArrayDisplay($FolderList, '>3')

If MsgBox(4, '???', 'FileRecycle ?') = 6 Then
	$err = ''
	For $i = 1 To $FolderList[0]
		If Not FileRecycle($FolderList[$i]) Then
			$err &= $FolderList[$i] & @CRLF
		EndIf
	Next
	If $err Then MsgBox(0, 'Error', $err)
EndIf