#include '_RSA_crypt.au3'

Opt('MustDeclareVars', 1)

Global $iN, $iE, $sString, $bString, $sEnCrypt, $bEnCrypt, $iStart, $sTime

;������������� �������� ������ ����� ����� ������������ ������ � ������� ��������� �����
;(� ���������������� ���� �������� �������)

;{E,N} �������� ����(public key), ���������� ����� �������� _RSA_GenerateKeys()
;� ���� � �������� ������(private key)
$iE = 10448737 ;E: �������� ����������(public exponent)
$iN = 15861917 ;N: ������(modulus)

;����� ��� ����������
$sString = '�������� RSA ���� ������������ � ������� 1977 ���� � ������� Scientific American.'

;������������� ����� $sString � ������ $sEnCrypt:
$iStart = TimerInit()
$sEnCrypt = _RSA_EnCrypt($sString, $iE, $iN)
$sTime = StringFormat('%.2f ms', TimerDiff($iStart))
MsgBox(64, $sTime, '����� :' & @LF & $sString & @LF & @LF & '������������� ����� �������:' & _
		@LF & $sEnCrypt)

;������������� �������� ����� $sString � �������� ������ $bEnCrypt:
$bString = Binary($sString)
$iStart = TimerInit()
$bEnCrypt = _RSA_EnCrypt($sString, $iE, $iN, -1, 1)
$sTime = StringFormat('%.2f ms', TimerDiff($iStart))
MsgBox(64, $sTime, '����� :' & @LF & $sString & @LF & @LF & '������������� ����� � �������� ����:' & _
		@LF & $bEnCrypt)