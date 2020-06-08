#include-once
#Include <_RegFunc.au3> ; _RegRead   http://www.autoitscript.com/forum/topic/70108-custom-registry-functions-udf/

; 2012.06.08
; _RegSearchKey
; _RegSearchValueName
; _RegSearchValue

; ============================================================================================
; Function Name ...: _RegSearchKey (__RegSearchKey)
; Description ........: Search for a registry key name including the registry subkeys.
; Syntax................: _RegSearchKey($sMask[, $sKey[, $iFull = 1[, $iArray = 1]]])
; Parameters:
;		$sMask - mask, using symbols "*" and "?" with the separator "|".
;		$sKey - the registry key in which to search. By default, search the entire registry
;		$iFull - Affect the result
;                  |0 - the relative path to a registry key
;                  |1 - the full path to the registry key
;		$iArray - Specifies the result as an array or list
;                  |0 - the list with a separator @CRLF
;                  |1 - array, where $iArray[0]=number of found (By default)
;                  |2 - array, where $iArray[0] contains the first found section of the registry
; Return values ....: Success - Array or list with separator @CRLF
;					Failure - empty string, @error:
;                  |0 - no error
;                  |2 - Invalid mask
;                  |3 - not found
; Author(s) ..........: AZJIO
; Remarks ..........: Not case sensitive only for the Latin alphabet
; ============================================================================================
; ��� ������� ...: _RegSearchKey (__RegSearchKey)
; �������� ........: ����� ������� ������� �� �����, ������� ���������� �������.
; ���������.......: _RegSearchKey($sMask[, $sKey[, $iFull = 1[, $iArray = 1]]])
; ���������:
;		$sMask - ����� � �������������� �������� "*" � "?" � ������������� ����� "|".
;		$sKey - ������, � ������� ����������� �����. �� ��������� ���� ������
;		$iFull - ������ �� ���������
;                  |0 - ������������� ���� � ������� �������
;                  |1 - ������ ���� � ������� �������
;		$iArray - (0,1,2) ���������� ����� ����������, ������ ��� ������
;                  |0 - ������ � ������������ @CRLF
;                  |1 - ������, � ������� $iArray[0]=���������� ��������� �������� (�� ���������)
;                  |2 - ������, � ������� $iArray[0] �������� ������ ��������� ������
; ������������ ��������: ������� - ������ ��� ������ � ������������ @CRLF
;					�������� - ������ ������, @error:
;                  |0 - ��� ������
;                  |2 - �������� �����
;                  |3 - ������ �� �������
; ����� ..........: AZJIO
; ���������� ..: ��� ������ ������� ���� �� ����������� ������ ��� ���������� ��������
; ============================================================================================
Func _RegSearchKey($sMask, $sKey = '*', $iFull = 1, $iArray = 1)
	Local $vKeyList, $aKeyList, $i, $s=Chr(1)
	If $sMask = '\' Then Return SetError(2, 0, '')
	; If Not StringRegExp($sKey, '(�������� ����������) Or StringInStr($sKey, '\\') Then Return SetError(1, 0, '')
	; If Not Exists($sKey) Then Return SetError(1, 0, '') ; �������� ��������������� �������

	If $sKey = '*' Or $sKey = '' Then
		__RegSearchKey($vKeyList, 'HKEY_CLASSES_ROOT\') ; 90 ���
		__RegSearchKey($vKeyList, 'HKEY_CURRENT_USER\') ; 0.7 ���
		__RegSearchKey($vKeyList, 'HKEY_LOCAL_MACHINE\') ; 6.7 ���
		__RegSearchKey($vKeyList, 'HKEY_USERS\') ; 0.9 ���
		__RegSearchKey($vKeyList, 'HKEY_CURRENT_CONFIG\') ; 0.01 ���
	Else
		If StringRight($sKey, 1) <> '\' Then $sKey &= '\'
		__RegSearchKey($vKeyList, $sKey)
	EndIf
	
	$vKeyList = StringTrimRight($vKeyList, 2)
	$sMask = StringReplace(StringReplace(StringRegExpReplace($sMask, '[][$^.{}()+|]', '\\$0'), '?', '.'), '*', '.*?')
	; $sMask = StringRegExpReplace($sMask, '[][$^.{}()+*?|]', '\\$0') ; ����� $mode ��� ������ ��������� ��������
	
	$aKeyList = StringRegExp($vKeyList, '(?mi)^(.+\001(?:' & $sMask & '))(?:\r|\z)', 3)

	$vKeyList = ''
	For $i = 0 To UBound($aKeyList) - 1
		$vKeyList &= $aKeyList[$i] & @CRLF
	Next
	
	$vKeyList = StringReplace(StringTrimRight($vKeyList, 2), $s, '') ; ������������ ������ �����������, ������ "|"
	If Not $vKeyList Then Return SetError(3, 0, '')

	If $iFull = 0 Then $vKeyList = StringRegExpReplace($vKeyList, '(?m)^(?:.{' & StringLen($sKey) & '})(.*)$', '\1')
	Switch $iArray
		Case 1
			$vKeyList = StringSplit($vKeyList, @CRLF, 1)
		Case 2
			$vKeyList = StringSplit($vKeyList, @CRLF, 3)
	EndSwitch
	Return $vKeyList
EndFunc

Func __RegSearchKey(ByRef $sKeyList, $sKey)
	Local $sTmp, $i = 0, $s=Chr(1)
	While 1
		$i += 1
		$sTmp = RegEnumKey($sKey, $i)
		If @error Then ExitLoop
		$sKeyList &= $sKey & $s & $sTmp & @CRLF
		__RegSearchKey($sKeyList, $sKey & $sTmp & '\')
	WEnd
EndFunc





; ============================================================================================
; Function Name ...: _RegSearchValueName (__RegSearchValueName)
; Description ........: Search for a registry value name including the registry subkeys.
; Syntax................: _RegSearchKey($sMask[, $sKey[, $iFull = 1[, $iArray = 1]]])
; Parameters:
;		$sMask - mask, using symbols "*" and "?" with the separator "|".
;		$sKey - the registry key in which to search. By default, search the entire registry
;		$iFull - Affect the result
;                  |0 - the relative path to a registry key
;                  |1 - the full path to the registry key
;		$iArray - Specifies the result as an array or list
;                  |0 - the list with a separator @CRLF
;                  |1 - array, where $iArray[0]=number of found (By default)
;                  |2 - array, where $iArray[0] contains the first found section of the registry
; Return values ....: Success - Array or list with separator @CRLF
;					Failure - empty string, @error:
;                  |0 - no error
;                  |2 - Invalid mask
;                  |3 - not found
; Author(s) ..........: AZJIO
; Remarks ..........: Not case sensitive only for the Latin alphabet
; ============================================================================================
; ��� ������� ...: _RegSearchValueName (__RegSearchValueName)
; �������� ........: ����� ��������� ������� �� �����, ������� ���������� �������.
; ���������.......: _RegSearchValueName($sMask[, $sKey[, $iFull = 1[, $iArray = 1]]])
; ���������:
;		$sMask - ����� � �������������� �������� "*" � "?" � ������������� ����� "|".
;		$sKey - ������, � ������� ����������� �����. �� ��������� ���� ������
;		$iFull - ������ �� ���������
;                  |0 - ������������� ���� � ������� �������
;                  |1 - ������ ���� � ������� �������
;		$iArray - (0,1,2) ���������� ����� ����������, ������ ��� ������
;                  |0 - ������ � ������������ @CRLF
;                  |1 - ������, � ������� $iArray[0]=���������� ��������� ���������� (�� ���������)
;                  |2 - ������, � ������� $iArray[0] �������� ������ ��������� ������
; ������������ ��������: ������� - ������ ��� ������ � ������������ @CRLF
;					�������� - ������ ������, @error:
;                  |0 - ��� ������
;                  |2 - �������� �����
;                  |3 - ������ �� �������
; ����� ..........: AZJIO
; ���������� ..: ��� ������ ������� ���� �� ����������� ������ ��� ���������� ��������
; ============================================================================================
Func _RegSearchValueName($sMask, $sKey = '*', $iFull = 1, $iArray = 1)
	Local $vKeyList, $aKeyList, $i, $s=Chr(1)
	If $sMask = '\' Then Return SetError(2, 0, '')
	; If Not StringRegExp($sKey, '(�������� ����������) Or StringInStr($sKey, '\\') Then Return SetError(1, 0, '')
	; If Not Exists($sKey) Then Return SetError(1, 0, '') ; �������� ��������������� �������

	If $sKey = '*' Or $sKey = '' Then
		__RegSearchValueName($vKeyList, 'HKEY_CLASSES_ROOT\') ; 90 ���
		__RegSearchValueName($vKeyList, 'HKEY_CURRENT_USER\') ; 3.3 ���
		__RegSearchValueName($vKeyList, 'HKEY_LOCAL_MACHINE\') ; 15 ���
		__RegSearchValueName($vKeyList, 'HKEY_USERS\') ; 4.2 ���
		__RegSearchValueName($vKeyList, 'HKEY_CURRENT_CONFIG\') ; 0.01 ���
	Else
		; If StringRight($sKey, 1) <> '\' Then $sKey &= '\'
		__RegSearchValueName($vKeyList, $sKey)
	EndIf
	
	$vKeyList = StringTrimRight($vKeyList, 2)
	$sMask = StringReplace(StringReplace(StringRegExpReplace($sMask, '[][$^.{}()+]', '\\$0'), '?', '.'), '*', '.*?')
	; $sMask = StringRegExpReplace($sMask, '[][$^.{}()+*?|]', '\\$0') ; ����� $mode ��� ������ ��������� ��������
	
	$aKeyList = StringRegExp($vKeyList, '(?mi)^(.+\001(?:' & $sMask & '))(?:\r|\z)', 3)

	$vKeyList = ''
	For $i = 0 To UBound($aKeyList) - 1
		$vKeyList &= $aKeyList[$i] & @CRLF
	Next

	$vKeyList = StringTrimRight($vKeyList, 2)
	If Not $vKeyList Then Return SetError(3, 0, '')

	If $iFull = 0 Then $vKeyList = StringRegExpReplace($vKeyList, '(?m)^(?:.{' & StringLen($sKey)+1 & '})(.*)$', '\1')
	Switch $iArray
		Case 0
			$vKeyList = StringReplace($vKeyList, $s, @Tab&'|'&@Tab)
		Case 1
			__ToArray2Row($vKeyList, 1)
		Case 2
			__ToArray2Row($vKeyList, 0)
	EndSwitch
	Return $vKeyList
EndFunc

Func __ToArray2Row(ByRef $vKeyList, $m)
	Local $aArray, $i, $s=Chr(1)
	$aArray = StringSplit(StringReplace($vKeyList, @CRLF, $s), $s)
	Dim $vKeyList[$aArray[0]/2+$m][2]
	If $m Then
		For $i = 1 To $aArray[0] Step 2
			$p=($i+1)/2
			$vKeyList[$p][0]=$aArray[$i]
			$vKeyList[$p][1]=$aArray[$i+1]
		Next
		$vKeyList[0][0]=$p
	Else
		For $i = 1 To $aArray[0] Step 2
			$p=($i-1)/2
			$vKeyList[$p][0]=$aArray[$i]
			$vKeyList[$p][1]=$aArray[$i+1]
		Next
	EndIf
EndFunc

Func __RegSearchValueName(ByRef $sKeyList, $sKey)
	Local $sTmp, $i = 0, $s=Chr(1)
	While 1
		$i += 1
		$sTmp = RegEnumVal($sKey, $i)
		If @error Then ExitLoop
		$sKeyList &= $sKey & $s & $sTmp & @CRLF
	WEnd
	$i = 0
	While 1
		$i += 1
		$sTmp = RegEnumKey($sKey, $i)
		If @error Then ExitLoop
		__RegSearchValueName($sKeyList, $sKey & '\' & $sTmp)
	WEnd
EndFunc



; ============================================================================================
; Function Name ...: _RegSearchValue (__RegSearchValue)
; Description ........: Search  the value in the registry including the registry subkeys.
; Syntax................: _RegSearchValue($sMask[, $sKey[, $iFull = 1[, $iArray = 1]]])
; Parameters:
;		$sMask - mask, using symbols "*" and "?" with the separator "|".
;		$sKey - the registry key in which to search. By default, search the entire registry
;		$iFull - Affect the result
;                  |0 - the relative path to a registry key
;                  |1 - the full path to the registry key
;		$iArray - Specifies the result as an array or list
;                  |0 - the list with a separator @CRLF
;                  |1 - array, where $iArray[0]=number of found (By default)
;                  |2 - array, where $iArray[0] contains the first found section of the registry
; Return values ....: Success - Array or list with separator @CRLF
;					Failure - empty string, @error:
;                  |0 - no error
;                  |2 - Invalid mask
;                  |3 - not found
; Author(s) ..........: AZJIO
; Remarks ..........: Not case sensitive only for the Latin alphabet
; ============================================================================================
; ��� ������� ...: _RegSearchValue (__RegSearchValue)
; �������� ........: ����� �������� ������� �� ����� �������, � ���������� �������.
; ���������.......: _RegSearchValue($sMask[, $sKey[, $iFull = 1[, $iArray = 1]]])
; ���������:
;		$sMask - ����� � �������������� �������� "*" � "?" � ������������� ����� "|".
;		$sKey - ������, � ������� ����������� �����. �� ��������� ���� ������
;		$iFull - ������ �� ���������
;                  |0 - ������������� ���� � ������� �������
;                  |1 - ������ ���� � ������� �������
;		$iArray - (0,1,2) ���������� ����� ����������, ������ ��� ������
;                  |0 - ������ � ������������ @CRLF
;                  |1 - ������, � ������� $iArray[0]=���������� ��������� �������� (�� ���������)
;                  |2 - ������, � ������� $iArray[0] �������� ������ ��������� ������
; ������������ ��������: ������� - ������ ��� ������ � ������������ @CRLF
;					�������� - ������ ������, @error:
;                  |0 - ��� ������
;                  |2 - �������� �����
;                  |3 - ������ �� �������
; ����� ..........: AZJIO
; ���������� ..: ��� ������ ������� ���� �� ����������� ������ ��� ���������� ��������
; ============================================================================================
Func _RegSearchValue($sMask, $sKey = '*', $iFull = 1, $iArray = 1)
	Local $vKeyList, $aKeyList, $i, $s0=Chr(2), $s=Chr(1)
	If $sMask = '\' Then Return SetError(2, 0, '')
	; If Not StringRegExp($sKey, '(�������� ����������) Or StringInStr($sKey, '\\') Then Return SetError(1, 0, '')
	; If Not Exists($sKey) Then Return SetError(1, 0, '') ; �������� ��������������� �������

	If $sKey = '*' Or $sKey = '' Then
		__RegSearchValue($vKeyList, 'HKEY_CLASSES_ROOT\') ; 120 ���
		__RegSearchValue($vKeyList, 'HKEY_CURRENT_USER\') ; 24 ���
		__RegSearchValue($vKeyList, 'HKEY_LOCAL_MACHINE\') ; 65 ���
		__RegSearchValue($vKeyList, 'HKEY_USERS\') ; 27 ���
		__RegSearchValue($vKeyList, 'HKEY_CURRENT_CONFIG\') ; 0.02 ���
	Else
		; If StringRight($sKey, 1) <> '\' Then $sKey &= '\'
		__RegSearchValue($vKeyList, $sKey)
	EndIf

	$vKeyList = StringTrimRight($vKeyList, 2)
	$sMask = StringReplace(StringReplace(StringRegExpReplace($sMask, '[][$^.{}()+]', '\\$0'), '?', '.'), '*', '.*?')

	$aKeyList = StringRegExp($vKeyList, '(?mi)^(.+\001(?:' & $sMask & '))(?:\r|\z)', 3)

	$vKeyList = ''
	For $i = 0 To UBound($aKeyList) - 1
		$vKeyList &= $aKeyList[$i] & @CRLF
	Next

	$vKeyList = StringTrimRight($vKeyList, 2)
	If Not $vKeyList Then Return SetError(3, 0, '')

	If $iFull = 0 Then $vKeyList = StringRegExpReplace($vKeyList, '(?m)^(?:.{' & StringLen($sKey)+1 & '})(.*)$', '\1')
	Switch $iArray
		Case 0
			$vKeyList = StringReplace($vKeyList, $s, @Tab&'|'&@Tab)
			$vKeyList = StringReplace($vKeyList, $s0, @Tab&'|'&@Tab)
		Case 1
			__ToArray3Row($vKeyList, 1)
		Case 2
			__ToArray3Row($vKeyList, 0)
	EndSwitch
	Return $vKeyList
EndFunc

Func __ToArray3Row(ByRef $vKeyList, $m)
	Local $aArray, $i, $s0=Chr(2), $s=Chr(1)
	$aArray = StringSplit(StringReplace(StringReplace($vKeyList, @CRLF, $s), $s0, $s), $s)
	Dim $vKeyList[$aArray[0]/3+$m][3]
	If $m Then
		For $i = 1 To $aArray[0] Step 3
			$p=($i+2)/3
			$vKeyList[$p][0]=$aArray[$i]
			$vKeyList[$p][1]=$aArray[$i+1]
			$vKeyList[$p][2]=$aArray[$i+2]
		Next
		$vKeyList[0][0]=$p
	Else
		For $i = 1 To $aArray[0] Step 3
			$p=($i-1)/3
			$vKeyList[$p][0]=$aArray[$i]
			$vKeyList[$p][1]=$aArray[$i+1]
			$vKeyList[$p][2]=$aArray[$i+2]
		Next
	EndIf
EndFunc

Func __RegSearchValue(ByRef $sKeyList, $sKey)
	Local $sTmp, $sVal, $i = 0, $s0=Chr(2), $s=Chr(1)
	While 1
		$i += 1
		$sTmp = RegEnumVal($sKey, $i)
		If @error Then ExitLoop
		$sVal = _RegRead($sKey, $sTmp) ; RegRead
		If Not @error Then $sKeyList &= $sKey & $s0 & $sTmp & $s & $sVal & @CRLF
	WEnd
	$i = 0
	While 1
		$i += 1
		$sTmp = RegEnumKey($sKey, $i)
		If @error Then ExitLoop
		__RegSearchValue($sKeyList, $sKey & '\' & $sTmp)
	WEnd
EndFunc