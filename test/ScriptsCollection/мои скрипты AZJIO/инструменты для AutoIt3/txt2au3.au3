;  @AZJIO
; ����������: ��������� ������ �� ������� ���������� ����� 4085 �������, ��������������� �������� �����, ������ ��������� ' � ������ ������� ����������. ������ ��������� �������� ������ ������ ���������.
; � ��� ������ ��������� ���-������ ��� ������ � Notepad++. ���������� ����� ����� ��������� ������� � �������� ���-������. ���� ��������� ��������, �� �������� ��� � ����� ������ � ������ �� ������� ��������� ������� ������� ����������� ������� � Notepad++, ��� ���� � ������ ���������� ������ ������ � ����� �������� ��� � ���� ��������� Notepad++ ��� SciTE.
;���������� ������� ��� Notepad++ ��� ���� � "$(CURRENT_WORD)" ����������� ���������, ����� �������� �������������� ��� ��������� ����������.
;"C:\Program Files\AutoIt3AutoIt3.exe" "C:\Program Files\AutoIt3\txt2au3.au3" "$(CURRENT_WORD)"

#NoTrayIcon
$bufer_read = 1 ; ���� 1 �� ������ �� ������, ���� 0 �� ������ ������ �����
$bufer_write = 1 ; ���� 1 �� ��������� � �����, ���� 0 �� ��������� � ���� file_0.au3 � �������� ����������
$Msg_FW = 0 ; ���� 1 �� � �������� ������ ������ � ����, ���� 0 �� ������ ���������

If $CmdLine[0] <> 0 And $CmdLine[1] <> '' Then
	$text = $CmdLine[1]
Else
	If $bufer_read = 1 Then
		$text = ClipGet()
	Else
		$Path = FileOpenDialog("����� �����.", @WorkingDir & "", "������ (*.*)", 1 + 4)
		If @error Then Exit
		$file = FileOpen($Path, 0)
		$text = FileRead($file)
		FileClose($file)
	EndIf
EndIf

;==============================
;����� ���� �� UDF File.au3 ��� ���������� ������� ��������� � ������
If StringInStr($text, @LF) Then
	$aFiletext = StringSplit(StringStripCR($text), @LF)
ElseIf StringInStr($text, @CR) Then ;; @LF does not exist so split on the @CR
	$aFiletext = StringSplit($text, @CR)
Else ;; unable to split the file
	If StringLen($text) Then
		Dim $aFiletext[2] = [1, $text]
	Else
		MsgBox(0, "���������", "��� ������")
		Exit
	EndIf
EndIf
; ���������� ���������� $text
$text = '$text= _' & @CRLF
; $Kol=1
$Kol2 = ''
$ostatok = ''
$Kol3 = ''
$Kol4 = 0
$trkol = 0
$trkol2 = 0
$Limit = 4070 ; ����� 4085, �� ����� ���� ������, ��� ��� � ������������ ���������� �� ����� 4084 ($text&=)
For $i = 1 To UBound($aFiletext) - 1
	$aFiletext[$i] = StringReplace($aFiletext[$i], "'", "''")
	; ���� � ������ ����� 4084 �������, �� ��������� ������ �� ������������ ���������� ($text&=)
	If StringLen($aFiletext[$i]) > $Limit Then
		$trkol = 1
		$trkol2 = 1
		$text = StringTrimRight($text, 6) & @CRLF
		$Kol2 = StringLen($aFiletext[$i])
		$Kol4 += $Kol2
		$ostatok = Mod($Kol2, $Limit)
		$Kol3 = Int($Kol2 / $Limit)
		If $ostatok <> 0 Then $Kol3 += 1
		For $z = 1 To $Kol3
			If $z = $Kol3 Then
				$text &= '$text&= ' & '"' & StringMid($aFiletext[$i], 1) & '" & @CRLF & _' & @CRLF
			Else
				$text &= '$text&= ' & '"' & StringMid($aFiletext[$i], 1, $Limit) & '"' & @CRLF
				$aFiletext[$i] = StringTrimLeft($aFiletext[$i], $Limit)
			EndIf
		Next
	EndIf
	
	If $trkol2 = 1 Then
		$trkol2 = 0
		ContinueLoop
	EndIf
	
	; ���� � ����� �������� ����� ����� 4084 �������, �� ��������� ������ �� ������������ ���������� ($text&=), � ������ ������ ��������� �����������.
	; � ����� ���� �������� ���������� ������� "������ ����� 4084 �������"
	If StringLen($text) > $Limit + $Kol4 Or $trkol = 1 Then
		$trkol = 0
		$text = StringTrimRight($text, 6) & @CRLF & '$text&= _' & @CRLF
		$Kol4 = StringLen($text)
	EndIf
	
	If $aFiletext[$i] = '' Then
		$text &= '@CRLF & _' & @CRLF
	Else
		$text &= '''' & $aFiletext[$i] & ''' & @CRLF & _' & @CRLF
	EndIf
Next
$text = StringTrimRight($text, 14)
If StringRight($text, 3) = ' & ' Then $text = StringTrimRight($text, 3) ; ���� ����� � ����� � ���������� �����, �� �������������� �������� 3-� ��������

If $Msg_FW = 0 Then
	$text &= @CRLF & 'MsgBox(0, "���������", $text)'
Else
	$text &= @CRLF & '$file = FileOpen(@ScriptDir&"\file.txt",2)' & @CRLF & 'FileWrite($file, $text)' & @CRLF & 'FileClose($file)'
EndIf
;==============================

If $bufer_write = 1 Then
	ClipPut($text)
Else
	$filetxt = @ScriptDir & '\file_'
	$i = 0
	While FileExists($filetxt & $i & '.au3')
		$i = $i + 1
	WEnd
	$filetxt = $filetxt & $i & '.au3'

	$file = FileOpen($filetxt, 2)
	FileWrite($file, $text)
	FileClose($file)
EndIf