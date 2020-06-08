#include '_RSA_crypt.au3'
#include <Array.au3>

Opt('MustDeclareVars', 1)

Global $aKey, $iStart, $sTime

#cs
N: модуль(modulus) - $aKey[0];
E: открытая экспонента(public exponent) - $aKey[1];
D: секретная экспонента(private exponent) - $aKey[2].
{E,N}: открытый ключ(public key) - передается всем, с кем будет поддерживаться связь;
{D,N}: закрытый ключ(private key) - знает только его владелец.

Генерируем ключи с количеством знаков в открытой экспоненте(E) от 3 до 8:
(в скомпилированном виде работает быстрее)
#ce
For $i = 3 To 8
	$iStart = TimerInit()
	$aKey = _RSA_GenerateKeys($i)
	$sTime = StringFormat('%.2f ms', TimerDiff($iStart))
	_ArrayDisplay($aKey, 'Знаков: ' & $i & ', ' & $sTime)
Next