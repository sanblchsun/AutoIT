#include '_RSA_crypt.au3'

Opt('MustDeclareVars', 1)

Global $iN, $iE, $sString, $bString, $sEnCrypt, $bEnCrypt, $iStart, $sTime

;Зашифрованный открытым ключом текст можно расшифровать только с помощью закрытого ключа
;(в скомпилированном виде работает быстрее)

;{E,N} открытый ключ(public key), полученный ранее функцией _RSA_GenerateKeys()
;в паре с закрытым ключом(private key)
$iE = 10448737 ;E: открытая экспонента(public exponent)
$iN = 15861917 ;N: модуль(modulus)

;текст для зашифровки
$sString = 'Описание RSA было опубликовано в августе 1977 года в журнале Scientific American.'

;зашифровываем текст $sString в строку $sEnCrypt:
$iStart = TimerInit()
$sEnCrypt = _RSA_EnCrypt($sString, $iE, $iN)
$sTime = StringFormat('%.2f ms', TimerDiff($iStart))
MsgBox(64, $sTime, 'Текст :' & @LF & $sString & @LF & @LF & 'Зашифрованный текст строкой:' & _
		@LF & $sEnCrypt)

;зашифровываем бинарный текст $sString в бинарные данные $bEnCrypt:
$bString = Binary($sString)
$iStart = TimerInit()
$bEnCrypt = _RSA_EnCrypt($sString, $iE, $iN, -1, 1)
$sTime = StringFormat('%.2f ms', TimerDiff($iStart))
MsgBox(64, $sTime, 'Текст :' & @LF & $sString & @LF & @LF & 'Зашифрованный текст в бинарном виде:' & _
		@LF & $bEnCrypt)