
; ������������� ������ ������ ���������� � ������� �� ������� ������� ��� reg.exe (�������� ���� �������, ������� ��������� ������� � �������� �������, � �� ������ � ��������.

$potok = Run(@ComSpec & " /c reg.exe -?", @SystemDir, @SW_HIDE, 6) ; �� ����� �� ������� �������� 2 � ���� ������ �� �������� � �������� �������
$line1=''
While 1
    $line = StdoutRead($potok)
    If @error Then ExitLoop
	$line1 &= $line ; � ������ �� ��� ������ ������ �� ��������
Wend

MsgBox(0, "���������", $line1)


; ������������ ������ ������� ������������ (� ru-board)
$sLog = ''
$hRun = Run(@ComSpec & " /C ipconfig -all", "", @SW_HIDE, 2)
While 1
    $sLog &= StdoutRead($hRun)
    If @error Then ExitLoop
    Sleep(10)
WEnd
$sLog = StringRegExpReplace(@CRLF&$sLog, "(\r\n)+", '') ; �������� ��������� �����
MsgBox(0, "", $sLog)
;ClipPut($sLog ) ; ��������� � �����