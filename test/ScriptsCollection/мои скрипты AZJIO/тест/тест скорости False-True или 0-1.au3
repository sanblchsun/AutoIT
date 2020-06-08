MsgBox(0,"Тест", 'Начинаем')
$z=0
$timer = TimerInit()
For $i = 1 to 1000000
	If $z=False Then
		$z=True
	Else
		$z=False
	EndIf
Next
MsgBox(0,"Время выполнения", Round(TimerDiff($timer) / 1000, 2) & ' сек')

$z=0
$timer = TimerInit()
For $i = 1 to 1000000
	If $z=1 Then
		$z=0
	Else
		$z=1
	EndIf
Next
MsgBox(0,"Время выполнения", Round(TimerDiff($timer) / 1000, 2) & ' сек')