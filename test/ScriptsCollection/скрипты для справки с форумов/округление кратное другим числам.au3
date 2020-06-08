$step = 3
$number = 458
$number = Round($number / $step) * $step

$number1 = 457
$number1 = Round($number1 / $step) * $step
MsgBox(0, 'Сообщение', $number & @LF & $number1)