$au3 = RegRead("HKCR\au3file\Shell\Open", "")

; �����
If $au3 = '������� � ���������' Then
RegWrite("HKCR\au3file\Shell\Open","","REG_SZ",'��������� ������')
RegWrite("HKCR\au3file\Shell\Open\Command","","REG_SZ",'"AutoIt3.exe" "%1" %*')
RegWrite("HKCR\au3file\Shell\Run","","REG_SZ",'������� � ���������')
RegWrite("HKCR\au3file\Shell\Run\Command","","REG_SZ",'"X:\PROGRAMS\Notepad++\Notepad++.exe" "%1"')
RegWrite("HKCR\au3file\Shell\rx_re","","REG_SZ",'������������� au3 �� ��������')
RegWrite("HKCR\au3file\Shell\rx_re\Command","","REG_SZ",'"AutoIt3.exe" "X:\PROGRAMS\Update_Utilite\re_au3.au3" %*')
EndIf

; �������
If $au3 = '��������� ������' Then
RegWrite("HKCR\au3file\Shell\Open","","REG_SZ",'������� � ���������')
RegWrite("HKCR\au3file\Shell\Open\Command","","REG_SZ",'"X:\PROGRAMS\Notepad++\Notepad++.exe" "%1"')
RegWrite("HKCR\au3file\Shell\Run","","REG_SZ",'��������� ������')
RegWrite("HKCR\au3file\Shell\Run\Command","","REG_SZ",'"AutoIt3.exe" "%1" %*')
RegWrite("HKCR\au3file\Shell\rx_re","","REG_SZ",'������������� au3 �� ����������')
RegWrite("HKCR\au3file\Shell\rx_re\Command","","REG_SZ",'"AutoIt3.exe" "X:\PROGRAMS\Update_Utilite\re_au3.au3" %*')
EndIf