; #include <Array.au3> ; ��� _ArrayDisplay
; ������ ������:
; 07.06.2011 8:01 62.80.230.41 ���.���.���.��� TCP 3389 1875 0,022325 10
; 07.06.2011 8:01 81.23.3.110 ���.���.���.��� TCP 3389 1987 0,022293 10

$text = FileRead(@ScriptDir&'\������.txt')
If StringInStr($text, @LF) Then
	$aText=StringSplit(StringStripCR(StringStripWS($text, 7)), @LF) ; ����� ������ ��������� � ������, ������ ������� @CR � ������ �������
Else
	$aText=StringSplit(StringStripWS($text, 7), @CR)
EndIf

Global $aTable[$aText[0]+1][9] ; ������ ����� ������ � 9-� ���������
$aTable[0][0]=$aText[0]

; ��������� ������ 9-�� ����������, ��������� ������ �� ������� �� ��������
For $i = 1 to $aText[0]
	$aTmp=StringSplit($aText[$i], ' ')
	For $j = 1 to $aTmp[0]
		$aTable[$i][$j-1]=$aTmp[$j]
	Next
Next

$aOut=_Calculate($aTable) ; ������� ��������
; _ArrayDisplay($aOut, 'aOut')
$Out=''
For $i = 1 to $aOut[0][0] ; ����������� ������� � ������������� �����
	$aOut[$i][0]&=@TAB&$aOut[$i][1]
	$Out&=$aOut[$i][0]&@CRLF
Next

$file = FileOpen(@ScriptDir&'\����� ������.txt',2) ; ���������� � ����
FileWrite($file, $Out)
FileClose($file)

Func _Calculate($a)
	Local $k, $ind, $i
	If Not IsArray($a) Or UBound($a)<2 Then SetError(1, 0, '�������� �������') ; �������� ���������� �������

	$ind='_//' ; ������ ��� ������������� � ����������� �������
	Assign($ind, 2, 1)

	$k=0
	For $i = 1 To $a[0][0]
		If Not IsDeclared($a[$i][2]&$ind) Then
			$k+=1
			$a[$k][0]=$a[$i][2]
		EndIf
		Assign($a[$i][2]&$ind, Eval($a[$i][2]&$ind)+StringReplace($a[$i][7], ',', '.'), 1) ; ������ ��������� ���������� ��� ����������� �������� ��� ��� ���������
	Next
	
	If $k = 0 Then Return SetError(1, 0, '�������� �������')
	ReDim $a[$k+1][2]
	For $i = 1 to $k
		$a[$i][1]=Eval($a[$i][0]&$ind)
	Next
	$a[0][0]=$k
	Return $a
EndFunc