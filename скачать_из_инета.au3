#include <File.au3>
$file = 'C:\Users\Makosov_A\Desktop\test\111.txt'


Local $aRecords
If Not _FileReadToArray($file, $arecords) Then
   MsgBox(4096, "������", " ������ ������ ����� � ������     ������ = " & @error)
   Exit
EndIf
For $i = 1 To $aRecords[0]
   ;MsgBox(4096, '������:' & $i, $aRecords[$i])
   InetGet($aRecords[$i], 'C:\Users\Makosov_A\Desktop\test\' & $i & '.swf')
Next