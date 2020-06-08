;  @AZJIO 25.03.2010

; �������� ��������� �������
$tempfile=@TempDir&'\temporarily.reg'
$razdelit='' ; ��������� ���������������� �����, ���������� ����, ��� ����� � ����� ��������
$del=1 ;���� 1 - ��������� ���� �������� �����, 0 - �� ���������

$close = RegRead("HKCR\regfile\shell\mbackup", '')
If @error=1 Then
	;����������� � ������� � ����������� � ��������� �����, ��� ������ �������
RegWrite("HKCR\regfile\shell\mbackup","","REG_SZ","������������ reg")
RegWrite("HKCR\regfile\shell\mbackup\command","","REG_SZ",@AutoItExe&' "'&@SystemDir&'\reg-backup.au3" "%1"')
If Not FileExists(@SystemDir&'\reg-backup.au3') Then FileCopy(@ScriptDir&'\reg-backup.au3', @SystemDir,1)
EndIf

;���������� $sTarget ��������� ������������ ������ � ����������� ����
If $CmdLine[0]=0 Then
	$regfile = FileOpenDialog("����� ����� *.reg, ��� �������� ����� �������� �����.", @ScriptDir & "", "reg-���� (*.reg)", 1 + 4 )
	If @error Then Exit
Else
$regfile=$CmdLine[1]
EndIf


$aRegfileS = StringRegExp($regfile, "(^.*)\\(.*)$", 3) ; ����� ������� ������� reg-����� ��� �������� ������
$aRegfileS1 = StringRegExp($regfile, "(^.*)\\(.*)\.(.*)$", 3)

$timer = TimerInit() ; �������� �����
; ���������� ��� ������ ����� � ������� ����� �� ������ ���� ���� ����������
$i = 1
While FileExists($aRegfileS1[1]&'_BAK'&$i&'.reg') or FileExists($aRegfileS1[1]&'_DEL'&$i&'.reg')
    $i +=1
WEnd
$filename=$aRegfileS1[1]&'_BAK'&$i&'.reg'
$delname=$aRegfileS1[1]&'_DEL'&$i&'.reg'

If $del=1 Then
$delfile = FileOpen($aRegfileS[0]&'\'&$delname, 1)
FileWrite($delfile, '#Windows Registry Editor Version 5.00'&@CRLF&@CRLF)
EndIf

;�������� ��������� � ���� �������� ���� reg-���� 100�� � �����
ProgressOn("�������������", $aRegfileS[1], "1. ������� ��������, 0 %"&@CRLF&@CRLF&"			@AZJIO 25.03.2010",-1,-1,18)

$regfileT = FileOpen($regfile, 0) ; ��������� ������������ ���� ��� ������
$regfileT1= FileRead($regfileT)
FileClose($regfileT)
 ; �������� ������ ������
$regfileT1=StringTrimRight (StringRegExpReplace($regfileT1 & "[","\[[^\]]*\]\s*(?=\[)",""),1) 
;$regfileT1=StringRegExpReplace($regfileT1,"(\[.*\])(?=(\s+\[.*|\s+$|$))","")
$aRegfileT1 = StringRegExp($regfileT1, "(\[HK.*?\])", 3) ; �������� ������� ����� �������

$regfileT1=''
For $i = 0 to UBound($aRegfileT1) - 1 ; ����������� ������� � �������������� ����
$regfileT1&=$aRegfileT1[$i]&@CRLF
Next
$iaReg=UBound($aRegfileT1) - 1
; ������ ��������, ������ �����, ��������. ���� 1�� �������������� �� ������ � ���� �����.
; � ������ ��������� ������ ������� ������� � ����������� � ����� ������
; ���������� ���������� ���������������� ��������� ������, ���������� ����-������� �� ����������� ����
For $i = 0 to $iaReg
$regfileT1=StringRegExpReplace($regfileT1,StringRegExpReplace(StringTrimRight($aRegfileT1[$i], 1), "[][{}()*+?.\\^$|=<>#]", "\\$0")&'(\\.*|\])',"") 
If @Extended >0 Then $regfileT1 &= @CRLF&$aRegfileT1[$i] ; ��� ������ ������ ���������� ��� �������
$ps=Ceiling ($i*100/$iaReg)
ProgressSet( $ps, "1. ������� ��������, 0 %"&$ps & " %,  �����: "&$i&' / '&$iaReg&@CRLF&Ceiling(TimerDiff($timer) / 1000) & " ���"&@CRLF&"			@AZJIO 25.03.2010")
Next
$timer0=Ceiling(TimerDiff($timer) / 1000)
$regfileT1=StringRegExpReplace($regfileT1,'\n\r?\n\r?',"") ;�������� ������ �����

$aRecords = StringSplit($regfileT1, @CRLF) ; ���������� � ������ ���������

ProgressSet( 0, "2. ������� �� �������, 0 %,  �����: "&$i&@CRLF&@CRLF&"			@AZJIO 25.03.2010")
$timer1 = TimerInit() ; �������� ����� ��� ����� ������� �������� ��������
$filebackup = FileOpen($aRegfileS[0]&'\'&$filename, 1) ; ��������� �����-����
FileWrite($filebackup, 'Windows Registry Editor Version 5.00'&@CRLF&@CRLF)
;FileWrite($filebackup, 'REGEDIT4'&@CRLF&@CRLF) ; ��� win98
If $razdelit<>'' Then $razdelit&=@CRLF
$Data=''
$z=1
if IsInt($aRecords[0]/2) Then ; ������� �����
	$a=$aRecords[0]/2
Else
	$a=($aRecords[0]-1)/2
EndIf
For $i=1 To $aRecords[0]
	If StringLeft($aRecords[$i], 3)='[HK' Then ; ������� �������� ���������� ������ � �������� �������
		$temporarily = StringRegExpReplace($aRecords[$i],'\[|\]',"") ; �������� ������ � ������, ���� ������ ����� ������
		If $del=1 Then FileWrite($delfile, '[-'&$temporarily&']'&@CRLF)
		$reg1 = RegRead($temporarily, "") ; �������� ������������� �����
		If @error=1 Then
			ContinueLoop
		Else
			RunWait ( @Comspec&' /C reg export "'&$temporarily&'" "'&$tempfile&'"', '', @SW_HIDE )
			$vr = FileOpen($tempfile, 0)
			$vr1 = FileRead($vr)
			$vr1 = StringReplace($vr1, "Windows Registry Editor Version 5.00"&@CRLF&@CRLF, $razdelit)
			;$vr1 = StringReplace($vr1, "REGEDIT4"&@CRLF&@CRLF, $razdelit) ; ��� win98
			$Data &=$vr1
			FileClose($vr)
		EndIf
	EndIf
	; ����������: ������� ������ ���������, �������� ������� �� 2, ��� ��� � ������� � 2 ���� ������ �����
	$ps=Ceiling ($i*100/$aRecords[0])
	if IsInt($i/2) Then $z=$i/2
	ProgressSet( $ps, "2. ������� �� �������, "&$ps & " %,  �����: "&$z&' / '&$a&@CRLF&$timer0&' + '&Ceiling(TimerDiff($timer1) / 1000) & " ���"&@CRLF&"			@AZJIO 25.03.2010")
Next
ProgressOff()

$Data=StringTrimRight (StringRegExpReplace($Data & "[","\[[^\]]*\]\s*(?=\[)",""),1) 
FileWrite($filebackup, $Data)
; ��������� �����
If $del=1 Then FileClose($delfile)
FileClose($filebackup)

;���� ���� ������, �� ������� ���. ����������� ������ ������ � ������ ���� ����� ���������� ������.
If FileGetSize($aRegfileS[0]&'\'&$filename)=40 Then FileDelete($aRegfileS[0]&'\'&$filename)
If $del=1 Then 
   If FileGetSize($aRegfileS[0]&'\'&$delname)=41 Then FileDelete($aRegfileS[0]&'\'&$delname)
EndIf