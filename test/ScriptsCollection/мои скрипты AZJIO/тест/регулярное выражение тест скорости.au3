;StringInStr - время выполнения сильно зависимо от количества символов в шаблоне. Если один символ, то время выполнения в 1000-100000 раз меньше. Если образец не найден, то время даже превышает регулярное выражение. Проверте сохранённую страничку "Версия для печати" с форума forum.ru-board.com

$Path=@ScriptDir&'\Board.htm'
If Not FileExists($Path) Then Exit
$file = FileOpen($Path, 0)
$text = FileRead($file)
FileClose($file)

$timer = TimerInit()
StringInStr($text, "Редактировать")
$speed1 = TimerDiff($timer)

$timer = TimerInit()
StringRegExp($text, "Редактировать")
$speed2 = TimerDiff($timer)

$timer = TimerInit()
StringRegExpReplace ($text, "Редактировать", 'd')
$kol=@Extended
$speed3 = TimerDiff($timer)

$speed0=$speed1+$speed2+$speed3

MsgBox(0, 'Время выполнения функции',  "количество итераций " & $kol & @CRLF & _
"StringInStr                  " & $speed1 & " милисекунд, " & Round(100*$speed1/$speed0,2) & "%" & @CRLF & _
"StringRegExp              " & $speed2 & " милисекунд, " & Round(100*$speed2/$speed0,2) & "%" & @CRLF & _
"StringRegExpReplace " & $speed3 & " милисекунд, " & Round(100*$speed3/$speed0,2) & "%" & @CRLF)