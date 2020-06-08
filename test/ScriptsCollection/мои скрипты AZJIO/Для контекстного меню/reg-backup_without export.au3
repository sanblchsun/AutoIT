#include <_RegFunc.au3> ; http://www.autoitscript.com/forum/topic/70108-custom-registry-functions-udf/
#include <Array.au3>

;  @AZJIO 2012.08
; ���� ������ ��������� ������� �������� �������� �������, ��������� �������� ����� �������� � ���������� ������� REG-�����.
; ������� Spiff59 �� ����������� ������ ���������� ��������, Erik Pilsits �� _RegFunc.

; En
$LngCM = 'Backup reg'
$LngSel1 = 'Select'
$LngSel2 = 'REG-File'
$LngPr1 = '1. Search for unique , 0 %'
$LngPr2 = '%,  Key:'
$LngS = 'sec'
$LngPr3 = '2. Export, 0 %,  Key:'
$LngPr4 = '2. Export,'
; $LngErr1 = 'Key:"'
; $LngErr2 = '" Valuename:"'
; $LngErr3 = '" type:"'
; $LngErr4 = '" Value:"'

; Ru
; ���� �������, �� ������������ ���
If @OSLang = 0419 Then
	$LngCM = '�������������� reg-������'
	$LngSel1 = '����� �����, ������ �������� �������������.'
	$LngSel2 = 'REG-����'
	$LngPr1 = '1. ����� ����������, 0 %'
	$LngPr2 = '%, ������:'
	$LngS = '���'
	$LngPr3 = '2. ������� �� �������, 0 %,  ��������:'
	$LngPr4 = '2. ������� �� �������,'
	; $LngErr1 = '����:"'
	; $LngErr2 = '" ��������:"'
	; $LngErr3 = '" ���:"'
	; $LngErr4 = '" ��������:"'
EndIf

; ������� ��������� �������
$Author_Date = '@AZJIO 2012.08'
; $sHeader = 'REGEDIT4' ; ��� win98
$sHeader = 'Windows Registry Editor Version 5.00'
$iTrDel = 1 ; ���� 1 - ��������� ���� �������� �����, 0 - �� ���������
Global $Data = '', $sKey, $DataErr = '', $Re = '', $sKey = '', $sValuename, $sValue, $sValuetype, $L, $hex

; ���������� � ������
RegRead("HKCR\regfile\shell\mbackup", '')
If @error = 1 Then
	;����������� � ������� � ����������� � ��������� �����, ��� ������ �������
	RegWrite("HKCR\regfile\shell\mbackup", "", "REG_SZ", $LngCM)
	RegWrite("HKCR\regfile\shell\mbackup\command", "", "REG_SZ", @AutoItExe & ' "' & @SystemDir & '\reg-backup.au3" "%1"')
	If Not FileExists(@SystemDir & '\reg-backup.au3') Then FileCopy(@ScriptFullPath, @SystemDir, 1)
EndIf

;���������� $sTarget ��������� ������������ ������ � ����������� ����
If $CmdLine[0] Then
	$sPathReg = $CmdLine[1]
Else
	$sPathReg = FileOpenDialog($LngSel1, @ScriptDir & "", $LngSel2 & " (*.reg)", 1 + 4)
	If @error Then Exit
EndIf

$aPath = StringRegExp($sPathReg, "^(.*)\\(.*)\.(.*)$", 3) ; ������: ����, ��� � ����������

$timer0 = TimerInit() ; �������� �����
; ���������� ��� ������ ����� � ������� ����� �� ������ ���� ���� ����������
$iNFile = 1
While FileExists($aPath[0] & '\' & $aPath[1] & '_BAK' & $iNFile & '.reg') Or FileExists($aPath[0] & '\' & $aPath[1] & '_DEL' & $iNFile & '.reg')
	$iNFile += 1
WEnd

;�������� ��������� � ���� �������� ���� reg-���� 100�� � �����
ProgressOn($LngCM, $aPath[1] & '.reg', $LngPr1 & @CRLF & @CRLF & @Tab & @Tab & @Tab & $Author_Date, -1, -1, 18)

$sRegData = FileRead($sPathReg) ; ��������� ������������ ���� ��� ������

; �������� ������ ������
$sRegData = StringTrimRight(StringRegExpReplace($sRegData & "[", "\[[^\]]*\]\s*(?=\[)", ""), 1)
;$sRegData=StringRegExpReplace($sRegData,"(\[.*\])(?=(\s+\[.*|\s+$|$))","")
$sRegData = StringReplace($sRegData, "]", "\")
$aRegKey = StringRegExp($sRegData, "(?m)^(\[HK.*\\)(?:\r$|\z)", 3) ; �������� ������� ����� �������
If @error Then Exit ; ���� ���� ������, �� �����
_ArraySort($aRegKey, 0) ; ����������� �� ��������

$n = UBound($aRegKey)
$i = 0
For $j = 1 to $n-1
    If Not StringInStr($aRegKey[$j], $aRegKey[$i]) Then
        $i += 1
        $aRegKey[$i] = $aRegKey[$j]
    Endif
Next
ReDim $aRegKey[$i + 1]
$n = $i

$timer0 = Round(TimerDiff($timer0) / 1000)

ProgressSet(0, $LngPr3 & ' ' & $i+1 & @CRLF & @CRLF & @Tab & @Tab & @Tab & $Author_Date)
$timer1 = TimerInit() ; �������� ����� ��� ����� ������� �������� ��������
$Data = ''
$z = 1

$sRegDel = ''
; _ArrayDisplay($aRegKey, 'Array')
; Exit
For $i = 0 To $n
	$sKey = StringRegExpReplace($aRegKey[$i], '^\[|\\$', "") ; �������� ������ � ������, ���� ������ ����� ������
	If $iTrDel Then $sRegDel &= '[-' & $sKey & ']' & @CRLF ; ������ ������ � reg-���� ��������
	If _RegKeyExists($sKey) Then ; ���� ����������, ��
		_RegExport_X($sKey, $Data) ; ������� ���������� ������� ������� � ���������� $Data
		; ����������: ������� ������ ���������
		$ps = Round(($i+1) * 100 / ($n+1))
		ProgressSet($ps, $LngPr4 & ' ' & $ps & ' ' & $LngPr2 & ' ' & $i+1 & ' / ' & $n & @CRLF & _
		$timer0 & ' + ' & Round(TimerDiff($timer1) / 1000) & ' ' & $LngS & @CRLF & @Tab & @Tab & @Tab & $Author_Date)
	EndIf
Next
ProgressOff()

If $Data Or $DataErr Then ; ����� � ����, ���� ������ ��������
	$hFile = FileOpen($aPath[0] & '\' & $aPath[1] & '_BAK' & $iNFile & '.reg', 2)
	FileWrite($hFile, $sHeader & @CRLF & $Data & @CRLF & $DataErr & @CRLF)
	FileClose($hFile)
EndIf

If $iTrDel And $sRegDel Then; ����� � ����, ���� ������� ���� � ���� $iTrDel �������
	$hFile = FileOpen($aPath[0] & '\' & $aPath[1] & '_DEL' & $iNFile & '.reg', 2)
	FileWrite($hFile, '#' & $sHeader & @CRLF & @CRLF & $sRegDel)
	FileClose($hFile)
EndIf


Func _RegExport_X($sKey, ByRef $Data)
	Local $aaaValue, $asValue0, $cmd, $DataErr, $hex, $i, $L, $line1, $Re, $sTemp, $sValue, $sValue0, $sValuename, $sValuetype

	$i = 0
	Do
		$i += 1
		; If $i=1 Then $Data &= @CRLF & '[' & $sKey & ']' & @CRLF
		$sValuename = RegEnumVal($sKey, $i)
		If @error Then ExitLoop
		$sValue = _RegRead($sKey, $sValuename, True)
		If @error Then ContinueLoop
		$sValuetype = @extended
		; $sValueName = StringRegExpReplace($sValueName, '[\\]', "\\$0") ; ������ �������� � ��������� ��������� ����� �� �������
		$sValuename = StringReplace($sValuename, '\', "\\") ; ������ �������� � ��������� ��������� ����� �� �������
		If $i = 1 Then $Data &= @CRLF & '[' & $sKey & ']' & @CRLF ; ���� ������ ����������� � ������, �� ��� ������� ���� ������ ���������
		; ����� ��� ������� ���� ������ ���� �������� ���������� ��������
		Switch $sValuetype
			Case 1
				$sValue = StringReplace(StringReplace(StringRegExpReplace($sValue, '["\\]', "\\$0"), '=\"\"', '="\"'), '\"\"', '\""')
				$Data &= '"' & $sValuename & '"="' & $sValue & '"' & @CRLF
			Case 7, 2
				$hex = _HEX($sValuetype, $sValue, $sValuename, $L)
				$Data &= '"' & $sValuename & '"=' & $L & $hex & @CRLF
			Case 4
				$Data &= '"' & $sValuename & '"=dword:' & StringLower(Hex(Int($sValue))) & @CRLF
			Case 3
				$hex = _HEX(3, $sValue, $sValuename, $L)
				$Data &= '"' & $sValuename & '"=' & $L & $hex & @CRLF
			Case 0, 8, 9, 10, 11 ; ��� ������ ������� �� ��������� AutoIt3, ������� ������������ ������� ���������� ��������.
				; ����������� �������� � ������� � ������ � ��
				$hex = _HEX($sValuetype, $sValue, $sValuename, $L)
				$Data &= '"' & $sValuename & '"=' & $L & $hex & @CRLF
			Case Else
				$DataErr &= '# error... Key:"' & $sKey & '" Valuename:"' & $sValuename & '" Value:"' & $sValue & '" type:"' & $sValuetype & '"' & @CRLF
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
EndFunc

; ������� ����������������� ������, �������� � �������� - �������� ������ � ������� reg-����� (������� �����)
; ������ ����������� ������� ��������� ������������� �������� � reg-������ ���������� �������� �� ������� ����������.
Func _HEX($sValuetype, ByRef $sValue, $sValuename, ByRef $L)
	Local $aValue, $hex, $i, $k, $len, $lenVN, $r, $s, $s0
	$k = 0
	$lenVN = StringLen($sValuename) - 1
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
			$lenVN = StringLen($sValuename) + 2
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
	$aValue = StringRegExp($sValue, '..', 3)
	$len = UBound($aValue) ; �� �����. �������� ��������� ������� �����. �������� ������ ������ ������
	If $lenVN >= 69 Then $lenVN = 66
	$s0 = 22 - ($lenVN - Mod($lenVN, 3)) / 3 ; ���������� �������� ��� ������ ������ reg-������
	Switch $sValuetype
		Case 7, 8, 9
			$s0 -= 1
	EndSwitch
	$s = 0
	$r = 0
	For $i = $k To $len - 1 ; ���� ��������� ���������� ������� �����, � �������������� �������
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
EndFunc