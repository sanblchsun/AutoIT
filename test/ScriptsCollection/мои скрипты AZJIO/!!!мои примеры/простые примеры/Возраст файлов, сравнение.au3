
$file01='D:\file1.au3'
$file02='D:\file2.au3'
If Not (FileExists($file01) Or FileExists($file02)) Then
	MsgBox(0, "���������", '����������� ����� ��� ���������')
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
			$t='����1 - ������='&$file1[$i]&@CRLF&'����2 - ������='&$file2[$i]&@CRLF&_S($i)
			ExitLoop
		Else
			$t='����1 - ������='&$file1[$i]&@CRLF&'����2 - ������='&$file2[$i]&@CRLF&_S($i)
			ExitLoop
		EndIf
	EndIf
Next

MsgBox(0, "���������", $t)

Func _S($i)
	Switch $i
		Case 0
		   Return '(���)'
		Case 1
		   Return '(�����)'
		Case 2
		   Return '(����)'
		Case 3
		   Return '(���)'
		Case 4
		   Return '(������)'
		Case 5
		   Return '(�������)'
	EndSwitch
EndFunc