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
MsgBox(262192, 'Информация о диске', _
       'Метка тома: '         & $result[2] & @CR & _
       'Серийный номер: '     & DllStructGetData($volStr, 3) & @CR & _
       'Файловая структура: ' & $result[7])
