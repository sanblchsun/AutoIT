#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=Device_off_on.exe
#AutoIt3Wrapper_icon=Device_off_on.ico
#AutoIt3Wrapper_Compression=n
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=Device_off_on.exe
#AutoIt3Wrapper_Res_Fileversion=0.1.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#AutoIt3Wrapper_Res_Icon_Add=off.ico
#AutoIt3Wrapper_Run_After=%autoitdir%\SciTE\ResHacker\ResHacker.exe -delete "%out%", "%out%", ICON, 162,
#AutoIt3Wrapper_Run_After=%autoitdir%\SciTE\ResHacker\ResHacker.exe -delete "%out%", "%out%", ICON, 164,
#AutoIt3Wrapper_Run_After=%autoitdir%\SciTE\ResHacker\ResHacker.exe -delete "%out%", "%out%", ICON, 169,
#AutoIt3Wrapper_Run_After=%autoitdir%\SciTE\upx\upx.exe -7 --compress-icons=0 "%out%"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 3.11.2010 (AutoIt3_v3.3.6.1)

; ���� devcon.exe ������ �� ������ ���� � ��������� SFX-�����.
; http://support.microsoft.com/kb/311272/ru

If $CmdLine[0]>0 Then
	$sDevice = $CmdLine[1]
Else
	MsgBox(0, '�������', 'Device_off_on - ������� ������������� ��� ��������� � ���������� ��������� �� �� ����, �������� ������� ����� ��� Wi-Fi ��� Web-������ ��� �����������, ��� ����� �� ���� ����������� ����� ��� ����������. ��������� ���������� ���������� ������ ������, � ���� �� ������ ��������� ���������� �� ������ ��������� � ������. ��� ������ ������������� ������ ����� � ����������� ���������� ����. ����� ������������ ������������ � ������ ���������������� ��������.'&@CRLF&@CRLF&'�������������� ���������:'&@CRLF&'1. ������ �������� - ��� ����������, �������� PCI\VEN_10EC&DEV_8168'&@CRLF&'2. ������ �������� - ��� ��� ���� ������������ ������. ���� ��� �� �������, �� � �������� ����� ������������ ��� ����������. ���� �� ������ ����, �� ����� �������� �� ������� �����. ���� ������ ����� ������� ������ ���� � ������ (��� ���������), �� ����� �������� �� ���������� ����, ��� ������ ��� �������� ������ �� ������ �������� ������� ��� � ���� ���� > ��� ���������.'&@CRLF&@CRLF&'��������� ���������� ������� ���������� ���������.'&@CRLF&@CRLF&'������������� �� ������������� ��������� ��������� ����������, ������� �������������� ����� �������� �� ������� ���������� ������� � ���, �������� ���������� ���������� �����, ��������, ����������. ��� ��������� ���� ���������� ������� ������� ��������� ��������� � � ��������� ���������� ���������� ������� ������� "��������".'&@CRLF&@CRLF&'��� ������������ ������������ ������� devcon.exe, ������� ����� ������� �� ������ http://support.microsoft.com/kb/311272/ru, ��� �� � ��������� � ������� ��������.')
	Exit
EndIf
$sDevCMD = StringReplace($sDevice, '&', '^&')
$sDevREx=StringRegExpReplace($sDevice, '[][{}()*+?.\\^$|=<>#]', '\\$0')
$sStatus = ''
$hRun = Run(@Comspec&' /C devcon status @'&$sDevCMD&'*', '', @SW_HIDE, 2)
While 1
    $sStatus &= StdoutRead($hRun)
    If @error Then ExitLoop
    Sleep(10)
WEnd
$sStatus=StringRegExpReplace($sStatus, '(?si)(?:.*'&$sDevREx&'.*?\r\n    Name.*?\r\n    )(.*?)(?:\.\r\n.*)', '\1')

If $sStatus = 'Device is disabled' Then
	; ����������
	RunWait(@Comspec&' /C devcon enable '&$sDevCMD&'*', '', @SW_HIDE)
	; MsgBox(0, '��������', '������� ���������� ��������', 3)
	_Icon(0)
ElseIf $sStatus = 'Driver is running' Then
	; ���������
	RunWait(@Comspec&' /C devcon disable '&$sDevCMD&'*', '', @SW_HIDE)
	; MsgBox(0, '���������', '������� ���������� ���������', 3)
	_Icon(1)
Else
	MsgBox(0, '�����������', '���������� �����������', 3)
EndIf

Func _Icon($n)
If @compiled Then
	$Exe=@ScriptFullPath
	$arg='"'&$CmdLine[1]&'"'
	$ico=@ScriptFullPath
Else
	$Exe=@AutoItExe
	$arg='"'&@ScriptFullPath&'" "'&$CmdLine[1]&'"'
	$ico=@ScriptDir&'\Device_off_on.dll'
EndIf
If $CmdLine[0]>1 Then
	$arg&=' "'&$CmdLine[2]&'"'
	If StringInStr($CmdLine[2], '\') Then
		$LnkPath=$CmdLine[2]&'.lnk'
	Else
		$LnkPath=@DesktopDir&'\'&$CmdLine[2]&'.lnk'
	EndIf
Else
	$LnkPath=@DesktopDir&'\'&StringReplace($CmdLine[1], 'PCI\VEN_', '')&'.lnk'
EndIf
FileCreateShortcut('"'&$Exe&'"', $LnkPath, @ScriptDir, $arg, '',$ico, '', $n)
EndFunc