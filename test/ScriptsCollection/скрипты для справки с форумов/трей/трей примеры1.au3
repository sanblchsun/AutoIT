#NoTrayIcon 

AutoItSetOption('GUIOnEventMode', 1) 
AutoItSetOption('TrayIconHide', 0) 
AutoItSetOption('TrayMenuMode', 1) 
AutoItSetOption('TrayOnEventMode', 1) 

#include <Constants.au3> 

;~ Закрытие программы: Ctrl+Alt+ESC 
HotKeySet('!^{Esc}', 'exit_pro') 

$tray_run = TrayCreateItem('Открыть Блокнот?') 
TrayItemSetOnEvent(-1, 'run_program') 
TrayCreateItem('') 
$tray_exit = TrayCreateItem('Закрыть') 
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
Case 'Открыть Блокнот?' 
TrayItemSetText($tray_run, 'Открыть Калькулятор?') 
Run('C:\WINDOWS\system32\notepad.exe') 
Case 'Открыть Калькулятор?' 
TrayItemSetText($tray_run, 'Открыть диск Paint?') 
Run('C:\WINDOWS\system32\calc.exe') 
Case 'Открыть диск Paint?' 
TrayItemSetText($tray_run, 'Ну сколько можно?') 
Run('C:\WINDOWS\system32\mspaint.exe') 
Case 'Ну сколько можно?' 
TrayItemSetText($tray_run, 'Заблокировался ') 
TrayItemSetState($tray_run, $TRAY_DISABLE) 
MsgBox(0, 'Дышите глубже, Господа', 'Пожалуйста, жмите не более 3 раз в сутки !') 
EndSwitch 
EndFunc 