#Include <_RegFunc.au3>

; v0.2

$Key = 'HKEY_LOCAL_MACHINE\HARDWARE'

$timer = TimerInit()
$sData='Windows Registry Editor Version 5.00'&@CRLF&@CRLF
; $sData='' ; ����� ����� ������� "�����" reg-�����
$DataErr = _RegExport_X($Key, $sData)
$timer = Round(TimerDiff($timer), 2)


If MsgBox(4, '_RegExport_X + _RegFunc', 'Time : ' & $timer &@LF&@LF& $DataErr &@LF&@LF& '���������?')=6 Then
	$file = FileOpen(@ScriptDir&'\Export.reg',2)
	FileWrite($file, $sData)
	FileClose($file)
EndIf

; #FUNCTION# ;=================================================================================
; ��� ������� ...: _RegExport_X
; �������� ........: ���������� �������������� �� ������� ������.
; ���������.......: _RegExport_X ( $sKey, ByRef $Data )
; ���������:
;		$sKey - ������ ���� � �������, ������� ����� �������������
;		$Data - ����������, � ������� �������������� ���������
; ������������ ��������: �������������� ������ (��� "�����")
; ����� ..........: AZJIO
; ���������� ..:� $Data ����� �������� "�����", ������������ ������ ����� ������������. ��� ������������ ������ ������ ��������������, � �� ����������������.
; ������� NIKZZZZ �� ������ ������������ ������ http://forum.ru-board.com/topic.cgi?forum=5&topic=29240&start=3080#12
; ������� Erik Pilsits, ��� _RegFunc.au3 ������������ � �������
; ============================================================================================
Func _RegExport_X($sKey, ByRef $Data)
	Local $aaaValue, $asValue0, $cmd, $DataErr, $hex, $i, $L, $line1, $Re, $sTemp, $sValue, $sValue0, $sValueName, $sValuetype

	$i = 0
	Do
		$i += 1
		; If $i=1 Then $Data &= @CRLF & '[' & $sKey & ']' & @CRLF
		$sValueName = RegEnumVal($sKey, $i)
		If @error Then ExitLoop
		$sValue = _RegRead($sKey, $sValueName, True)
		If @error Then ContinueLoop
		$sValuetype = @extended
		; $sValueName = StringRegExpReplace($sValueName, '[\\]', "\\$0") ; ������ �������� � ��������� ��������� ����� �� �������
		$sValueName = StringReplace($sValueName, '\', "\\") ; ������ �������� � ��������� ��������� ����� �� �������
		If $i=1 Then $Data &= @CRLF & '[' & $sKey & ']' & @CRLF ; ���� ������ ����������� � ������, �� ��� ������� ���� ������ ���������
		; ����� ��� ������� ���� ������ ���� �������� ���������� ��������
		Switch $sValuetype
			Case 1
				$sValue = StringReplace(StringReplace(StringRegExpReplace($sValue, '["\\]', "\\$0"), '=\"\"', '="\"'), '\"\"', '\""')
				$Data &= '"' & $sValueName & '"="' & $sValue & '"' & @CRLF
			Case 7, 2
				$hex=_HEX($sValuetype, $sValue, $sValueName, $L)
				$Data &= '"' & $sValueName & '"=' & $L & $hex & @CRLF
			Case 4
				$Data &= '"' & $sValueName & '"=dword:' & StringLower(Hex(Int($sValue))) & @CRLF
			Case 3
				$hex=_HEX(3, $sValue, $sValueName, $L)
				$Data &= '"' & $sValueName & '"=' & $L & $hex & @CRLF
			Case 0, 8, 9, 10, 11 ; ��� ������ ������� �� ��������� AutoIt3, ������� ������������ ������� ���������� ��������.
				; ����������� �������� � ������� � ������ � ��
				$hex=_HEX($sValuetype, $sValue, $sValueName, $L)
				$Data &= '"' & $sValueName & '"=' & $L & $hex & @CRLF
			Case Else
				$DataErr &= '# error... Key:"' & $sKey & '" Valuename:"' & $sValueName & '" ��������:"' & $sValue & '" type:"' & $sValuetype & '"' & @CRLF
		EndSwitch
	Until 0
	;��������
	$i = 0
	While 1
		$i += 1
		$sTemp = RegEnumKey($sKey, $i)
		If @error Then ExitLoop
		$DataErr &= _RegExport_X($sKey & '\' & $sTemp, $Data)
	WEnd
	$Data = StringReplace($Data, '""=', '@=') ; �������� � ������ ��������� �� ��������� �� ����������
	Return $DataErr
EndFunc   ;==>_RegExport_X

; ������� ����������������� ������, �������� � �������� - �������� ������ � ������� reg-����� (������� �����)
; ������ ����������� ������� ��������� ������������� �������� � reg-������ ���������� �������� �� ������� ����������.
Func _HEX($sValuetype, ByRef $sValue, $sValueName, ByRef $L)
	Local $aValue, $hex, $i, $k, $len, $lenVN, $r, $s, $s0
	$k = 0
	$lenVN = StringLen($sValueName) - 1
	Switch $sValuetype
		Case 0
			$L = 'hex(0):'
		Case 3
			$k = 1
			$L = 'hex:'
		Case 2
			$k = 1
			$L = 'hex(2):'
			$sValue = StringToBinary($sValue, 2)
			$sValue &= '0000'
			$lenVN = StringLen($sValueName) + 2
		Case 7
			$k = 1
			$L = 'hex(7):'
			; $sValue = StringToBinary($sValue, 2) ; ��������� � �������� ���
			; $sValue = StringReplace($sValue, '000a00', '000000') ; �� ����� �� ������� ���������������� � ����������� ������ �������� ����� �������
			; $sValue &= '00000000' ; ����������������� ������ ��������� ��������� ������, ������ �� ��������� ����������, ������ �������� ��� ��� ������ ������ ��� ���������
		Case 8
			$sValue = StringTrimLeft($sValue, 2)
			$L = 'hex(8):'
		Case 10
			$L = 'hex(a):'
		Case 11
			$L = 'hex(b):'
		Case 9
			; $k = -1
			$sValue = StringTrimLeft($sValue, 2)
			$L = 'hex(9):'
	EndSwitch
	$hex = ''
	$aValue=StringRegExp($sValue, '..', 3)
	$len = UBound($aValue) ; �� �����. �������� ��������� ������� �����. �������� ������ ������ ������
	If $lenVN >= 69 Then $lenVN = 66
	$s0 = 22 - ($lenVN - Mod($lenVN, 3)) / 3 ; ���������� �������� ��� ������ ������ reg-������
	Switch $sValuetype
		Case 7,8,9
			$s0 -= 1
	EndSwitch
	$s = 0
	$r = 0
	For $i = $k To $len-1 ; ���� ��������� ���������� ������� �����, � �������������� �������
		If $s = $s0 Or $r = 24 Then
			$hex &= $aValue[$i] & ',\' & @CRLF & '  '
			$s = 24
			$r = 0
		Else
			$hex &= $aValue[$i] & ','
			$s += 1
			$r += 1
		EndIf
	Next
	$hex = StringTrimRight($hex, 1)
	If StringRight($hex, 5) = ',\' & @CRLF & ' ' Then $hex = StringTrimRight($hex, 5) ;������� ����� ��������
	$hex = StringLower($hex) ; �������������� � ��������
	Return $hex
EndFunc   ;==>_HEX