HotKeySet("{ESC}", "_Quit")
; �������� ��������� �� IP, �� ������������� � ������ ������������� � ����� �����-������ � ���������
Global $Statys=False, $adres='http://www.google.ru/', $IPP=80 , $ignore='127.0.0.0;0.0.0.0', $iptest='', $time=1000


While 1
_WriteIP2Text(@IPAddress1)
_WriteIP2Text(@IPAddress2)
_WriteIP2Text(@IPAddress3)
_WriteIP2Text(@IPAddress4)
	If $Statys=True Then
		_Ping()
	Else
		$time0 = InputBox("���������",  '������� �������� ������� �� ��������� �������� ��������� � ��������'&@CRLF&'"������" - ������ �� �������', $time/1000, "",270, 150)
		If $time0='' Then
			Exit
		Else
			$time=$time0*1000
		EndIf
	EndIf
    Sleep($time)
WEnd

Func _WriteIP2Text($ip)
	If StringInStr(';'&$ignore&';', ';'&$ip&';')>0 Then
		Return
	Else
		$iptest=$ip
		$file = FileOpen(@ScriptDir&'\IP.txt' ,2)
		FileWrite($file, $ip)
		FileClose($file)
		$Statys=True
    EndIf
EndFunc

Func _Ping()
	TCPStartUp()
	$adres = StringRegExpReplace($adres, "(?:ht|f)tp\:\/\/(.*)\/.*", "\1")
While 1
	$socket = TCPConnect(TCPNameToIP($adres), $IPP)
	If @error Then
		Sleep(1000)
		ContinueLoop
	Else
		$time0 = InputBox("���������",  '�������� ��������, ��� IP: '& $iptest&@CRLF& '������� �������� ������� �� ��������� �������� ��������� � ��������'&@CRLF&'"������" - ������ �� �������', $time/1000, "",270, 170)
		If $time0='' Then
			Exit
		Else
			$time=$time0*1000
		EndIf
		TCPShutdown()
		ExitLoop
	EndIf
WEnd
EndFunc

Func _Quit()
    Exit
EndFunc