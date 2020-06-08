#include <SysTray_UDF.au3> 
 
$pid = ProcessExists("pwmixer.exe") 
$index = _SysTrayIconIndex($pid) 
If @error Then MsgBox(16, "Ошибка", "Этот процесс не имеет иконки") 
$pos = _SysTrayIconPos($index) 
MouseClick("right", $pos[0], $pos[1]) 
