;StringInStr - ����� ���������� ������ �������� �� ���������� �������� � �������. ���� ���� ������, �� ����� ���������� � 1000-100000 ��� ������. ���� ������� �� ������, �� ����� ���� ��������� ���������� ���������. �������� ���������� ��������� "������ ��� ������" � ������ forum.ru-board.com

$Path=@ScriptDir&'\Board.htm'
If Not FileExists($Path) Then Exit
$file = FileOpen($Path, 0)
$text = FileRead($file)
FileClose($file)

$timer = TimerInit()
StringInStr($text, "�������������")
$speed1 = TimerDiff($timer)

$timer = TimerInit()
StringRegExp($text, "�������������")
$speed2 = TimerDiff($timer)

$timer = TimerInit()
StringRegExpReplace ($text, "�������������", 'd')
$kol=@Extended
$speed3 = TimerDiff($timer)

$speed0=$speed1+$speed2+$speed3

MsgBox(0, '����� ���������� �������',  "���������� �������� " & $kol & @CRLF & _
"StringInStr                  " & $speed1 & " ����������, " & Round(100*$speed1/$speed0,2) & "%" & @CRLF & _
"StringRegExp              " & $speed2 & " ����������, " & Round(100*$speed2/$speed0,2) & "%" & @CRLF & _
"StringRegExpReplace " & $speed3 & " ����������, " & Round(100*$speed3/$speed0,2) & "%" & @CRLF)