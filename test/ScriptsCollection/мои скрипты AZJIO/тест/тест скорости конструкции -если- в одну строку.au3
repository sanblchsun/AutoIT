; Разница в два раза. Экономия пол-секунды для миллиона итераций (двух-ядерный процессор 3000МГц)

MsgBox(0,"Тест", 'Начинаем - 1')
$z=0
$timer = TimerInit()
For $i = 1 to 1000000
	If 1 Then $z=False
Next
MsgBox(0,"Время выполнения", Round(TimerDiff($timer) / 1000, 2) & ' сек')

$z=0
$timer = TimerInit()
For $i = 1 to 1000000
	If 1 Then
		$z=False
	EndIf
Next
MsgBox(0,"Время выполнения", Round(TimerDiff($timer) / 1000, 2) & ' сек')


; при логическом False в условии комбинация в одну строку работает быстрее, поэтому цикл содержащий вероятное условие False и однократный True для выхода из цикла -  лучше делать одной строкой.
MsgBox(0,"Тест", 'Начинаем - 2')
$z=0
$timer = TimerInit()
For $i = 1 to 1000000
	If 0 Then $z=False
Next
MsgBox(0,"Время выполнения", Round(TimerDiff($timer) / 1000, 2) & ' сек')

$z=0
$timer = TimerInit()
For $i = 1 to 1000000
	If 0 Then
		$z=False
	EndIf
Next
MsgBox(0,"Время выполнения", Round(TimerDiff($timer) / 1000, 2) & ' сек')