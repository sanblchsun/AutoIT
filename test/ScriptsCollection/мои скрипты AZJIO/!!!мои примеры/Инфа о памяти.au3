$mem = MemGetStats()
MsgBox(0,"���������� (MemGetStats)",'������� ������ ������ ��� (RAM):       ' & Ceiling ($mem[1]*$mem[0]/1024/100)&'��, '&$mem[0]&'% �� �����'& @CRLF & _
'����� ������ ������ ��� (RAM):       ' & Ceiling ($mem[1]/1024)&'��'& @CRLF & _
'�������� � ������ ��� (RAM):       ' & Ceiling ($mem[2]/1024)&'��'& @CRLF & _
'����� ������ ����������� ������, ���+pagefile:       ' & Ceiling ($mem[3]/1024)&'��'& @CRLF & _
'����� ��������� �����:       ' & Ceiling ($mem[4]/1024)&'��'& @CRLF & _
'����� ������ pagefile:       ' & Ceiling ($mem[5]/1024)&'��'& @CRLF & _
'��������� ����� � pagefile:       ' & Ceiling ($mem[6]/1024)&'��')