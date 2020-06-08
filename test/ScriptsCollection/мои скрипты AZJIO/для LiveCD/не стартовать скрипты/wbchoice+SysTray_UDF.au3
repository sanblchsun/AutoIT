Global Const $GUI_EVENT_CLOSE = -3
Const $TB_GETBUTTON = 1047
Const $TB_BUTTONCOUNT = 1048
Const $TB_GETITEMRECT = 1053
Const $PROCESS_ALL_ACCESS = 2035711
Const $NO_TITLE = "---No title---"
AutoItSetOption("TrayIconHide", 1)
If Not ProcessExists("wbload.exe") Then
$nameThemes = 'SilverAS'
RegWrite("HKLM\SOFTWARE\Stardock\ObjectDesktop\WindowBlinds","CanUpgrade","REG_SZ",'1')
RegWrite("HKLM\SOFTWARE\Stardock\ObjectDesktop\WindowBlinds","Path","REG_SZ",@ScriptDir)
RegWrite("HKLM\SOFTWARE\Stardock\ObjectDesktop\WindowBlinds","EXE","REG_SZ",'wbconfig.exe')
RegWrite("HKLM\SOFTWARE\Stardock\ObjectDesktop\WindowBlinds","Version","REG_SZ",'4.60')
RegWrite("HKLM\SOFTWARE\Stardock\ObjectDesktop\WindowBlinds","Revision","REG_SZ",'460')
RegWrite("HKLM\SOFTWARE\Stardock\ObjectDesktop\WindowBlinds","NeedsReboot","REG_SZ",'1')
RegWrite("HKLM\SOFTWARE\Stardock\ObjectDesktop\WindowBlinds","Startup","REG_SZ",'1')
RegWrite("HKLM\SOFTWARE\Stardock\ObjectDesktop\WindowBlinds","Disable","REG_SZ",'wbload.exe UNLOAD')
RegWrite("HKLM\SOFTWARE\Stardock\ObjectDesktop\WindowBlinds","Updated","REG_SZ",'12/10/2005 20:47:44')
RegWrite("HKLM\SOFTWARE\Stardock\ObjectDesktop\WindowBlinds","Tooltip","REG_SZ",'WB 4.60')
RegWrite("HKLM\SOFTWARE\Stardock\ObjectDesktop\WindowBlinds","Type","REG_SZ",'enhanced')
RegWrite("HKLM\SOFTWARE\Stardock\WindowBlinds\WB5.ini\INSTALLED","RealPath","REG_SZ",@ScriptDir)
RegWrite("HKLM\SOFTWARE\Stardock\WindowBlinds\WB5.ini\INSTALLED","Path","REG_SZ",'Object Desktop')
RegWrite("HKLM\SOFTWARE\Stardock\WindowBlinds\WB5.ini\INSTALLED","Path2","REG_SZ",'WB-g1de774')
RegWrite("HKLM\SOFTWARE\Stardock\WindowBlinds\WB5.ini\WBLiteFX","INET","REG_SZ",'O')
RegWrite("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\WindowBlinds","InstallLocation","REG_SZ",@ScriptDir)
RegWrite("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\WindowBlinds","Publisher","REG_SZ",'Stardock.net, Inc.')
RegWrite("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\WindowBlinds","VersionMajor","REG_SZ",'3')
RegWrite("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\WindowBlinds","VersionMinor","REG_SZ",'460')
RegWrite("HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\Notify\WB","Asynchronous","REG_DWORD",'0')
RegWrite("HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\Notify\WB","DllName","REG_SZ",@ScriptDir&'\fastload.dll')
RegWrite("HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\Notify\WB","Logon","REG_SZ",'StartWB')
RegWrite("HKCU\Software\Stardock\WindowBlinds\wb.ini\0","COL","REG_SZ",'65280')
RegWrite("HKCU\Software\Stardock\WindowBlinds\wb.ini\1","COL","REG_SZ",'15326093')
RegWrite("HKCU\Software\Stardock\WindowBlinds\wb.ini\10","COL","REG_SZ",'8453888')
RegWrite("HKCU\Software\Stardock\WindowBlinds\wb.ini\11","COL","REG_SZ",'8421440')
RegWrite("HKCU\Software\Stardock\WindowBlinds\wb.ini\2","COL","REG_SZ",'9982701')
RegWrite("HKCU\Software\Stardock\WindowBlinds\wb.ini\3","COL","REG_SZ",'4975603')
RegWrite("HKCU\Software\Stardock\WindowBlinds\wb.ini\4","COL","REG_SZ",'4227072')
RegWrite("HKCU\Software\Stardock\WindowBlinds\wb.ini\5","COL","REG_SZ",'8404992')
RegWrite("HKCU\Software\Stardock\WindowBlinds\wb.ini\6","COL","REG_SZ",'4227327')
RegWrite("HKCU\Software\Stardock\WindowBlinds\wb.ini\7","COL","REG_SZ",'128')
RegWrite("HKCU\Software\Stardock\WindowBlinds\wb.ini\8","COL","REG_SZ",'16777088')
RegWrite("HKCU\Software\Stardock\WindowBlinds\wb.ini\9","COL","REG_SZ",'8388863')
RegWrite("HKCU\Software\Stardock\WindowBlinds\wb.ini\global","noStatus","REG_SZ",'0')
RegWrite("HKCU\Software\Stardock\WindowBlinds\wb.ini\global","noMenu","REG_SZ",'0')
RegWrite("HKCU\Software\Stardock\WindowBlinds\wb.ini\MAP","Red","REG_SZ",'141')
RegWrite("HKCU\Software\Stardock\WindowBlinds\wb.ini\MAP","Green","REG_SZ",'219')
RegWrite("HKCU\Software\Stardock\WindowBlinds\wb.ini\MAP","Blue","REG_SZ",'233')
RegWrite("HKCU\Software\Stardock\WindowBlinds\wb.ini\MAP","LCOL","REG_SZ",'4')
RegWrite("HKCU\Software\Stardock\WindowBlinds\wb.ini\MAP","FORCE2","REG_SZ",'255')
RegWrite("HKCU\Software\Stardock\WindowBlinds\wb.ini\MAP2","Enabled","REG_SZ",'0')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\Installed","Path","REG_SZ",@ScriptDir)
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\map","HueAdjust","REG_SZ",'1')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","Skinset","REG_SZ",@ScriptDir&'\'&$nameThemes&'\'&$nameThemes&'.uis')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","Skinset2","REG_SZ",$nameThemes)
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","DoMenuBorders","REG_SZ",'1')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","UseChecks","REG_SZ",'1')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","UseButtons","REG_SZ",'1')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","UseColours","REG_SZ",'1')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","TaskBar","REG_SZ",'1')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","bitBmp","REG_SZ",'1')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","OptionNum","REG_SZ",'1')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","ShowConfig","REG_SZ",'0')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","AllowCol","REG_SZ",'1')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","noDiaBitmaps","REG_SZ",'1')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","transTxt","REG_SZ",'1')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","SubSkin","REG_SZ",'0')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","TOOLON","REG_SZ",'1')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","noExpBitmaps","REG_SZ",'1')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","stretchBitmaps","REG_SZ",'0')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","noFlatTool","REG_SZ",'0')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","Wallpaper","REG_SZ",'1')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","Icons","REG_SZ",'1')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","SysTray","REG_SZ",'0')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","UnloadWarn","REG_SZ",'1')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","Prompt","REG_SZ",'1')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","Fade","REG_SZ",'0')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","Over2","REG_SZ",'0')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","UserMode","REG_SZ",'0')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","SORTMODE","REG_SZ",'0')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","DoExplorerColour","REG_SZ",'0')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","FastExplorer","REG_SZ",'1')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","ExpTrans","REG_SZ",'0')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","INSTANTON","REG_SZ",'1')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","OverrideXP","REG_SZ",'0')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","InclusionList","REG_SZ",'0')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","OverrideShell","REG_SZ",'0')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","LastLoc","REG_SZ",'X:\')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WB5.ini\WBLiteFX","Lastsub","REG_SZ",'0')
RegWrite("HKCU\Software\Stardock\WindowBlinds\WindowFX.ini\WindowFX","Lang","REG_SZ",'Russian')
ShellExecute(@ScriptDir&'\wbload.exe','','','', @SW_HIDE )
Exit
EndIf
GUICreate("Выбор темы",265,125)
$Silver=GUICtrlCreateButton ("Silver", 5,5,55,22)
GUICtrlSetTip(-1, "Применить тему Silver"&@CRLF&"с указанным шрифтом и размером шрифта")
$fontf1=GUICtrlCreateCombo ("", 70,5,130,22)
GUICtrlSetData(-1,'Смешанный|Tahoma|Arial|Verdana|Microsoft Sans Serif', 'Arial')
GUICtrlSetTip($fontf1,'Выбираем шрифт')
$fontHeight1=GUICtrlCreateCombo ("", 210,5,45,22)
GUICtrlSetData(-1,'11|12|13|14|15|16|17', '14')
GUICtrlSetTip($fontHeight1,'Выбираем размер шрифта')
$black=GUICtrlCreateButton ("black", 5,35,55,22)
GUICtrlSetTip(-1, "Применить тему black"&@CRLF&"с указанным шрифтом и размером шрифта")
$fontf2=GUICtrlCreateCombo ("", 70,35,130,22)
GUICtrlSetData(-1,'Tahoma|Arial|Verdana|Microsoft Sans Serif', 'Arial')
GUICtrlSetTip($fontf2,'Выбираем шрифт')
$fontHeight2=GUICtrlCreateCombo ("", 210,35,45,22)
GUICtrlSetData(-1,'11|12|13|14|15|16|17', '14')
GUICtrlSetTip($fontHeight2,'Выбираем размер шрифта')
$Other=GUICtrlCreateButton ("Другое", 5,65,55,22)
GUICtrlSetTip(-1, "Применить указанную тему"&@CRLF&"(имя каталога)")
$Otherinput=GUICtrlCreateInput ('введите имя темы', 70,65,137,22)
$unwb=GUICtrlCreateButton ("Выгрузить WB", 5,95,96,22)
GUICtrlSetTip(-1, "Выгрузить WindowBlinds")
$stwb=GUICtrlCreateButton ("Старт WB", 111,95,96,22)
GUICtrlSetTip(-1, "Старт WindowBlinds")
GUISetState ()
While 1
$msg = GUIGetMsg()
Select
Case $msg = $Silver
$fontf_v=GUICtrlRead ($fontf1)
$fontf=$fontf_v
If $fontf_v="Смешанный" Then $fontf="Verdana"
$fontHeight=GUICtrlRead ($fontHeight1)
$inifile=@ScriptDir&'\SilverAS\SilverAS.uis'
$fontHeight00=$fontHeight
$fontHeight00+=1
IniWrite($inifile, "SystemFont0", "FontHeight", '-'&$fontHeight00 )
IniWrite($inifile, "SystemFont1", "FontHeight", '-'&$fontHeight )
IniWrite($inifile, "SystemFont2", "FontHeight", '-'&$fontHeight )
IniWrite($inifile, "SystemFont3", "FontHeight", '-'&$fontHeight )
IniWrite($inifile, "SystemFont4", "FontHeight", '-'&$fontHeight )
IniWrite($inifile, "SystemFont5", "FontHeight", '-'&$fontHeight )
IniWrite($inifile, "Font0", "FontHeight", '-'&$fontHeight )
$fontHeight04=$fontHeight
$fontHeight04+=9
IniWrite($inifile, "Font1", "FontHeight", '-'&$fontHeight04 )
IniWrite($inifile, "Font2", "FontHeight", '-'&$fontHeight )
$fontHeight06=$fontHeight
$fontHeight06+=6
IniWrite($inifile, "Font3", "FontHeight", '-'&$fontHeight06 )
$fontHeight07=$fontHeight
$fontHeight07-=3
IniWrite($inifile, "Font4", "FontHeight", '-'&$fontHeight07 )
$fontHeight09=$fontHeight
$fontHeight09-=2
IniWrite($inifile, "Font6", "FontHeight", '-'&$fontHeight09 )
IniWrite($inifile, "SystemFont1", "FontName", $fontf)
IniWrite($inifile, "SystemFont3", "FontName", $fontf)
IniWrite($inifile, "SystemFont4", "FontName", $fontf)
IniWrite($inifile, "SystemFont5", "FontName", $fontf)
IniWrite($inifile, "Font1", "FontName", $fontf)
IniWrite($inifile, "Font2", "FontName", $fontf)
IniWrite($inifile, "Font3", "FontName", $fontf)
IniWrite($inifile, "Font4", "FontName", $fontf)
IniWrite($inifile, "Font6", "FontName", $fontf)
If $fontf_v="Смешанный" Then $fontf="Arial"
IniWrite($inifile, "SystemFont0", "FontName", $fontf)
IniWrite($inifile, "SystemFont2", "FontName", $fontf)
IniWrite($inifile, "Font0", "FontName", $fontf)
RunWait ( @Comspec & ' /C start '&@ScriptDir&'\wbload.exe SilverAS\SilverAS.uis', '', @SW_HIDE )
Sleep(300)
$pid = ProcessExists("wbload.exe")
$index = _SysTrayIconIndex($pid)
If @error Then MsgBox(16, "Ошибка", "Это процесс не имеет иконку в трее")
$pos = _SysTrayIconPos($index)
If @OSType="WIN32_NT" Then BlockInput ( 1 )
MouseClick("right", $pos[0], $pos[1])
BlockInput ( 0 )
Case $msg = $black
$fontf=GUICtrlRead ($fontf2)
$fontHeight=GUICtrlRead ($fontHeight2)
IniWrite(@ScriptDir&'\black\black.uis', "SystemFont0", "FontHeight", '-'&$fontHeight )
IniWrite(@ScriptDir&'\black\black.uis', "SystemFont1", "FontHeight", '-'&$fontHeight )
IniWrite(@ScriptDir&'\black\black.uis', "SystemFont2", "FontHeight", '-'&$fontHeight )
IniWrite(@ScriptDir&'\black\black.uis', "SystemFont3", "FontHeight", '-'&$fontHeight )
IniWrite(@ScriptDir&'\black\black.uis', "SystemFont4", "FontHeight", '-'&$fontHeight )
IniWrite(@ScriptDir&'\black\black.uis', "SystemFont5", "FontHeight", '-'&$fontHeight )
IniWrite(@ScriptDir&'\black\black.uis', "Font0", "FontHeight", '-'&$fontHeight )
IniWrite(@ScriptDir&'\black\black.uis', "Font1", "FontHeight", '-'&$fontHeight )
IniWrite(@ScriptDir&'\black\black.uis', "Font3", "FontHeight", '-'&$fontHeight )
IniWrite(@ScriptDir&'\black\black.uis', "Font4", "FontHeight", '-'&$fontHeight )
IniWrite(@ScriptDir&'\black\black.uis', "Font5", "FontHeight", '-'&$fontHeight )
IniWrite(@ScriptDir&'\black\black.uis', "Font6", "FontHeight", '-'&$fontHeight )
IniWrite(@ScriptDir&'\black\black.uis', "SystemFont0", "FontName", $fontf)
IniWrite(@ScriptDir&'\black\black.uis', "SystemFont1", "FontName", $fontf)
IniWrite(@ScriptDir&'\black\black.uis', "SystemFont2", "FontName", $fontf)
IniWrite(@ScriptDir&'\black\black.uis', "SystemFont3", "FontName", $fontf)
IniWrite(@ScriptDir&'\black\black.uis', "SystemFont4", "FontName", $fontf)
IniWrite(@ScriptDir&'\black\black.uis', "SystemFont5", "FontName", $fontf)
IniWrite(@ScriptDir&'\black\black.uis', "Font0", "FontName", $fontf)
IniWrite(@ScriptDir&'\black\black.uis', "Font1", "FontName", $fontf)
IniWrite(@ScriptDir&'\black\black.uis', "Font2", "FontName", $fontf)
IniWrite(@ScriptDir&'\black\black.uis', "Font3", "FontName", $fontf)
IniWrite(@ScriptDir&'\black\black.uis', "Font4", "FontName", $fontf)
IniWrite(@ScriptDir&'\black\black.uis', "Font5", "FontName", $fontf)
IniWrite(@ScriptDir&'\black\black.uis', "Font6", "FontName", $fontf)
RunWait ( @Comspec & ' /C start '&@ScriptDir&'\wbload.exe black\black.uis', '', @SW_HIDE )
Sleep(300)
$pid = ProcessExists("wbload.exe")
$index = _SysTrayIconIndex($pid)
If @error Then MsgBox(16, "Ошибка", "Это процесс не имеет иконку в трее")
$pos = _SysTrayIconPos($index)
If @OSType="WIN32_NT" Then BlockInput ( 1 )
MouseClick("right", $pos[0], $pos[1])
BlockInput ( 0 )
Case $msg = $Other
$Otherinput0=GUICtrlRead ($Otherinput)
RunWait ( @Comspec & ' /C start '&@ScriptDir&'\wbload.exe '&$Otherinput0&'\'&$Otherinput0&'.uis', '', @SW_HIDE )
Sleep(300)
$pid = ProcessExists("wbload.exe")
$index = _SysTrayIconIndex($pid)
If @error Then MsgBox(16, "Ошибка", "Это процесс не имеет иконку в трее")
$pos = _SysTrayIconPos($index)
If @OSType="WIN32_NT" Then BlockInput ( 1 )
MouseClick("right", $pos[0], $pos[1])
BlockInput ( 0 )
Case $msg = $unwb
RunWait ( @Comspec & ' /C start '&@ScriptDir&'\wbload.exe UNLOAD', '', @SW_HIDE )
Case $msg = $stwb
RunWait ( @Comspec & ' /C start '&@ScriptDir&'\wbload.exe', '', @SW_HIDE )
Case $msg = $GUI_EVENT_CLOSE
ExitLoop
EndSelect
WEnd
Func _SysTrayIconIndex($name, $mode=0)
Local $index = -1
Local $process
Local $i
If $mode < 0 or $mode > 2 or Not IsInt($mode) Then
SetError(1)
return -1
EndIf
If $mode = 0 Then
$process = _SysTrayIconProcesses()
Else
$process = _SysTrayIconTitles()
EndIf
For $i = 0 to Ubound($process)-1
If $process[$i] = $name Then
$index = $i
EndIf
Next
return $index
EndFunc
Func _SysTrayIconPos($iIndex=0)
Local $str = "int;int;byte;byte;byte[2];dword;int"
Dim $TBBUTTON = DllStructCreate($str)
Dim $TBBUTTON2 = DllStructCreate($str)
Dim $ExtraData = DllStructCreate("dword[2]")
Dim $lpData
DIM $RECT
Local $pId
Local $text
Local $procHandle
Local $index = $iIndex
Local $bytesRead
Local $info
Local $pos[2]
Local $hidden = 0
Local $trayHwnd
Local $ret
$trayHwnd = _FindTrayToolbarWindow()
If $trayHwnd = -1 Then
$TBBUTTON = 0
$TBBUTTON2 = 0
$ExtraData = 0
SetError(1)
Return -1
EndIf
$ret = DLLCall("user32.dll","int","GetWindowThreadProcessId", "hwnd", $trayHwnd, "int*", -1)
If Not @error Then
$pId = $ret[2]
Else
ConsoleWrite("Error: Could not find toolbar process id, " & @error & @LF)
$TBBUTTON = 0
$TBBUTTON2 = 0
$ExtraData = 0
SetError(1)
Return -1
EndIf
$procHandle = DllCall("kernel32.dll", 'int', 'OpenProcess', 'int', $PROCESS_ALL_ACCESS, 'int', False, 'int', $pId)
If @error Then
ConsoleWrite("Error: Could not read toolbar process memory, " & @error & @LF)
$TBBUTTON = 0
$TBBUTTON2 = 0
$ExtraData = 0
SetError(1)
return -1
EndIf
$lpData = DLLCall("kernel32.dll","int","VirtualAllocEx", "int", $procHandle[0], "int", 0, "int", DllStructGetSize ( $TBBUTTON ), "int", 0x1000, "int", 0x04)
If @error Then
ConsoleWrite(@CRLF & "VirtualAllocEx Error" & @LF)
$TBBUTTON = 0
$TBBUTTON2 = 0
$ExtraData = 0
SetError(1)
Return -1
Else
DLLCall("user32.dll","int","SendMessage", "hwnd", $trayHwnd, "int", $TB_GETBUTTON, "int", $index, "ptr",$lpData[0])
DllCall('kernel32.dll', 'int', 'ReadProcessMemory', 'int', $procHandle[0], 'int', $lpData[0], 'ptr', DllStructGetPtr($TBBUTTON2), 'int', DllStructGetSize( $TBBUTTON), 'int', $bytesRead)
DllCall('kernel32.dll', 'int', 'ReadProcessMemory', 'int', $procHandle[0], 'int', DllStructGetData($TBBUTTON2,6), 'int', DllStructGetPtr($ExtraData), 'int', DllStructGetSize( $ExtraData), 'int', $bytesRead)
$info = DllStructGetData($ExtraData,1,1)
If Not BitAND(DllStructGetData($TBBUTTON2,3), 8) Then
$str = "int;int;int;int"
$RECT = DllStructCreate($str)
DLLCall("user32.dll","int","SendMessage", "hwnd", $trayHwnd, "int", $TB_GETITEMRECT, "int", $index, "ptr",$lpData[0])
DllCall('kernel32.dll', 'int', 'ReadProcessMemory', 'int', $procHandle[0], 'int', $lpData[0], 'ptr', DllStructGetPtr($RECT), 'int', DllStructGetSize($RECT), 'int', $bytesRead)
$ret = DLLCall("user32.dll","int","MapWindowPoints", "hwnd", $trayHwnd, "int", 0, 'ptr', DllStructGetPtr($RECT), "int",2)
ConsoleWrite("Info: " & $info & "RECT[0](left): " & DllStructGetData($RECT,1) & "RECT[1](top): " & DllStructGetData($RECT,2) & "RECT[2](right): " & DllStructGetData($RECT,3) & "RECT[3](bottom): " & DllStructGetData($RECT,4) & @LF)
$pos[0] = DllStructGetData($RECT,1)
$pos[1] = DllStructGetData($RECT,2)
$RECT = 0
Else
$hidden = 1
EndIf
DLLCall("kernel32.dll","int","VirtualFreeEx", "int", $procHandle[0], "ptr", $lpData[0], "int", 0, "int", 0x8000) ;DllStructGetSize ( $TBBUTTON ), "int", 0x8000)
EndIf
DllCall('kernel32.dll', 'int', 'CloseHandle', 'int', $procHandle[0])
$TBBUTTON = 0
$TBBUTTON2 = 0
$ExtraData = 0
If $hidden <> 1 Then
return $pos
Else
Return -1
EndIf
EndFunc
Func _SysTrayIconTitles()
Local $i
Local $j
Local $max = _SysTrayIconCount()
Local $info[$max]
Local $titles[$max]
Local $var
For $i=0 to $max-1
$info[$i] = _SysTrayIconHandle($i)
Next
$var = WinList()
For $i = 0 to $max-1
For $j = 1 to $var[0][0]
If $info[$i] = HWnd($var[$j][1]) Then
If $var[$j][0] <> "" Then
$titles[$i] = $var[$j][0]
Else
$titles[$i] = $NO_TITLE
EndIf
ExitLoop
EndIf
Next
Next
return $titles
EndFunc
Func _SysTrayIconProcesses()
Local $i
Local $j
Local $pids = _SysTrayIconPids()
Local $processes[UBound($pids)]
Local $list
$list = ProcessList()
For $i = 0 to Ubound($pids)-1
For $j = 1 To $list[0][0]
If $pids[$i] = $list[$j][1] Then
$processes[$i] = $list[$j][0]
ExitLoop
EndIf
Next
Next
return $processes
EndFunc ;_SysTrayIconProcesses()
Func _FindTrayToolbarWindow()
Local $hWnd = DLLCall("user32.dll","hwnd","FindWindow", "str", "Shell_TrayWnd", "int", 0)
if @error Then return -1
$hWnd = DLLCall("user32.dll","hwnd","FindWindowEx", "hwnd", $hWnd[0], "int", 0, "str", "TrayNotifyWnd", "int", 0);FindWindowEx(hWnd,NULL,_T("TrayNotifyWnd"), NULL);
if @error Then return -1
If @OSVersion <> "WIN_2000" Then
$hWnd = DLLCall("user32.dll","hwnd","FindWindowEx", "hwnd", $hWnd[0], "int", 0, "str", "SysPager", "int", 0);FindWindowEx(hWnd,NULL,_T("TrayNotifyWnd"), NULL);
if @error Then return -1
EndIf
$hWnd = DLLCall("user32.dll","hwnd","FindWindowEx", "hwnd", $hWnd[0], "int", 0, "str", "ToolbarWindow32", "int", 0);FindWindowEx(hWnd,NULL,_T("TrayNotifyWnd"), NULL);
if @error Then return -1
Return $hWnd[0]
EndFunc
Func _SysTrayIconPids()
Local $i
Local $titles = _SysTrayIconTitles()
Local $processes[UBound($titles)]
Local $ret
For $i=0 to Ubound($titles)-1
If $titles[$i] <> $NO_TITLE Then
$processes[$i] = WinGetProcess($titles[$i])
Else
$ret = DLLCall("user32.dll","int","GetWindowThreadProcessId", "int", _SysTrayIconHandle($i), "int*", -1)
If Not @error Then
$processes[$i] = $ret[2]
EndIf
EndIf
Next
return $processes
EndFunc
Func _SysTrayIconHandle($iIndex=0)
Local $str = "int;int;byte;byte;byte[2];dword;int";char[128]"
Dim $TBBUTTON = DllStructCreate($str)
Dim $TBBUTTON2 = DllStructCreate($str)
Dim $ExtraData = DllStructCreate("dword[2]")
Local $pId
Local $text
Local $procHandle
Local $index = $iIndex
Local $bytesRead
Local $info
Local $lpData
Local $trayHwnd
$trayHwnd = _FindTrayToolbarWindow()
If $trayHwnd = -1 Then
$TBBUTTON = 0
$TBBUTTON2 = 0
$ExtraData = 0
SetError(1)
Return -1
EndIf
Local $ret = DLLCall("user32.dll","int","GetWindowThreadProcessId", "hwnd", $trayHwnd, "int*", -1)
If Not @error Then
$pId = $ret[2]
Else
ConsoleWrite("Error: Could not find toolbar process id, " & @error & @LF)
$TBBUTTON = 0
$TBBUTTON2 = 0
$ExtraData = 0
Return -1
EndIf
$procHandle = DllCall("kernel32.dll", 'int', 'OpenProcess', 'int', $PROCESS_ALL_ACCESS, 'int', False, 'int', $pId)
If @error Then
ConsoleWrite("Error: Could not read toolbar process memory, " & @error & @LF)
$TBBUTTON = 0
$TBBUTTON2 = 0
$ExtraData = 0
return -1
EndIf
$lpData = DLLCall("kernel32.dll","int","VirtualAllocEx", "int", $procHandle[0], "int", 0, "int", DllStructGetSize ( $TBBUTTON ), "int", 0x1000, "int", 0x04)
If @error Then
ConsoleWrite("VirtualAllocEx Error" & @LF)
$TBBUTTON = 0
$TBBUTTON2 = 0
$ExtraData = 0
Return -1
Else
DLLCall("user32.dll","int","SendMessage", "hwnd", $trayHwnd, "int", $TB_GETBUTTON, "int", $index, "ptr", $lpData[0]);e(hwnd, TB_GETBUTTON, index, (LPARAM)lpData);
DllCall('kernel32.dll', 'int', 'ReadProcessMemory', 'int', $procHandle[0], 'int', $lpData[0], 'ptr', DllStructGetPtr($TBBUTTON2), 'int', DllStructGetSize( $TBBUTTON), 'int', $bytesRead)
DllCall('kernel32.dll', 'int', 'ReadProcessMemory', 'int', $procHandle[0], 'int', DllStructGetData($TBBUTTON2,6), 'int', DllStructGetPtr($ExtraData), 'int', DllStructGetSize( $ExtraData), 'int', $bytesRead);_MemRead($procHandle, $lpData[0], DllStructGetSize( $TBBUTTON))
$info = DllStructGetData($ExtraData,1)
DLLCall("kernel32.dll","int","VirtualFreeEx", "int", $procHandle[0], "ptr", $lpData[0], "int", 0, "int", 0x8000) ;DllStructGetSize ( $TBBUTTON ), "int", 0x8000)
EndIf
DllCall('kernel32.dll', 'int', 'CloseHandle', 'int', $procHandle[0])
$TBBUTTON = 0
$TBBUTTON2 = 0
$ExtraData = 0
$lpData = 0
return $info
EndFunc
Func _SysTrayIconCount()
Local $hWnd = _FindTrayToolbarWindow()
Local $count = 0
$count = DLLCall("user32.dll","int","SendMessage", "hwnd", $hWnd, "int", $TB_BUTTONCOUNT, "int", 0, "int", 0)
If @error Then Return -1
return $count[0]
EndFunc
