$timer = TimerInit()
$n2=''
$n1=''
For $i = 1 to 30
	$n2&=$i
	$n1 &=StringRegExpReplace($n2, '(\A\d{1,3}(?=(\d{3})+\z)|\d{3}(?=\d))', '\1 ')&@CRLF ; dwerf (71 ����)
	; $n1 &=StringRegExpReplace($n2, '(^\d{1,3}(?=(\d{3})+$)|\d{3}(?=\d))', '\1 ')&@CRLF ; dwerf, � ������� ������ �� ^ � $
	; $n1 &=StringRegExpReplace($n2, '(^\d+?(?=(?>(?:\d{3})+)(?!\d))|\G\d{3}(?=\d))', '\1 ')&@CRLF ; (84 ����)
	; $n1 &=StringRegExpReplace($n2, '(?!^\d{3})(\d{3})(?=(\d{3})*$)', ' \1')&@CRLF ; ��� ������� (265 ����)
	; $n1 &=StringRegExpReplace($n2, '(?<=\d)(?=(\d{3})+\z)', ' ')&@CRLF ; � ����� ��.������ (860 ����)
	; $n1 &=StringRegExpReplace($n2, '(?<=\d)(?=(\d{3})+(?!\d))', ' ')&@CRLF ; (1000 ����) http://ru2.php.net/manual/ru/function.number-format.php
	; $n1 &=StringRegExpReplace($n2, '(\d)\s?(\d?)\s?(\d?)(?=((\d\s?){3})*\z)', "\1\2\3 ")&@CRLF ; (927 ����)
	; $n1 &=StringRegExpReplace($n2, '(\d{3}(?=\d)|^\d{1,3}(?=(\d{3})+$))', '\1 ')&@CRLF ; ��������� �������, ������� �������� ������ ������� � dwerf .
Next
MsgBox(0, 'Message', $n1 &@CRLF&Round(TimerDiff($timer), 2)&' ����') ; ���������� ���� 30 (�������� ����������)
; MsgBox(0, 'Message', Round(TimerDiff($timer), 2)&' ����') ; ���������� ���� 300 (���� ��������)