#include '_RSA_crypt.au3'

Opt('MustDeclareVars', 1)

;��� ������� ����� ������������ �� ������ ��� RSA-����������, �� � ��� ������ �����.
;(� ���������������� ���� �������� �������)
Global $iPrime, $iNumNoPrime, $iNumPrime, $iNum_1, $iNum_2, $iNum_3, $iStart, $sTime

;#cs
;���������� ������� ����� �������� ����� �� 2 �� 12:
For $i = 2 To 12
	$iStart = TimerInit()
	$iPrime = _RSA_Generate_Prime($i)
	$sTime = StringFormat('%.2f ms', TimerDiff($iStart))
	MsgBox(64, '������: ' & $i, '������� �����: ' & $iPrime & @LF & $sTime)
Next
;#ce

;#cs
;���������� 10 ������� ����� ��������� (�� 2 �� 8) �����:
For $i = 1 To 10
	$iStart = TimerInit()
	$iPrime = _RSA_Generate_Prime()
	$sTime = StringFormat('%.2f ms', TimerDiff($iStart))
	MsgBox(64, $i & '. ������: 2-8', '������� �����: ' & $iPrime & @LF & $sTime)
Next
;#ce

;#cs
;�������� ����� �� ��������:
$iNumNoPrime = 123456789 ;��������� �����
$iNumPrime = 558678719;������� �����
MsgBox(64, '�������', $iNumNoPrime & @LF & '������� �����: ' & _RSA_IsPrime($iNumNoPrime))
MsgBox(64, '�������', $iNumPrime & @LF & '������� �����: ' & _RSA_IsPrime($iNumPrime))
;#ce

;#cs
;�������� ����� �� �������� ��������:
$iNum_1 = 123456789012345
$iNum_2 = 123
$iNum_3 = 29137

MsgBox(64, '������� �������', $iNum_1 & ' � ' & $iNum_2 & @LF & '������� ������� �����: ' & _
		_RSA_IsCoprime($iNum_1, $iNum_2))
MsgBox(64, '������� �������', $iNum_1 & ' � ' & $iNum_3 & @LF & '������� ������� �����: ' & _
		_RSA_IsCoprime($iNum_1, $iNum_3))
;#ce