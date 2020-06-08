; Author: Rutger83
; Recursive Fibonacci Sequence

Global $n, $n1, $n0
#AutoIt Version: 3.2.10.0
$n0 = 0
$n1 = 1
$n = 10
MsgBox(0, "Recursive Fibonacci ", rec_febo($n0, $n1, $n))
Func rec_febo($r_0, $r_1, $R)
	If $R < 3 Then
		If $R == 2 Then
			Return $r_1
		ElseIf $R == 1 Then
			Return $r_0
		ElseIf $R == 0 Then
			Return 0
		EndIf
		Return $R
	Else
		Return rec_febo($r_0, $r_1, $R - 1) + rec_febo($r_0, $r_1, $R - 2)
	EndIf
EndFunc   ;==>rec_febo