
MsgBox(0, "���������", '������ ��� ������ ������ �������')
Exit; ������ ��� ������
; ���������� ��� ������ ����� � ������� ����� �� ������ ���� ���� ����������

; ����� �������, � ������� ������������ ������, ����� ��� �� ���� ������, ������� ���������� ����� �����.
Local $name, $i = 0
Do
    $i+=1
	$name=@TempDir&'\d8r0m4d'&$i&'z'&Random(1,1000,1)&'.au3'
Until Not FileExists($name)

;�������1
; ���������� ��� ������ ����� � ������� ����� �� ������ ���� ���� ����������
; � ����� ������� ����������� ����������� 200, ������ ���� ���������� ������ ������, �� ������ �� �������� ����� ������.
For $i=1 To 200
	If Not FileExists($aRegfileS1[1]&'_BAK'&$i&'.reg') and Not FileExists($aRegfileS1[1]&'_DEL'&$i&'.reg') Then
		$filename=$aRegfileS1[1]&'_BAK'&$i&'.reg'
		$delname=$aRegfileS1[1]&'_DEL'&$i&'.reg'
		ExitLoop
	EndIf
Next

;�������2
; ���� ������� ����� Until ���������, �� ����� �� ����� Do-Until
$i = 0
Do
    $i+=1
Until Not FileExists($aRegfileS1[1]&'_BAK'&$i&'.reg') and Not FileExists($aRegfileS1[1]&'_DEL'&$i&'.reg')
$filename=$aRegfileS1[1]&'_BAK'&$i&'.reg'
$delname=$aRegfileS1[1]&'_DEL'&$i&'.reg'

;�������3
; ����� ������ While: ���� ������� �����, �� ��������� ����, ����� �� ���������.
$i = 0
While FileExists($aRegfileS1[1]&'_BAK'&$i&'.reg') or FileExists($aRegfileS1[1]&'_DEL'&$i&'.reg')
    $i+=1
WEnd
$filename=$aRegfileS1[1]&'_BAK'&$i&'.reg'
$delname=$aRegfileS1[1]&'_DEL'&$i&'.reg'

