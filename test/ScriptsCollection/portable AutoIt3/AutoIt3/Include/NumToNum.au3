#include <BigNum.au3>

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