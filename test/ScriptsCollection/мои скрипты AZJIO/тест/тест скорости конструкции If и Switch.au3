; ������� � ��� ����. �������� ���-������� ��� �������� �������� (����-������� ��������� 3000���)
$k=67
MsgBox(0,"����", '��������')
$z=0
$timer = TimerInit()
For $i = 1 to 100000
	If $k=3 Or $k=8 Or $k=12 Or $k=43 Or $k=67 Then
		$z+=1
	EndIf
Next
MsgBox(0,"����� ����������", Round(TimerDiff($timer) / 1000, 2) & ' ���'&@CRLF& $z)

$z=0
$timer = TimerInit()
For $i = 1 to 100000
	Switch $k
		Case 3,8,12,43,67
		   $z+=1
	EndSwitch
Next
MsgBox(0,"����� ����������", Round(TimerDiff($timer) / 1000, 2) & ' ���'&@CRLF& $z)