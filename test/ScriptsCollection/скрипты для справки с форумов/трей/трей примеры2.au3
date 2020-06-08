#include <Constants.au3> 

Opt("TrayMenuMode", 1) 
TraySetClick(16) 

$My_TrayItem = TrayCreateItem("Меню1") 
TrayCreateItem("") 
$Exit_TrayItem = TrayCreateItem("Выход") 

While 1 
Switch TrayGetMsg() 
Case $My_TrayItem 
Switch TrayItemGetText($My_TrayItem) 
Case "Меню1" 
TrayItemSetText($My_TrayItem, "Меню2") 
Run("MyApp1.exe") 
Case "Меню2" 
TrayItemSetText($My_TrayItem, "Меню3") 
Run("MyApp2.exe") 

;Эту строчку можно раскомментировать, если нужно чтобы пункт был неактивным. 
;TrayItemSetState($My_TrayItem, $TRAY_DISABLE) 
Case "Меню3" 
MsgBox(48, "Приехали!", "Всё, фенито, этот пункт доступен не более 3 раз в сутки.") 
EndSwitch 
Case $Exit_TrayItem 
Exit 
EndSwitch 
WEnd 