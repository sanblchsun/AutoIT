MsgBox(0,"����", '��������')
$z=0
$timer = TimerInit()
For $i = 1 to 1000000
	If $z=False Then
		$z=True
	Else
		$z=False
	EndIf
Next
MsgBox(0,"����� ����������", Round(TimerDiff($timer) / 1000, 2) & ' ���')

$z=0
$timer = TimerInit()
For $i = 1 to 1000000
	If $z=1 Then
		$z=0
	Else
		$z=1
	EndIf
Next
MsgBox(0,"����� ����������", Round(TimerDiff($timer) / 1000, 2) & ' ���')