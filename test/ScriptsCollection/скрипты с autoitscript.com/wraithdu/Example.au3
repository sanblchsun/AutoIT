#AutoIt3Wrapper_Plugin_Funcs=_GetMasterVolume_Vista,_GetMasterVolumeScalar_Vista, _
_SetMasterVolume_Vista,_SetMasterVolumeScalar_Vista,_GetVolumeRange_Vista,_IsMute_Vista, _
_SetMute_Vista,_GetVolumeStepInfo_Vista,_VolumeStepUp_Vista,_VolumeStepDown_Vista

$hDLL = PluginOpen("vista_vol.dll")

; ## Get current volume levels
$vol = _GetMasterVolume_Vista()
ConsoleWrite("Get Vol Error: " & @error & @CRLF)
ConsoleWrite("Volume: " & $vol & " (decibels)" & @CRLF)

$vol = _GetMasterVolumeScalar_Vista()
ConsoleWrite("Get Vol Error: " & @error & @CRLF)
ConsoleWrite("Volume: " & $vol & " (scalar)" & @CRLF)

; ## Set new volume levels
ConsoleWrite("Set vol to -20db..." & @CRLF)
_SetMasterVolume_Vista(-20)
ConsoleWrite("Set Vol Error: " & @error & @CRLF)

$vol = _GetMasterVolume_Vista()
ConsoleWrite("Get Vol Error: " & @error & @CRLF)
ConsoleWrite("Volume: " & $vol & " (decibels)" & @CRLF)

ConsoleWrite("Set vol to scalar 30..." & @CRLF)
_SetMasterVolumeScalar_Vista(30)
ConsoleWrite("Set Vol Error: " & @error & @CRLF)

$vol = _GetMasterVolumeScalar_Vista()
ConsoleWrite("Get Vol Error: " & @error & @CRLF)
ConsoleWrite("Volume: " & $vol & " (scalar)" & @CRLF)

; ## Get volume range information
$range = DllStructCreate("float LevelMinDB;float LevelMaxDB;float VolumeIncrementDB")
ConsoleWrite("Get range info..." & @CRLF)
_GetVolumeRange_Vista(DllStructGetPtr($range))
ConsoleWrite("Get Range Error: " & @error & @CRLF)
ConsoleWrite("MinDB: " & DllStructGetData($range, "LevelMinDB") & @CRLF)
ConsoleWrite("MaxDB: " & DllStructGetData($range, "LevelMaxDB") & @CRLF)
ConsoleWrite("Increment: " & DllStructGetData($range, "VolumeIncrementDB") & @CRLF)

; ## Set mute states
ConsoleWrite("Set mute true..." & @CRLF)
_SetMute_Vista(True)
ConsoleWrite("Set Mute Error: " & @error & @CRLF)

$mute = _IsMute_Vista()
ConsoleWrite("Get Mute Error: " & @error & @CRLF)
ConsoleWrite("Muted: " & $mute & @CRLF)

Sleep(2000)

ConsoleWrite("Set mute false..." & @CRLF)
_SetMute_Vista(False)
ConsoleWrite("Set Mute Error: " & @error & @CRLF)

$mute = _IsMute_Vista()
ConsoleWrite("Get Mute Error: " & @error & @CRLF)
ConsoleWrite("Muted: " & $mute & @CRLF)

; ## Get volume step info
; ## Steps range from 0 to nStepCount - 1
$step = DllStructCreate("uint nStep;uint nStepCount")
ConsoleWrite("Get step info..." & @CRLF)
_GetVolumeStepInfo_Vista(DllStructGetPtr($step))
ConsoleWrite("Get Step Error: " & @error & @CRLF)
ConsoleWrite("Current step: " & DllStructGetData($step, "nStep") & @CRLF)
ConsoleWrite("Total steps: 0 to " & DllStructGetData($step, "nStepCount") - 1 & @CRLF)

ConsoleWrite("Increase 5 steps..." & @CRLF)
For $i = 1 To 5
    _VolumeStepUp_Vista()
Next
_GetVolumeStepInfo_Vista(DllStructGetPtr($step))
ConsoleWrite("Get Step Error: " & @error & @CRLF)
ConsoleWrite("Current step: " & DllStructGetData($step, "nStep") & @CRLF)

ConsoleWrite("Decrease 2 steps..." & @CRLF)
For $i = 1 To 2
    _VolumeStepDown_Vista()
Next
_GetVolumeStepInfo_Vista(DllStructGetPtr($step))
ConsoleWrite("Get Step Error: " & @error & @CRLF)
ConsoleWrite("Current step: " & DllStructGetData($step, "nStep") & @CRLF)

PluginClose($hDLL)