
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