
If $CmdLine[0]=0 Then Exit

; ��������� ���� � au3.properties
$file = FileOpen(@ScriptDir&'\SciTE\Properties\au3.properties', 0)
$text = FileRead($file)
FileClose($file)
$Path=StringRegExpReplace(@ScriptDir, '\\', '\\$0')
$text=StringRegExpReplace($text, 'autoit3dir=.*', 'autoit3dir='&$Path&@CR)

$file = FileOpen(@ScriptDir&'\SciTE\Properties\au3.properties',2)
FileWrite($file, $text)
FileClose($file)


GUICreate("���������", 450, 150)
$CrRe_au3=GUICtrlCreateCheckbox('�������� re_au3.au3', 10, 10, 240, 17)
GUICtrlSetState(-1, 1)
GUICtrlSetState(-1, 128)
$Theme=GUICtrlCreateRadio('������������ ���� DARK GREY (����-�����) � ��������� SciTE', 10, 30, 440, 22)
GUICtrlSetState(-1, 1)
$ThemeDel=GUICtrlCreateRadio('������� ���� � SciTE, ���� ������������� ��������������� ����������� ����', 10, 50, 440, 22)
$RegToAu3=GUICtrlCreateCheckbox('�������� � ����������� ���� REG-������ ��������� RegToAu3', 10, 70, 440, 22)
GUICtrlSetState(-1, 1)
$OtherAutoIt3=GUICtrlCreateCheckbox('�������� � ����������� ���� AU3-������ - "������ ������ AutoIt3"', 10, 90, 440, 22)
GUICtrlSetState(-1, 1)
GUICtrlSetTip(-1, '������ ����� ������ ��� �������, ��� � ��� ����� ���'&@CRLF&'���� ������ AutoIt3. ���� ������������, �� ���������'&@CRLF&'� ������ �������� ���� � ���� �������. ������ �����������'&@CRLF&'� "system32\contmenuAutoIt3.au3"')
$Button1=GUICtrlCreateButton('��', 175, 120, 100, 25)
GUISetState ()
While 1
   $msg = GUIGetMsg()
   Select
       Case $msg = $Button1
		   If GUICtrlRead($CrRe_au3)=1 Then
; ���������� re_au3.au3
$as='HKCR\AutoIt3Script'
$OpenCom0='������� � ���������'
$RunCom0='��������� ������'
$AutInp0=@ScriptDir&'\AutoIt3.exe'
$RedInp01=@ScriptDir&'\SciTE\SciTE.exe'
	RegWrite($as&"\Shell\rx_re","","REG_SZ",'������������� au3')
	RegWrite($as&"\Shell\rx_re\Command","","REG_SZ",'"'&$AutInp0&'" "'&@ScriptDir&'\re_au3.au3" %*')
	$file = FileOpen(@ScriptDir&'\re_au3.au3', 2)
	$sText = '$au3 = RegRead("HKCR\AutoIt3Script\Shell\Open", "")' & @CRLF & 'If $au3 = "'&$OpenCom0&'" Then' & @CRLF &'; �����' & @CRLF &'RegWrite("HKCR\AutoIt3Script\Shell\Open","","REG_SZ","'&$RunCom0&'")' & @CRLF &'RegWrite("HKCR\AutoIt3Script\Shell\Open\Command","","REG_SZ","""'&$AutInp0&'"" ""%1"" %*")' & @CRLF &'RegWrite("HKCR\AutoIt3Script\Shell\Run","","REG_SZ","'&$OpenCom0&'")' & @CRLF &'RegWrite("HKCR\AutoIt3Script\Shell\Run\Command","","REG_SZ","""'&$RedInp01&'"" ""%1""")' & @CRLF &'RegWrite("HKCR\AutoIt3Script\Shell\rx_re","","REG_SZ","������������� au3")' & @CRLF &'RegWrite("HKCR\AutoIt3Script\Shell\rx_re\Command","","REG_SZ","""'&$AutInp0&'"" ""'&@ScriptDir&'\re_au3.au3"" %*")' & @CRLF &'EndIf' & @CRLF & @CRLF &'If $au3 = "'&$RunCom0&'" Then' & @CRLF &'; �������' & @CRLF &'RegWrite("HKCR\AutoIt3Script\Shell\Run","","REG_SZ","'&$RunCom0&'")' & @CRLF &'RegWrite("HKCR\AutoIt3Script\Shell\Run\Command","","REG_SZ","""'&$AutInp0&'"" ""%1"" %*")' & @CRLF &'RegWrite("HKCR\AutoIt3Script\Shell\Open","","REG_SZ","'&$OpenCom0&'")' & @CRLF &'RegWrite("HKCR\AutoIt3Script\Shell\Open\Command","","REG_SZ","""'&$RedInp01&'"" ""%1""")' & @CRLF &'RegWrite("HKCR\AutoIt3Script\Shell\rx_re","","REG_SZ","������������� au3")' & @CRLF &'RegWrite("HKCR\AutoIt3Script\Shell\rx_re\Command","","REG_SZ","""'&$AutInp0&'"" ""'&@ScriptDir&'\re_au3.au3"" %*")' & @CRLF &'EndIf' & @CRLF
	FileWrite($file, $sText)
	FileClose($file)
		   EndIf
; ����� ���� ��� ��������� ���������
		   If GUICtrlRead($Theme)=1 Then FileCopy(@ScriptDir & '\SciTE\SciTEConfig\SciTEUser.properties', @UserProfileDir & '\SciTEUser.properties', 1)
		   If GUICtrlRead($ThemeDel)=1 And FileExists(@UserProfileDir & '\SciTEUser.properties') Then FileDelete(@UserProfileDir & '\SciTEUser.properties')
		   If GUICtrlRead($RegToAu3)=1 Then
; RegToScript � ����������� ���� REG-������
$mconv = RegRead('HKEY_CLASSES_ROOT\regfile\shell\mconv\command', '')
If @error And FileExists(@ScriptDir&'\Tools\RegToScript\RegToScript.exe') Then
	RegWrite("HKEY_CLASSES_ROOT\regfile\shell\mconv", "", "REG_SZ", '�������������� reg2au3')
	RegWrite("HKEY_CLASSES_ROOT\regfile\shell\mconv\command", "", "REG_SZ", '"'&@ScriptDir&'\Tools\RegToScript\RegToScript.exe" /au3 "%1" "%1.au3"')
EndIf
		   EndIf
		   If GUICtrlRead($OtherAutoIt3)=1 Then
; ��������� ������� "������ ������ AutoIt3"
$curret = RegRead("HKLM\SOFTWARE\script_az\contmenuAutoIt3", "Default")
If @error And FileExists(@ScriptDir&'\!script\��� ������� AZJIO\��� ������������ ����\contmenuAutoIt3.au3') Then ShellExecute(@ScriptDir&'\!script\��� ������� AZJIO\��� ������������ ����\contmenuAutoIt3.au3')
		   EndIf
		   FileSetAttrib(@ScriptDir,"+S")
		   ContinueCase
       Case $msg = -3
           Exit
   EndSelect
WEnd