
;������ ��������� ���������
MsgBox(0, '���������', '������, ���� ������������')

; ������ ����� ���� � ��������� ��� ����� �������� ����
Dim $SoundName[1][2]
$i=0
While 1
	$i+=1
	ReDim $SoundName[$i+1][2]
    $SoundName[$i][0] = RegEnumKey('HKCU\AppEvents\Schemes\Apps\.Default', $i)
	If @error Then ExitLoop
	$SoundName[$i][1]=RegRead('HKCU\AppEvents\Schemes\Apps\.Default\'&$SoundName[$i][0]&'\.Current','')
	RegWrite('HKCU\AppEvents\Schemes\Apps\.Default\'&$SoundName[$i][0]&'\.Current','',"REG_SZ",'')
WEnd
ReDim $SoundName[$i-1][2]
$SoundName[0][0]=$i-2
;~~~~
;���������� ��������� � �������� ���������� ��������
MsgBox(0, '���������', '����� ���'&@CRLF&$SoundName)
;~~~~
; �������������� �������� ����
For $i = 1 to $SoundName[0][0]
	RegWrite('HKCU\AppEvents\Schemes\Apps\.Default\'&$SoundName[$i][0]&'\.Current','','REG_SZ',$SoundName[$i][1])
Next
MsgBox(0, '���������', '�����, ���� ����������')

