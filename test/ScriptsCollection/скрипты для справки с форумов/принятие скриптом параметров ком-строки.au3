Exit

; примеры проверки параметров передаваемых скрипту ком-строкой.

; проверка по количеству параметров.
If $CmdLine[0] < 2 Then Exit

; из скрипта CopyPath.au3, автор Monamo

Case $CmdLine[1] = "/installhere"
_InstallHere()
Case $CmdLine[1] = "/uninstall"
_Uninstall()
Case $CmdLine[1] = "/help" Or $CmdLine[1] = "-help" Or $CmdLine[1] = "/?" Or $CmdLine[1] = "-?"
_Help()

; из скрипта AeroTrans-X3.au3  (установка прозрачности), автор  ichigo325

Func _CheckParameters()
	If $CmdLine[0] = "" Or $CmdLine[0] = 0 Then
		Return 0
	Else
		For $i = 1 To $CmdLine[0]
			If StringRegExp($CmdLine[$i], '-t[0-255]') = 1 Then _TraySetTrans($CmdLine[$i])
			If StringRegExp($CmdLine[$i], '-s[0-255]') = 1 Then _StartSetTrans($CmdLine[$i])
			If $CmdLine[$i] = "-reset" Then
				WinSetTrans("[CLASS:Shell_TrayWnd]", "", 255)
				ControlClick("[CLASS:Shell_TrayWnd]", "", "[CLASS:Button; INSTANCE:1]")
				WinSetTrans("[CLASS:DV2ControlHost]", "", 255)
				Sleep(1000)
				ControlFocus("[CLASS:Shell_TrayWnd]", "", "[CLASS:Button; INSTANCE:1]")
				IniWrite($inipath, @UserName, "Taskbar", 255)
				IniWrite($inipath, @UserName, "StartMenu", 255)
			EndIf
			If $CmdLine[$i] = "-silent" Then
				WinSetTrans("[CLASS:Shell_TrayWnd]", "", IniRead($inipath, @UserName, "Taskbar", 255))
				ControlClick("[CLASS:Shell_TrayWnd]", "", "[CLASS:Button; INSTANCE:1]")
				WinSetTrans("[CLASS:DV2ControlHost]", "", IniRead($inipath, @UserName, "StartMenu", 255))
				Sleep(1000)
				ControlFocus("[CLASS:Shell_TrayWnd]", "", "[CLASS:Button; INSTANCE:1]")
			EndIf
			If $CmdLine[$i] = "-refresh" Then ProcessClose("explorer.exe")
		Next
		Exit
	EndIf
EndFunc   ;==>_CheckParameters