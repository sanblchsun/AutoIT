
$file01='D:\file1.au3'
$file02='D:\file2.au3'
If Not (FileExists($file01) Or FileExists($file02)) Then
	MsgBox(0, "Сравнение", 'Отсутствуют файлы для сравнения')
	Exit
EndIf

$file1=FileGetTime($file01)
$file2=FileGetTime($file02)

$t=''
For $i = 0 to UBound($file1)-1
	If Int($file1[$i]) == Int($file2[$i] ) Then
		$t='no'
		ContinueLoop
	Else
		If Int($file1[$i]) < Int($file2[$i] ) Then
			$t='Файл1 - старше='&$file1[$i]&@CRLF&'Файл2 - младше='&$file2[$i]&@CRLF&_S($i)
			ExitLoop
		Else
			$t='Файл1 - младше='&$file1[$i]&@CRLF&'Файл2 - старше='&$file2[$i]&@CRLF&_S($i)
			ExitLoop
		EndIf
	EndIf
Next

MsgBox(0, "Сравнение", $t)

Func _S($i)
	Switch $i
		Case 0
		   Return '(год)'
		Case 1
		   Return '(месяц)'
		Case 2
		   Return '(день)'
		Case 3
		   Return '(час)'
		Case 4
		   Return '(минуты)'
		Case 5
		   Return '(секунды)'
	EndSwitch
EndFunc