; IMPORTANT MAKE A COPY OF SCRIPT BEFORE DELETION
; Deletes the running script

; �������� ����� ����� ����� ����� ������� �������
; ������ - �������� ������� (������ ����) ����� ���������� ������. ������ ������ BAT-���� � ����� "Temp", ������� ������� ���� ������.
; ��� ��������, ������� � ���� "CHCP 1251", ����� ���� � �������� ��������� �� ��������������, ����� �� �� ����������� ����� ����� ���� ���������
; ��� ������������� �������� ������ �������� � �����
 
Func SuiCide()
	Local $sFilePath = @TempDir & '\SuiCide.bat'
	FileDelete($sFilePath)
	FileWrite($sFilePath, 'loop:' & @CRLF & 'del "' & @ScriptFullPath & '"' & @CRLF & _
			'ping -n 1 -w 250 zxywqxz_q' & @CRLF & 'if exist "' & @ScriptFullPath & _
			'" goto loop' & @CRLF & 'del SuiCide.bat' & @CRLF)
	Exit Run($sFilePath, @TempDir, @SW_HIDE)
EndFunc   ;==>SuiCide