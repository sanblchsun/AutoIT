$mem = MemGetStats()
MsgBox(0,"Информация (MemGetStats)",'Занятый размер памяти ОЗУ (RAM):       ' & Ceiling ($mem[1]*$mem[0]/1024/100)&'Мб, '&$mem[0]&'% от общей'& @CRLF & _
'Общий размер памяти ОЗУ (RAM):       ' & Ceiling ($mem[1]/1024)&'Мб'& @CRLF & _
'Свободно в памяти ОЗУ (RAM):       ' & Ceiling ($mem[2]/1024)&'Мб'& @CRLF & _
'Общий размер виртуальной памяти, ОЗУ+pagefile:       ' & Ceiling ($mem[3]/1024)&'Мб'& @CRLF & _
'Общий доступный объём:       ' & Ceiling ($mem[4]/1024)&'Мб'& @CRLF & _
'Общий размер pagefile:       ' & Ceiling ($mem[5]/1024)&'Мб'& @CRLF & _
'Доступный объём в pagefile:       ' & Ceiling ($mem[6]/1024)&'Мб')