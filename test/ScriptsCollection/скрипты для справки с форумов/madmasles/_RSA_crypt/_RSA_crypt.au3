#region Header
; #INDEX# =======================================================================================================
; Title .........: _RSA_crypt
; AutoIt Version : 3.3.6.1 +
; Language ......: Русский
; Description ...: Шифрование по алгоритму RSA (описание алгоритма: http://ru.wikipedia.org/wiki/RSA)
; Author ........: madmasles
; Remarks........: Изначальные авторы некоторых используемых функций - великие математики прошлого. :)
; ===============================================================================================================

; #CURRENT_FUNCTIONS# ===========================================================================================
;_RSA_GenerateKeys
;_RSA_EnCrypt
;_RSA_DeCrypt
;_RSA_Generate_Prime
;_RSA_IsPrime
;_RSA_IsCoprime
; ===============================================================================================================

; #INTERNAL_USE_ONLY#============================================================================================
;__RSA_GeneratePQ
;__RSA_ControlKeys
;__RSA_Calculate
;__RSA_GenerateD
;__RSA_GenerateE
;__RSA_Swap
; ===============================================================================================================
#include-once
#endregion Header

#region Public Functions
; #FUNCTION# ====================================================================================================
; Name...........: _RSA_GenerateKeys
; Description....: Генерирует {E,N} - открытый ключ(public key) и {D,N} - закрытый ключ(private key)
;                  для шифрования (расшифровки) текста по алгоритму RSA.
; Syntax.........: _RSA_GenerateKeys($i_E_Len = 6)
; Parameters.....: $i_E_Len [Optional] - количество знаков в открытой экспоненте(public exponent)Е (от 3 до 8),
;                  по умолчанию 6. Чтобы использовать значение по умолчанию можно или оставить пустую
;                  строку, или Default, или -1.
;
; Return values..: Одномерный массив $a_Keys из трех элементов:
;                  $aKey[0] - модуль(modulus) N;
;                  $aKey[1] - открытая экспонента(public exponent) Е;
;                  $aKey[2] - секретная экспонента(private exponent) D.
;
; Author.........: madmasles
; Modified.......:
; Remarks........: Количество знаков в открытой экспоненте практически не влияет на скорость обработки.
;                  {E,N}: открытый ключ(public key) - передается всем, с кем будет поддерживаться связь;
;                  {D,N}: закрытый ключ(private key) - знает только его владелец.
;                  Текст, зашифрованный открытым ключом, можно расшифровать только закрытым ключом, и наоборот.
;                  Зашифрованный текст можно передавать получателю по любым открытым каналам,
;                  с определенной гарантией того, что прочитает его только тот, для кого он предназначен.
; Related........: __RSA_GeneratePQ, __RSA_GenerateE, __RSA_GenerateD, __RSA_ControlKeys
; Link...........: http://autoit-script.ru/index.php/topic,8343.0.html
; Example........: Есть
; ===============================================================================================================
Func _RSA_GenerateKeys($i_E_Len = 6)
	Local $a_PQ, $i_Euler, $a_Keys[3], $f_OK
	If $i_E_Len = -1 Or $i_E_Len = Default Or Not $i_E_Len Then $i_E_Len = 6
	$i_E_Len = Int($i_E_Len)
	If $i_E_Len < 3 Then $i_E_Len = 3
	If $i_E_Len > 8 Then $i_E_Len = 8
	While Not $f_OK
		$a_PQ = __RSA_GeneratePQ()
		$a_Keys[0] = $a_PQ[0] * $a_PQ[1]
		$i_Euler = ($a_PQ[0] - 1) * ($a_PQ[1] - 1)
		$a_Keys[1] = __RSA_GenerateE($i_E_Len, $i_Euler)
		If Not $a_Keys[1] Then ContinueLoop
		$a_Keys[2] = __RSA_GenerateD($a_Keys[1], $i_Euler)
		$f_OK = __RSA_ControlKeys($a_Keys)
	WEnd
	Return $a_Keys
EndFunc   ;==>_RSA_GenerateKeys

; #FUNCTION# ====================================================================================================
; Name...........: _RSA_EnCrypt
; Description....: Зашифровывает текст по алгоритму RSA по открытому {E,N} или закрытому {D,N} ключу.
; Syntax.........: _RSA_EnCrypt($v_String, $i_ED, $i_N, $s_Delim = -1, $f_Binary = 0)
; Parameters.....: $v_String - текст для шифрования в строковом или в бинарном виде.
;                  $i_ED - экспонента открытая (public exponent) Е или секретная (private exponent) D.
;                  $i_N - модуль(modulus) N.
;                  $s_Delim [Optional] - разделитель чисел в зашифрованной строке. Любой ASCII символ(символы),
;                                        кроме цифр. Цифры, если есть, будут удалены.
;                                        По умолчанию Chr(124) ('|').Чтобы использовать значение по умолчанию
;                                        можно или оставить пустую строку, или Default, или -1.
;                  $f_Binary [Optional] - 0 - зашифрованный текст возвращается в строковом виде,
;                                         любое не пустое значение - в бинарном, по умолчанию - 0.
;
; Return values..: Success - зашифрованный текст.
;                  Failure - пустая строка и флаг @error:
;                            1 - отсутствует текст для шифрования;
;                            2 - отсутствует или модуль, или экспонента.
; Author.........: madmasles
; Modified.......:
; Remarks........: В тексте для шифрования должны быть только ASCII символы (Chr(0) - Chr(255)).
;                  Лучше использовать в тексте английский язык, так как, если, например, зашифровать
;                  русский текст, то потом расшифровать его не получится на компьютере с не установленным
;                  русским языком. Возврат в бинарном виде может понадобиться при наличие в тексте
;                  непечатных символов или для передачи через соответствующие каналы связи.
; Related........: __RSA_Calculate
; Link...........: http://autoit-script.ru/index.php/topic,8343.0.html
; Example........: Есть
; ===============================================================================================================
Func _RSA_EnCrypt($v_String, $i_ED, $i_N, $s_Delim = -1, $f_Binary = 0)
	Local $a_String, $a_Uniq[1], $i_Asc, $i_Count, $v_EnCrypt

	If Not $v_String Then Return SetError(1, 0, '')
	$i_ED = Abs(Int($i_ED))
	$i_N = Abs(Int($i_N))
	If Not $i_ED Or Not $i_N Then Return SetError(2, 0, '')
	If $s_Delim = -1 Or $s_Delim = Default Then
		$s_Delim = Chr(124)
	Else
		$s_Delim = StringRegExpReplace($s_Delim, '\d', '')
		If Not $s_Delim Then $s_Delim = Chr(124)
	EndIf
	If IsBinary($v_String) Then $v_String = BinaryToString($v_String)
	$a_String = StringSplit($v_String, '')
	ReDim $a_Uniq[$a_String[0] + 1][2]
	For $i = 1 To $a_String[0]
		$i_Asc = Asc($a_String[$i])
		Assign($i_Asc, Eval($i_Asc) + 1)
		If Eval($i_Asc) = 1 Then
			$i_Count += 1
			$a_Uniq[$i_Count][0] = $a_String[$i]
			$a_Uniq[$i_Count][1] = __RSA_Calculate($i_Asc, $i_ED, $i_N)
		EndIf
	Next
	For $i = 1 To $a_String[0]
		For $j = 1 To $i_Count
			If $a_String[$i] == $a_Uniq[$j][0] Then
				$v_EnCrypt &= $a_Uniq[$j][1] & $s_Delim
			EndIf
		Next
	Next
	$v_EnCrypt = StringTrimRight($v_EnCrypt, StringLen($s_Delim))
	If $f_Binary Then
		$v_EnCrypt = Binary($v_EnCrypt)
	EndIf
	Return $v_EnCrypt
EndFunc   ;==>_RSA_EnCrypt

; #FUNCTION# ====================================================================================================
; Name...........: _RSA_DeCrypt
; Description....: Расшифровывает шифрованный текст  по алгоритму RSA с помощью закрытого {D,N} или
;                  открытого {E,N} ключа.
; Syntax.........: _RSA_DeCrypt($v_EnCrypt, $i_ED, $i_N)
; Parameters.....: $v_EnCrypt - зашифрованный текст в строковом или в бинарном виде.
;                  $i_ED - экспонента секретная (private exponent) D или открытая (public exponent) Е,
;                  зависит от того, каким ключом текст был зашифрован.
;                  $i_N - модуль(modulus) N.
;
; Return values..: Success - расшифрованная строка в строковом виде.
;                  Failure - пустая сторока и флаг @error:
;                            1 - отсутствует текст для расшифровки;
;                            2 - отсутствует или модуль, или экспонента.
;                            3 - в тексте для расшифровки отсутствуют числа.
; Author.........: madmasles
; Modified.......:
; Remarks........: Текст, зашифрованный открытым ключом, можно расшифровать только закрытым ключом,
;                  и наоборот. Оба ключа должны быть сгенерированы функцией _RSA_GenerateKeys.
; Related........: __RSA_Calculate
; Link...........: http://autoit-script.ru/index.php/topic,8343.0.html
; Example........: Есть
; ===============================================================================================================
Func _RSA_DeCrypt($v_EnCrypt, $i_ED, $i_N)
	Local $a_String, $a_Uniq[1], $i_Count, $s_DeCrypt

	If Not $v_EnCrypt Then Return SetError(1, 0, 0)
	$i_ED = Abs(Int($i_ED))
	$i_N = Abs(Int($i_N))
	If Not $i_ED Or Not $i_N Then Return SetError(2, 0, 0)
	If IsBinary($v_EnCrypt) Then $v_EnCrypt = BinaryToString($v_EnCrypt)
	$a_String = StringRegExp('|000|' & $v_EnCrypt, '\d+', 3)
	$a_String[0] = UBound($a_String) - 1
	If Not $a_String[0] Then Return SetError(3, 0, 0)
	ReDim $a_Uniq[$a_String[0] + 1][2]
	For $i = 1 To $a_String[0]
		Assign($a_String[$i], Eval($a_String[$i]) + 1)
		If Eval($a_String[$i]) = 1 Then
			$i_Count += 1
			$a_Uniq[$i_Count][0] = $a_String[$i]
			$a_Uniq[$i_Count][1] = __RSA_Calculate($a_String[$i], $i_ED, $i_N)
		EndIf
	Next
	For $i = 1 To $a_String[0]
		For $j = 1 To $i_Count
			If $a_String[$i] == $a_Uniq[$j][0] Then
				$s_DeCrypt &= Chr($a_Uniq[$j][1])
			EndIf
		Next
	Next
	Return $s_DeCrypt
EndFunc   ;==>_RSA_DeCrypt

; #FUNCTION# ====================================================================================================
; Name...........: _RSA_Generate_Prime
; Description....: Генерирует простое положительное число с заданным количеством знаков.
; Syntax.........: _RSA_Generate_Prime($i_Len)
; Parameters.....: $i_Len [Optional] - количество знаков в генерируемом простом числе от 2 до 12.
;                                      По умолчанию - случайное число от 2 до 8. Чтобы использовать значение
;                                      по умолчанию можно или оставить пустую строку, или Default, или -1.
;
; Return values..: Простое число.
; Author.........: madmasles
; Modified.......:
; Remarks........: Чем больше количество знаков, тем дольше генерируется число из-за проверки на простоту.
;                  Оптимально - до 8 знаков.
; Related........: _RSA_IsPrime
; Link...........: http://autoit-script.ru/index.php/topic,8343.0.html
; Example........: Есть
; ===============================================================================================================
Func _RSA_Generate_Prime($i_Len = -1)
	Local $i_Prime, $i_Max, $a_End[4] = [1, 3, 7, 9]

	$i_Len = Int($i_Len)
	If $i_Len = -1 Or $i_Len = Default Or Not $i_Len Then $i_Len = Random(2, 8, 1)
	If $i_Len < 2 Then $i_Len = 2
	If $i_Len > 12 Then $i_Len = 12
	For $i = 1 To $i_Len
		$i_Max &= 9
	Next
	While 1
		$i_Prime = Random(1, 9, 1)
		If $i_Len > 2 Then
			For $i = 1 To $i_Len - 2
				$i_Prime &= Random(0, 9, 1)
			Next
		EndIf
		$i_Prime &= $a_End[Random(0, 3, 1)]
		While 1
			If _RSA_IsPrime($i_Prime) Then ExitLoop 2
			$i_Prime += 2
			If $i_Prime >= $i_Max Then ExitLoop
		WEnd
	WEnd
	Return $i_Prime
EndFunc   ;==>_RSA_Generate_Prime

; #FUNCTION# ====================================================================================================
; Name...........: _RSA_IsPrime
; Description....: Проверяет число на простоту.
; Syntax.........: _RSA_IsPrime($i_Num)
; Parameters.....: $i_Num - число для проверки на простоту.
;
; Return values..: Success - True, если число простое, False, если число составное.
;                  Failure - False и флаг @error = 1, если число больше 999999999989 (последнее простое 12-значное число)
; Author.........: jennico (jennicoattminusonlinedotde), http://www.autoitscript.com/forum/topic/83091-all-about-primes-the-prime-suite-primesau3-udf-lots-of-math-functions/page__hl__prime
; Modified.......: madmasles
; Remarks........: Ограничение в 12 знаков на проверяемое число. Слишком долго проверяет большие числа этим способом.
; Related........: _RSA_Generate_Prime
; Link...........: http://autoit-script.ru/index.php/topic,8343.0.html
; Example........: Есть
; ===============================================================================================================
Func _RSA_IsPrime($i_Num)
	If $i_Num > 999999999989 Then Return SetError(1, 0, False)
	If Not Mod($i_Num, 2) Then Return False
	If Not Mod($i_Num, 3) Then Return False
	If Not Mod($i_Num, 5) Then Return False

	Local $a_Num[9] = [7, 4, 2, 4, 2, 4, 6, 2, 6], $i_End = Int(Sqrt($i_Num)) + 1

	While $a_Num[0] < $i_End
		For $i = 1 To 8
			If Not Mod($i_Num, $a_Num[0]) Then Return False
			$a_Num[0] += $a_Num[$i]
		Next
	WEnd
	Return True
EndFunc   ;==>_RSA_IsPrime

; #FUNCTION# ====================================================================================================
; Name...........: _RSA_IsCoprime
; Description....: Проверяет два положительных числа на взаимную простоту.
; Syntax.........: _RSA_IsCoprime($i_First, $i_Second)
; Parameters.....: $i_First - первое число.
;                  $i_Second - второе число
;
; Return values..: Success - True, если числа взаимно простые, False, если нет.
;                  Failure - False и флаг @error = 1, если хотя бы одно из чисел больше 999999999999998.
; Author.........: madmasles
; Modified.......:
; Remarks........: Проверяет очень быстро
; Related........: __RSA_Swap
; Link...........: http://autoit-script.ru/index.php/topic,8343.0.html
; Example........: Есть
; ===============================================================================================================
Func _RSA_IsCoprime($i_First, $i_Second)
	$i_First = Abs(Int($i_First))
	$i_Second = Abs(Int($i_Second))
	If $i_First > 999999999999998 Or $i_Second > 999999999999998 Then Return SetError(1, 0, False)

	While $i_First
		__RSA_Swap($i_First, $i_Second)
		$i_First = Mod($i_First, $i_Second)
	WEnd
	Return ($i_Second = 1)
EndFunc   ;==>_RSA_IsCoprime
#endregion Public Functions

#region Internal Functions
; #FUNCTION# ====================================================================================================
; Name...........: __RSA_Swap
; Description....: Если значение второй переменной больше значения первой, то меняет их значения местами.
;                  Используется в функции _RSA_IsCoprime.
; Syntax.........: __RSA_Swap(ByRef $i_Max, ByRef $i_Min)
; Parameters.....: $i_Max - первое число
;                  $i_Min - второе число
; Related........: _RSA_IsCoprime
; ===============================================================================================================
Func __RSA_Swap(ByRef $i_Max, ByRef $i_Min)
	Local $i_Temp = $i_Max

	If $i_Min > $i_Max Then
		$i_Max = $i_Min
		$i_Min = $i_Temp
	EndIf
EndFunc   ;==>__RSA_Swap

; #FUNCTION# ====================================================================================================
; Name...........: __RSA_ControlKeys
; Description....: Проверяет правильность сгенерированных ключей. Используется в функции _RSA_GenerateKeys.
; ===============================================================================================================
Func __RSA_ControlKeys($a_Key)
	Local $i_EnCrypt, $i_DeCrypt, $i_Start
	For $i = 0 To 2
		If Not $a_Key[$i] Then Return False
	Next
	$i_Start = Random(10, 100, 1)
	For $i = $i_Start To $i_Start + 3
		$i_EnCrypt = __RSA_Calculate($i, $a_Key[1], $a_Key[0])
		$i_DeCrypt = __RSA_Calculate($i_EnCrypt, $a_Key[2], $a_Key[0])
		If $i_DeCrypt <> $i Then Return False
	Next
	Return True
EndFunc   ;==>__RSA_ControlKeys

; #FUNCTION# ====================================================================================================
; Name...........: __RSA_Calculate
; Description....: Произволит соответствующие вычисления при шифровании(расшифровке). Используется в
;                  функциях _RSA_EnCrypt, _RSA_DeCrypt, __RSA_ControlKeys.
; Author.........: Authenticity; http://www.autoitscript.com/forum/topic/95363-rsa-algorithm/page__view__findpost__p__685973
; Modified.......: madmasles
; ===============================================================================================================
Func __RSA_Calculate($i_Num, $i_ED, $i_N)
	Local $i_Result = 1

	While $i_ED > 0
		While Not Mod($i_ED, 2)
			$i_Num = Mod($i_Num * $i_Num, $i_N)
			$i_ED /= 2
		WEnd
		$i_Result = Mod($i_Num * $i_Result, $i_N)
		$i_ED -= 1
	WEnd
	Return Int($i_Result)
EndFunc   ;==>__RSA_Calculate

; #FUNCTION# ====================================================================================================
; Name...........: __RSA_GeneratePQ
; Description....: Генерирует пару простых чисел случайной длины от 2 до 6 таких, чтобы значение функции
;                  Ейлера было больше 10010000. Используется в функции _RSA_GenerateKeys.
; ===============================================================================================================
Func __RSA_GeneratePQ()
	Local $a_PQ_Gen[2], $i_LenP, $i_LenQ

	While 1
		Switch Random(0, 2, 1)
			Case 0
				$i_LenP = 4
				$i_LenQ = 4
			Case 1
				$i_LenP = 3
				$i_LenQ = 5
			Case 2
				$i_LenP = 2
				$i_LenQ = 6
		EndSwitch
		$a_PQ_Gen[0] = _RSA_Generate_Prime($i_LenP)
		While 1
			$a_PQ_Gen[1] = _RSA_Generate_Prime($i_LenQ)
			If ($a_PQ_Gen[0] - 1) * ($a_PQ_Gen[1] - 1) < 10010000 Then ExitLoop
			If $a_PQ_Gen[1] <> $a_PQ_Gen[0] Then ExitLoop 2
		WEnd
	WEnd
	Return $a_PQ_Gen
EndFunc   ;==>__RSA_GeneratePQ

; #FUNCTION# ====================================================================================================
; Name...........: __RSA_GenerateE
; Description....: Генерирует открытую экспоненту(public exponent) Е заданной длины, взаимно простую
;                  со значением функции Ейлера. Используется в функции _RSA_GenerateKeys.
; ===============================================================================================================
Func __RSA_GenerateE($i_Len, $i_Eul)
	Local $i_E_Gen, $a_End[5] = [1, 3, 5, 7, 9], $i_Start = TimerInit()

	While 1
		If $i_Len < 8 Then
			$i_E_Gen = Random(1, 9, 1)
		Else
			$i_E_Gen = StringLeft($i_Eul, 1)
			If $i_E_Gen = 2 Then
				$i_E_Gen = Random(1, 2, 1)
			ElseIf $i_E_Gen > 2 Then
				$i_E_Gen = Random(1, $i_E_Gen - 1, 1)
			EndIf
		EndIf
		For $i = 1 To $i_Len - 2
			$i_E_Gen &= Random(0, 9, 1)
		Next
		$i_E_Gen &= $a_End[Random(0, 4, 1)]
		While 1
			If $i_E_Gen >= $i_Eul Then ExitLoop
			If _RSA_IsCoprime($i_Eul, $i_E_Gen) Then ExitLoop 2
			$i_E_Gen += 2
		WEnd
		If TimerDiff($i_Start) > 100 Then Return 0
	WEnd
	Return $i_E_Gen
EndFunc   ;==>__RSA_GenerateE

; #FUNCTION# ====================================================================================================
; Name...........: __RSA_GenerateD
; Description....: Вычисляет секретную экспонету (private exponent) D по открытой экспоненте
;                 (public exponent) Е и значению функции Ейлера. Используется в функции _RSA_GenerateKeys.
; Author.........: Andreik; http://www.autoitscript.com/forum/topic/95363-rsa-algorithm/page__view__findpost__p__686569
; Modified.......: madmasles
; ===============================================================================================================
Func __RSA_GenerateD($i_E, $i_Eul)
	Local $i_Qu, $a_Num[3][3] = [[0],[1, 0, $i_Eul],[0, 1, $i_E]]

	While $a_Num[2][2]
		$i_Qu = Int($a_Num[1][2] / $a_Num[2][2])
		For $j = 0 To 2
			$a_Num[0][$j] = $a_Num[1][$j] - $i_Qu * $a_Num[2][$j]
			$a_Num[1][$j] = $a_Num[2][$j]
			$a_Num[2][$j] = $a_Num[0][$j]
		Next
	WEnd
	If $a_Num[1][1] < 0 Then
		$a_Num[1][1] += $i_Eul
	EndIf
	Return $a_Num[1][1]
EndFunc   ;==>__RSA_GenerateD
#endregion Internal Functions