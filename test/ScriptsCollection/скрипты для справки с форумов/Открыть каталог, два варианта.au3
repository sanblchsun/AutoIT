;~ ������ 1 
Run("Explorer.exe /select," & @ScriptFullPath) 

;~ ������ 2
MsgBox(64, '�������! #1', '�������� ����� "��� ���������":' & @CRLF & @CRLF & @MyDocumentsDir) 
;~ ������ @MyDocumentsDir - ������� ����������� �����, ������: ShellExecute('c:\Mega folder\'): 
ShellExecute(@MyDocumentsDir) 

