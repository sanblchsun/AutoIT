$volStr = DllStructCreate('char[255];char[255];udword;udword;udword')
$result = DllCall('KERNEL32.dll', _
          'long', 'GetVolumeInformationA', _
          'str',  'C:\', _
          'str',  DllStructGetPtr($volStr, 1), _
          'long', 255, _
          'long', DllStructGetPtr($volStr, 3), _
          'long', DllStructGetPtr($volStr, 4), _
          'long', DllStructGetPtr($volStr, 5), _
          'str',  DllStructGetPtr($volStr, 2), _
          'long', 255)
MsgBox(262192, '���������� � �����', _
       '����� ����: '         & $result[2] & @CR & _
       '�������� �����: '     & DllStructGetData($volStr, 3) & @CR & _
       '�������� ���������: ' & $result[7])
