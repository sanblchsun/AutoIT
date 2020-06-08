#include <GUIConstants.au3>
#include <SysTray_UDF.au3> 
AutoItSetOption("TrayIconHide", 1) ;скрыть в системной панели индикатор AutoIt

If Not ProcessExists("wbload.exe") Then
   $nameThemes = 'SilverAS'
; регистрация WindowBlinds в реестре
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
; старт WindowBlinds и выход из скрипта
ShellExecute(@ScriptDir&'\wbload.exe','','','', @SW_HIDE )
Exit
EndIf


GUICreate("Выбор темы",265,125) ; размер окна

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
				;$fontHeight08=$fontHeight
				;$fontHeight08-=3
				;IniWrite($inifile, "Font5", "FontHeight", '-'&$fontHeight08 )
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
				;If $fontf_v="Смешанный" Then $fontf="Microsoft Sans Serif"
				;IniWrite($inifile, "Font5", "FontName", $fontf)
				
				RunWait ( @Comspec & ' /C start '&@ScriptDir&'\wbload.exe SilverAS\SilverAS.uis', '', @SW_HIDE )
				Sleep(300)
				$pid = ProcessExists("wbload.exe")
				$index = _SysTrayIconIndex($pid)
				If @error Then MsgBox(16, "Ошибка", "Это процесс не имеет иконку в трее")
				$pos = _SysTrayIconPos($index)
				If @OSType="WIN32_NT" Then BlockInput ( 1 ) ;блокировать мышь и клавиатуру
				MouseClick("right", $pos[0], $pos[1])
				BlockInput ( 0 ) ;разблокировать мышь и клавиатуру
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
				If @OSType="WIN32_NT" Then BlockInput ( 1 ) ;блокировать мышь и клавиатуру
				MouseClick("right", $pos[0], $pos[1])
				BlockInput ( 0 ) ;разблокировать мышь и клавиатуру
            Case $msg = $Other
				$Otherinput0=GUICtrlRead ($Otherinput)
				RunWait ( @Comspec & ' /C start '&@ScriptDir&'\wbload.exe '&$Otherinput0&'\'&$Otherinput0&'.uis', '', @SW_HIDE )
				Sleep(300)
				$pid = ProcessExists("wbload.exe")
				$index = _SysTrayIconIndex($pid)
				If @error Then MsgBox(16, "Ошибка", "Это процесс не имеет иконку в трее")
				$pos = _SysTrayIconPos($index)
				If @OSType="WIN32_NT" Then BlockInput ( 1 ) ;блокировать мышь и клавиатуру
				MouseClick("right", $pos[0], $pos[1])
				BlockInput ( 0 ) ;разблокировать мышь и клавиатуру
            Case $msg = $unwb
				RunWait ( @Comspec & ' /C start '&@ScriptDir&'\wbload.exe UNLOAD', '', @SW_HIDE )
            Case $msg = $stwb
				RunWait ( @Comspec & ' /C start '&@ScriptDir&'\wbload.exe', '', @SW_HIDE )
			Case $msg = $GUI_EVENT_CLOSE
				ExitLoop
		EndSelect
	WEnd