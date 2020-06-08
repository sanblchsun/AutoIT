Local $FileList = ''
$timer = TimerInit()
_FileSearch(@WindowsDir, $FileList)
MsgBox(0, "Time", 'Time : ' & Round(TimerDiff($timer) / 1000, 2) & ' sec')

$file = FileOpen(@ScriptDir & '\file.txt', 2)
FileWrite($file, $FileList)
FileClose($file)

Func _FileSearch($sPath, ByRef $FileList)
	If StringRight($sPath, 1) <> '\' Then $sPath &= '\'
	If Not FileExists($sPath) Then Return SetError(1, 0, '')
	If StringInStr($sPath, '/') Then Return SetError(1, 0, '')
	Local $hSearch, $c=0
	$hSearch=FileFindFirstFile($sPath & "*")
	If $hSearch = -1 Then Return SetError(3, 0, '')
	Local $aSearchList[125][2] = [[$hSearch, $sPath]], $sName
	
	Do
		$sPath = $aSearchList[$c][1]
		$sName = FileFindNextFile($aSearchList[$c][0])
		If @error Then
			FileClose($aSearchList[$c][0])
			$c -= 1
			ContinueLoop
		EndIf
		If @extended Then
			$c += 1
			$aSearchList[$c][1] = $sPath & $sName & "\"
			$aSearchList[$c][0] = FileFindFirstFile($aSearchList[$c][1] & "*")
			ContinueLoop
		Else
			$FileList &= $sPath & $sName & @CRLF
		EndIf
	Until $c < 0

	$FileList = StringTrimRight($FileList, 2)
	If Not $FileList Then Return SetError(3, 0, '')
EndFunc