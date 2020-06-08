#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=FixMegaFon.exe
#AutoIt3Wrapper_Icon=FixMegaFon.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=FixMegaFon.exe
#AutoIt3Wrapper_Res_Fileversion=0.1.0.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Field=Version|0.1
#AutoIt3Wrapper_Res_Field=Build|2012.07.02
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

; ������ ��������������� ����������� ��������-��������.
; ��������: ��� ������� ������ � USB ��������� ������, ������� ������� ��������������� ��������� ��������, ����� ���������� � ����������� � ����. ������������� ��������������� ������� "O�o�pa�a�� co�ep���oe o��a �p� �epe�ac���a���", ������� ������������� ��������� ���������� �� ���������� �������.

; AZJIO 04.08.2012

Global $sPath = @ProgramFilesDir & '\MegaFon Internet\MegaFon Internet.exe'
Global $hMF_Inet, $title_MF_Inet = "������� ��������"
; TraySetIcon('shell32.dll', -149)
If @Compiled Then ; ������ ��������������� ������ ���������
	TraySetIcon('FixMegaFon.exe', 0)
Else
	TraySetIcon('FixMegaFon.ico', 0)
EndIf

If ProcessExists('MegaFon Internet.exe') Then
	$hMF_Inet = WinActivate($title_MF_Inet) ; ���������� ����
	$hMF_Inet = WinWaitActive($title_MF_Inet, '', 2) ; ��� ��������� ����
	If $hMF_Inet Then ; ���� ���� ��������������, �� �����������
		_Connect1()
		_Connect2()
	Else
		; ���� ���� �� �������������� � ������� 2 ���, �� ���������� �������������
		If MsgBox(4, '���������', '��������� ��� �������� � ������ ���� � ����' & @CRLF & '������ ������������� ���������?') = 6 Then
			If Not WinClose($title_MF_Inet) Then
				ProcessClose('MegaFon Internet.exe')
				If Not ProcessWaitClose("MegaFon Internet.exe", 2) Then _Exit()
			EndIf
		Else
			_Exit() ; ��� ����������
		EndIf
	EndIf
EndIf

; ��������� 12 ��� � ������ � 3 ������� ��������� ����������� USB � CD-ROM-����������
$iDrivesExists = 0
For $i = 1 To 12
	$iDrivesExists = _DrivesTrue()
	If $iDrivesExists Then ExitLoop
	TrayTip('����� ���������', '������� ' & $i & ' (�� �������)', 3, 1)
	If $i = 12 Then _Exit() ; ����� ���� �� 12 ������� ���� ���������� ��� ����������� ���������
	Sleep(3000)
Next
TrayTip('����� ���������', '���������� ����������', 3, 1)

; ��������� � ���������� ����� �������
Run($sPath)
_Connect1() ; ������� ����������
_SetCheck() ; �������������� ������� "O�o�pa�a�� co�ep���oe o��a �p� �epe�ac���a���", ���� ������� ��������� �����������
_Connect2() ; ������� ���� ��������� ��������� ��������� �����. � 9 ������� � ������������� ������� �� �������

Func _Connect1()
	$hMF_Inet = WinWait($title_MF_Inet, '', 5) ; ������� ����
	If Not $hMF_Inet Then _Exit()
	Sleep(100)
	If ControlGetText($hMF_Inet, '', '[CLASS:Button; INSTANCE:5]') = '����������' Then ; ���� ����� ������ = 
		ControlClick($hMF_Inet, '', '[CLASS:Button; INSTANCE:5]') ; ������� �
		TrayTip('�����������', '�����������...', 3, 1)
	EndIf
EndFunc

Func _Connect2()
	; ������� �������� ���� �����������
	Local $hConnect, $i, $title_Connect = '��������� �������� �����������'
	For $i = 1 To 9
		$hConnect = WinWait($title_Connect, '', 1)
		If $hConnect Then ; ���� ���������� ���� �����������
			; ���� ����� ������ =, �� ������� �
			If ControlGetText($hConnect, '', '[CLASS:Button; INSTANCE:1]') = '��������� �����' Then ControlClick($hConnect, '', '[CLASS:Button; INSTANCE:1]')
			If $i = 9 Then _Exit() ; �����, ���� ��� ���� 9-�� �������
			TrayTip('�����������', '������� ' & $i & ' (�� ����������)', 3, 1)
			Sleep(400)
		Else
			ExitLoop
		EndIf
	Next
	; ���� ������ ���������� �� "���������", �� ����������� ����
	For $i = 1 To 5
		If ControlGetText($title_MF_Inet, '', '[CLASS:Button; INSTANCE:5]') = '���������' Then
			WinSetState($title_MF_Inet, '', @SW_MINIMIZE) ; �����������
			TrayTip('�����������', '������', 3, 1)
			_Exit()
		EndIf
		Sleep(400)
	Next
EndFunc

Func _Exit()
	TraySetIcon('')
	Exit
EndFunc

Func _SetCheck()
	Local $hEffects, $hEkran, $title_Effects, $title_Ekran
	$title_Ekran = "��������: �����"
	$title_Effects = "�������"
	Run('rundll32 shell32.dll,Control_RunDLL desk.cpl,,2') ; ��������� ���� "��������: �����" �� ������� "����������"
	$hEkran = WinWait($title_Ekran, '', 5) ; ������� ��������� ���� 5 ���
	If $hEkran Then
		Sleep(100) ; �������� ��������� ��� ����������� ����
		ControlClick($hEkran, '', '[CLASS:Button; INSTANCE:1]') ; ������� ������ "�������..."
		$hEffects = WinWait($title_Effects, '', 2) ; ������� ��������� ���� "�������" 2 ���
		If $hEffects Then ; ���� ��������� ����, ��
			Sleep(100)
			; ControlClick($hEffects, '', '[CLASS:Button; INSTANCE:5]') ; ������� ������� "���������� ���������� ���� ��� ��������������"
			ControlCommand($hEffects, "", '[CLASS:Button; INSTANCE:5]', "Check") ; ������������� ������� "���������� ���������� ���� ��� ��������������"
			ControlClick($hEffects, '', '[CLASS:Button; INSTANCE:7]') ; ������� �� � ���� "�������"
			ControlClick($hEkran, '', '[CLASS:Button; INSTANCE:3]') ; ������� �� � ����"��������: �����"
		Else
			WinWaitClose($hEkran, '', 5) ; ���� �� ��������� ����, �� ��������� ���� "��������: �����" 
		EndIf	
	EndIf
EndFunc

; �������� ���������/������������� ������������ ��������� ��������
Func _DrivesTrue()
	Local $iDrivesExists = 0, $i, $DrivesArr
	$DrivesArr = DriveGetDrive('REMOVABLE') ; ����������� ��� ���������� ����������
	If @error Then Return SetError(1, 0, 0) ; ���� �� �������
	For $i = 1 To $DrivesArr[0]
		If DriveStatus($DrivesArr[$i]) = 'NOTREADY' Then $iDrivesExists += 1
	Next
	If Not $iDrivesExists Then Return SetError(1, 0, 0) ; ���� �� ������ ���������� ����������
	$DrivesArr = DriveGetDrive('CDROM') ; ����������� ��� CDROM
	If @error Then Return SetError(1, 0, 0) ; ���� �� �������
	For $i = 1 To $DrivesArr[0]
		; ���� �������� CD � �� �� ������ ���� "MegaFon Internet", �� ���������� 1
		If DriveStatus($DrivesArr[$i]) = 'READY' And FileExists($DrivesArr[$i] & '\MegaFon Internet') Then Return SetError(0, 0, 1)
	Next
EndFunc