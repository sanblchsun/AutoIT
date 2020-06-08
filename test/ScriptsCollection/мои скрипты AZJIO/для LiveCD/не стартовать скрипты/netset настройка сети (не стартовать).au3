;  @AZJIO
#NoTrayIcon
OnAutoItExitRegister('_Exit')
$keyExit = "0" ; 1 - "��", 0 ��� ������ �������� - "���������" �� ��������� �������
$sTitle = "[REGEXPTITLE:PE .+? 0\.\d\d.*]" ; ����������� �� 0.58, PENetwork_Rus.lng �� �������� ����� ��� ��������� ���� �� ���������.
$exe = "PENetwork.exe" ;� RusLive PENetwork.exe; � �-�� 7sh3 RUN-NETCFG.CMD ��� ������� ������������ ����.
$namewin = "����� ����� ������������ ����."
$DNS_adres = 'DNS-������'
$Add_DNS_adres = '�������� DNS-������-�����'

$tmp = FileOpenDialog($namewin, @ScriptDir, "������ (*.ini)", 1)
If @error Then Exit
Global $Ini = $tmp
$name = IniRead($Ini, "setnet", "name", "")

If $name = "Start" Then
	Run($exe)
	Exit
EndIf

If $name = "Cleaner1" Or $name = "Cleaner2" Or $name = "Cleaner3" Then
	$hWnd = _GetWnd()
	Sleep(300)
	BlockInput(1) ;����������� ���� � ����������
	If $name = "Cleaner2" Then
		Send("{TAB 2}")
		Send("{RIGHT}")
		Sleep(300)
	EndIf
	If $name = "Cleaner3" Then
		Send("{TAB 2}")
		Send("{RIGHT 2}")
		Sleep(300)
	EndIf
	ControlClick($hWnd, "", "[CLASS:Button; INSTANCE:19]")
	ControlClick($hWnd, "", "[CLASS:Button; INSTANCE:27]")
	ControlClick($hWnd, "", "[CLASS:Button; INSTANCE:29]")
	Sleep(300)
	If $keyExit = "1" Then
		ControlClick($hWnd, "", "[CLASS:Button; INSTANCE:10]")
	Else
		ControlClick($hWnd, "", "[CLASS:Button; INSTANCE:9]")
	EndIf
	BlockInput(0) ;�������������� ���� � ����������
	Exit
EndIf

Global $ctrl[4]

$dev = IniRead($Ini, "setnet", "number_device", "")
$IP = IniRead($Ini, "setnet", "IP", "")
$MS = IniRead($Ini, "setnet", "MS", "")
$GW = IniRead($Ini, "setnet", "GW", "")
$DNS1 = IniRead($Ini, "setnet", "DNS1", "")
$DNS2 = IniRead($Ini, "setnet", "DNS2", "")
$DNS3 = IniRead($Ini, "setnet", "DNS3", "")

$hWnd = _GetWnd()
BlockInput(1) ;����������� ���� � ����������
If $dev = 2 Then
	Sleep(300)
	Send("{TAB 2}")
	Send("{RIGHT}")
EndIf

If $dev = 3 Then
	Sleep(300)
	Send("{TAB 2}")
	Send("{RIGHT 2}")
EndIf
Sleep(300)
$aIP = StringSplit($IP, '.', 2)
If Not @error And UBound($aIP) = 4 Then
	ControlClick($hWnd, "", "[CLASS:Button; INSTANCE:19]")
	Dim $ctrl[4]= ['5', '4', '3', '2']
	_Send($ctrl, $aIP)
EndIf

$aMS = StringSplit($MS, '.', 2)
If Not @error And UBound($aMS) = 4 Then
	Dim $ctrl[4]= ['9', '8', '7', '6']
	_Send($ctrl, $aMS)
EndIf

$aGW = StringSplit($GW, '.', 2)
If Not @error And UBound($aGW) = 4 Then
	Dim $ctrl[4]= ['13', '12', '11', '10']
	_Send($ctrl, $aGW)
EndIf

$aDNS1 = StringSplit($DNS1, '.', 2)
If Not @error And UBound($aDNS1) = 4 Then
	Dim $ctrl[4]= ['17', '16', '15', '14']
	_Send($ctrl, $aDNS1)
EndIf

$aDNS2 = StringSplit($DNS2, '.', 2)
$aDNS3 = StringSplit($DNS3, '.', 2)
If $DNS2 And $DNS3 And UBound($aDNS2) = 4 And UBound($aDNS3) = 4 Then
	ControlClick($hWnd, "", "[CLASS:Button; INSTANCE:28]")
	Sleep(300)
	ControlClick($DNS_adres, "", "[CLASS:Button; INSTANCE:3]")
	Sleep(300)
	Dim $ctrl[4]= ['4', '3', '2', '1']
	_Send($ctrl, $aDNS2, $Add_DNS_adres)

	ControlClick($Add_DNS_adres, "", "[CLASS:Button; INSTANCE:1]")
	Sleep(300)
	ControlClick($DNS_adres, "", "[CLASS:Button; INSTANCE:3]")
	Sleep(300)

	Dim $ctrl[4]= ['4', '3', '2', '1']
	_Send($ctrl, $aDNS3, $Add_DNS_adres)

	ControlClick($Add_DNS_adres, "", "[CLASS:Button; INSTANCE:1]")
	Sleep(300)
	ControlClick($DNS_adres, "", "[CLASS:Button; INSTANCE:5]")
EndIf

Sleep(300)
If $keyExit = "1" Then
	ControlClick($hWnd, "", "[CLASS:Button; INSTANCE:10]")
Else
	ControlClick($hWnd, "", "[CLASS:Button; INSTANCE:9]")
EndIf

Func _Send($ctrl, $aDNS, $gui = $hWnd)
	For $i = 0 To 3
		ControlSend($gui, "", '[CLASS:Edit; INSTANCE:' & $ctrl[$i] & ']', $aDNS[$i])
	Next
EndFunc   ;==>_Send

Func _GetWnd()
	$iPID = ProcessExists($exe)
	If $iPID Then ;���� ���������� ������� PENetwork.exe, �� ��������� ���
		ProcessClose($iPID)
		If Not ProcessWaitClose($iPID, 3) Then _Error('ProcessClose')
	EndIf
	Run($exe)
	$hWnd = WinWait($sTitle, "", 5) ; ��� �������� (5) �������� ����������
	If Not $hWnd Then _Error('���� �� �������')
	Return $hWnd
EndFunc   ;==>_GetWnd

Func _Error($msg)
	Exit MsgBox(4096, '������', $msg & ', ��������� ������ �������')
EndFunc   ;==>_Error

Func _Exit()
	BlockInput(0) ; ������������ ��� ������ ��� ������
EndFunc   ;==>_Exit