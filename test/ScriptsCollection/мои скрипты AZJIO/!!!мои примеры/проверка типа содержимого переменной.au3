;If IsAdmin() Then MsgBox(0, "", "�� �����")


$test = '�������� ��� � ��� ���������, ��������� ���� ����������.'

If IsBinary($test) Then MsgBox(0, '���������', "��������")
if isBool($test) then Msgbox(0, '���������', "���������� (true, false)")
if IsDllStruct($test) Then MsgBox(0, '���������', "DLL-���������")
if IsFloat($test) Then MsgBox(0, '���������', "� ��������� �������")
if IsHWnd($test) Then MsgBox(0, '���������', "��� HWnd")
if IsNumber($test) Then MsgBox(0, '���������', "��� �����")
if IsInt($test) Then MsgBox(0, '���������', "����� �����")
if IsKeyword($test) Then MsgBox(0, '���������', "�������� �����")
if IsObj($test) Then MsgBox(0, '���������', "������")
if IsString($test) Then MsgBox(0, '���������', "�����")
; ������ if ($test) Then MsgBox(0, '���������', "")





; �������� � ������� VarGetType
Dim $Var[11][2] = [ _
['Array','������'&@CRLF&'Array'], _
['Binary','��������'&@CRLF&'Binary'], _
['Bool','���������� (true, false)'&@CRLF&'Bool'], _
['DLLStruct','DLL-���������'&@CRLF&'DLLStruct'], _
['Double','� ��������� �������'&@CRLF&'Double'], _
['Ptr','HWnd - �����, ����������'&@CRLF&'Ptr'], _
['-','-'], _
['Int32','����� �����'&@CRLF&'Int32'], _
['Keyword','�������� �����'&@CRLF&'Keyword'], _
['Object','������'&@CRLF&'Object'], _
['String','�����'&@CRLF&'String'] _
]

$Var1=VarGetType($test)
For $i = 0 to 10
	If $Var1 = $Var[$i][0] Then
		$Var1 = $Var[$i][1]
		ExitLoop
	EndIf
Next

MsgBox(0, 'VarGetType', $Var1)