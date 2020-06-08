#NoTrayIcon 
#include <ModernMenuRaw.au3> 
 
$hTrayIcon = _TrayIconCreate("My Tray App") 
 
_TrayIconSetClick(-1, 16) 
_TrayIconSetState() 
 
$nTrayMenu = _TrayCreateContextMenu() 
 
$Calc_TrayItem = _TrayCreateItem("Калькулятор") 
_TrayItemSetIcon(-1, "calc.exe", 0) 
 
$Notepad_TrayItem = _TrayCreateItem("Блокнот") 
_TrayItemSetIcon(-1, "notepad.exe", 0) 
 
$CmdLine_TrayItem = _TrayCreateItem("Коммандная строка") 
_TrayItemSetIcon(-1, "cmd.exe", 0) 
 
$MSPaint_TrayItem = _TrayCreateItem("MSPaint") 
_TrayItemSetIcon(-1, "mspaint.exe", 0) 
 
_TrayCreateItem("") 
_TrayItemSetIcon(-1, "", 0) 
 
$Exit_TrayItem = _TrayCreateItem("Выход") 
_TrayItemSetIcon(-1, "shell32.dll", 28) 
 
_SetTrayIconBkColor(0xC46200) 
_SetTraySelectBkColor(0x087272) 
_SetTraySelectTextColor(0xFFFFFF) 
 
While 1 
    Switch GUIGetMsg() 
        Case $Calc_TrayItem 
            Run("Calc.exe") 
        Case $Notepad_TrayItem 
            Run("Notepad.exe") 
        Case $CmdLine_TrayItem 
            Run("Cmd.exe") 
        Case $MSPaint_TrayItem 
            Run("MSPaint.exe") 
        Case $Exit_TrayItem 
            _TrayIconDelete($hTrayIcon) 
            Exit 
    EndSwitch 
WEnd 