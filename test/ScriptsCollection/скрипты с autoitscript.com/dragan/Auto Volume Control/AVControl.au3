#AutoIt3Wrapper_UseX64=n ;if you use 64-bit Au3, enable this line
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>
#include <SoundQuery.au3>
#include <SliderConstants.au3>
#include <StaticConstants.au3>
#Include <Constants.au3>

Opt("TrayOnEventMode",1)
Opt("TrayMenuMode",1)
Opt("GUICloseOnESC",0)

OnAutoItExitRegister('QuitApplication')

Global $StartupFile = @StartupDir & "\AVControl.lnk"
Global $IniFile = @ScriptDir & '\Data\Config.ini'
If NOT FileExists(@ScriptDir & '\Data') then DirCreate(@ScriptDir & '\Data')

Global $old_Max_S, $old_Max_I, $old_Min_S, $old_Min_I, $old_Interval
Global $Pause = False

Global $VistaVol, $PluginVol
Global $VistaVolDll = @ScriptDir & '\Vista_Vol.dll'

Global $MaxVol, $MinVol, $GlobalChannel

_OSCheck()

If $VistaVol Then
	$PluginVol = PluginOpen($VistaVolDll)
EndIf

#AutoIt3Wrapper_Plugin_Funcs = _GetMasterVolumeScalar_Vista, _SetMasterVolumeScalar_Vista, _IsMute_Vista, _SetMute_Vista

Global $original_vol
If $VistaVol = 1 then
	$original_vol = Round(_GetMasterVolumeScalar_Vista())
Else
	$original_vol = Round(_SoundGetMasterVolume())
EndIf

$Form1 = GUICreate("Auto Vol. Control", 240, 305)
GUICtrlCreateLabel('Max vol:', 5, 13, 50, 17)
$HighVolInput = GUICtrlCreateInput(IniRead($IniFile, 'Options', 'MaxVol', '25'), 50, 10, 50, 21, $ES_NUMBER)
GUICtrlSetLimit(-1, 3, 1)
GUICtrlCreateUpdown(-1)
GUICtrlSetLimit(-1, 100, 0)
$HighVolSlider = GUICtrlCreateSlider(105, 10, 130, 21, $TBS_NOTICKS+$TBS_BOTH)
GUICtrlSetData(-1, IniRead($IniFile, 'Options', 'MaxVol', '25'))
GUICtrlSetLimit(-1, 100, 0)
GUICtrlCreateLabel('Min vol:', 5, 43, 50, 17)
$LowVolInput = GUICtrlCreateInput(IniRead($IniFile, 'Options', 'MinVol', '10'), 50, 40, 50, 21, $ES_NUMBER)
GUICtrlSetLimit(-1, 3, 1)
GUICtrlCreateUpdown(-1)
GUICtrlSetLimit(-1, 100, 0)
$LowVolSlider = GUICtrlCreateSlider(105, 40, 130, 21, $TBS_NOTICKS+$TBS_BOTH)
GUICtrlSetData(-1, IniRead($IniFile, 'Options', 'MinVol', '10'))
GUICtrlSetLimit(-1, 100, 0)
GUICtrlCreateLabel('Refresh interval [ms]:', 5, 73, 100, 17)
If IniRead($IniFile, 'Options', 'CheckInterval', '10') < 10 then IniWrite($IniFile, 'Options', 'CheckInterval', '10')
$IntervalInput = GUICtrlCreateInput(IniRead($IniFile, 'Options', 'CheckInterval', '25'), 110, 70, 50, 21)
GUICtrlSetLimit(-1, 5, 1)
GUICtrlCreateUpdown(-1)
GUICtrlSetLimit(-1, 10000, 0)
$PauseButton = GUICtrlCreateButton(" Pause", 165, 69, 70, 23)
GUICtrlSetImage($PauseButton, "shell32.dll", -234, 0)
GUICtrlCreateGroup('Sound level:', 5, 95, 230, 50)
$ProgressLevel = GUICtrlCreateProgress(15, 115, 210, 20)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup('Options', 5, 150, 230, 80)
$StartupCB = GUICtrlCreateCheckbox('Startup with windows', 15, 165, 117)
if FileExists($StartupFile) Then GUICtrlSetState(-1, $GUI_CHECKED)
$RestoreSoundCB = GUICtrlCreateCheckbox('Restore volume on program close', 15, 185, 177)
GUICtrlSetState(-1, IniRead($IniFile, 'Options', 'RestoreVolume', '1'))
$MinimizeCB = GUICtrlCreateCheckbox('Minimize on program close', 15, 205, 147)
GUICtrlSetState(-1, IniRead($IniFile, 'Options', 'MinimizeOnClose', '4'))
GUICtrlCreateGroup("", -99, -99, 1, 1)
$TrayMinimizeButton = GUICtrlCreateButton(' Minize to tray', 5, 250, 100, 25)
GUICtrlSetImage(-1, "shell32.dll", -248, 0)
$ExitButton = GUICtrlCreateButton(' Exit', 240-65, 250, 60, 25)
GUICtrlSetImage(-1, "shell32.dll", -132, 0)
GUICtrlCreateLabel('______________________________________' & @CRLF & 'v1.0.0.0 - by dragan', 0, 275, 240, 34, $SS_CENTER)
GUICtrlSetState(-1, $GUI_DISABLE)
GUISetState(@SW_SHOW)

if $CmdLine[0] <> 0 Then
	Local $WillCrateWin = True
	for $i = 1 to $CmdLine[0]
		if $CmdLine[$i] = "-a" then
			$WillCrateWin = False
			ExitLoop
		EndIf
	Next
	If $WillCrateWin = True then
		GUISetState(@SW_SHOW, $Form1)
	Else
		If IniRead($IniFile, 'Options', 'FirstTime', '1') = 1 then
			IniWrite($IniFile, 'Options', 'FirstTime', '0')
			TrayTip('Auto Volume Control', 'In order to change options click' & @CRLF & 'on this icon', 20, 1)
		EndIf
		GUISetState(@SW_MINIMIZE, $Form1)
		GUISetState(@SW_HIDE, $Form1)
	EndIf
EndIf

$ConfigTray	= TrayCreateItem("Restore Control window")
TrayItemSetState(-1, $TRAY_DEFAULT)
TrayItemSetOnEvent(-1, "RestoreWindow")
$AutoStartupTray = TrayCreateItem("Startup with windows")
TrayItemSetOnEvent(-1, "SetAtStartup")
if FileExists($StartupFile) Then TrayItemSetState($AutoStartupTray, $TRAY_CHECKED)
TrayCreateItem("")
$ExitTray = TrayCreateItem("Exit")
TrayItemSetOnEvent(-1, "QuitApplication2")
TraySetState()

TraySetToolTip('Auto Volume Control')

GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")

Local $mciInit = DllCall('winmm.dll', 'long', 'mciSendStringA', 'str', 'open new type waveaudio alias mywave', 'str', '', 'long', 64, 'long', 0)
If $mciInit[0] <> 0 Then _mciShowError($mciInit[0])


AdlibRegister('MonitorVolume', Number(GUICtrlRead($IntervalInput)))

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			If GUICtrlRead($MinimizeCB) = $GUI_CHECKED then
				If IniRead($IniFile, 'Options', 'FirstTime', '1') = 1 then
					IniWrite($IniFile, 'Options', 'FirstTime', '0')
					TrayTip('Auto Volume Control', 'In order to change options click' & @CRLF & 'on this icon', 20, 1)
				EndIf
				GUISetState(@SW_MINIMIZE, $Form1)
				GUISetState(@SW_HIDE, $Form1)
			Else
				_SaveData()
				Exit
			EndIf
	EndSwitch
	;----------------------------
	$MaxVol = Number(GUICtrlRead($HighVolInput))
	$MinVol = Number(GUICtrlRead($LowVolInput))
	;----------------------------
	If $old_Max_S <> GUICtrlRead($HighVolSlider) Then
		$old_Max_S = GUICtrlRead($HighVolSlider)
		GUICtrlSetData($HighVolInput, $old_Max_S)
		$old_Max_I = $old_Max_S
		If $MinVol > $MaxVol Then
			GUICtrlSetData($LowVolInput, $MaxVol)
			GUICtrlSetData($LowVolSlider, $MaxVol)
			$old_Min_S = $MaxVol
			$old_Min_I = $MaxVol
			$MinVol = $MaxVol
		EndIf
	EndIf
	If $old_Max_I <> $MaxVol Then
		$old_Max_I = $MaxVol
		GUICtrlSetData($HighVolSlider, $old_Max_I)
		$old_Max_S = $old_Max_I
		If $MinVol > $MaxVol Then
			GUICtrlSetData($LowVolInput, $MaxVol)
			GUICtrlSetData($LowVolSlider, $MaxVol)
			$old_Min_S = $MaxVol
			$old_Min_I = $MaxVol
			$MinVol = $MaxVol
		EndIf
	EndIf
	If $old_Min_S <> GUICtrlRead($LowVolSlider) Then
		$old_Min_S = GUICtrlRead($LowVolSlider)
		GUICtrlSetData($LowVolInput, $old_Min_S)
		$old_Min_I = $old_Min_S
		If $MinVol > $MaxVol Then
			GUICtrlSetData($HighVolInput, $MinVol)
			GUICtrlSetData($HighVolSlider, $MinVol)
			$old_Max_S = $MinVol
			$old_Max_I = $MinVol
			$MaxVol = $MinVol
		EndIf
	EndIf
	If $old_Min_I <> $MinVol Then
		$old_Min_I = $MinVol
		GUICtrlSetData($LowVolSlider, $old_Min_I)
		$old_Min_S = $old_Min_I
		If $MinVol > $MaxVol Then
			GUICtrlSetData($HighVolInput, $MinVol)
			GUICtrlSetData($HighVolSlider, $MinVol)
			$old_Max_S = $MinVol
			$old_Max_I = $MinVol
			$MaxVol = $MinVol
		EndIf
	EndIf
	If $old_Interval <> GUICtrlRead($IntervalInput) Then
		$old_Interval = GUICtrlRead($IntervalInput)
		If $old_Interval >= 10 then AdlibRegister('MonitorVolume', $old_Interval)
	EndIf
	;----- get sound level ------
	Local $mciLevel = DllCall('winmm.dll', 'long', 'mciSendStringA', 'str', 'status mywave level', 'str', '', 'long', 64, 'long', 0)
    If $mciLevel[0] <> 0 Then
		if $mciLevel[0] <> 0 then _mciShowError($mciLevel[0])
        Exit
    EndIf

	$GlobalChannel = Round((101 * $mciLevel[2]) / 100) - 1 ;/128
	GUICtrlSetData($ProgressLevel, $GlobalChannel)
	Sleep(10)
WEnd

Func MonitorVolume()
	If ($Pause = False) then
		$Pause = True

		If $GlobalChannel > $MaxVol then
			If $VistaVol = 1 then
				Local $get_vol = Round(_GetMasterVolumeScalar_Vista())
				Local $DecVol = $get_vol*$MaxVol/$GlobalChannel
				If $DecVol < 1 then $DecVol = 1
				_SetMasterVolumeScalar_Vista($DecVol)
			Else
				Local $get_vol = Round(_SoundGetMasterVolume())
				Local $DecVol = $get_vol*$MaxVol/$GlobalChannel
				If $DecVol < 1 then $DecVol = 1
				_SoundSetMasterVolume($DecVol)
			EndIf
		EndIf

		If ($GlobalChannel < $MinVol) Then
			If $VistaVol = 1 then
				Local $get_vol = Round(_GetMasterVolumeScalar_Vista())
				If $get_vol < 100 then
					If $get_vol < 25 Then
						Local $newVol = $get_vol+Sqrt(Number(GUICtrlRead($IntervalInput)))/3*3
						If $newVol > 100 then
							_SetMasterVolumeScalar_Vista(100)
						Else
							_SetMasterVolumeScalar_Vista($newVol)
						EndIf
					ElseIf $get_vol < 50 then
						Local $newVol = $get_vol+Sqrt(Number(GUICtrlRead($IntervalInput)))/3*2
						If $newVol > 100 then
							_SetMasterVolumeScalar_Vista(100)
						Else
							_SetMasterVolumeScalar_Vista($newVol)
						EndIf
					Else
						Local $newVol = $get_vol+Sqrt(Number(GUICtrlRead($IntervalInput)))/3*1
						If $newVol > 100 then
							_SetMasterVolumeScalar_Vista(100)
						Else
							_SetMasterVolumeScalar_Vista($newVol)
						EndIf
					EndIf
				EndIf
			Else
				Local $get_vol = Round(_SoundGetMasterVolume())
				If $get_vol < 100 then
					If $get_vol < 25 Then
						Local $newVol = $get_vol+Sqrt(Number(GUICtrlRead($IntervalInput)))/3*3
						If $newVol > 100 then
							_SoundSetMasterVolume(100)
						Else
							_SoundSetMasterVolume($newVol)
						EndIf
					ElseIf $get_vol < 50 then
						Local $newVol = $get_vol+Sqrt(Number(GUICtrlRead($IntervalInput)))/3*2
						If $newVol > 100 then
							_SoundSetMasterVolume(100)
						Else
							_SoundSetMasterVolume($newVol)
						EndIf
					Else
						Local $newVol = $get_vol+Sqrt(Number(GUICtrlRead($IntervalInput)))/3*1
						If $newVol > 100 then
							_SoundSetMasterVolume(100)
						Else
							_SoundSetMasterVolume($newVol)
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf

		$Pause = False
	EndIf
EndFunc

Func _mciShowError($mciError)
	Local $Result = DllCall('winmm.dll', 'long', 'mciGetErrorStringA', 'int', $mciError, 'str', '', 'int', 180)
	MsgBox (0, 'Error', 'MCI Error Number ' & $mcierror & ': ' & $Result[2])
	Exit
EndFunc

Func RestoreWindow()
	TrayItemSetState($ConfigTray, $TRAY_UNCHECKED)
	GUISetState(@SW_SHOW, $Form1)
	GUISetState(@SW_RESTORE, $Form1)
EndFunc

Func _OSCheck()
	If @OSType = 'WIN32_NT' Then
		Switch @OSVersion
			Case 'WIN_2000', 'WIN_XP', 'WIN_2003'
				$VistaVol = 0
				Return
			Case 'WIN_VISTA', 'WIN_2008', 'WIN_7'
				$VistaVol = 1
				Return
		EndSwitch
	EndIf
EndFunc

Func SetAtStartup()
	if FileExists($StartupFile) Then
		TrayItemSetState($AutoStartupTray, $TRAY_UNCHECKED)
		GUICtrlSetState($StartupCB, $GUI_UNCHECKED)
		FileDelete($StartupFile)
	Else
		FileCreateShortcut(@ScriptFullPath, $StartupFile, @ScriptDir, ' -a', 'Auto Volume Control link', @ScriptFullPath, '', 0)
		TrayItemSetState($ConfigTray, $TRAY_UNCHECKED)
		GUICtrlSetState($StartupCB, $GUI_CHECKED)
	EndIf
EndFunc

Func _SaveData()
	if (NOT FileExists($IniFile)) AND (NOT FileExists(@ScriptDir & '\Data\')) then DirCreate(@ScriptDir & '\Data\')
	IniWrite($IniFile, 'Options', 'MaxVol', GUICtrlRead($HighVolInput))
	IniWrite($IniFile, 'Options', 'MinVol', GUICtrlRead($LowVolInput))
	IniWrite($IniFile, 'Options', 'CheckInterval', GUICtrlRead($IntervalInput))
	IniWrite($IniFile, 'Options', 'MinimizeOnClose', GUICtrlRead($MinimizeCB))
EndFunc

Func QuitApplication()
	If IniRead($IniFile, 'Options', 'RestoreVolume', '1') = 1 then
		If $VistaVol = 1 then
			_SetMasterVolumeScalar_Vista($original_vol)
		Else
			_SoundSetMasterVolume($original_vol)
		EndIf
	EndIf
	PluginClose($VistaVolDll)
EndFunc

Func QuitApplication2()
	exit
EndFunc

Func WM_COMMAND($hWnd, $iMsg, $iwParam, $ilParam)
	Switch $iwParam
		Case $ExitButton
			_SaveData()
			Exit
		Case $RestoreSoundCB
			IniWrite($IniFile, 'Options', 'RestoreVolume', GUICtrlRead($RestoreSoundCB))
		Case $StartupCB
			If GUICtrlRead($StartupCB) = $GUI_CHECKED then
				FileCreateShortcut(@ScriptFullPath, $StartupFile, @ScriptDir, ' -a', 'Auto Volume Control link', @ScriptFullPath, '', 0)
				TrayItemSetState($ConfigTray, $TRAY_UNCHECKED)
			Else
				TrayItemSetState($AutoStartupTray, $TRAY_UNCHECKED)
				FileDelete($StartupFile)
			EndIf
		Case $TrayMinimizeButton
			If IniRead($IniFile, 'Options', 'FirstTime', '1') = 1 then
				IniWrite($IniFile, 'Options', 'FirstTime', '0')
				TrayTip('Auto Volume Control', 'In order to change options click' & @CRLF & 'on this icon', 20, 1)
			EndIf
			GUISetState(@SW_MINIMIZE, $Form1)
			GUISetState(@SW_HIDE, $Form1)
		Case $PauseButton
			If $Pause = False Then
				$Pause = True
				GUICtrlSetData($PauseButton, ' Resume')
				GUICtrlSetImage($PauseButton, "shell32.dll", -138, 0)
				If IniRead($IniFile, 'Options', 'RestoreVolume', '1') = 1 then
					If $VistaVol = 1 then
						_SetMasterVolumeScalar_Vista($original_vol)
					Else
						_SoundSetMasterVolume($original_vol)
					EndIf
				EndIf
			Else
				$Pause = False
				GUICtrlSetData($PauseButton, ' Pause')
				GUICtrlSetImage($PauseButton, "shell32.dll", -234, 0)
			EndIf
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc