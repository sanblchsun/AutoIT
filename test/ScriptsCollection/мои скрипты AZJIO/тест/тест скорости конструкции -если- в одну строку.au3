; ������� � ��� ����. �������� ���-������� ��� �������� �������� (����-������� ��������� 3000���)

MsgBox(0,"����", '�������� - 1')
$z=0
$timer = TimerInit()
For $i = 1 to 1000000
	If 1 Then $z=False
Next
MsgBox(0,"����� ����������", Round(TimerDiff($timer) / 1000, 2) & ' ���')

$z=0
$timer = TimerInit()
For $i = 1 to 1000000
	If 1 Then
		$z=False
	EndIf
Next
MsgBox(0,"����� ����������", Round(TimerDiff($timer) / 1000, 2) & ' ���')


; ��� ���������� False � ������� ���������� � ���� ������ �������� �������, ������� ���� ���������� ��������� ������� False � ����������� True ��� ������ �� ����� -  ����� ������ ����� �������.
MsgBox(0,"����", '�������� - 2')
$z=0
$timer = TimerInit()
For $i = 1 to 1000000
	If 0 Then $z=False
Next
MsgBox(0,"����� ����������", Round(TimerDiff($timer) / 1000, 2) & ' ���')

$z=0
$timer = TimerInit()
For $i = 1 to 1000000
	If 0 Then
		$z=False
	EndIf
Next
MsgBox(0,"����� ����������", Round(TimerDiff($timer) / 1000, 2) & ' ���')