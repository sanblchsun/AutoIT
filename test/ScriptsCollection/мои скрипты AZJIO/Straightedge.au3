#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=Straightedge.exe
#AutoIt3Wrapper_Icon=Straightedge.ico
#AutoIt3Wrapper_Compression=4
; #AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=Straightedge.exe
#AutoIt3Wrapper_Res_Fileversion=0.3.0.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Field=Version|0.3
#AutoIt3Wrapper_Res_Field=Build|2012.07.11
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/SOI
; #Obfuscator_Parameters=/StripOnly
; #Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
; #AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 11.07.2012 AutoIt3_v3.3.6.1
#NoTrayIcon
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <WINAPI.au3>
#include <Misc.au3>
Opt("GUIResizeMode", 802)
Opt("GUIOnEventMode", 1)

; En
$LngTitle = 'Straightedge'
$LngAbout = 'About'
$LngVer = 'Version'
$LngSite = 'Site'
$LngCopy = 'Copy'
$LngOpt = 'Settings'
$Lng90 = 'Rotate 90 (1)'
$LngMrr = 'Flip (2)'
$Lng000 = 'Set the start to the edges of the screen (0)'
$LngMin = 'Minimize (4)'
$LngExit = 'Exit'
$LngTnsp = 'Transparency (- or +)'
$LngClS = 'Straightedge color'
$LngClF = 'Font color'
$LngOSc = 'Opaque scale'
$LngSwCr = 'Show cursor position'
$LngSpc = '(Space - switch)'

; Ru
; если русская локализация, то русский язык
If @OSLang = 0419 Then
	$LngTitle = 'Линейка'
	$LngAbout = 'О программе'
	$LngVer = 'Версия'
	$LngSite = 'Сайт'
	$LngCopy = 'Копировать'
	$LngOpt = 'Настройки'
	$Lng90 = 'Повернуть на 90 (1)'
	$LngMrr = 'Отразить (2)'
	$Lng000 = 'Установить начало к краям экрана (0)'
	$LngMin = 'Свернуть (4)'
	$LngExit = 'Выход'
	$LngTnsp = 'Прозрачность (- или +)'
	$LngClS = 'Цвет линейки'
	$LngClF = 'Цвет шрифта'
	$LngOSc = 'Непрозрачная шкала'
	$LngSwCr = 'Показывать координаты курсора'
	$LngSpc = '(Пробел - переключить)'
EndIf

Global $TrgGui = 0, $Tmp = 0, $Dw = @DesktopWidth, $Dh = @DesktopHeight, $btnExit, $btnMove, $Gui, $Gui1, $G = 0, $ZV = 2, $ZH = 0, $BkC = 0x0, $Tnsp = 184, $CRn = 0xffffff, $ini = @ScriptDir & '\Straightedge.ini', $btnBkC, $btnCRn, $InpTnsp, $TrnScale, $chTrnScl, $TnspScale = 0x95B062, $Coor = 1, $Sleep = 1000, $chCoor
Global $aSG[41][5] = [ _
		[0, 0, 0, 0, 'TrGui'], _
		[0, 0, 0, 0, 'Gui x'], _
		[0, 0, 0, 0, 'Gui y'], _
		[201, 201, 41, 41, 'Gui w'], _
		[41, 41, 201, 201, 'Gui h'], _
		[0, 0, 0, 0, 'L PrDg x'], _
		[0, 0, 0, 0, 'L PrDg y'], _
		[181, 181, 41, 41, 'L PrDg w'], _
		[41, 41, 181, 181, 'L PrDg h'], _
		[183, 183, 0, 25, '<> x'], _
		[0, 25, 183, 183, '<> y'], _
		[0, 0, 25, 0, 'Gr L x'], _
		[25, 0, 0, 0, 'Gr L y'], _
		[$Dw, $Dw, 16, 16, 'Gr L w'], _
		[16, 16, $Dh, $Dh, 'Gr L h'], _
		[$Dw, $Dw, $Dh, $Dh, 'For to'], _
		['$i', '$i', 21, 16, 'M40 x'], _
		[21, 16, '$i', '$i', 'M40 y'], _
		[1, 1, 4, 4, 'M40 w'], _
		[4, 4, 1, 1, 'M40 h'], _
		['$i', '$i', 25, 0, 'M40-B x'], _
		[25, 0, '$i', '$i', 'M40-B y'], _
		[1, 1, 16, 16, 'M40-B w'], _
		[16, 16, 1, 1, 'M40-B h'], _
		['$i-7', '$i-7', 2, 21, 'Num x'], _
		[5, 21, '$i-7', '$i-7', 'Num y'], _
		[Default, Default, 19, Default, 'Num w'], _
		[15, 15, 15, 15, 'Num h'], _
		['$i', '$i', 25, 0, 'M20 x'], _
		[25, 0, '$i', '$i', 'M20 y'], _
		[1, 1, 16, 16, 'M20 w'], _
		[16, 16, 1, 1, 'M20 h'], _
		['$i', '$i', 25, 3, 'M10 x'], _
		[25, 3, '$i', '$i', 'M10 y'], _
		[1, 1, 13, 13, 'M10 w'], _
		[13, 13, 1, 1, 'M10 h'], _
		['$i', '$i', 25, 6, 'Else x'], _
		[25, 6, '$i', '$i', 'Else y'], _
		[1, 1, 10, 10, 'Else w'], _
		[10, 10, 1, 1, 'Else h'], _
		[0, 0, 0, 0, '_Coor']]

If Not FileExists($ini) And DriveStatus(StringLeft(@ScriptDir, 1)) <> 'NOTREADY' Then
	$file = FileOpen($ini, 2)
	FileWrite($file, '[Set]' & @CRLF & _
			'XV=-1' & @CRLF & _
			'YV=-1' & @CRLF & _
			'XH=-1' & @CRLF & _
			'YH=-1' & @CRLF & _
			'LongV=201' & @CRLF & _
			'LongH=201' & @CRLF & _
			'Transparency=175' & @CRLF & _
			'BkColor=0' & @CRLF & _
			'FontColor=16442136' & @CRLF & _
			'TrnScale=1' & @CRLF & _
			'Coor=0' & @CRLF & _
			'VorH=0')
	FileClose($file)
EndIf

$aSG[1][0] = Number(IniRead($ini, 'Set', 'XH', -1))
$aSG[1][1] = $aSG[1][0]
$aSG[2][0] = Number(IniRead($ini, 'Set', 'YH', -1))
$aSG[2][1] = $aSG[2][0]
$aSG[1][2] = Number(IniRead($ini, 'Set', 'XV', -1))
$aSG[1][3] = $aSG[1][2]
$aSG[2][2] = Number(IniRead($ini, 'Set', 'YV', -1))
$aSG[2][3] = $aSG[2][2]

$aSG[3][0] = Number(IniRead($ini, 'Set', 'LongH', '201'))
$aSG[3][1] = $aSG[3][0]
$aSG[4][2] = Number(IniRead($ini, 'Set', 'LongV', '201'))
$aSG[4][3] = $aSG[4][2]

$Tnsp = Number(IniRead($ini, 'Set', 'Transparency', 184))
$BkC = Number(IniRead($ini, 'Set', 'BkColor', 0x0))
$CRn = Number(IniRead($ini, 'Set', 'FontColor', 0xffffff))
$G = Number(IniRead($ini, 'Set', 'VorH', 0))

$TrnScale = Number(IniRead($ini, 'Set', 'TrnScale', 0))
If $TrnScale <> 0 Then $TnspScale = $CRn

$Coor = Number(IniRead($ini, 'Set', 'Coor', 0))
If $Coor Then $Sleep = 10

If $BkC = 0x95B062 Or $BkC = Dec('95B062') Then $BkC = 0x96B163
If $CRn = 0x95B062 Or $CRn = Dec('95B062') Then $CRn = 0x96B163

_Gui()
GUIRegisterMsg(0x0232, "WM_EXITSIZEMOVE")

While 1
	Sleep(10)
	If $Coor Then
		$Mpos = MouseGetPos()
		ToolTip('x=' & $Mpos[0] - $aSG[1][1] & @CRLF & 'y=' & $Mpos[1] - $aSG[2][2])
	EndIf
	If $TrgGui Then
		$TrgGui = 0
		_Gui()
	EndIf
WEnd

Func _Gui()
	Local $i, $AccelKeys, $contextmenu, $dmy[14], $task
	If $G = 2 Or $G = 3 Then
		$ZV = $G
		$aSG[10][$G] = $aSG[4][2] - 18
		$aSG[8][$G] = $aSG[4][2] - 21
	Else
		$ZH = $G
		$aSG[9][$G] = $aSG[3][0] - 18
		$aSG[7][$G] = $aSG[3][0] - 21
	EndIf

	$Gui = GUICreate($LngTitle, $aSG[3][$G], $aSG[4][$G], $aSG[1][$G], $aSG[2][$G], $WS_POPUP + $WS_SYSMENU, $WS_EX_LAYERED)
	GUISetBkColor($BkC)
	_WinAPI_SetLayeredWindowAttributes($Gui, 0x95B062, $Tnsp)
	GUISetOnEvent($GUI_EVENT_PRIMARYDOWN, "_Move")
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
	If Not @Compiled Then GUISetIcon(@ScriptDir & '\Straightedge.ico')
	
	$dmy[1] = GUICtrlCreateDummy()
	GUICtrlSetOnEvent(-1, "_GuiSwitch2")
	$dmy[2] = GUICtrlCreateDummy()
	GUICtrlSetOnEvent(-1, "_GuiSwitch1")
	$dmy[3] = GUICtrlCreateDummy()
	GUICtrlSetOnEvent(-1, "_GuiUp")
	$dmy[4] = GUICtrlCreateDummy()
	GUICtrlSetOnEvent(-1, "_GuiDown")
	$dmy[5] = GUICtrlCreateDummy()
	GUICtrlSetOnEvent(-1, "_GuiLeft")
	$dmy[6] = GUICtrlCreateDummy()
	GUICtrlSetOnEvent(-1, "_GuiRight")
	$dmy[7] = GUICtrlCreateDummy()
	GUICtrlSetOnEvent(-1, "_000")
	$dmy[8] = GUICtrlCreateDummy()
	GUICtrlSetOnEvent(-1, "_Coor")
	$dmy[9] = GUICtrlCreateDummy()
	GUICtrlSetOnEvent(-1, "_TrnPls")
	$dmy[10] = GUICtrlCreateDummy()
	GUICtrlSetOnEvent(-1, "_TrnMns")
	$dmy[11] = GUICtrlCreateDummy()
	GUICtrlSetOnEvent(-1, "_CoorClip")
	$dmy[12] = GUICtrlCreateDummy()
	GUICtrlSetOnEvent(-1, "_CoorSizeClip")
	$dmy[13] = GUICtrlCreateDummy()
	GUICtrlSetOnEvent(-1, "_Minimize")
	
	$task = GUICtrlCreateLabel('', $aSG[5][$G], $aSG[6][$G], $aSG[7][$G], $aSG[8][$G], -1, $GUI_WS_EX_PARENTDRAG)
	GUICtrlSetResizing(-1, 2 + 4 + 32 + 64)
	GUICtrlSetBkColor(-1, -2)
	$contextmenu = GUICtrlCreateContextMenu($task)
	GUICtrlCreateMenuItem($LngOpt, $contextmenu)
	GUICtrlSetOnEvent(-1, "_Setting")
	GUICtrlCreateMenuItem($Lng90, $contextmenu)
	GUICtrlSetOnEvent(-1, "_GuiSwitch2")
	GUICtrlCreateMenuItem($LngMrr, $contextmenu)
	GUICtrlSetOnEvent(-1, "_GuiSwitch1")
	GUICtrlCreateMenuItem($Lng000, $contextmenu)
	GUICtrlSetOnEvent(-1, "_000")
	GUICtrlCreateMenuItem($LngMin, $contextmenu)
	GUICtrlSetOnEvent(-1, "_Minimize")
	GUICtrlCreateMenuItem($LngAbout, $contextmenu)
	GUICtrlSetOnEvent(-1, "_About")
	GUICtrlCreateMenuItem($LngExit, $contextmenu)
	GUICtrlSetOnEvent(-1, "_Exit")
	
	$btnMove = GUICtrlCreateButton('<>', $aSG[9][$G], $aSG[10][$G], 18, 16)

	If $G < 2 Then
		GUICtrlSetCursor($btnMove, 13)
	Else
		GUICtrlSetCursor($btnMove, 11)
	EndIf

	GUICtrlCreateGraphic($aSG[11][$G], $aSG[12][$G], $aSG[13][$G], $aSG[14][$G])
	GUICtrlSetBkColor(-1, $TnspScale)
	For $i = 0 To $aSG[15][$G] Step 2
		If Mod($i, 40) = 0 Then
			GUICtrlCreateGraphic(Execute($aSG[16][$G]), Execute($aSG[17][$G]), $aSG[18][$G], $aSG[19][$G])
			GUICtrlSetBkColor(-1, $CRn)
			GUICtrlCreateGraphic(Execute($aSG[20][$G]), Execute($aSG[21][$G]), $aSG[22][$G], $aSG[23][$G])
			GUICtrlSetBkColor(-1, $BkC)

			If $i <> 0 Then
				GUICtrlCreateLabel($i, Execute($aSG[24][$G]), Execute($aSG[25][$G]), $aSG[26][$G], $aSG[27][$G])
				GUICtrlSetBkColor(-1, -2)
				GUICtrlSetColor(-1, $CRn)
			EndIf
		ElseIf Mod($i, 20) = 0 Then
			GUICtrlCreateGraphic(Execute($aSG[28][$G]), Execute($aSG[29][$G]), $aSG[30][$G], $aSG[31][$G])
			GUICtrlSetBkColor(-1, $BkC)
		ElseIf Mod($i, 10) = 0 Then
			GUICtrlCreateGraphic(Execute($aSG[32][$G]), Execute($aSG[33][$G]), $aSG[34][$G], $aSG[35][$G])
			GUICtrlSetBkColor(-1, $BkC)
		Else
			GUICtrlCreateGraphic(Execute($aSG[36][$G]), Execute($aSG[37][$G]), $aSG[38][$G], $aSG[39][$G])
			GUICtrlSetBkColor(-1, $BkC)
		EndIf
	Next
	GUISetState()
	Dim $AccelKeys[13][2] = [["1", $dmy[1]],["2", $dmy[2]],["{Up}", $dmy[3]],["{Down}", $dmy[4]],["{Left}", $dmy[5]],["{Right}", $dmy[6]],["0", $dmy[7]],["{Space}", $dmy[8]],["=", $dmy[9]],["-", $dmy[10]],["7", $dmy[11]],["8", $dmy[12]],["4", $dmy[13]]]
	GUISetAccelerators($AccelKeys)
EndFunc

Func _Minimize()
	If Not BitAND(WinGetState($Gui), 16) Then WinSetState($Gui, "", @SW_MINIMIZE)
EndFunc

Func _CoorClip()
	$aSG[40][0] = MouseGetPos(0) - $aSG[1][1]
	$aSG[40][1] = MouseGetPos(1) - $aSG[2][2]
	ClipPut($aSG[40][0] & ', ' & $aSG[40][1])
EndFunc

Func _CoorSizeClip()
	$aSG[40][2] = MouseGetPos(0) - $aSG[1][1] - $aSG[40][0]
	$aSG[40][3] = MouseGetPos(1) - $aSG[2][2] - $aSG[40][1]
	ClipPut($aSG[40][0] & ', ' & $aSG[40][1] & ', ' & $aSG[40][2] & ', ' & $aSG[40][3])
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

Func _Setting()
	$GP = _ChildCoor($Gui, 200, 210)
	GUIRegisterMsg(0x0232, "")
	GUISetState(@SW_DISABLE, $Gui)
	$Gui1 = GUICreate($LngOpt, $GP[2], $GP[3], $GP[0], $GP[1], BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $Gui) ; WS_CAPTION+WS_SYSMENU
	If Not @Compiled Then GUISetIcon(@ScriptDir & '\Straightedge.ico')
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit1")

	GUICtrlCreateLabel($LngTnsp, 10, 12, 120, 17)
	$InpTnsp = GUICtrlCreateInput($Tnsp, 130, 10, 40, 22)

	GUICtrlCreateLabel($LngClS, 10, 42, 95, 17)
	$btnBkC = GUICtrlCreateButton("", 105, 40, 60, 22)
	GUICtrlSetBkColor(-1, $BkC)
	GUICtrlSetOnEvent(-1, "_BkC")

	GUICtrlCreateLabel($LngClF, 10, 72, 95, 17)
	$btnCRn = GUICtrlCreateButton("", 105, 70, 60, 22)
	GUICtrlSetBkColor(-1, $CRn)
	GUICtrlSetOnEvent(-1, "_CRn")

	$chTrnScl = GUICtrlCreateCheckbox($LngOSc, 10, 102, 145, 17)
	If $TrnScale <> 0 Then GUICtrlSetState(-1, 1)

	$chCoor = GUICtrlCreateCheckbox($LngSwCr, 10, 122, 195, 17)
	If $Coor <> 0 Then GUICtrlSetState(-1, 1)
	GUICtrlCreateLabel($LngSpc, 30, 139, 195, 17)

	$OK = GUICtrlCreateButton("OK", 70, $GP[3] - 48, 60, 30)
	GUICtrlSetOnEvent(-1, "_OK")
	
	GUISetState(@SW_SHOW, $Gui1)
EndFunc

Func _OK()
	$Tnsp = Number(GUICtrlRead($InpTnsp))
	If $Tnsp > 255 Or $Tnsp < 15 Then $Tnsp = 184
	
	If GUICtrlRead($chTrnScl) = 1 Then
		$TrnScale = 1
		$TnspScale = $CRn
	Else
		$TrnScale = 0
		$TnspScale = 0x95B062
	EndIf
	
	If GUICtrlRead($chCoor) = 1 Then
		$Coor = 1
		$Sleep = 10
	Else
		$Coor = 0
		$Sleep = 1000
		ToolTip('')
	EndIf
	
	_GuiSwitch1()
	_GuiSwitch1()
	_Exit1()
EndFunc

Func _Coor()
	If $Coor = 0 Then
		$Coor = 1
		$Sleep = 10
	Else
		$Coor = 0
		$Sleep = 1000
		ToolTip('')
	EndIf
EndFunc

Func _BkC()
	$Tmp = _ChooseColor(2, $BkC, 2, $Gui1)
	If $Tmp = -1 Then Return
	$BkC = $Tmp
	If $BkC = 0x95B062 Then $BkC = 0x96B163
	GUICtrlSetBkColor($btnBkC, $BkC)
	; GUISetBkColor($BkC, $Gui)
EndFunc

Func _CRn()
	$Tmp = _ChooseColor(2, $CRn, 2, $Gui1)
	If $Tmp = -1 Then Return
	$CRn = $Tmp
	If $CRn = 0x95B062 Then $CRn = 0x96B163
	GUICtrlSetBkColor($btnCRn, $CRn)
	; GUISetBkColor($CRn, $Gui)
EndFunc

Func _TrnMns()
	$Tnsp -= 10
	If $Tnsp < 15 Then $Tnsp = 15
	_WinAPI_SetLayeredWindowAttributes($Gui, 0x95B062, $Tnsp)
EndFunc
Func _TrnPls()
	$Tnsp += 10
	If $Tnsp > 255 Then $Tnsp = 255
	_WinAPI_SetLayeredWindowAttributes($Gui, 0x95B062, $Tnsp)
EndFunc

Func _Exit1()
	GUISetState(@SW_ENABLE, $Gui)
	GUIDelete($Gui1)
	GUIRegisterMsg(0x0232, "WM_EXITSIZEMOVE")
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
EndFunc

Func _GuiUp()
	$GP = WinGetPos($Gui)
	WinMove($Gui, '', Default, $GP[1] - 1)
EndFunc
Func _GuiDown()
	$GP = WinGetPos($Gui)
	WinMove($Gui, '', Default, $GP[1] + 1)
EndFunc
Func _GuiLeft()
	$GP = WinGetPos($Gui)
	WinMove($Gui, '', $GP[0] - 1, Default)
EndFunc
Func _GuiRight()
	$GP = WinGetPos($Gui)
	WinMove($Gui, '', $GP[0] + 1, Default)
EndFunc

Func _GuiSwitch1()
	GUIDelete($Gui)
	Switch $G
		Case 0
			$G = 1
		Case 1
			$G = 0
		Case 2
			$G = 3
		Case 3
			$G = 2
	EndSwitch
	$TrgGui = 1
EndFunc

Func _GuiSwitch2()
	GUIDelete($Gui)
	Switch $G
		Case 0, 1
			$G = $ZV
		Case 2, 3
			$G = $ZH
	EndSwitch
	$TrgGui = 1
EndFunc

Func _Exit()
	IniWrite($ini, 'Set', 'XH', $aSG[1][0])
	IniWrite($ini, 'Set', 'YH', $aSG[2][0])
	IniWrite($ini, 'Set', 'XV', $aSG[1][2])
	IniWrite($ini, 'Set', 'YV', $aSG[2][2])
	IniWrite($ini, 'Set', 'LongH', $aSG[3][0])
	IniWrite($ini, 'Set', 'LongV', $aSG[4][2])
	IniWrite($ini, 'Set', 'Transparency', $Tnsp)
	IniWrite($ini, 'Set', 'BkColor', $BkC)
	IniWrite($ini, 'Set', 'FontColor', $CRn)
	IniWrite($ini, 'Set', 'VorH', $G)
	IniWrite($ini, 'Set', 'TrnScale', $TrnScale)
	IniWrite($ini, 'Set', 'Coor', $Coor)
	Exit
EndFunc

Func WM_EXITSIZEMOVE()
	$Gpos = WinGetPos($Gui)
	If $G = 2 Or $G = 3 Then
		$aSG[1][2] = $Gpos[0]
		$aSG[1][3] = $Gpos[0]
		$aSG[2][2] = $Gpos[1]
		$aSG[2][3] = $Gpos[1]
	Else
		$aSG[1][0] = $Gpos[0]
		$aSG[1][1] = $Gpos[0]
		$aSG[2][0] = $Gpos[1]
		$aSG[2][1] = $Gpos[1]
	EndIf
EndFunc

Func _000()
	If $G = 2 Or $G = 3 Then
		WinMove($Gui, '', Default, 0)
	Else
		WinMove($Gui, '', 0, Default)
	EndIf
	$aSG[2][2] = 0
	$aSG[2][3] = 0
	$aSG[1][0] = 0
	$aSG[1][1] = 0
EndFunc

Func _Move()
	$aCur_Info = GUIGetCursorInfo($Gui)
	; MsgBox(0, 'Message', $aCur_Info[4] &@CRLF&$btnMove)
	; GUICtrlSetState($btnMove, $GUI_DEFBUTTON)
	If $aCur_Info[4] = $btnMove Then
		; If Not $Coor Then GUISetStyle($WS_POPUP + $WS_SYSMENU, $WS_EX_LAYERED + $WS_EX_COMPOSITED)
		$aID_Pos = ControlGetPos($Gui, '', $btnMove)
		If $G = 2 Or $G = 3 Then
			; высчитываем разницу координат
			$dX = $aID_Pos[1] - $aCur_Info[1]
			While 1
				Sleep(10)
				$aCur_Info = GUIGetCursorInfo($Gui) ; получаем новую инфу
				$aCur_Info[1] += $dX
				
				If $aCur_Info[1] <> $Tmp Then
					If $aCur_Info[1] > $Dh - 18 Then $aCur_Info[1] = $Dh - 18
					GUICtrlSetPos($btnMove, $aID_Pos[0], $aCur_Info[1]) ; устанавливаем новые координаты
					WinMove($Gui, '', Default, Default, Default, $aCur_Info[1] + 18)
					$Tmp = $aCur_Info[1]
				EndIf
				If Not $aCur_Info[2] Then
					$aSG[4][2] = $Tmp + 18
					$aSG[4][3] = $Tmp + 18
					ExitLoop ; выход если курсор отпущен
				EndIf
			WEnd
		Else
			; высчитываем разницу координат
			$dX = $aID_Pos[0] - $aCur_Info[0]
			While 1
				Sleep(10)
				$aCur_Info = GUIGetCursorInfo($Gui) ; получаем новую инфу
				$aCur_Info[0] += $dX
				
				If $aCur_Info[0] <> $Tmp Then
					If $aCur_Info[0] > $Dw - 18 Then $aCur_Info[0] = $Dw - 18
					GUICtrlSetPos($btnMove, $aCur_Info[0], $aID_Pos[1]) ; устанавливаем новые координаты
					WinMove($Gui, '', Default, Default, $aCur_Info[0] + 18, Default)
					$Tmp = $aCur_Info[0]
				EndIf
				If Not $aCur_Info[2] Then
					$aSG[3][0] = $Tmp + 18
					$aSG[3][1] = $Tmp + 18
					ExitLoop ; выход если курсор отпущен
				EndIf
			WEnd
		EndIf
		; If Not $Coor Then GUISetStyle($WS_POPUP + $WS_SYSMENU, $WS_EX_LAYERED)
	EndIf
EndFunc

Func _About()
	$GP = _ChildCoor($Gui, 270, 180)
	GUIRegisterMsg(0x0232, "")
	GUISetState(@SW_DISABLE, $Gui)
	$font = "Arial"
	$Gui1 = GUICreate($LngAbout, $GP[2], $GP[3], $GP[0], $GP[1], BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $Gui)
	If Not @Compiled Then GUISetIcon(@ScriptDir & '\Straightedge.ico')
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit1")
	GUISetBkColor(0xE1E3E7)
	GUICtrlCreateLabel($LngTitle, 0, 0, 270, 63, 0x01 + 0x0200)
	GUICtrlSetFont(-1, 14, 600, -1, $font)
	GUICtrlSetColor(-1, 0x3a6a7e)
	GUICtrlSetBkColor(-1, 0xF1F1EF)
	GUICtrlCreateLabel("-", 2, 64, 268, 1, 0x10)
	
	GUISetFont(9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer & ' 0.2  11.07.2012', 55, 100, 210, 17)
	GUICtrlCreateLabel($LngSite & ':', 55, 115, 40, 17)
	$url = GUICtrlCreateLabel('http://azjio.ucoz.ru', 92, 115, 170, 17)
	GUICtrlSetOnEvent(-1, "_url")
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney:', 55, 130, 85, 17)
	$WbMn = GUICtrlCreateLabel('R939163939152', 130, 130, 125, 17)
	GUICtrlSetOnEvent(-1, "_WbMn")
	GUICtrlSetColor(-1, 0x3a6a7e)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel('Copyright AZJIO © 2009-2011', 55, 145, 210, 17)
	GUISetState(@SW_SHOW, $Gui1)
EndFunc

Func _url()
	ShellExecute('http://azjio.ucoz.ru')
EndFunc

Func _WbMn()
	ClipPut('R939163939152')
EndFunc