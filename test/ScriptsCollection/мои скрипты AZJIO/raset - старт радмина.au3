;  @AZJIO
#include <GUIConstants.au3>
AutoItSetOption("TrayIconHide", 1) ;������ � ��������� ������ ��������� AutoIt
Global $Ini = @ScriptDir&'\raset.ini' ; ���� � raset.ini
;�������� ������������� raset.ini � ����������� ��� �����������
$answerini = ""
If Not FileExists($Ini) Then $answerini = MsgBox(4, "�������� �����������", "������ ������� ����������� raset.ini"&@CRLF&"��� ���������� �������� ����������?")
If $answerini = "6" Then
	IniWriteSection($Ini, "password", 'pass1="3870e3b9f6f4fb9ef89c779211f4ce1a"'&@LF&'pass2="c332c582f10ec850b73c20f723271614"'&@LF&'pass3="42dfed0ba335a1c1af33cb2fa55c7066"'&@LF&'pass4="59dcd1982ff66958c24b25a3d6dd6fdf"'&@LF&'pass5="411c1eecd1fea51069e5b61d0576afbe"')
EndIf


;��������� raset.ini

$pass1= IniRead ($Ini, "password", "pass1", "3870e3b9f6f4fb9ef89c779211f4ce1a") ;123456789
$pass2= IniRead ($Ini, "password", "pass2", "c332c582f10ec850b73c20f723271614") ;11111111
$pass3= IniRead ($Ini, "password", "pass3", "42dfed0ba335a1c1af33cb2fa55c7066") ;WinPE000
$pass4= IniRead ($Ini, "password", "pass4", "59dcd1982ff66958c24b25a3d6dd6fdf") ;1324354657687980
$pass5= IniRead ($Ini, "password", "pass5", "411c1eecd1fea51069e5b61d0576afbe") ;d8k2g0rl8esj8y

; ������ �������� ����, �������, ������.
GUICreate("Start RAdmin",257,190) ; ������ ����
$tab=GUICtrlCreateTab (4,5, 249,182) ; ������ �������
GUICtrlCreateTabitem ("RAdmin") ; ��� �������

GUICtrlCreateLabel ("������", 20,36,47,22)
GUICtrlSetTip(-1, "���������� ����"&@CRLF&"�� ���� �������.")
$password=GUICtrlCreateCombo ("", 70,32,43,18)
GUICtrlSetData(-1,'1|2|3|4|5', '1')
$copy=GUICtrlCreateButton ("� �����", 120,33,60,22)
GUICtrlSetTip(-1, "���������� ������"&@CRLF&"� ����� ������.")
$Readme=GUICtrlCreateButton ("Readme", 185,33,60,22)

$client=GUICtrlCreateButton ("����� �������", 15,65,110,22)
GUICtrlSetTip(-1, "������������� ������������ ������"&@CRLF&" �������� �� ClientsBkUp.reg �� ������.")

$Import=GUICtrlCreateButton ("������������", 15,95,110,22)
GUICtrlSetTip(-1, "������������ ������ ��������"&@CRLF&"�� ����� ClientsBkUp.reg")

$export=GUICtrlCreateButton ("��������� ��������", 15,125,110,22)
GUICtrlSetTip(-1, "��������� ������ ��������"&@CRLF&"� ���� ClientsBkUp.reg")

$passset=GUICtrlCreateButton ("��������� ������", 15,155,110,22)
GUICtrlSetTip(-1, "��������� ������� ������ �������"&@CRLF&"� ���� raset.ini � ������-1")

$server=GUICtrlCreateButton ("����� �������", 135,65,110,22)
GUICtrlSetTip(-1, "����� �������"&@CRLF&"Radmin.")

$stop=GUICtrlCreateButton ("���������� ������", 135,95,110,22)

$del=GUICtrlCreateButton ("������� � �������", 135,125,110,22)
GUICtrlSetTip(-1, "������� ��� ������ � �������,"&@CRLF&"�����������, ������, ���������.")

$setup=GUICtrlCreateButton ("���������", 135,155,110,22)
GUICtrlSetTip(-1, "��������� �������"&@CRLF&"(����� ������ �������)")

GUICtrlCreateTabitem ("")   ; ����� �������

GUISetState ()

	While 1
		$msg = GUIGetMsg()
		Select
            Case $msg = $server
			   $password03 = GUICtrlRead ($password)
			   If $password03 = "1" Then $password0=$pass1
			   If $password03 = "2" Then $password0=$pass2
			   If $password03 = "3" Then $password0=$pass3
			   If $password03 = "4" Then $password0=$pass4
			   If $password03 = "5" Then $password0=$pass5
			   If $password03 <> "1" And $password03 <> "2" And $password03 <> "3" And $password03 <> "4" And $password03 <> "5" Then $password0=$pass1
			   ;������ ������ �������
			   RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\r_server","Start","REG_DWORD",'3')
			   ;������ ������� 12345678 - 02ba5e187e2589be6f80da0046aa7e3c
			   RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\RAdmin\v2.0\Server\Parameters","Parameter","REG_BINARY",$password0)
			   ;���������� �������� ���������� ������������ �� ����������� � �������, 
			   ;��� ���������� ������ ������������ ����� ����� 10 ������
			   RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\RAdmin\v2.0\Server\Parameters","Timeout","REG_BINARY",'0a000000')
			   RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\RAdmin\v2.0\Server\Parameters","AutoAllow","REG_BINARY",'00000000')
			   RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\RAdmin\v2.0\Server\Parameters","AskUser","REG_BINARY",'01000000')
			   ;��������
			   RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\RAdmin\v1.01\ViewType","Data","REG_BINARY",'35e3dbda7cef32ad2ca5b81a4be2b2477b1deb054c360e658affecaa7d63a14750dbf20ac5a71ddd086b7f02902bb86cda7a96cbdcc9e21a8c4d253957f8ee83')
			   RunWait ( @Comspec & ' /C '&@ScriptDir&'\r_server.exe /silence /install', '', @SW_HIDE )
			   RunWait ( @Comspec & ' /C '&@ScriptDir&'\r_server.exe /start', '', @SW_HIDE )
            Case $msg = $client
			   ;�� ���������� �������� ��� ������� �������
			   RegWrite("HKEY_CURRENT_USER\Software\RAdmin\v2.0\Parameters","showbw","REG_BINARY",'00000000')
			   ;��� ����������� IP-������� - �������
			   RegWrite("HKEY_CURRENT_USER\Software\RAdmin\v2.0\Parameters","ViewType","REG_BINARY",'03000000')
			   ;rem ����� ���������� - "����������"
			   RegWrite("HKEY_CURRENT_USER\Software\RAdmin\v2.0\Parameters","ConnectionMode","REG_BINARY",'499c0000')
			   ;����������� ������ ������� ��� ������ ������ "����� �������"
			   RegWrite("HKEY_CURRENT_USER\Software\RAdmin\v2.0\Parameters","FileManLocalViewMode","REG_BINARY",'569c0000')
			   RegWrite("HKEY_CURRENT_USER\Software\RAdmin\v2.0\Parameters","FileManRemoteViewMode","REG_BINARY",'569c0000')
			   ;��������
			   RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\RAdmin\v1.01\ViewType","Data","REG_BINARY",'35e3dbda7cef32ad2ca5b81a4be2b2477b1deb054c360e658affecaa7d63a14750dbf20ac5a71ddd086b7f02902bb86cda7a96cbdcc9e21a8c4d253957f8ee83')
			   Run (@ScriptDir&'\radmin.exe')
            Case $msg = $setup ;���������
			   RunWait ( @Comspec & ' /C '&@ScriptDir&'\r_server.exe /setup', '', @SW_HIDE )
            Case $msg = $copy ;������ � �����
			   $password03 = GUICtrlRead ($password)
			   If $password03 = "1" Then $password0=$pass1
			   If $password03 = "2" Then $password0=$pass2
			   If $password03 = "3" Then $password0=$pass3
			   If $password03 = "4" Then $password0=$pass4
			   If $password03 = "5" Then $password0=$pass5
			   If $password03 <> "1" And $password03 <> "2" And $password03 <> "3" And $password03 <> "4" And $password03 <> "5" Then $password0=$pass1
			   $password01=""
			   If $password0 = "3870e3b9f6f4fb9ef89c779211f4ce1a" Then $password01="123456789"
			   If $password0 = "c332c582f10ec850b73c20f723271614" Then $password01="11111111"
			   If $password0 = "42dfed0ba335a1c1af33cb2fa55c7066" Then $password01="WinPE000"
			   If $password0 = "59dcd1982ff66958c24b25a3d6dd6fdf" Then $password01="1324354657687980"
			   If $password0 = "411c1eecd1fea51069e5b61d0576afbe" Then $password01="d8k2g0rl8esj8y"
			   If $password01="" Then $password01="����������"
			   ClipPut($password01)
			   MsgBox(0, "���������", '������: '&$password01&' ���������� � ����� ������')
			Case $msg = $stop ;���������� ������
			   Run ( @Comspec & ' /C '&@ScriptDir&'\r_server.exe /silence /uninstall', '', @SW_HIDE )
			Case $msg = $export ;��������� ������ �������� �������������
			   If FileExists(@ScriptDir&'\ClientsBkUp.reg.BAK') Then FileDelete (@ScriptDir&'\ClientsBkUp.reg.BAK')
			   If FileExists(@ScriptDir&'\ClientsBkUp.reg') Then
			   FileCopy(@ScriptDir&'\ClientsBkUp.reg', @ScriptDir&'\ClientsBkUp.reg.BAK', 1)
			   FileDelete (@ScriptDir&'\ClientsBkUp.reg')
			   EndIf
			   Run ( @Comspec & ' /C reg export HKCU\Software\RAdmin\v2.0\Clients '&@ScriptDir&'\ClientsBkUp.reg', '', @SW_HIDE )
			Case $msg = $Import ; ������������ ������ �������� �������������
			   Run ( @Comspec & ' /C regedit.exe /s '&@ScriptDir&'\ClientsBkUp.reg', '', @SW_HIDE )
			Case $msg = $passset ;���������� �������� ������
			   $passset0 = RegRead("HKEY_LOCAL_MACHINE\SYSTEM\RAdmin\v2.0\Server\Parameters", "Parameter")
			   If $passset0 <> "" Then IniWrite($Ini, "password", "pass1", $passset0)
			   If $passset0 = "" Then MsgBox(0, "������ ������", '������ �����������')
			Case $msg = $del ;������� � ������� ��� ������ � �������
			   RegDelete("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\r_server")
			   RegDelete("HKEY_LOCAL_MACHINE\SYSTEM\RAdmin")
			   RegDelete("HKEY_LOCAL_MACHINE\SOFTWARE\RAdmin")
			   RegDelete("HKEY_CURRENT_USER\Software\RAdmin")
			Case $msg = $Readme
			   MsgBox(0, "Readme", '�������� ����������� �������� ��� LiveCD. �������� � � ������������ Windows, �� � ������ ������������� ��� ������� �� ����������� ���������.')
			Case $msg = $GUI_EVENT_CLOSE
				ExitLoop
		EndSelect
	WEnd