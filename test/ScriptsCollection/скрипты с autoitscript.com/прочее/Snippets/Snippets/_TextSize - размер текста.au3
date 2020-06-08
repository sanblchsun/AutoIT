;Author: JScript - Snippet Version No. = 1.0
;Snippet was Created Using AutoIt Version = 3.3.8.1, Creation Date = 23/05/12.

Local $sText = "Текст для определения его размера!"
Local $aiSize = _TextSize($sText)

MsgBox(4096, "TextSize", "Строка: " & $sText & @CRLF & @CRLF & "Ширина: " & $aiSize[0] & @CRLF & "Высота: " & $aiSize[1])

Func _TextSize($sString, $iSize = 9, $iWeight = 400, $sFontName = "")
	Local $hWnd, $hGuiSwitch, $aCtrlSize, $aRetSize[2] = [0, 0]

	$hWnd = GUICreate($sString, 0, 0, 0, 0, BitOR(0x80000000, 0x20000000), BitOR(0x00000080, 0x00000020))
	$hGuiSwitch = GUISwitch($hWnd)
	GUISetFont($iSize, $iWeight, -1, $sFontName, $hWnd)
	$aCtrlSize = ControlGetPos($hWnd, "", GUICtrlCreateLabel($sString, 0, 0))
	GUIDelete($hWnd)
	GUISwitch($hGuiSwitch)

	If IsArray($aCtrlSize) Then
		$aRetSize[0] = $aCtrlSize[2]; Width
		$aRetSize[1] = $aCtrlSize[3]; Height
		Return SetError(0, 0, $aRetSize)
	EndIf
	Return SetError(1, 0, $aRetSize)
EndFunc   ;==>_TextSize