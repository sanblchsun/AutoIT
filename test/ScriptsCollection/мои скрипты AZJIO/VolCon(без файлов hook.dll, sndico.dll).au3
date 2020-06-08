#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=VolCon.exe
#AutoIt3Wrapper_Icon=VolCon.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=VolCon.exe
#AutoIt3Wrapper_Res_Fileversion=0.5.5.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Field=Version|0.5.5
#AutoIt3Wrapper_Res_Field=Build|2012.10.21
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=CompanyName|AZJIO_Soft
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 23.09.2010 (AutoIt3_v3.2.12.1+)

#include <GUIConstantsEx.au3>
#include "SoundGetSetQuery.au3"
FileChangeDir(@ScriptDir)
FileInstall("sndico.dll", "*")
FileInstall("hook.dll", "*")
Opt("TrayMenuMode", 7)
Opt("TrayOnEventMode", 1)

$LngTitle = 'Volume Control'
; En
$LngAbout = 'About'
$LngVer = 'Version'
$LngSite = 'Site'
$LngCopy = 'Copy'
$LngQuit = 'Exit'
$LngSet = 'Setting'
$LngTrn = 'Transparent (0-255)'
$LngSV = 'Set the volume at startup (0-100)'
$LngAS = 'Auto start when Windows starts'
$LngAp = 'Apply'
$LngTh = 'Themes'
$LngGHK = 'HotKey'
$LngHK = 'Regulation'
$LngHK1 = '+MouseWheel'
$LngHKM = 'Mute Ctrl+'
$LngMxr = 'Standard Mixer'
$LngMs4 = 'One copy of the program is already running.'

; Ru
; если русская локализация, то русский язык
If @OSLang = 0419 Then
	$LngAbout = 'О программе'
	$LngVer = 'Версия'
	$LngSite = 'Сайт'
	$LngCopy = 'Копировать'
	$LngQuit = 'Выход'
	$LngSet = 'Настройки'
	$LngTrn = 'Прозрачность (0-255)'
	$LngSV = 'Установить громкость при старте (0-100)'
	$LngAS = 'Автостарт при загрузке Windows'
	$LngAp = 'Применить'
	$LngTh = 'Цветовая тема'
	$LngGHK = 'Горячие клавиши'
	$LngHK = 'Регулировка'
	$LngHK1 = '+Колёсико мыши'
	$LngHKM = 'Вкл/выкл Ctrl+'
	$LngMxr = 'Микшер Windows'
	$LngMs4 = 'Одна копия программы уже выполняется.'
EndIf

If WinExists('VolCon_AZJIO') Then
	Opt("TrayIconHide", 1)
	MsgBox(0, $LngTitle, $LngMs4)
	Exit
EndIf

Const $WH_MOUSE = 7
Const $WM_AUTOITMOUSEWHEELUP = 0x1400 + 0x0D30
Const $WM_AUTOITMOUSEWHEELDOWN = 0x1400 + 0x0D31


Global Const $WS_CAPTION = 0x00C00000
Global Const $WS_SYSMENU = 0x00080000

Global Const $WS_EX_TRANSPARENT = 0x00000020 ; прозрачность поддерживается
Global Const $WS_EX_TOPMOST = 0x00000008 ; поверх всех окон
Global Const $WS_POPUP = 0x80000000 ; без заголовка
Global Const $WS_EX_TOOLWINDOW = 0x00000080 ; не отображать в панели задач
; константы для перемещения индикатора
Global Const $HTCLIENT = 1
Global Const $HTCAPTION = 2

; Global Const $SS_LEFTNOWORDWRAP = 0xC
Global Const $SS_CENTERIMAGE = 0x0200
Global Const $SS_CENTER = 0x1
Global Const $SS_ETCHEDFRAME = 0x12

Global Const $CBS_DROPDOWNLIST = 0x3
Global Const $TRAY_EVENT_PRIMARYDOUBLE = -13

Global $hGui, $TrMouseWheel = 0, $NumICO = '', $TrGui = 0, $iniTrn, $iniX, $iniY, $iniAtSt, $iniDV, $iniColBk, $iniColVol, $a, $iniHK = '', $iniHKM = ''


Global $Ini = @ScriptDir & '\VolCon.ini'
If Not FileExists($Ini) Then
	$file = FileOpen($Ini, 2)
	FileWrite($file, _
			'[setting]' & @CRLF & _
			'transparent=190' & @CRLF & _
			'xpos=' & @DesktopWidth - 60 & @CRLF & _
			'ypos=' & @DesktopHeight - 165 & @CRLF & _
			'DefVol=0' & @CRLF & _
			'HotKey=A0' & @CRLF & _
			'HotKeyM=' & @CRLF & _
			'ColorBk=d0ff96' & @CRLF & _
			'ColorVol=00d20a')
	FileClose($file)
EndIf

$DWX = @DesktopWidth
$DWY = @DesktopHeight

$iniTrn = IniRead($Ini, 'setting', 'transparent', '190')
$iniX = IniRead($Ini, 'setting', 'xpos', $DWX - 60)
$iniY = IniRead($Ini, 'setting', 'ypos', $DWY - 165)
$iniDV = IniRead($Ini, 'setting', 'DefVol', '0')
$iniColBk = Dec(IniRead($Ini, 'setting', 'ColorBk', 'd0ff96'))
$iniColVol = Dec(IniRead($Ini, 'setting', 'ColorVol', '00d20a'))
$iniHK = IniRead($Ini, 'setting', 'HotKey', 'A0')
$iniHKM = IniRead($Ini, 'setting', 'HotKeyM', '')
If $iniHK = '' Then $iniHK = 'A0'
If $iniX > $DWX - 30 Then $iniX = $DWX - 60
If $iniY > $DWY - 135 Then $iniY = $DWY - 165
If $iniHKM <> '' Then HotKeySet('^{' & $iniHKM & '}', "_MUTE")

If StringLeft($iniDV, 1) <> 0 Then _SoundSetMasterVolume(StringTrimLeft($iniDV, 1))

$hGui = GUICreate('VolCon_AZJIO', 30, 135, $iniX, $iniY, $WS_POPUP + $WS_EX_TRANSPARENT, $WS_EX_TOPMOST + $WS_EX_TOOLWINDOW)
TraySetIcon('stobject.dll', -3)
; If @compiled=0 Then TraySetIcon('stobject.dll', -3)
; скрипт назначения колёсику мыши горячей клавиши - http://www.autoitscript.com/forum/index.php?showtopic=27994&st=0&p=198681&#entry198681
; hook.dll - http://www.autoitscript.com/forum/index.php?showtopic=83645&st=0&p=598457&#entry598457
Global $DLLinst = DllCall("kernel32.dll", "hwnd", "LoadLibrary", "str", ".\hook.dll")
Global $mouseHOOKproc = DllCall("kernel32.dll", "hwnd", "GetProcAddress", "hwnd", $DLLinst[0], "str", "MouseProc")

Global $hhMouse = DllCall("user32.dll", "hwnd", "SetWindowsHookEx", "int", $WH_MOUSE, "hwnd", $mouseHOOKproc[0], "hwnd", $DLLinst[0], "int", 0)

DllCall("hook.dll", "int", "SetValuesMouse", "hwnd", $hGui, "hwnd", $hhMouse[0])

GUIRegisterMsg($WM_AUTOITMOUSEWHEELUP, "_MouseWheel")
GUIRegisterMsg($WM_AUTOITMOUSEWHEELDOWN, "_MouseWheel")
TraySetOnEvent($TRAY_EVENT_PRIMARYDOUBLE, "_MUTE")
GUIRegisterMsg(0x0003, "WM_MOVE")
$volcur = Int(_SoundGetMasterVolume())

; округление к кратным величинам
If $volcur > 20 Then
	$volcur -= Mod($volcur, 5)
	_SoundSetMasterVolume($volcur)
EndIf
If $volcur < 20 And $volcur > 5 Then
	$volcur -= Mod($volcur - 2, 3)
	_SoundSetMasterVolume($volcur)
EndIf

$vol = GUICtrlCreateLabel($volcur, 0, 0, 30, 27, BitOR($SS_CENTER, $SS_CENTERIMAGE), $GUI_WS_EX_PARENTDRAG)
GUICtrlSetFont(-1, 12, 400)
GUICtrlSetCursor(-1, 0)
GUICtrlCreateLabel('-', 2, 28, 27, 105, $SS_ETCHEDFRAME, $GUI_WS_EX_PARENTDRAG)
GUICtrlSetCursor(-1, 0)
$b = GUICtrlCreateGraphic(4, 30, 22, 101)
GUICtrlSetBkColor(-1, $iniColBk)
WinSetTrans($hGui, "", $iniTrn)
_SetVolumeGraphic($volcur)
_ico($volcur)
$delta = 5
Global $GuiPos = ''
If _SoundGetMasterMute() = 1 Then TraySetIcon('sndico.dll', 12)

$iSetting = TrayCreateItem($LngSet)
TrayItemSetOnEvent(-1, "_Setting")

$iMixer = TrayCreateItem($LngMxr)
TrayItemSetOnEvent(-1, "_Mixer")

$iAbout = TrayCreateItem($LngAbout)
TrayItemSetOnEvent(-1, "_about")

$iExit = TrayCreateItem($LngQuit)
TrayItemSetOnEvent(-1, "_Quit")

TraySetToolTip($LngTitle)

While 1
	Sleep(1000)
	If $TrMouseWheel Then
		$TrMouseWheel = 0
		Sleep(1500)
		If $TrMouseWheel = 0 Then
			If $DWX = @DesktopWidth And $DWY = @DesktopHeight Then
				$GuiPos = WinGetPos($hGui)
				$iniX = $GuiPos[0]
				$iniY = $GuiPos[1]
			EndIf
			GUISetState(@SW_HIDE)
		EndIf
	EndIf
WEnd

Func _MouseWheel($hWndGUI, $MsgID, $WParam, $LParam)
	If Not _IsPressed($iniHK) Or $TrGui = 1 Or _SoundGetMasterMute() = 1 Then Return
	$V = Int(_SoundGetMasterVolume())
	GUISetState(@SW_SHOWNA)
	$TrMouseWheel = 1
	Switch $MsgID
		Case $WM_AUTOITMOUSEWHEELUP
			If $delta = 0 Then
				Return
			ElseIf $V >= 20 Then
				$delta = 5
			ElseIf $V < 5 Then
				$delta = 1
			ElseIf $V < 20 Then
				$delta = 3
			EndIf
			If $V + $delta > 100 Then $delta = 100 - $V
			_SoundSetMasterVolume($V + $delta)
			_SetVolumeGraphic($V + $delta)
			GUICtrlSetData($vol, $V + $delta)
			_ico($V + $delta)
		Case $WM_AUTOITMOUSEWHEELDOWN
			If $V = 0 Then
				Return
			ElseIf $V > 20 Then
				$delta = 5
			ElseIf $V <= 5 Then
				$delta = 1
			ElseIf $V <= 20 Then
				$delta = 3
			EndIf
			; If $V-$delta < 0 Then $delta=$V+1
			_SoundSetMasterVolume($V - $delta)
			_SetVolumeGraphic($V - $delta)
			GUICtrlSetData($vol, $V - $delta)
			_ico($V - $delta)
	EndSwitch
	If $DWX = @DesktopWidth And $DWY = @DesktopHeight Then
		If $GuiPos <> '' Then
			$iniX = $GuiPos[0]
			$iniY = $GuiPos[1]
		EndIf
		WinMove($hGui, "", $iniX, $iniY)
	Else
		WinMove($hGui, "", @DesktopWidth - 60, @DesktopHeight - 165)
	EndIf
EndFunc

Func _IsPressed($sHexKey, $vDLL = 'user32.dll')
	Local $a_R = DllCall($vDLL, "short", "GetAsyncKeyState", "int", '0x' & $sHexKey)
	If @error Then Return SetError(@error, @extended, False)
	Return BitAND($a_R[0], 0x8000) <> 0
EndFunc

Func _SetVolumeGraphic($V)
	GUICtrlDelete($a)
	$a = GUICtrlCreateGraphic(4, 130 - $V, 22, $V)
	GUICtrlSetBkColor(-1, $iniColVol)
	GUICtrlSetGraphic($a, $GUI_GR_REFRESH)
EndFunc

Func _Quit()
	TraySetState(2)
	DllCall("user32.dll", "int", "UnhookWindowsHookEx", "hwnd", $hhMouse[0])
	DllCall("kernel32.dll", "int", "FreeLibrary", "hwnd", $DLLinst[0])
	If $GuiPos <> '' Then
		IniWrite($Ini, "setting", "xpos", $GuiPos[0])
		IniWrite($Ini, "setting", "ypos", $GuiPos[1])
	EndIf
	Exit
EndFunc

Func _ico($V, $param = 0)
	Local $tmp = $NumICO
	Switch $V
		Case 0 To 5
			$NumICO = 1
		Case 6 To 15
			$NumICO = 2
		Case 16 To 25
			$NumICO = 3
		Case 26 To 35
			$NumICO = 4
		Case 36 To 45
			$NumICO = 5
		Case 46 To 55
			$NumICO = 6
		Case 56 To 65
			$NumICO = 7
		Case 66 To 75
			$NumICO = 8
		Case 76 To 85
			$NumICO = 9
		Case 86 To 95
			$NumICO = 10
		Case 96 To 100
			$NumICO = 11
		Case Else
			$NumICO = 12
	EndSwitch
	If $NumICO <> $tmp Or $param Then _TrayIcon($NumICO)
EndFunc

Func _TrayIcon($NumICO)
	TraySetIcon('sndico.dll', $NumICO)
	; If @compiled=0 Then TraySetIcon('stobject.dll', -3)
EndFunc

Func WM_MOVE()
	If $DWX = @DesktopWidth And $DWY = @DesktopHeight Then
		$GuiPos = WinGetPos($hGui)
		$iniX = $GuiPos[0]
		$iniY = $GuiPos[1]
	EndIf
	$TrMouseWheel = 1
EndFunc

Func _Setting()
	Local  $apply, $iChAS, $iChDV, $iChHK1, $iChHKM, $iChTh, $iDefVolInp, $tmp, $gr3, $gr4, $hGui1, $HKInp, $HKMInp, $ThInp, $TrnInp
	$TrGui = 1
	TrayItemSetState($iSetting, 128)
	TrayItemSetState($iAbout, 128)
	TrayItemSetState($iExit, 128)

	GUISetState(@SW_DISABLE, $hGui)
	$hGui1 = GUICreate($LngTitle, 300, 230, @DesktopWidth - 370, @DesktopHeight - 305, BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $hGui)

	$TrnInp = GUICtrlCreateInput($iniTrn, 5, 10, 35, 21)
	GUICtrlCreateLabel($LngTrn, 45, 12, 160, 17, 0xC)

	$iDefVolInp = GUICtrlCreateInput(_SoundGetMasterVolume(), 5, 35, 35, 21)
	$iChDV = GUICtrlCreateCheckbox($LngSV, 45, 37, 250, 17)
	If StringLeft($iniDV, 1) <> 0 Then GUICtrlSetState($iChDV, 1)

	$iChAS = GUICtrlCreateCheckbox($LngAS, 5, 62, 200, 17)
	RegRead("HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run", "Volume_Control")
	If Not @error Then GUICtrlSetState($iChAS, 1)

	$iChTh = GUICtrlCreateCheckbox($LngTh, 5, 87, 105, 17)
	$ThInp = GUICtrlCreateCombo('', 110, 85, 90, 21, $CBS_DROPDOWNLIST)
	GUICtrlSetData(-1, 'Green|Red|Blue|Yellow', 'Green')
	Switch Hex($iniColVol, 6)
		Case '00d20a'
			GUICtrlSetData($ThInp, 'Green')
		Case 'd4451d'
			GUICtrlSetData($ThInp, 'Red')
		Case '01adcf'
			GUICtrlSetData($ThInp, 'Blue')
		Case 'e8db00'
			GUICtrlSetData($ThInp, 'Yellow')
	EndSwitch
	GUICtrlCreateGraphic(205, 85, 22, 11)
	GUICtrlSetBkColor(-1, $iniColBk)
	GUICtrlCreateGraphic(205, 96, 22, 11)
	GUICtrlSetBkColor(-1, $iniColVol)
	$gr3 = GUICtrlCreateGraphic(230, 85, 22, 11)
	GUICtrlSetBkColor(-1, $iniColBk)
	$gr4 = GUICtrlCreateGraphic(230, 96, 22, 11)
	GUICtrlSetBkColor(-1, $iniColVol)
	
	GUICtrlCreateGroup($LngGHK, 1, 112, 297, 73)

	$iChHK1 = GUICtrlCreateCheckbox($LngHK, 5, 132, 105, 17)
	Switch $iniHK
		Case 'A0'
			$tmp = 'Left SHIFT'
		Case 'A1'
			$tmp = 'Right SHIFT'
		Case '10'
			$tmp = 'SHIFT'
		Case 'A2'
			$tmp = 'Left Ctrl'
		Case 'A3'
			$tmp = 'Right Ctrl'
		Case '11'
			$tmp = 'Ctrl'
		Case '12'
			$tmp = 'Alt'
	EndSwitch
	$HKInp = GUICtrlCreateCombo('', 110, 130, 90, 21, $CBS_DROPDOWNLIST)
	GUICtrlSetData(-1, 'Left SHIFT|Right SHIFT|SHIFT|Left Ctrl|Right Ctrl|Ctrl|Alt', $tmp)
	GUICtrlCreateLabel($LngHK1, 203, 132, 93, 17, 0xC)

	$iChHKM = GUICtrlCreateCheckbox($LngHKM, 5, 157, 105, 17)
	$HKMInp = GUICtrlCreateCombo('', 110, 155, 90, 21)
	GUICtrlSetData(-1, '|PAUSE|F12|9|0', $iniHKM)
	If Not StringInStr('|PAUSE|F12|9|0|', '|' & $iniHKM & '|') And $iniHKM <> '' Then
		GUICtrlSetData($HKMInp, $iniHKM, $iniHKM)
	EndIf
	If $iniHKM <> '' Then GUICtrlSetState($iChHKM, 1)

	$apply = GUICtrlCreateButton($LngAp, 210, 195, 85, 30)
	GUISetState(@SW_SHOW, $hGui1)
	
	While 1
		Switch GUIGetMsg()
			Case $HKMInp
				GUICtrlSetState($iChHKM, 1)
			Case $ThInp
				GUICtrlSetState($iChTh, 1)
				Switch GUICtrlRead($ThInp)
					Case 'Green'
						GUICtrlSetBkColor($gr3, Dec('d0ff96'))
						GUICtrlSetBkColor($gr4, Dec('00d20a'))
					Case 'Red'
						GUICtrlSetBkColor($gr3, Dec('fbb194'))
						GUICtrlSetBkColor($gr4, Dec('d4451d'))
					Case 'Blue'
						GUICtrlSetBkColor($gr3, Dec('a7f2fc'))
						GUICtrlSetBkColor($gr4, Dec('01adcf'))
					Case 'Yellow'
						GUICtrlSetBkColor($gr3, Dec('fbffab'))
						GUICtrlSetBkColor($gr4, Dec('e8db00'))
				EndSwitch
				GUICtrlSetGraphic($a, $GUI_GR_REFRESH)
			Case $HKInp
				GUICtrlSetState($iChHK1, 1)
			Case $apply
				$iniTrn = GUICtrlRead($TrnInp)
				IniWrite($Ini, "setting", "transparent", $iniTrn)
				WinSetTrans($hGui, "", $iniTrn)
				If GUICtrlRead($iChDV) = 1 Then
					$iniDV = '1' & GUICtrlRead($iDefVolInp)
					IniWrite($Ini, "setting", "DefVol", $iniDV)
				Else
					IniWrite($Ini, "setting", "DefVol", '0')
					$iniDV = 0
				EndIf
				If GUICtrlRead($iChAS) = 1 Then
					RegWrite("HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run", "Volume_Control", "REG_SZ", '"' & @AutoItExe & '"')
				Else
					RegDelete("HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run", "Volume_Control")
				EndIf
				If GUICtrlRead($iChTh) = 1 Then
					Switch GUICtrlRead($ThInp)
						Case 'Green'
							_Color('d0ff96', '00d20a')
						Case 'Red'
							_Color('fbb194', 'd4451d')
						Case 'Blue'
							_Color('a7f2fc', '01adcf')
						Case 'Yellow'
							_Color('fbffab', 'e8db00')
					EndSwitch
				EndIf
				If GUICtrlRead($iChHK1) = 1 Then
					Switch GUICtrlRead($HKInp)
						Case 'Left SHIFT'
							$iniHK = 'A0'
						Case 'Right SHIFT'
							$iniHK = 'A1'
						Case 'SHIFT'
							$iniHK = '10'
						Case 'Left Ctrl'
							$iniHK = 'A2'
						Case 'Right Ctrl'
							$iniHK = 'A3'
						Case 'Ctrl'
							$iniHK = '11'
						Case 'Alt'
							$iniHK = '12'
						Case Else
							$iniHK = 'A0'
					EndSwitch
					IniWrite($Ini, "setting", "HotKey", $iniHK)
				EndIf
				
				If GUICtrlRead($iChHKM) = 1 And GUICtrlRead($HKMInp) <> '' Then
					If $iniHKM <> '' Then HotKeySet('^{' & $iniHKM & '}')
					$iniHKM = GUICtrlRead($HKMInp)
					If $iniHKM <> '' Then
						HotKeySet('^{' & $iniHKM & '}', "_MUTE")
						IniWrite($Ini, "setting", "HotKeyM", $iniHKM)
					EndIf
				Else
					If $iniHKM <> '' Then HotKeySet('^{' & $iniHKM & '}')
					$iniHKM = ''
					IniWrite($Ini, "setting", "HotKeyM", '')
				EndIf
				
				ContinueCase
			Case -3
				GUIDelete($hGui1)
				TrayItemSetState($iSetting, 64)
				TrayItemSetState($iAbout, 64)
				TrayItemSetState($iExit, 64)
				GUISetState(@SW_ENABLE, $hGui)
				$TrGui = 0
				ExitLoop
		EndSwitch
	WEnd
EndFunc

Func _Color($1, $2)
	IniWrite($Ini, "setting", "ColorBk", $1)
	IniWrite($Ini, "setting", "ColorVol", $2)
	$iniColBk = Dec($1)
	$iniColVol = Dec($2)
	GUICtrlSetBkColor($b, $iniColBk)
	GUICtrlSetBkColor($a, $iniColVol)
EndFunc

Func _MUTE()
	$Mute = _SoundGetMasterMute()
	If $Mute = 0 Then
		_SoundSetMasterMute(1)
		TraySetIcon('sndico.dll', 12)
	EndIf
	If $Mute = 1 Then
		_SoundSetMasterMute(0)
		_ico(_SoundGetMasterVolume(), 1)
	EndIf
EndFunc

Func _Mixer()
	Run(@ComSpec & " /c rundll32.exe shell32.dll,Control_RunDLL mmsys.cpl,,0", '', @SW_HIDE)
EndFunc

Func _About()
	Local $msg
	$TrGui = 1
	TrayItemSetState($iSetting, 128)
	TrayItemSetState($iAbout, 128)
	TrayItemSetState($iExit, 128)

	GUISetState(@SW_DISABLE, $hGui)
	$font = "Arial"
	$hGui1 = GUICreate($LngAbout, 270, 180, @DesktopWidth - 350, @DesktopHeight - 260, BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $hGui)
	GUISetBkColor(0xf2d588)
	GUICtrlCreateLabel($LngTitle, 0, 0, 270, 63, 0x01 + 0x0200)
	GUICtrlSetFont(-1, 15, 600, -1, $font)
	GUICtrlSetColor(-1, 0xa13d00)
	GUICtrlSetBkColor(-1, 0xfdf3ac)
	GUICtrlCreateLabel("-", 2, 64, 268, 1, 0x10)
	
	GUISetFont(9, 600, -1, $font)

	GUICtrlCreateLabel($LngVer & ' 0.5  23.09.2010', 55, 100, 210, 17)
	GUICtrlCreateLabel($LngSite & ':', 55, 115, 40, 17)
	$url = GUICtrlCreateLabel('http://azjio.ucoz.ru', 92, 115, 170, 17)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney:', 55, 130, 85, 17)
	$WbMn = GUICtrlCreateLabel('R939163939152', 130, 130, 125, 17)
	GUICtrlSetColor(-1, 0xa21a10)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel('Copyright AZJIO © 2010', 55, 145, 210, 17)
	GUISetState(@SW_SHOW, $hGui1)
	
	While 1
		Switch GUIGetMsg()
			Case $url
				ShellExecute('http://azjio.ucoz.ru')
			Case $WbMn
				ClipPut('R939163939152')
			Case -3
				GUIDelete($hGui1)
				TrayItemSetState($iSetting, 64)
				TrayItemSetState($iAbout, 64)
				TrayItemSetState($iExit, 64)
				GUISetState(@SW_ENABLE, $hGui)
				$TrGui = 0
				ExitLoop
		EndSwitch
	WEnd
EndFunc