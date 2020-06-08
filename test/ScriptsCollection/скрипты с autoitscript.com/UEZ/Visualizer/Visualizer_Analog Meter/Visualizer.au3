#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Run_After=upx.exe --ultra-brute "%out%"
#AutoIt3Wrapper_Run_After=del /f /q "Visualizer_Obfuscated.au3"

#include <GUIConstantsEx.au3>
#include <GDIplus.au3>
#include <WindowsConstants.au3>
#include "Bass.au3"

Global Const $bass_dll = _BASS_STARTUP(@ScriptDir & "\BASS.dll")
Global Const $width = 200
Global Const $height = 230
Global $title = "GDI+ Visualization by UEZ"
$file = FileOpenDialog("Open...", "", "MP3 Files (*.mp3)");
If @error Then
    MsgBox(0, "Error", "Could not load audio file" & @CR & "Error = " & @error)
    Exit
EndIf
_BASS_Init($BASS_DEVICE_CPSPEAKERS)
$MusicHandle = _BASS_StreamCreateFile(False, $file, 0, 0, 0)
_BASS_ChannelPlay($MusicHandle, 1)
$song_length = _BASS_ChannelGetLength($MusicHandle, $BASS_POS_BYTE)

Opt("GUIOnEventMode", 1)
$hwnd = GUICreate($title, $width, $height, -1, -1, Default, $WS_EX_TOOLWINDOW)
GUISetOnEvent($GUI_EVENT_CLOSE, "Close")
GUISetState()

_GDIPlus_Startup()
$graphics = _GDIPlus_GraphicsCreateFromHWND($hwnd)
$bitmap = _GDIPlus_BitmapCreateFromGraphics($width, $height, $graphics)
$backbuffer = _GDIPlus_ImageGetGraphicsContext($bitmap)
_GDIPlus_GraphicsClear($backbuffer)
$pen1_size = 4
$pen1 = _GDIPlus_PenCreate(0, $pen1_size)
$pen2_size = 4
$pen2 = _GDIPlus_PenCreate(0, $pen2_size)

$c = 1
$equalizer_width = 30
$max_l = 0
$max_r = 0
$fall_speed = 5
$fire_up = 15
Do
    $levels = _BASS_ChannelGetLevel($MusicHandle)
    $LeftChLvl = Round(_HiWord($levels) / $height * 1.5, 0)
    $RightChLvl = Round(_LoWord($levels) / $height * 1.5, 0)
	If _BASS_ChannelGetPosition($MusicHandle, $BASS_POS_BYTE) >= $song_length Then
		$LeftChLvl = 0
		$RightChLvl = 0
	EndIf
    If $max_l <= $LeftChLvl Then ;fire up higest line
        $max_l = $LeftChLvl + $fire_up
		$fall_speed_l_threshold = 20
    Else
        If $fall_speed_l_threshold <= 0 Then ;increase fall speed of highest line faster until threshold is <= 0 (second fall part)
			If $max_l > $LeftChLvl + $pen2_size * 2 Then $max_l -= $fall_speed
		Else
			$fall_speed_l_threshold -= 1 ;increase fall speed of highest line by slower until threshold is <= 0 (first fall part)
			If $max_l > $LeftChLvl + $pen2_size * 2 Then $max_l -= $fall_speed / 3
		EndIf
    EndIf

    If $max_r <= $RightChLvl Then
        $max_r = $RightChLvl + $fire_up
		$fall_speed_r_threshold = 20
    Else
		If $fall_speed_r_threshold <= 0 Then
			If $max_r > $RightChLvl + $pen2_size * 2 Then $max_r -= $fall_speed
		Else
			$fall_speed_r_threshold -= 1
			If $max_r > $RightChLvl + $pen2_size * 2 Then $max_r -= $fall_speed / 3
		EndIf
	EndIf

    _GDIPlus_GraphicsClear($backbuffer, 0x9F000000)
    _GDIPlus_PenSetColor($pen2, 0xFF7F7F7F)
    For $l = -$pen1_size - 2 To $leftChLvl Step $pen1_size * 2
		$r = $l / ($height) * 256
		$g = 256 - $r
		$b = 0
        _GDIPlus_PenSetColor($pen1, "0xEF" & Hex($r, 2) & Hex($g, 2) & Hex($b, 2))
        _GDIPlus_GraphicsDrawLine($backbuffer, $width / 5, $height - $l, $width / 5 + $equalizer_width, $height - $l, $pen1)
    Next
    For $l = 0 To $RightChLvl
        $r = (-(Cos(1.7 * $l / 2^7) + 1) / 2) * 256
        $g = ((Cos(4 * $l / 2^8) + 1) / 2) * 256
        $b = 0
        _GDIPlus_PenSetColor($pen1, "0xEF" & Hex($r, 2) & Hex($g, 2) & Hex($b, 2))
        _GDIPlus_GraphicsDrawLine($backbuffer, 3 * $width / 5, $height - $l, 3 * $width / 5 + $equalizer_width, $height - $l, $pen1)
    Next
    _GDIPlus_GraphicsDrawLine($backbuffer, $width / 5, $height - $max_l, $width / 5 + $equalizer_width, $height - $max_l, $pen2)
    _GDIPlus_GraphicsDrawLine($backbuffer, 3 * $width / 5, $height - $max_r, 3 * $width / 5 + $equalizer_width, $height - $max_r, $pen2)
    _GDIPlus_GraphicsDrawImageRect($graphics, $bitmap, 0, 0, $width, $height)
	$c += 1
    Sleep(15)
Until False

Func close()
	_BASS_Stop()
    _BASS_Free()
	DllClose(@ScriptDir & "\BASS.dll")
    _GDIPlus_PenDispose($pen1)
    _GDIPlus_PenDispose($pen2)
    _GDIPlus_BitmapDispose($bitmap)
    _GDIPlus_GraphicsDispose($graphics)
    _GDIPlus_GraphicsDispose($backbuffer)
    _GDIPlus_Shutdown()
    Exit
EndFunc   ;==>close
