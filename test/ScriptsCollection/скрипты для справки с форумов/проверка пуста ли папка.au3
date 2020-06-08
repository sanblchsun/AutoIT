;���������� $IsEmpty ������������� �������� ������������ �-�� _DirIsEmpty() 
$IsEmpty = _DirIsEmpty("C:\Windows") 
 
;����������� ����������� ���������� $IsEmpty � ������� ����������� 
MsgBox(64, "Results", "$IsEmpty = " & $IsEmpty & @LF & "@error = " & @error) 
 
;������� ��������� ���� ������� �� ��������� ���� �� �������� �����/�����. 
;���� ����� �� ���������� (�� ���� �� ���������� $sPath), �� @error = 1 � ������������ 0 
;���� ����� ����������, � ��� *��* �����, �� ������������ 0 
;���� ����� ����������, � ��� *�����*, �� ������������ 1 
Func _DirIsEmpty($sPath) 
 
    ;���� ������� ����� �� �������� D (�� ����� Dir), �� ������������� ������� ����������� � ���������� 0 
    If Not StringInStr(FileGetAttrib($sPath), "D") Then Return SetError(1, 0, 0) 
 
    ;������������� ������ *������* ����� � ��������� ���� 
    Local $hSearch = FileFindFirstFile($sPath & "\*") 
 
    ;"����������" ������� ����������� 
    Local $iRet = @error 
 
    ;�������� ������ (������������) ����� ������������� ������ (�����������) 
    FileClose($hSearch) 
 
    ;���������� ������� ����������� ($iRet), 
    ;FileFindFirstFile() ���������� @error = 1 ���� ����� �����, ��� � ���� ��������� ����, ��� ��� �����  
    Return $iRet 
EndFunc 