
; ���� ��� ����� ������, ������ ���
If not @ScriptDir&'\arr.txt' Then
$file = FileOpen(@ScriptDir&'\arr.txt' ,2)
FileWrite($file, 'A,B|F,Y|E,W|H,N|T,U|E,V|Y,S')
FileClose($file)
EndIf

; ������ ���� � ������
$fileini=FileRead(@ScriptDir&'\arr.txt')
$aMacciv = StringSplit($fileini, "|")
For $i = 1 to $aMacciv[0]
   $aSubMacciv = StringSplit($aMacciv[$i ], ",")
Next

; ��������� �� ���������� �������� �������
MsgBox(0, "���������", $aSubMacciv[2])

; ����������� � ������� ����� ������������ ��� ������� ����������� � ��������� �������. �������� � ������� ����� ���� �������, ������� �� ����� � ������������. � � ������������ ���������� ������ �����.