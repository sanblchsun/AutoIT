
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=timeout_gfx.exe
#AutoIt3Wrapper_icon=timeout_gfx.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=timeout_gfx.exe
#AutoIt3Wrapper_Res_Fileversion=0.2.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO   (AutoIt3_v3.2.12.1...v3.3.6.1) 
; 16.8.2009 > 26.11.2010 - ���������, ������������� ���

#NoTrayIcon
GUICreate("������� ������� gfxboot",308,165)
GUICtrlCreateGroup("����������� ��������", 21, 10, 140, 106)
$Radio1 = GUICtrlCreateRadio("������ ������", 30, 30, 110, 20)
GUICtrlSetState($Radio1, 1)
$Radio2 = GUICtrlCreateRadio("����� �������", 30, 50, 110, 20)
$Radio3 = GUICtrlCreateRadio("������ ����", 30, 70, 110, 20)
$Radio4 = GUICtrlCreateRadio("����� �����", 30, 90, 110, 20)


GUICtrlCreateGroup("������� ���������", 166, 10, 120, 106)
GUICtrlCreateLabel ("������:", 175,28,60,20)
$inputHeight=GUICtrlCreateInput ("6", 235,27,35,19) ; ������ ������� head.jpg, head_a.jpg

GUICtrlCreateLabel ("������:", 175,50,60,20)
$inputWidth=GUICtrlCreateInput ("800", 235,50,35,19)   ; ������ ������� head.jpg, head_a.jpg

GUICtrlCreateLabel ("���. �����", 175,73,60,20)
$amount=GUICtrlCreateInput ("100", 235,73,35,19)

$FileNew=GUICtrlCreateCheckbox('������ � ����� ����', 30,120,137,22)

GUICtrlCreateLabel ("AZJIO 26.11.2010", 30,145,137,22)
$start=GUICtrlCreateButton ("���������", 195,125,87,28)
GUICtrlSetTip(-1, "���������� � �������� ����������.")
$FileName=''

GUISetState ()

While 1
	$msg = GUIGetMsg()
	Select
		Case $msg = $Radio1 Or $msg = $Radio2
			GUICtrlSetData($inputHeight,'6')
			GUICtrlSetData($inputWidth,'800')
		Case $msg = $Radio3 Or $msg = $Radio4
			GUICtrlSetData($inputHeight,'600')
			GUICtrlSetData($inputWidth,'6')
		Case $msg = $start
			If GUICtrlRead($FileNew)=1 Then 
				$FileName=@ScriptDir&'\GfxTimeOut'
				$i = 0
				While FileExists($FileName&'_'&$i&'.txt')
					$i+=1
				WEnd
				$FileName=$FileName&'_'&$i&'.txt'
			Else
				$FileName=@ScriptDir&'\GfxTimeOut_0.txt'
			EndIf
			$amount0=GUICtrlRead ($amount)
			$inputHeight0=GUICtrlRead ($inputHeight)
			$inputWidth0=GUICtrlRead ($inputWidth)
			If GUICtrlRead ($Radio1)=1 Then
				$Radio0=1
			ElseIf GUICtrlRead ($Radio2)=1 Then
				$Radio0=2
			ElseIf GUICtrlRead ($Radio3)=1 Then
				$Radio0=3
			ElseIf GUICtrlRead ($Radio4)=1 Then
				$Radio0=4
			EndIf
		
			Switch $Radio0
				Case 1, 2
				   $blok=$inputWidth0/$amount0
				Case 3, 4
				   $blok=$inputHeight0/$amount0
			EndSwitch
			
			If ($Radio0=1 Or $Radio0=2) And mod($inputWidth0, $amount0)<>0 Then 
			  MsgBox(0, "������ ������", '������� ������� ����� ������ � ���������� �����'&@CRLF&'����� ��������� ������ ������ ���� ������,'&@CRLF&'��� ����� ���������� �����')
			  ContinueLoop
			EndIf
			
			If ($Radio0=3 Or $Radio0=4) And mod($inputHeight0, $amount0)<>0 Then 
			  MsgBox(0, "������ ������", '������� ������� ����� ������ � ���������� �����'&@CRLF&'����� ��������� ������ ������ ���� ������,'&@CRLF&'��� ����� ���������� �����')
			  ContinueLoop
			EndIf
			   
			$xy1=0
			$FileText='�������� ������� GFX-����' & @CRLF & _
			'���������� ������� head.jpg, head_a.jpg' & @CRLF & _
			'� ����� common.inc ������ 1197' & @CRLF & _
			 '/head.x 100 def - ������ �����' & @CRLF & _
			'/head.y 15 def - ������ ������' & @CRLF & _
			'-------------------------' & @CRLF & _
			'������� ������� head.jpg, head_a.jpg' & @CRLF & _
			'��� �� ����������� � ���� �������' & @CRLF & _
			$inputHeight0&' - ������' & @CRLF & _
			$inputWidth0&' - ������' & @CRLF & _
			'-------------------------' & @CRLF & _
			'������� �������������� �����' & @CRLF & _
			'� ����� timeout.inc ������ 105' & @CRLF & _
			'�������� "8 8 savescreen" ��' & @CRLF
			
		
			Switch $Radio0
				Case 1, 2
				   $FileText&=$blok&' '&$inputHeight0&' savescreen' & @CRLF
				Case 3, 4
				   $FileText&=$inputWidth0&' '&$blok&' savescreen' & @CRLF
			EndSwitch
			
			$FileText&='-------------------------' & @CRLF & _
			'������� ����������� �������������� �����' & @CRLF & _
			'� ����� timeout.inc ������ 123' & @CRLF & _
			'     y  x' & @CRLF & _
			'-------------------------' & @CRLF
			$amount0-=1
			
			Switch $Radio0
				Case 1
					For $i=0 To $amount0
					   $xy2=$inputWidth0-$i*$blok-$blok
					   $FileText&='  [  '&$xy2&'  '&$xy1&'  .undef ]' & @CRLF
					Next
				Case 2
					For $i=0 To $amount0
						$xy2=$i*$blok
						$FileText&='  [  '&$xy2&'  '&$xy1&'  .undef ]' & @CRLF
					Next
				Case 3
					For $i=0 To $amount0
						$xy2=$inputHeight0-$i*$blok-$blok
						$FileText&='  [  '&$xy1&'  '&$xy2&'  .undef ]' & @CRLF
					Next
				Case 4
					For $i=0 To $amount0
						$xy2=$i*$blok
						$FileText&='  [  '&$xy1&'  '&$xy2&'  .undef ]' & @CRLF
					Next
			EndSwitch
			
			$file = FileOpen($FileName, 2)
			If $file = -1 Then
				MsgBox(0, "������", "�� �������� ������� ����.")
				Exit
			EndIf
			FileWrite($file, $FileText)
			FileClose($file)
			ShellExecute($FileName)
		Case $msg = -3
			ExitLoop
	EndSelect
WEnd