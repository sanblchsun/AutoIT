
; ������� 1 ���������, ������ ��� 0 � 1
MsgBox(0, 'Message', '1 vs 1 = '&BitXOR(1, 1)&@CRLF& '0 vs 1 = '&BitXOR(0, 1))


; ������� 2 - �������, ��� ����� ����� 1 � ����� -1
$rezyltat=''
For $i = 1 to 10
	$z=$i-5
	$rezyltat&=$z&' - '&Number(Not ($z))&@CRLF
Next
$rezyltat&=@CRLF&'�������������� ��� ������ (������ - ������ ������,'&@CRLF&'��������� ��� ����� ��� ��������� ���������.)'&@CRLF&@CRLF
$text=StringSplit('|�����|0|1', '|')
For $i = 1 to $text[0]
	$rezyltat&=$text[$i]&' - '&Number(Not ($text[$i]))&@CRLF
Next

MsgBox(0, '', '��������� ��������������'&@CRLF&'��� ��������� �����'&@CRLF&@CRLF&$rezyltat)