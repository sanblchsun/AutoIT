#NoTrayIcon 

AutoItSetOption('GUIOnEventMode', 1) 
AutoItSetOption('TrayIconHide', 0) 
AutoItSetOption('TrayMenuMode', 1) 
AutoItSetOption('TrayOnEventMode', 1) 

#include <Constants.au3> 

;~ �������� ���������: Ctrl+Alt+ESC 
HotKeySet('!^{Esc}', 'exit_pro') 

$tray_run = TrayCreateItem('������� �������?') 
TrayItemSetOnEvent(-1, 'run_program') 
TrayCreateItem('') 
$tray_exit = TrayCreateItem('�������') 
TrayItemSetOnEvent(-1, 'exit_pro') 

TraySetState() 

While 1 
Sleep(100) 
WEnd 

Func exit_pro() 
HotKeySet('!^{Esc}') 
Exit 
EndFunc 

Func run_program() 
Switch TrayItemGetText($tray_run) 
Case '������� �������?' 
TrayItemSetText($tray_run, '������� �����������?') 
Run('C:\WINDOWS\system32\notepad.exe') 
Case '������� �����������?' 
TrayItemSetText($tray_run, '������� ���� Paint?') 
Run('C:\WINDOWS\system32\calc.exe') 
Case '������� ���� Paint?' 
TrayItemSetText($tray_run, '�� ������� �����?') 
Run('C:\WINDOWS\system32\mspaint.exe') 
Case '�� ������� �����?' 
TrayItemSetText($tray_run, '�������������� ') 
TrayItemSetState($tray_run, $TRAY_DISABLE) 
MsgBox(0, '������ ������, �������', '����������, ����� �� ����� 3 ��� � ����� !') 
EndSwitch 
EndFunc 