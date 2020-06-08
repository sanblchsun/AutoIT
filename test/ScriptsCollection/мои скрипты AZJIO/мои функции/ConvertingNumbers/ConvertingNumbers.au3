#include <BigNum.au3> ; http://www.autoitscript.com/forum/topic/83529-bignum-udf/

; ============================================================================================
; Function Name ...: _NumToDec
; Description ........: Converts a number into a decimal
; Syntax.......: _NumToDec($num, $sSymbol)
; Parameters:
;		$num - number
;		$sSymbol - A set of symbols defining the sequence
;		$casesense - (0,1,2) corresponds to flag StringInStr
; Return values: Success - Returns a decimal number, @extended - the number of characters in the discharge
;					Failure - Returns $num, and sets @error:
;                  |1 - $sSymbol contains less than 2 characters
;                  |2 - The symbol is not found in the character set
; Author(s) ..........: AZJIO
; Remarks ..........: For the 16 - Dec
; ============================================================================================
; ��� ������� ...: _NumToDec
; �������� ........: ������������ ��������� ����� � ����������
; ���������.......: _NumToDec($num, $sSymbol[, $casesense = 0])
; ���������:
;		$num - �����
;		$sSymbol - ����� �������� ������������ ������������������ ��� ������� �������
;		$casesense - ��������-����������� (0,1,2), ������������� ������ StringInStr
; ������������ ��������: ������� - ���������� ���������� �����, @extended ���������� ���������� ���������� �������� � �������
;					�������� - ���������� ����� ���������� � ��������� $num � ������������� @error:
;                  |1 - $sSymbol �������� ����� 2 ��������
;                  |2 - ������ ����� �� ������ � ������ ��������
; ����� ..........: AZJIO
; ���������� ..: �� ����������� ������� ��� ��������������� �� 16 - ������ �����, ��� ����� ���� Dec
; ============================================================================================
Func _NumToDec($num, $sSymbol, $casesense = 0)
	Local $i, $iPos, $Len, $n, $Out
	$Len = StringLen($sSymbol)
	If $Len < 2 Then Return SetError(1, 0, $num)
	
	$n = StringSplit($num, '')
	For $i = 1 To $n[0]
		$iPos = StringInStr($sSymbol, $n[$i], $casesense)
		If Not $iPos Then Return SetError(2, 0, $num)
		$Out = _BigNum_Add(_BigNum_Mul($iPos - 1, _BigNum_Pow($Len, $n[0] - $i)), $Out)
	Next
	Return SetError(0, $Len, $Out)
EndFunc

; ============================================================================================
; Function Name ...: _DecToNum
; Description ........: Converts a number from the decimal system to the specified
; Syntax.......: _DecToNum ( $iDec, $Symbol )
; Parameters:
;		$iDec - decimal number
;		$Symbol - A set of symbols defining the sequence
; Return values: Success - Returns the new number, @extended - the number of characters in the discharge
;					Failure - Returns $iDec, @error = 1
; Author(s) ..........: AZJIO
; Remarks ..........: For the 16, 8 - Hex, StringFormat
; ============================================================================================
; ��� ������� ...: _DecToNum
; �������� ........: ������������ ���������� ����� � ���������
; ���������.......: _DecToNum ( $iDec, $Symbol )
; ���������:
;		$iDec - ���������� �����
;		$Symbol - ����� �������� ������������ ������������������ � �������
; ������������ ��������: ������� - ���������� ����� � ����� �����������, @extended ���������� ���������� �������� � �������
;					�������� - ���������� ����� ���������� � ��������� $iDec ������������� @error ������ 1
; ����� ..........: AZJIO
; ���������� ..: �� ����������� ������� ��� ��������������� � 16, 8 - ������ �����, ��� ����� ���� Hex, StringFormat
; ============================================================================================
Func _DecToNum($iDec, $Symbol)
	Local $Out, $ost
	$Symbol = StringSplit($Symbol, '')
	If @error Or $Symbol[0] < 2 Then Return SetError(1, 0, $iDec)
	Do
		$ost = _BigNum_Mod($iDec, $Symbol[0])
		$iDec = _BigNum_Div(_BigNum_Sub($iDec, $ost), $Symbol[0])
		$Out = $Symbol[$ost + 1] & $Out
	Until Not Number($iDec)
	Return SetError(0, $Symbol[0], $Out)
EndFunc

; ============================================================================================
; Function Name ...: _DecToRoman
; Description ........: Convert decimal to Roman
; Syntax.......: _DecToRoman ( $iDec )
; Parameters:
;		$iDec - decimal number from 0 to 3999 (Adding thousands adds character "M")
; Return values: Success - Returns the string
;					Failure - Returns -1 (Number outside the specified range), @error - 1, 2
; Author(s) ..........: AZJIO, ������������ ����� http://forum.algolist.ru/algorithm-maths-mathematical/663-rimskie-chisla.html
; Remarks ..........: If 0, the empty string
; ============================================================================================
; ��� ������� ...: _DecToRoman
; �������� ........: ����������� ���������� ����� � �������
; ���������.......: _DecToRoman ( $iDec )
; ���������:
;		$iDec - ���������� ����� �� 0 �� 3999 (���������� ����� ��������� ������ "M")
; ������������ ��������: ������� - ���������� ������
;					�������� - ���������� -1 (����� ��� ���������� ���������) � ������������� @error 
; ����� ..........: AZJIO, Credits http://forum.algolist.ru/algorithm-maths-mathematical/663-rimskie-chisla.html
; ���������� ..: ���� 0, �� ������ ������
; ============================================================================================
Func _DecToRoman($iDec)
	$iDec = Int($iDec) ; ���� ����� ����� �����
	If $iDec < 1 Then
		If $iDec < 0 Then Return SetError(1, 0, -1)
		Return SetError(0, 0, '')
	EndIf
	If $iDec > 3999 Then Return SetError(2, 0, -1) ; ���� �������� �����
	Local $r[13] = ['M', 'CM', 'D', 'CD', 'C', 'XC', 'L', 'XL', 'X', 'IX', 'V', 'IV', 'I']
	Local $n[13] = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
	Local $sRim = ''
	
	For $i = 0 To 12
		While $iDec >= $n[$i]
			$iDec -= $n[$i]
			$sRim &= $r[$i]
		WEnd
	Next
	Return $sRim
EndFunc   ;==>_DecToRoman

; ============================================================================================
; Function Name ...: _RomanToDec
; Description ........: Converts Roman numbers to decimal
; Syntax.......: _RomanToDec ( $sRoman )
; Parameters:
;		$sRoman - Roman number
; Return values: Success - Returns decimal number
;					Failure - Returns -1, @error = -1, if the number doesn't correspond to a format
; Author(s) ..........: AZJIO, http://forum.algolist.ru/algorithm-maths-mathematical/663-rimskie-chisla.html
; Remarks ..........: Verify that number, i.e. not only the use but also the order of the characters. Only the canonical written, i.e. 99 is written as XCIX, not IC. If characters in lower case then @extended = 1
; ============================================================================================
; ��� ������� ...: _RomanToDec
; �������� ........: ����������� ������� ����� � ����������
; ���������.......: _RomanToDec ( $sRoman )
; ���������:
;		$sRoman - ������� �����
; ������������ ��������: ������� - ���������� ���������� �����
;					�������� - ���������� -1, @error = -1, ���� ����� �� ������������� �������
; ����� ..........: AZJIO, http://forum.algolist.ru/algorithm-maths-mathematical/663-rimskie-chisla.html
; ���������� ..: ���������� ������������ �����, �.�. �� ������ ������������� �������� �� � �������. ������ ������������ ���������, �� ���� 99 ������� ��� XCIX, � �� IC. ���� ������� � ������ �������� �� @extended = 1
; ============================================================================================
Func _RomanToDec($sRoman)
	Local $extended = 0
	If Not StringIsUpper($sRoman) Then $extended = 1
	If StringRegExp($sRoman, '(?i)([VLD])\1') Or StringRegExp($sRoman, '(?i)([IXCM])\1\1\1') Then Return SetError(-1, $extended, -1)
	Local $c[7] = ['C', 'C', 'X', 'X', 'I', 'I', ''], _
	$d[7] = [100, 100, 10, 10, 1, 1, 0], _
	$r[7] = ['M', 'D', 'C', 'L', 'X', 'V', 'I'], _
	$n[7] = [1000, 500, 100, 50, 10, 5, 1], _
	$iDec = 0
	
	For $i = 0 To 6
		$aTmp = StringRegExp($sRoman, '^(' & $r[$i] & '+' & $c[$i] & $r[$i] & '|' & $r[$i] & '+|' & $c[$i] & $r[$i] & ')(.*?)$', 3)
		If Not @error Then
			$iDec += StringLen($aTmp[0]) * $n[$i]
			If StringInStr($aTmp[0], $c[$i]) Then $iDec -= $d[$i] + $n[$i]
			$sRoman = $aTmp[1]
			If Not $sRoman Then ExitLoop
		EndIf
	Next
	If $sRoman Then Return SetError(-1, $extended, -1)
	Return $iDec
EndFunc   ;==>_RomanToDec

; ============================================================================================
; Function Name ...: _NumberNumToName
; AutoIt Version ....: 3.2.12.1+
; Description ........: Converts a number to text consisting of words
; Syntax................: _NumberNumToName($iNum, $iRusLng = 0)
; Parameters:
;		$iNumber - ����� ����� ����� �� 0 �� 9223372036854775806
;		$iRusLng - (0, 1) language settings
;                  |0 - in English (Default)
;                  |1 - in Russian
; Return values ....: Success - Returns a string
;					Failure - empty string, @error = 1, if the string contains no numbers
; Author(s) ..........: AZJIO, G.Sandler (CreatoR) (transformation and modernization of the VBS-script found in Google)
; link ..................: http://forum.oszone.net/post-1900913.html#post1900913 discussion and adding CreatoR'om English language support
; ============================================================================================
; ��� ������� ...: _NumberNumToName
; �������� ........: ����������� ����� � ������ ��������
; ���������.......: _NumberNumToName($iNum, $iRusLng = 0)
; ���������:
;		$iNumber - ����� ����� ����� �� 0 �� 9223372036854775806
;		$iRusLng - (0, 1) �������� ���������
;                  |0 - �� ���������� ����� (�� ���������)
;                  |1 - �� ������� �����
; ������������ ��������: ������� - ����� ��������
;					�������� - ������ ������, @error = 1, ���� ������ �������� �� �����
; ����� ..........: AZJIO, G.Sandler (CreatoR), �������������� � ������������ VBS-�������, ���������� � Google
; ������ ..........: http://forum.oszone.net/post-1900913.html#post1900913 ���������� � ���������� CreatoR'�� ��������� ����������� �����
; ============================================================================================
Func _NumberNumToName($iNum, $iRusLng = 0)
	Local $aN, $aNum, $c, $i, $j, $n, $r, $sText

	$iNum = StringStripWS($iNum, 8) ; ������� �������

	If $iNum = '0' Then
		If $iRusLng Then Return '����'
		Return 'Zero'
	EndIf

	$iNum = Int($iNum) ; ���� ����� ����� �����
	If Not StringIsDigit($iNum) Or $iNum > 9223372036854775806 Or $iNum = 0 Then Return SetError(1, 0, '') ; ���� �� ����� ��� �������� �����, �� �����

	$iNum = StringRegExpReplace($iNum, '(\A\d{1,3}(?=(\d{3})+\z)|\d{3}(?=\d))', '\1 ') ; dwerf
	$aNum = StringSplit($iNum, ' ')

	If $iRusLng Then
		Dim $a[4][10] = _
				[ _
				[' ������', ' �����������', ' ����������', ' ����������', ' ������������', ' ����������', ' �����������', ' ����������', ' ������������', ' ������������'], _
				['', ' ���', ' ������', ' ������', ' ���������', ' �������', ' ��������', ' �������', ' ���������', ' ���������'], _
				['', '', ' ��������', ' ��������', ' �����', ' ���������', ' ����������', ' ���������', ' �����������', ' ���������'], _
				['', '', '', ' ���', ' ������', ' ����', ' �����', ' ����', ' ������', ' ������'] _
				]

		Dim $aBitNum[7] = ['', ' �����', ' �������', ' ��������', ' ��������', ' �����������', ' �����������']
	Else
		Dim $a[4][10] = _
				[ _
				[' ten', ' eleven', ' twelve', ' thirteen', ' fourteen', ' fifteen', ' sixteen', ' seventeen', ' eighteen', ' nineteen'], _
				['', 'hundred', ' two hundred', ' three hundred', ' four hundred', ' five hundred', ' six hundred', ' seven hundred', ' eight hundred', ' nine hundred'], _
				['', '', ' twenty', ' thirty', ' forty', ' fifty', ' sixty', ' seventy', ' eighty', ' ninety'], _
				['', '', '', ' three', ' four', ' five', ' six', ' seven', ' eight', ' nine'] _
				]

		Dim $aBitNum[7] = ['', ' thousand', ' million', ' billion', ' trillion', ' quadrillion', ' quintillion']
	EndIf

	$aNum[1] = StringFormat('%03s', $aNum[1]) ; ��������� ������ ����������� �������
	$sText = ''

	For $i = 1 To $aNum[0]
		If $aNum[$i] = '000' Then ContinueLoop

		$aN = StringSplit($aNum[$i], '')
		$r = $aNum[0] - $i

		For $j = 1 To $aN[0]
			$n = Number($aN[$j])
			If Not $n Then ContinueLoop

			$c = $j

			Switch $j
				Case 3
					Switch $n ; ��� ����� 1 ��� 2
						Case 1
							If $iRusLng Then
								If $r = 1 Then ; ������ ������ (�� �������� � �����)
									$sText &= " ����"
								Else
									$sText &= " ����"
								EndIf
							Else
								$sText &= " one"
							EndIf
						Case 2
							If $iRusLng Then
								If $r = 1 Then
									$sText &= " ���"
								Else
									$sText &= " ���"
								EndIf
							Else
								$sText &= " two"
							EndIf
					EndSwitch
				Case 2 ; ��� ����� �� 10 �� 19
					If $n = 1 Then
						$c = 0
						$n = Number($aN[3])
						$aN[3] = 0
					EndIf
			EndSwitch

			$sText &= $a[$c][$n] ; ������������� ����� �� �������
		Next

		$sText &= $aBitNum[$r]

		Switch $n ; ��������� ��� ������ �������� 1000, ��� $j=3 � ����� �����
			Case 1
				If $r = 1 And $iRusLng Then ; ���� �����<�>
					$sText &= "�"
				EndIf
			Case 2, 3, 4
				If $r = 1 Then ; 2,3,4 �����<�>
					If $iRusLng Then
						$sText &= "�"
					Else
						$sText &= "s"
					EndIf
				ElseIf $r > 1 Then ; 2,3,4 ������<�>
					If $iRusLng Then
						$sText &= "�"
					Else
						$sText &= "s"
					EndIf
				EndIf
			Case Else
				If $r > 1 Then ; 5-9 ������<��>
					If $iRusLng Then
						$sText &= "��"
					Else
						$sText &= "s"
					EndIf
				EndIf
		EndSwitch
	Next

	Return StringStripWS($sText, 3)
EndFunc