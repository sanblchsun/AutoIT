#include <Array.au3>

$a = StringRegExp('qwertyuiop[]asdfghjkl;zxcvbnm�����������������������\���������.1234567890','(.{3})',3)
Dim $b[UBound($a)][3]
For $i = 0 to UBound($b)-1
	$tmp = StringSplit($a[$i], '')
	$b[$i][0]=$tmp[1]
	$b[$i][1]=$tmp[2]
	$b[$i][2]=$tmp[3]
Next
_ArrayDisplay($b, '������ ������')

; ������������ ������ � �����
; $sep1='#'
$sep1='}���{' ; ����������� �� ������ ��������� � ������/�������
$sep2=@CRLF ; ������� ������ � �������� ����������� ������ ����������� �����
$L1=StringLen($sep1) ; ���������� ������ ����������� ��� ������� � ����� ������
$L2=StringLen($sep2) ; ���������� ������ ����������� ��� ������� � ����� ������
$txt='' ; ����� ����������, ������� ����� ��������� ������� ������ ��� ������ � ����
For $i = 0 to UBound($b)-1
	For $j = 0 to 2 ; ����� ������� ��� �������� - 3
		$txt&=$b[$i][$j]&$sep1 ; ������������ ��������� ����� � $sep1 - �����������
	Next
	$txt=StringTrimRight($txt, $L1) ; �������� �������� ����������� ������
	$txt&=$sep2 ; ��������� ����������� ������
Next
$txt=StringTrimRight($txt, $L2) ; �������� �������� �����������

; ���������� � ����
$file = FileOpen(@ScriptDir&'\file.txt',2)
FileWrite($file, $txt)
FileClose($file)

MsgBox(0, '������� ��� ����������', $txt)

; !i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i

; ������ ����
$text = FileRead(@ScriptDir&'\file.txt')
$aText = StringSplit($text, $sep2, 1)
; Dim $new[$aText[0]+1][3] =[[$aText[0]]] ; ����� � ����������� � ������ ������
Dim $new[$aText[0]][3] ; ��������� ������ �� ������� ������������

For $i = 0 to $aText[0]-1
	$tmp = StringSplit($aText[$i+1], $sep1, 1)
	$new[$i][0]=$tmp[1]
	$new[$i][1]=$tmp[2]
	$new[$i][2]=$tmp[3]
Next
_ArrayDisplay($new, '���������� ������')