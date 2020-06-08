; Author: Rutger83
; Iterative Fibonacci Sequence

Global $n, $n1, $n0
#AutoIt Version: 3.2.10.0
$n0 = 0
$n1 = 1
$n = 10
MsgBox(0, "Iterative Fibonacci ", it_febo($n0, $n1, $n))

Func it_febo($n_0, $n_1, $n)
	Local $first = $n_0
	Local $second = $n_1
	Local $next = $first + $second
	Local $febo = 0
	For $i = 1 To $n - 3
		$first = $second
		$second = $next
		$next = $first + $second
	Next
	If $n == 0 Then
		$febo = 0
	ElseIf $n == 1 Then
		$febo = $n_0
	ElseIf $n == 2 Then
		$febo = $n_1
	Else
		$febo = $next
	EndIf
	Return $febo
EndFunc   ;==>it_febo