#include '_RSA_crypt.au3'
#include <Array.au3>

Opt('MustDeclareVars', 1)

Global $aKey, $iStart, $sTime

#cs
N: ������(modulus) - $aKey[0];
E: �������� ����������(public exponent) - $aKey[1];
D: ��������� ����������(private exponent) - $aKey[2].
{E,N}: �������� ����(public key) - ���������� ����, � ��� ����� �������������� �����;
{D,N}: �������� ����(private key) - ����� ������ ��� ��������.

���������� ����� � ����������� ������ � �������� ����������(E) �� 3 �� 8:
(� ���������������� ���� �������� �������)
#ce
For $i = 3 To 8
	$iStart = TimerInit()
	$aKey = _RSA_GenerateKeys($i)
	$sTime = StringFormat('%.2f ms', TimerDiff($iStart))
	_ArrayDisplay($aKey, '������: ' & $i & ', ' & $sTime)
Next