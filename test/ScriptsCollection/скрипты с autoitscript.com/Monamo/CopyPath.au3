#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=.\CopyPath.ico
#AutoIt3Wrapper_Outfile=CopyPath.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=Copies the path of a file or folder to the clipboard.
#AutoIt3Wrapper_Res_Description=CopyPath v2
#AutoIt3Wrapper_Res_Fileversion=2.1.0.0
#AutoIt3Wrapper_Res_Language=1033
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

Dim $file = ""
Dim $setMsg = ""

If $CmdLine[0] = "0" Then
	If Not StringInStr(RegRead("HKEY_CLASSES_ROOT\*\shell\Copy Path to Clipboard\Command", ""), @ScriptFullPath) Then
		MsgBox(32, "Not Installed", "CopyPath has not been installed in this location. Use '/installhere' to create the appropriate registry entries.")
	Else
		MsgBox(32, "Installed", "CopyPath has been installed in this location. Use '/uninstall' to remove registry entries.")
	EndIf
	_Help()
	Exit
Else
	Select
		Case $CmdLine[1] = "/installhere"
			_InstallHere()
		Case $CmdLine[1] = "/uninstall"
			_Uninstall()
		Case $CmdLine[1] = "/help" Or $CmdLine[1] = "-help" Or $CmdLine[1] = "/?" Or $CmdLine[1] = "-?"
			_Help()
		Case Else
			Dim $file = _GetLnkInfo()
			If DriveGetType($file) = "NETWORK" Then
				If StringInStr($file, ":", 0, 1) = 2 Then
					$uncYesNo = MsgBox(36, "Mapped drive path detected", "Would you like the UNC path to be copied to the clipboard?" & @LF & "If so, click 'YES' - Click 'No' to copy the (mapped) drive letter path to the clipboard.")
					If $uncYesNo = 6 Then
						_GetUNCPath()
					Else
					EndIf
				EndIf
			Else
			EndIf
	EndSelect
EndIf

ClipPut($file)

Func _GetLnkInfo()
	Select
		Case StringRight($CmdLine[1], 4) = ".lnk"
			$getShortcutYesNo = _GetShortcutPrompt()
			If $getShortcutYesNo = 6 Then
				$shortcutData = FileGetShortcut($CmdLine[1])
				$file = $shortcutData[0]
			Else
				$file = FileGetLongName($CmdLine[1])
			EndIf
		Case StringRight($CmdLine[1], 4) = ".url"
			$getShortcutYesNo = _GetShortcutPrompt()
			If $getShortcutYesNo = 6 Then
				$file = IniRead($CmdLine[1], "InternetShortcut", "URL", "")
			Else
				$file = FileGetLongName($CmdLine[1])
			EndIf
		Case Else
			$file = FileGetLongName($CmdLine[1])
	EndSelect
	Return $file
EndFunc

Func _GetShortcutPrompt()
	$prompt = MsgBox(36, "Shortcut detected", "Would you like the shortcut target path to be copied to the clipboard?" & @LF & "If so, click 'YES' - Click 'No' to copy the path of the " & Chr(34) & "link" & Chr(34) & " file to the clipboard.")
	Return $prompt
EndFunc

Func _GetUNCPath()
	$mappedDrive = StringTrimRight($file, (StringLen($file) - 2))
	$mappedPath = DriveMapGet($mappedDrive)
	$uncpath = $mappedPath & StringTrimLeft($file, 2)
	$file = $uncpath
EndFunc

Func _InstallHere()
	$sScriptPathReg = @ScriptFullPath & " " & Chr(34) & "%1" & Chr(34)
	RegWrite("HKEY_CLASSES_ROOT\*\shell\Copy Path to Clipboard\COMMAND", "", "REG_SZ", $sScriptPathReg)
	RegWrite("HKEY_CLASSES_ROOT\Folder\shell\Copy Path to Clipboard\command", "", "REG_SZ", $sScriptPathReg)
	RegWrite("HKEY_CLASSES_ROOT\lnkfile\shell\Copy Path to Clipboard\command", "", "REG_SZ", $sScriptPathReg)
	RegWrite("HKEY_CLASSES_ROOT\InternetShortcut\shell\Copy Path to Clipboard\command", "", "REG_SZ", $sScriptPathReg)
EndFunc

Func _Uninstall()
	RegDelete("HKEY_CLASSES_ROOT\*\shell\Copy Path to Clipboard")
	RegDelete("HKEY_CLASSES_ROOT\Folder\shell\Copy Path to Clipboard")
EndFunc

Func _Help()
	MsgBox(64, "CopyPath Help - Version " & FileGetVersion(@ScriptFullPath), "This application is not designed to be run without parameters." & @LF & @LF & "Usage:" & @LF & " - Right-click on a file or folder and select " & Chr(34) & "Copy Path to" & @LF & " Clipboard" & Chr(34) & @LF & @LF & " Or" & @LF & @LF & " - Drag and drop another file or folder directly onto the" & @LF & " CopyPath executable to have the file's full path copied" & @LF & " to the clipboard." & @LF)
EndFunc