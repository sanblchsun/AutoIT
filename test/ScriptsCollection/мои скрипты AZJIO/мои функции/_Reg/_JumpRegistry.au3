
_JumpRegistry('HKEY_CURRENT_USER\Software\Microsoft\Notepad')

Func _JumpRegistry($sKey)
	Local $hWnd, $hControl, $aKey, $i
	If Not ProcessExists("regedit.exe") Then
		Run(@WindowsDir & '\regedit.exe')
		If Not WinWaitActive('[CLASS:RegEdit_RegEdit]', '', 3) Then Return SetError(1, 1, 1)
	EndIf
	If Not WinActive('[CLASS:RegEdit_RegEdit]') Then WinActivate('[CLASS:RegEdit_RegEdit]')

	$hWnd = WinGetHandle("[CLASS:RegEdit_RegEdit]")
	$hControl = ControlGetHandle($hWnd, "", "[CLASS:SysTreeView32; INSTANCE:1]")

	$aKey = StringSplit($sKey, '\')
	$sKey = '#0'
	For $i = 1 To $aKey[0]
		ControlTreeView($hWnd, "", $hControl, "Expand", $sKey)
		$sKey &= '|' & $aKey[$i]
	Next
	ControlTreeView($hWnd, "", $hControl, "Expand", $sKey)
	ControlTreeView($hWnd, "", $hControl, "Select", $sKey)
EndFunc