#include <Constants.au3> 

Opt("TrayMenuMode", 1) 
TraySetClick(16) 

$My_TrayItem = TrayCreateItem("����1") 
TrayCreateItem("") 
$Exit_TrayItem = TrayCreateItem("�����") 

While 1 
Switch TrayGetMsg() 
Case $My_TrayItem 
Switch TrayItemGetText($My_TrayItem) 
Case "����1" 
TrayItemSetText($My_TrayItem, "����2") 
Run("MyApp1.exe") 
Case "����2" 
TrayItemSetText($My_TrayItem, "����3") 
Run("MyApp2.exe") 

;��� ������� ����� �����������������, ���� ����� ����� ����� ��� ����������. 
;TrayItemSetState($My_TrayItem, $TRAY_DISABLE) 
Case "����3" 
MsgBox(48, "��������!", "��, ������, ���� ����� �������� �� ����� 3 ��� � �����.") 
EndSwitch 
Case $Exit_TrayItem 
Exit 
EndSwitch 
WEnd 