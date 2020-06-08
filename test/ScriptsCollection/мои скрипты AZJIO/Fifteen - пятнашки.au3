#AutoIt3Wrapper_Outfile=Fifteen.exe
#AutoIt3Wrapper_Icon=Fifteen.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=Fifteen.exe
#AutoIt3Wrapper_Res_Fileversion=0.3.0.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Field=Version|0.3
#AutoIt3Wrapper_Res_Field=Build|2012.07.17
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"

;  @AZJIO 2010.10.17 - 2012.07.17 (AutoIt3_v3.2.12.1...v3.3.6.1)
; Resizing, displacement on 2-3 buttons.

#NoTrayIcon

#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <WinAPI.au3>

Opt("GUIResizeMode", 1)

; En
$LngTitle = 'Fifteen'
$LngAbout = 'About'
$LngVer = 'Version'
$LngSite = 'Site'
$LngCopy = 'Copy'
$LngA = 'Author'
$LngRe = 'Mix'
$LngMsgT = 'Message'
$LngMsg = 'Excellently'

; Ru
; если русская локализация, то русский язык
If @OSLang = 0419 Then
	$LngTitle = 'Пятнашки'
	$LngAbout = 'О программе'
	$LngVer = 'Версия'
	$LngCopy = 'Копировать'
	$LngSite = 'Сайт'
	$LngA = 'Автор'
	$LngRe = 'Перемешать'
	$LngMsgT = 'Сообщение'
	$LngMsg = 'Молодец!'
EndIf

$h = _WinAPI_GetSystemMetrics(4) + _WinAPI_GetSystemMetrics(33) * 2 + 21
$w = _WinAPI_GetSystemMetrics(32) * 2
Global $aXY[17][4], $s = 47

$gx = $s * 4
$gy = $s * 4 + 21
$Gui = GUICreate($LngTitle, $gx, $gy, -1, -1, $WS_OVERLAPPEDWINDOW + $WS_CLIPCHILDREN)
If Not @Compiled Then GUISetIcon(@ScriptDir&'\Fifteen.ico')

$iAbout = GUICtrlCreateButton($LngA, 0, $gy - 21, $s * 2, 20)
GUICtrlSetResizing(-1, 2 + 64 + 512)
$iRefresh = GUICtrlCreateButton($LngRe, $s * 2, $gy - 21, $s * 2, 20)
GUICtrlSetResizing(-1, 4 + 8 + 64 + 512)

GUISetFont(15, 700)
$y = 0
$x = 0
For $i = 1 To 16
	$aXY[$i][0] = $i
	Switch $i
		Case 1 To 4
			$y = 0
			$x = 1
		Case 5 To 8
			$y = 1
			$x = 5
		Case 9 To 12
			$y = 2
			$x = 9
		Case 13 To 16
			$y = 3
			$x = 13
	EndSwitch
	$aXY[$i][2] = ($i - $x) * $s
	$aXY[$i][3] = $y * $s
	If $i < 16 Then
		$aXY[$i][1] = GUICtrlCreateButton($i, $aXY[$i][2], $aXY[$i][3], $s, $s)
	EndIf
Next
GUISetState()
; _Resized()
_Refresh()

; $aClientSize = WinGetClientSize($Gui)
; MsgBox(0, "Размер клиентской области ", _
    ; 'ширина:'&@Tab&$aClientSize[0] &@CRLF& _
    ; 'высота:' &@Tab& $aClientSize[1])
	
	
GUIRegisterMsg($WM_SIZING, "WM_SIZING")
GUIRegisterMsg($WM_GETMINMAXINFO, "WM_GETMINMAXINFO")

While 1
	$msg = GUIGetMsg()

	; проверяем с конца последовательности, как наименее вероятную
	If $aXY[16][2] = $s * 3 And $aXY[16][3] = $s * 3 And $aXY[15][2] = $s * 2 And $aXY[15][3] = $s * 3 And $aXY[14][2] = $s And $aXY[14][3] = $s * 3 And $aXY[13][2] = 0 And $aXY[13][3] = $s * 3 And $aXY[12][2] = $s * 3 And $aXY[12][3] = $s * 2 And $aXY[11][2] = $s * 2 And $aXY[11][3] = $s * 2 And $aXY[10][2] = $s And $aXY[10][3] = $s * 2 And $aXY[9][2] = 0 And $aXY[9][3] = $s * 2 And $aXY[8][2] = $s * 3 And $aXY[8][3] = $s And $aXY[7][2] = $s * 2 And $aXY[7][3] = $s And $aXY[6][2] = $s And $aXY[6][3] = $s And $aXY[5][2] = 0 And $aXY[5][3] = $s And $aXY[4][2] = $s * 3 And $aXY[4][3] = 0 And $aXY[3][2] = $s * 2 And $aXY[3][3] = 0 And $aXY[2][2] = $s And $aXY[2][3] = 0 And $aXY[1][2] = 0 And $aXY[1][3] = 0 Then
		Sleep(500)
		MsgBox(0, $LngMsgT, $LngMsg)
		_Refresh()
	EndIf
	
	
	Switch $msg
		Case $aXY[1][1] To $aXY[15][1]
			$j = $msg - $aXY[1][1] + 1

			If ($aXY[$j][2] = $aXY[16][2] And ($aXY[$j][3] = $aXY[16][3] + $s Or $aXY[$j][3] = $aXY[16][3] - $s)) Or ($aXY[$j][3] = $aXY[16][3] And ($aXY[$j][2] = $aXY[16][2] + $s Or $aXY[$j][2] = $aXY[16][2] - $s)) Then _reButton($j)
			
			; displacement on 2-3 buttons.
			Select
				Case $aXY[$j][2] = $aXY[16][2] And $aXY[$j][3] = $aXY[16][3] + $s * 2 ; from below upwards
					_reArr(0, 1)
					_reArr(0, 1)
				Case $aXY[$j][2] = $aXY[16][2] And $aXY[$j][3] = $aXY[16][3] + $s * 3
					_reArr(0, 1)
					_reArr(0, 1)
					_reArr(0, 1)
				Case $aXY[$j][2] = $aXY[16][2] And $aXY[$j][3] = $aXY[16][3] - $s * 2 ; from top to bottom
					_reArr(0, -1)
					_reArr(0, -1)
				Case $aXY[$j][2] = $aXY[16][2] And $aXY[$j][3] = $aXY[16][3] - $s * 3
					_reArr(0, -1)
					_reArr(0, -1)
					_reArr(0, -1)
				Case $aXY[$j][2] = $aXY[16][2] + $s * 2 And $aXY[$j][3] = $aXY[16][3] ; right to left
					_reArr(1, 0)
					_reArr(1, 0)
				Case $aXY[$j][2] = $aXY[16][2] + $s * 3 And $aXY[$j][3] = $aXY[16][3]
					_reArr(1, 0)
					_reArr(1, 0)
					_reArr(1, 0)
				Case $aXY[$j][2] = $aXY[16][2] - $s * 2 And $aXY[$j][3] = $aXY[16][3] ; left to right
					_reArr(-1, 0)
					_reArr(-1, 0)
				Case $aXY[$j][2] = $aXY[16][2] - $s * 3 And $aXY[$j][3] = $aXY[16][3]
					_reArr(-1, 0)
					_reArr(-1, 0)
					_reArr(-1, 0)
			EndSelect

		Case $GUI_EVENT_RESIZED, $GUI_EVENT_MAXIMIZE, $GUI_EVENT_RESTORE
			_Resized()
		Case $iRefresh
			_Refresh()
		Case $iAbout
			_About()
		Case -3
			ExitLoop
	EndSwitch
WEnd

; we change places a button with paleholder by rand in 4-h directions
Func _Refresh()
	For $u = 1 To 500
		;Sleep(100)
		Switch Random(1, 4, 1)
			Case 1
				For $i = 1 To 16
					If $aXY[$i][2] = $aXY[16][2] + $s And $aXY[$i][3] = $aXY[16][3] Then _reButton($i)
				Next
			Case 2
				For $i = 1 To 16
					If $aXY[$i][2] = $aXY[16][2] - $s And $aXY[$i][3] = $aXY[16][3] Then _reButton($i)
				Next
			Case 3
				For $i = 1 To 16
					If $aXY[$i][2] = $aXY[16][2] And $aXY[$i][3] = $aXY[16][3] + $s Then _reButton($i)
				Next
			Case 4
				For $i = 1 To 16
					If $aXY[$i][2] = $aXY[16][2] And $aXY[$i][3] = $aXY[16][3] - $s Then _reButton($i)
				Next
		EndSwitch
	Next
EndFunc

; displacement on 2-3 buttons.
Func _reArr($o, $u)
	For $i = 1 To 16
		If $aXY[$i][2] = $aXY[16][2] + $s * $o And $aXY[$i][3] = $aXY[16][3] + $s * $u Then
			_reButton($i)
			Return
		EndIf
	Next
EndFunc

; we change places a button with paleholder
Func _reButton($i)
	GUICtrlSetPos($aXY[$i][1], $aXY[16][2], $aXY[16][3])
	$tmp2 = $aXY[$i][2]
	$tmp3 = $aXY[$i][3]
	$aXY[$i][2] = $aXY[16][2]
	$aXY[$i][3] = $aXY[16][3]
	$aXY[16][2] = $tmp2
	$aXY[16][3] = $tmp3
EndFunc

Func WM_SIZING($hWnd, $iMsg, $wparam, $lparam)
	Local $s1, $sRect = DllStructCreate("Int[4]", $lparam), _
			$left = DllStructGetData($sRect, 1, 1), _
			$top = DllStructGetData($sRect, 1, 2), _
			$Right = DllStructGetData($sRect, 1, 3), _
			$bottom = DllStructGetData($sRect, 1, 4), _
			$w0 = $Right - $left, _
			$h0 = $bottom - $top
	If ($w0 - $w) / 4 <> $s Or ($h0 - $h) / 4 <> $s Then
		If $w0 - $w < $h0 - $h Then
			$s1 = Int(($w0 - $w) / 4)
		Else
			$s1 = Int(($h0 - $h) / 4)
		EndIf
		If $s1 < 31 Then $s1 = 31
		For $i = 1 To 16
			GUICtrlSetFont($aXY[$i][1], Int($s1 / 2.7), 700, 2)
		Next
	EndIf
	Switch $wparam
		Case 1, 2
			DllStructSetData($sRect, 1, DllStructGetData($sRect, 1, 2) + $w0 + $h - $w, 4) ; bottom
		Case Else
			DllStructSetData($sRect, 1, DllStructGetData($sRect, 1, 1) + $h0 - $h + $w, 3) ; Right
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc

Func _Resized()
	Local $GuiPos = WinGetPos($Gui), $t
	If ($GuiPos[2] - $w) / 4 <> $s Or ($GuiPos[3] - $h) / 4 <> $s Then
		$t = $s
		If $GuiPos[2] - $w > $GuiPos[3] - $h Then
			$s = Int(($GuiPos[2] - $w) / 4)
		Else
			$s = Int(($GuiPos[3] - $h) / 4)
		EndIf
		If $s < 31 Then $s = 31
		WinMove($Gui, "", Default, Default, $s * 4 + $w, $s * 4 + $h)
		For $i = 1 To 16
			$aXY[$i][2] = $aXY[$i][2] / $t * $s
			$aXY[$i][3] = $aXY[$i][3] / $t * $s
			GUICtrlSetPos($aXY[$i][1], $aXY[$i][2], $aXY[$i][3], $s, $s)
			GUICtrlSetFont($aXY[$i][1], Int($s / 2.7), 700, 2)
		Next
		GUICtrlSetPos($iAbout, 0, $s * 4, $s * 2, 20)
		GUICtrlSetPos($iRefresh, $s * 2, $s * 4, $s * 2, 20)
	EndIf
EndFunc

Func WM_GETMINMAXINFO($hWnd, $iMsg, $wparam, $lparam)
	#forceref $iMsg, $wParam
	If $hWnd = $Gui Then
		Local $tMINMAXINFO = DllStructCreate("int;int;" & _
				"int MaxSizeX; int MaxSizeY;" & _
				"int MaxPositionX;int MaxPositionY;" & _
				"int MinTrackSizeX; int MinTrackSizeY;" & _
				"int MaxTrackSizeX; int MaxTrackSizeY", _
				$lparam)
		DllStructSetData($tMINMAXINFO, "MinTrackSizeY", 188)
		DllStructSetData($tMINMAXINFO, "MaxTrackSizeX", @DesktopHeight - 80)
	EndIf
EndFunc

Func _ChildCoor($Gui, $w, $h, $c = 0, $d = 0)
	Local $aWA = _WinAPI_GetWorkingArea(), _
			$GP = WinGetPos($Gui), _
			$wgcs = WinGetClientSize($Gui)
	Local $dLeft = ($GP[2] - $wgcs[0]) / 2, _
			$dTor = $GP[3] - $wgcs[1] - $dLeft
	If $c = 0 Then
		$GP[0] = $GP[0] + ($GP[2] - $w) / 2 - $dLeft
		$GP[1] = $GP[1] + ($GP[3] - $h - $dLeft - $dTor) / 2
	EndIf
	If $d > ($aWA[2] - $aWA[0] - $w - $dLeft * 2) / 2 Or $d > ($aWA[3] - $aWA[1] - $h - $dLeft + $dTor) / 2 Then $d = 0
	If $GP[0] + $w + $dLeft * 2 + $d > $aWA[2] Then $GP[0] = $aWA[2] - $w - $d - $dLeft * 2
	If $GP[1] + $h + $dLeft + $dTor + $d > $aWA[3] Then $GP[1] = $aWA[3] - $h - $dLeft - $dTor - $d
	If $GP[0] <= $aWA[0] + $d Then $GP[0] = $aWA[0] + $d
	If $GP[1] <= $aWA[1] + $d Then $GP[1] = $aWA[1] + $d
	$GP[2] = $w
	$GP[3] = $h
	Return $GP
EndFunc

Func _WinAPI_GetWorkingArea()
	Local Const $SPI_GETWORKAREA = 48
	Local $stRECT = DllStructCreate("long; long; long; long")

	Local $SPIRet = DllCall("User32.dll", "int", "SystemParametersInfo", "uint", $SPI_GETWORKAREA, "uint", 0, "ptr", DllStructGetPtr($stRECT), "uint", 0)
	If @error Then Return 0
	If $SPIRet[0] = 0 Then Return 0

	Local $sLeftArea = DllStructGetData($stRECT, 1)
	Local $sTopArea = DllStructGetData($stRECT, 2)
	Local $sRightArea = DllStructGetData($stRECT, 3)
	Local $sBottomArea = DllStructGetData($stRECT, 4)

	Local $aRet[4] = [$sLeftArea, $sTopArea, $sRightArea, $sBottomArea]
	Return $aRet
EndFunc

Func _About()
	$GP = _ChildCoor($Gui, 210, 180)
	GUISetState(@SW_DISABLE, $Gui)
	$font = "Arial"
	$Gui1 = GUICreate($LngAbout, $GP[2], $GP[3], $GP[0], $GP[1], BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $Gui) ; WS_CAPTION+WS_SYSMENU
	If Not @Compiled Then GUISetIcon(@ScriptDir&'\Fifteen.ico')
	GUISetBkColor(0xE1E3E7)
	GUICtrlCreateLabel($LngTitle, 0, 0, 210, 63, 0x01 + 0x0200)
	GUICtrlSetFont(-1, 14, 600, -1, $font)
	GUICtrlSetColor(-1, 0x3a6a7e)
	GUICtrlSetBkColor(-1, 0xF1F1EF)
	GUICtrlCreateLabel("-", 2, 64, 208, 1, 0x10)
	
	GUISetFont(9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer & ' 0.3 17.07.2012', 15, 100, 210, 17)
	GUICtrlCreateLabel($LngSite & ':', 15, 115, 40, 17)
	$url = GUICtrlCreateLabel('http://azjio.ucoz.ru', 52, 115, 170, 17)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney:', 15, 130, 85, 17)
	$WbMn = GUICtrlCreateLabel('R939163939152', 90, 130, 125, 17)
	GUICtrlSetColor(-1, 0x3a6a7e)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel('Copyright AZJIO © 2010', 15, 145, 210, 17)
	GUISetState(@SW_SHOW, $Gui1)

	While 1
		Switch GUIGetMsg()
			Case $url
				ShellExecute('http://azjio.ucoz.ru')
			Case $WbMn
				ClipPut('R939163939152')
			Case -3
				GUISetState(@SW_ENABLE, $Gui)
				GUIDelete($Gui1)
				ExitLoop
		EndSwitch
	WEnd
EndFunc