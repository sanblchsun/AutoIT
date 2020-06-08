#NoTrayIcon
If $CmdLine[0] Then
	$aLnk = FileGetShortcut($CmdLine[1])
	Run('Explorer.exe /select,"' & $aLnk[0] & '"')
Else
	Switch @OSVersion
		Case "WIN_XP", "WIN_XPe", "WIN_2000"
			$LngName = 'Find object'
			If @OSLang = 0419 Then $LngName = 'Найти объект'
			RegWrite("HKCR\lnkfile\shell\folder", "", "REG_SZ", $LngName)
			If @Compiled Then
				RegWrite("HKCR\lnkfile\shell\folder\command", "", "REG_SZ", '"' & @SystemDir & '\lnk.exe" "%1"')
				If Not FileExists(@SystemDir & '\lnk.exe') Then FileCopy(@ScriptFullPath, @SystemDir & '\lnk.exe', 1)
			Else
				RegWrite("HKCR\lnkfile\shell\folder\command", "", "REG_SZ", @AutoItExe & ' "' & @SystemDir & '\lnk.au3" "%1"')
				If Not FileExists(@SystemDir & '\lnk.au3') Then FileCopy(@ScriptFullPath, @SystemDir & '\lnk.au3', 1)
			EndIf
		Case Else
			MsgBox(0, 'Error', 'This system is not supported')
	EndSwitch
EndIf