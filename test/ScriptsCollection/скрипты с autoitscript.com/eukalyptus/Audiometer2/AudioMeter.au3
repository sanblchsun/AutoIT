;thx to Authenticity for GDIp.au3
#AutoIt3Wrapper_UseX64=n
#include "Bass.au3"
#include "BassExt.au3"
#include <GDIPlus.au3>

Opt("GUIOnEventMode", 1)
Opt("MustDeclareVars", 1)

Global $sFile = FileOpenDialog("Open...", "", "playable formats (*.MP3;*.MP2;*.MP1;*.OGG;*.WAV;*.AIFF;*.AIF)")
If @error Or Not FileExists($sFile) Then Exit

Global $iWidth = 550
Global $iHeight = 400

Global $hGui, $hGraphics, $hGfxBuffer, $hBmpBuffer, $hBmpBk, $hBmpMeter, $hBmpLed, $hBmpPhase, $hBmpPhaseMeter, $hBmpWave, $hBrushFFT, $hPenPhase, $hPenWaveL, $hPenWaveR
Global $aFFT, $aPeak, $aPhaseCorr, $aPhase, $aWave
Global $iTimer
Global $hStream

$hGui = GUICreate("BASS_EXT AudioMeter", $iWidth, $iHeight)
GUISetOnEvent(-3, "_EXIT")
GUISetBkColor(0x000000)

_GDIPlus_Startup()
$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGui)
$hBmpBuffer = _GDIPlus_BitmapCreateFromGraphics($iWidth, $iHeight, $hGraphics)
$hGfxBuffer = _GDIPlus_ImageGetGraphicsContext($hBmpBuffer)
_GDIPlus_GraphicsSetSmoothingMode($hGfxBuffer, 2)

$hBmpMeter = _BMPCreateMeter(360, $hGraphics)
$hBmpLed = _BMPCreateLED($hGraphics, 14, 0xFF000000, 0xFFFF1111)

$hBmpPhaseMeter = _BMPCreatePhaseMeter(200, $hGraphics)
$hBmpPhase = _BMPCreatePhase(200, 190, $hGraphics)
$hPenPhase = _GDIPlus_PenCreate(0xFFFFAA00, 1)

$hBmpWave = _BMPCreateWave(200, 200, $hGraphics)
$hPenWaveL = _GDIPlus_PenCreate(0xFF00FF00, 1)
$hPenWaveR = _GDIPlus_PenCreate(0xFFFF0000, 1)

$hBrushFFT = _BrushCreateFFT(130, 220, 410, 170, $iWidth, $iHeight, $hGraphics)
$aFFT = _BASS_EXT_CreateFFT(82, 130, 220, 410, 170, 1, 70, True)

$hBmpBk = _BMPCreateBackGround($iWidth, $iHeight, $hGraphics)


_BASS_Startup(@ScriptDir & "\bass.dll")
___Debug(@error, "load bass.dll")

_BASS_EXT_Startup(@ScriptDir & "\bassExt.dll")
___Debug(@error, "load bassext.dll")

_BASS_Init(0, -1, 44100, 0, "")
___Debug(@error, "initialize bass")

_BASS_SetConfig($BASS_CONFIG_UPDATEPERIOD, 100)
___Debug(@error, "set update period")

_BASS_SetConfig($BASS_CONFIG_BUFFER, 250)
___Debug(@error, "set buffer size")

GUIRegisterMsg(0x000F, "WM_PAINT")
GUISetState()

$hStream = _BASS_StreamCreateFile(False, $sFile, 0, 0, 0)
___Debug(@error, "create stream from file: " & $sFile)

$aPeak = _BASS_EXT_ChannelSetMaxPeakDsp($hStream)
___Debug(@error, "set dsp callback to check for the highest peak")

_BASS_ChannelPlay($hStream, True)
___Debug(@error, "start stream")

$iTimer = TimerInit()
While _BASS_ChannelIsActive($hStream)
	If TimerDiff($iTimer) > 25 Then
		$iTimer = TimerInit()
		_GDIPlus_GraphicsDrawImage($hGfxBuffer, $hBmpBk, 0, 0)
		_DrawMeter()
		_DrawPhase()
		_DrawWave()
		_DrawFFT()
		_GDIPlus_GraphicsDrawImage($hGraphics, $hBmpBuffer, 0, 0)
		;ConsoleWrite(TimerDiff($iTimer) & @CRLF)
	EndIf
WEnd

_Exit()


Func _DrawMeter()
	Local $iLong, $nLevelL, $nLevelR, $iLevel
	Local Static $nPeakL, $nPeakR, $nPeakL_Hold, $nPeakR_Hold, $iPeakL_Cnt, $iPeakR_Cnt
	Local Static $nRmsL, $nRmsR, $nRmsL_Hold, $nRmsR_Hold, $iRmsL_Cnt, $iRmsR_Cnt, $iPeakLedL_Cnt = 60, $iPeakLedR_Cnt = 60
	If _BASS_ChannelIsActive($hStream) = $BASS_ACTIVE_PLAYING Then
		$iLong = _BASS_ChannelGetLevel($hStream)
		$nLevelL = _BASS_EXT_Level2dB(_LoWord($iLong) / 32768, 60)
		$nLevelR = _BASS_EXT_Level2dB(_HiWord($iLong) / 32768, 60)
		If $nLevelL > $nPeakL Then $nPeakL = $nLevelL
		If $nLevelL > $nPeakL_Hold Then
			$nPeakL_Hold = $nLevelL
			$iPeakL_Cnt = 0
		EndIf
		If $nLevelR > $nPeakR Then $nPeakR = $nLevelR
		If $nLevelR > $nPeakR_Hold Then
			$nPeakR_Hold = $nLevelR
			$iPeakR_Cnt = 0
		EndIf

		$iLong = _BASS_EXT_ChannelGetRMSLevel($hStream)
		$nLevelL = _BASS_EXT_Level2dB(_LoWord($iLong) / 32768, 60)
		$nLevelR = _BASS_EXT_Level2dB(_HiWord($iLong) / 32768, 60)
		If $nLevelL > $nRmsL Then $nRmsL = $nLevelL
		If $nLevelL > $nRmsL_Hold Then
			$nRmsL_Hold = $nLevelL
			$iRmsL_Cnt = 0
		EndIf
		If $nLevelR > $nRmsR Then $nRmsR = $nLevelR
		If $nLevelR > $nRmsR_Hold Then
			$nRmsR_Hold = $nLevelR
			$iRmsR_Cnt = 0
		EndIf

	EndIf

	$iLevel = Round(360 - $nPeakL * 360)
	$iLevel -= Mod($iLevel, 4)
	_GDIPlus_GraphicsDrawImageRectRect($hGfxBuffer, $hBmpMeter, 0, $iLevel, 15, 360 - $iLevel, 10, 30 + $iLevel, 15, 360 - $iLevel)
	$iLevel = Round(360 - $nPeakL_Hold * 360)
	$iLevel -= Mod($iLevel, 4)
	_GDIPlus_GraphicsDrawImageRectRect($hGfxBuffer, $hBmpMeter, 0, $iLevel, 15, 4, 10, 30 + $iLevel, 15, 4)

	$iLevel = Round(360 - $nPeakR * 360)
	$iLevel -= Mod($iLevel, 4)
	_GDIPlus_GraphicsDrawImageRectRect($hGfxBuffer, $hBmpMeter, 0, $iLevel, 15, 360 - $iLevel, 80, 30 + $iLevel, 15, 360 - $iLevel)
	$iLevel = Round(360 - $nPeakR_Hold * 360)
	$iLevel -= Mod($iLevel, 4)
	_GDIPlus_GraphicsDrawImageRectRect($hGfxBuffer, $hBmpMeter, 0, $iLevel, 15, 4, 80, 30 + $iLevel, 15, 4)


	$iLevel = Round(360 - $nRmsL * 360)
	$iLevel -= Mod($iLevel, 4)
	_GDIPlus_GraphicsDrawImageRectRect($hGfxBuffer, $hBmpMeter, 0, $iLevel, 20, 360 - $iLevel, 30, 30 + $iLevel, 20, 360 - $iLevel)
	$iLevel = Round(360 - $nRmsL_Hold * 360)
	$iLevel -= Mod($iLevel, 4)
	_GDIPlus_GraphicsDrawImageRectRect($hGfxBuffer, $hBmpMeter, 0, $iLevel, 20, 4, 30, 30 + $iLevel, 20, 4)

	$iLevel = Round(360 - $nRmsR * 360)
	$iLevel -= Mod($iLevel, 4)
	_GDIPlus_GraphicsDrawImageRectRect($hGfxBuffer, $hBmpMeter, 0, $iLevel, 20, 360 - $iLevel, 100, 30 + $iLevel, 20, 360 - $iLevel)
	$iLevel = Round(360 - $nRmsR_Hold * 360)
	$iLevel -= Mod($iLevel, 4)
	_GDIPlus_GraphicsDrawImageRectRect($hGfxBuffer, $hBmpMeter, 0, $iLevel, 20, 4, 100, 30 + $iLevel, 20, 4)


	$nLevelL = _BASS_EXT_ChannelGetMaxPeak($aPeak, 0, True)
	$nLevelR = _BASS_EXT_ChannelGetMaxPeak($aPeak, 1, True)
	If $nLevelL > 0.99 Then $iPeakLedL_Cnt = 0
	If $nLevelR > 0.99 Then $iPeakLedR_Cnt = 0

	If $iPeakLedL_Cnt < 60 Then _GDIPlus_GraphicsDrawImage($hGfxBuffer, $hBmpLed, 10, 10)
	If $iPeakLedR_Cnt < 60 Then _GDIPlus_GraphicsDrawImage($hGfxBuffer, $hBmpLed, 80, 10)

	$iPeakL_Cnt += 1
	If $iPeakL_Cnt > 80 Then $nPeakL_Hold -= 0.005
	$iPeakR_Cnt += 1
	If $iPeakR_Cnt > 80 Then $nPeakR_Hold -= 0.005
	$nPeakL -= 0.01
	$nPeakR -= 0.01

	$iRmsL_Cnt += 1
	If $iRmsL_Cnt > 60 Then $nRmsL_Hold -= 0.005
	$iRmsR_Cnt += 1
	If $iRmsR_Cnt > 60 Then $nRmsR_Hold -= 0.005
	$nRmsL -= 0.01
	$nRmsR -= 0.01

	$iPeakLedL_Cnt += 1
	$iPeakLedR_Cnt += 1
EndFunc   ;==>_DrawMeter


Func _DrawWave()
	$aWave = _BASS_EXT_ChannelGetWaveformEx($hStream, 256, 340, 70, 200, 60, 340, 150, 200, 60)
	If Not @error Then
		DllCall($ghGDIPDll, "int", "GdipDrawCurveI", "handle", $hGfxBuffer, "handle", $hPenWaveL, "ptr", $aWave[0], "int", $aWave[2])
		DllCall($ghGDIPDll, "int", "GdipDrawCurveI", "handle", $hGfxBuffer, "handle", $hPenWaveR, "ptr", $aWave[1], "int", $aWave[2])
	EndIf
EndFunc   ;==>_DrawWave


Func _DrawPhase()
	$aPhaseCorr = _BASS_EXT_ChannelGetPhaseData($hStream, 128)
	Local Static $nPhase
	$nPhase += ($aPhaseCorr[0][1] - $nPhase) / 12
	Local $iPhase = 100 * $nPhase + 100
	$iPhase -= Mod($iPhase, 4)
	_GDIPlus_GraphicsDrawImageRectRect($hGfxBuffer, $hBmpPhaseMeter, $iPhase, 0, 4, 10, $iPhase + 130, 200, 4, 10)

	$aPhase = _BASS_EXT_ChannelGetPhaseDataEx($hStream, 512, 230, 107, 100, 100)
	If Not @error Then DllCall($ghGDIPDll, "int", "GdipDrawCurveI", "handle", $hGfxBuffer, "handle", $hPenPhase, "ptr", $aPhase[0], "int", $aPhase[1])
EndFunc   ;==>_DrawPhase


Func _DrawFFT()
	Local $iTimer = TimerInit()
	_BASS_EXT_ChannelGetFFT($hStream, $aFFT, 6)
	If Not @error Then DllCall($ghGDIPDll, "int", "GdipFillPolygonI", "handle", $hGfxBuffer, "handle", $hBrushFFT, "ptr", $aFFT[0], "int", $aFFT[1], "int", "FillModeAlternate")
EndFunc   ;==>_DrawFFT





Func WM_PAINT($hWnd, $uMsgm, $wParam, $lParam)
	_GDIPlus_GraphicsDrawImage($hGraphics, $hBmpBuffer, 0, 0)
	Return 'GUI_RUNDEFMSG'
EndFunc   ;==>WM_PAINT

Func _BMPCreateBackGround($iW, $iH, $hGraphics)
	Local $hBitmap = _GDIPlus_BitmapCreateFromGraphics($iW, $iH, $hGraphics)
	Local $hContext = _GDIPlus_ImageGetGraphicsContext($hBitmap)
	_GDIPlus_GraphicsSetSmoothingMode($hContext, 2)
	_GDIPlus_GraphicsClear($hContext, 0xFF000000)
	Local $hBrushBK = _GDIPlus_BrushCreateSolid(0xEE000000)
	Local $hBrushTXT = _GDIPlus_BrushCreateSolid(0xFF99AAFF)
	Local $hPen = _GDIPlus_PenCreate(0xFF222222, 1)
	_GDIPlus_GraphicsDrawImage($hContext, $hBmpLed, 10, 10)
	_GDIPlus_GraphicsDrawImageRectRect($hContext, $hBmpMeter, 0, 0, 15, 360, 10, 30, 15, 360)
	_GDIPlus_GraphicsDrawImageRectRect($hContext, $hBmpMeter, 0, 0, 20, 360, 30, 30, 20, 360)
	_GDIPlus_GraphicsDrawImage($hContext, $hBmpLed, 80, 10)
	_GDIPlus_GraphicsDrawImageRectRect($hContext, $hBmpMeter, 0, 0, 15, 360, 80, 30, 15, 360)
	_GDIPlus_GraphicsDrawImageRectRect($hContext, $hBmpMeter, 0, 0, 20, 360, 100, 30, 20, 360)
	_GDIPlus_GraphicsDrawImageRectRect($hContext, $hBmpPhaseMeter, 0, 0, 200, 10, 130, 200, 200, 10)
	DllCall($ghGDIPDll, "int", "GdipFillPolygonI", "handle", $hContext, "handle", $hBrushFFT, "ptr", $aFFT[0], "int", $aFFT[1], "int", "FillModeAlternate")
	_GDIPlus_GraphicsFillRect($hContext, 0, 0, $iW, $iH, $hBrushBK)
	_GDIPlus_GraphicsDrawImage($hContext, $hBmpPhase, 130, 10)
	_GDIPlus_GraphicsDrawImage($hContext, $hBmpWave, 340, 10)
	_DrawText($hContext, "PEAK", 26, 13, 6, $hBrushTXT)
	_DrawText($hContext, "PEAK", 96, 13, 6, $hBrushTXT)
	Local $sString
	Local $nY
	For $i = 0 To 59 Step 3
		$nY = _BASS_EXT_Level2dB(_BASS_EXT_dB2Level(-$i), 60)
		$sString = "-" & $i
		If $i = 0 Then $sString = "0 dB"
		_DrawText($hContext, $sString, 65, 390 - (360 * $nY), 7, $hBrushTXT, True)
	Next
	_GDIPlus_GraphicsDrawRect($hContext, 129, 9, 201, 201, $hPen)
	_GDIPlus_GraphicsDrawRect($hContext, 129, 199, 201, 11, $hPen)
	_GDIPlus_GraphicsDrawRect($hContext, 339, 9, 201, 201, $hPen)
	_GDIPlus_GraphicsDrawRect($hContext, 129, 219, 411, 171, $hPen)
	_GDIPlus_GraphicsDrawRect($hContext, 9, 9, 111, 381, $hPen)
	_GDIPlus_GraphicsDrawRect($hContext, 9, 29, 16, 361, $hPen)
	_GDIPlus_GraphicsDrawRect($hContext, 29, 29, 21, 361, $hPen)
	_GDIPlus_GraphicsDrawRect($hContext, 79, 29, 16, 361, $hPen)
	_GDIPlus_GraphicsDrawRect($hContext, 99, 29, 21, 361, $hPen)

	_GDIPlus_PenDispose($hPen)
	_GDIPlus_BrushDispose($hBrushBK)
	_GDIPlus_BrushDispose($hBrushTXT)
	_GDIPlus_GraphicsDispose($hContext)
	Return $hBitmap
EndFunc   ;==>_BMPCreateBackGround

Func _BrushCreateFFT($iX, $iY, $iW, $iH, $iWidth, $iHeight, $hGraphics)
	Local $hBitmap = _GDIPlus_BitmapCreateFromGraphics($iWidth, $iHeight, $hGraphics)
	Local $hContext = _GDIPlus_ImageGetGraphicsContext($hBitmap)
	_GDIPlus_GraphicsClear($hContext, 0xFF000000)
	Local $hBrush[5]
	$hBrush[0] = _GDIPlus_BrushCreateSolid(0xFFFF0000)
	$hBrush[1] = _GDIPlus_LineBrushCreate(0, 0, 0, 20, 0xFFFF0000, 0xFFFFAA00, 1)
	$hBrush[2] = _GDIPlus_LineBrushCreate(0, 20, 0, 40, 0xFFFFAA00, 0xFF00AAFF, 1)
	$hBrush[3] = _GDIPlus_BrushCreateSolid(0xFF00AAFF)
	$hBrush[4] = _GDIPlus_LineBrushCreate(0, 0, 0, 4, 0x00000000, 0xAA000000, 0)
	_GDIPlus_GraphicsFillRect($hContext, $iX, $iY, $iW, 20, $hBrush[0])
	_GDIPlus_GraphicsFillRect($hContext, $iX, $iY + 20, $iW, 20, $hBrush[1])
	_GDIPlus_GraphicsFillRect($hContext, $iX, $iY + 40, $iW, 20, $hBrush[2])
	_GDIPlus_GraphicsFillRect($hContext, $iX, $iY + 60, $iW, $iH - 60, $hBrush[3])
	_GDIPlus_GraphicsFillRect($hContext, $iX, $iY, $iW, $iH, $hBrush[4])
	For $i = 0 To 4
		_GDIPlus_BrushDispose($hBrush[$i])
	Next
	_GDIPlus_GraphicsDispose($hContext)
	Local $aRet = DllCall($ghGDIPDll, "uint", "GdipCreateTexture", "hwnd", $hBitmap, "int", 0, "int*", 0)
	_GDIPlus_BitmapDispose($hBitmap)
	Return $aRet[3]
EndFunc   ;==>_BrushCreateFFT

Func _BMPCreateWave($iW, $iH, $hGraphics)
	Local $hBitmap = _GDIPlus_BitmapCreateFromGraphics($iW, $iH, $hGraphics)
	Local $hContext = _GDIPlus_ImageGetGraphicsContext($hBitmap)
	_GDIPlus_GraphicsClear($hContext, 0xFF000000)
	Local $hPenL = _GDIPlus_PenCreate(0xFF003300)
	Local $hPenR = _GDIPlus_PenCreate(0xFF330000)
	Local $hBrushL = _GDIPlus_BrushCreateSolid(0xFF00FF00)
	Local $hBrushR = _GDIPlus_BrushCreateSolid(0xFFFF0000)
	_GDIPlus_GraphicsDrawLine($hContext, 0, 60, $iW, 60, $hPenL)
	_GDIPlus_GraphicsDrawLine($hContext, 0, 140, $iW, 140, $hPenR)
	_DrawText($hContext, "left", 5, 62, 7, $hBrushL, False)
	_DrawText($hContext, "right", 5, 142, 7, $hBrushR, False)
	_GDIPlus_PenDispose($hPenL)
	_GDIPlus_PenDispose($hPenR)
	_GDIPlus_BrushDispose($hBrushL)
	_GDIPlus_BrushDispose($hBrushR)
	_GDIPlus_GraphicsDispose($hContext)
	Return $hBitmap
EndFunc   ;==>_BMPCreateWave

Func _BMPCreatePhaseMeter($iW, $hGraphics)
	Local $hBitmap = _GDIPlus_BitmapCreateFromGraphics($iW, 12, $hGraphics)
	Local $hContext = _GDIPlus_ImageGetGraphicsContext($hBitmap)
	_GDIPlus_GraphicsClear($hContext, 0xFF000000)
	Local $hBrush[5]
	$hBrush[0] = _GDIPlus_BrushCreateSolid(0xFFFF0000)
	$hBrush[1] = _GDIPlus_LineBrushCreate(80, 0, 100, 0, 0xFFFF0000, 0xFFFFFF00, 1)
	$hBrush[2] = _GDIPlus_LineBrushCreate(100, 0, 120, 0, 0xFFFFFF00, 0xFF00FF00, 1)
	$hBrush[3] = _GDIPlus_BrushCreateSolid(0xFF00FF00)
	$hBrush[4] = _GDIPlus_LineBrushCreate(0, 0, 4, 0, 0x00000000, 0xAA000000, 0)
	_GDIPlus_GraphicsFillRect($hContext, 0, 0, 80, 12, $hBrush[0])
	_GDIPlus_GraphicsFillRect($hContext, 80, 0, 20, 12, $hBrush[1])
	_GDIPlus_GraphicsFillRect($hContext, 100, 0, 20, 12, $hBrush[2])
	_GDIPlus_GraphicsFillRect($hContext, 120, 0, 100, 12, $hBrush[3])
	_GDIPlus_GraphicsFillRect($hContext, 0, 0, 200, 12, $hBrush[4])
	For $i = 0 To 4
		_GDIPlus_BrushDispose($hBrush[$i])
	Next
	_GDIPlus_GraphicsDispose($hContext)
	Return $hBitmap
EndFunc   ;==>_BMPCreatePhaseMeter

Func _BMPCreatePhase($iW, $iH, $hGraphics)
	Local $hBitmap = _GDIPlus_BitmapCreateFromGraphics($iW, $iH, $hGraphics)
	Local $hContext = _GDIPlus_ImageGetGraphicsContext($hBitmap)
	_GDIPlus_GraphicsClear($hContext, 0xFF000000)
	Local $hPen = _GDIPlus_PenCreate(0xFF332200)
	Local $hBrush = _GDIPlus_BrushCreateSolid(0xFFFFAA00)
	Local $nPi = ATan(1) * 4
	Local $nDegToRad = $nPi / 180
	Local $iLX, $iLY
	For $i = 0 To 135 Step 45
		$iLX = Round(Cos($i * $nDegToRad) * $iW * 0.35)
		$iLY = Round(Sin($i * $nDegToRad) * $iW * 0.35)
		_GDIPlus_GraphicsDrawLine($hContext, $iW / 2 - $iLX, $iH / 2 - $iLY, $iW / 2 + $iLX, $iH / 2 + $iLY, $hPen)
		Switch $i
			Case 45
				_DrawText($hContext, "L", $iW / 2 - $iLX * 1.2, $iH / 2 - $iLY * 1.3, 7, $hBrush, True)
			Case 90
				_DrawText($hContext, "M", $iW / 2 - $iLX * 1.2, $iH / 2 - $iLY * 1.27, 7, $hBrush, True)
			Case 135
				_DrawText($hContext, "R", $iW / 2 - $iLX * 1.2, $iH / 2 - $iLY * 1.3, 7, $hBrush, True)
		EndSwitch
	Next
	For $i = -1 To 1
		_DrawText($hContext, $i, 101 + 90 * $i, 178, 7, $hBrush, True)
	Next
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_BrushDispose($hBrush)
	_GDIPlus_GraphicsDispose($hContext)
	Return $hBitmap
EndFunc   ;==>_BMPCreatePhase

Func _BMPCreateLED($hGraphics, $iSize, $iOffColor, $iOnColor)
	Local $hBitmap = _GDIPlus_BitmapCreateFromGraphics($iSize, $iSize, $hGraphics)
	Local $hContext = _GDIPlus_ImageGetGraphicsContext($hBitmap)
	_GDIPlus_GraphicsSetSmoothingMode($hContext, 2)
	Local $hPen = _GDIPlus_PenCreate()
	Local $hPath = _GDIPlus_CreatePath()
	_GDIPlus_AddPathEllipse($hPath, 0, 0, $iSize, $iSize)
	Local $hBrushGrad = _GDIPlus_CreatePathGradientFromPath($hPath)
	_GDIPlus_SetLineGammaCorrection($hBrushGrad, True)
	_GDIPlus_SetPathGradientSurroundColorsWithCount($hBrushGrad, $iOffColor)
	_GDIPlus_SetPathGradientCenterColor($hBrushGrad, $iOnColor)
	_GDIPlus_FillPath($hContext, $hBrushGrad, $hPath)
	_GDIPlus_ClosePathFigure($hPath)
	_GDIPlus_GraphicsDrawEllipse($hContext, 0, 0, $iSize, $iSize, $hPen)
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_BrushDispose($hBrushGrad)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_GraphicsDispose($hContext)
	Return $hBitmap
EndFunc   ;==>_BMPCreateLED

Func _BMPCreateMeter($iH, $hGraphics)
	Local $hBitmap = _GDIPlus_BitmapCreateFromGraphics(30, $iH, $hGraphics)
	Local $hContext = _GDIPlus_ImageGetGraphicsContext($hBitmap)
	_GDIPlus_GraphicsClear($hContext, 0xFF000000)
	Local $hBrush[6], $iT = Ceiling($iH / 12)
	$hBrush[0] = _GDIPlus_BrushCreateSolid(0xFFFF0000)
	$hBrush[1] = _GDIPlus_LineBrushCreate(0, $iT, 0, $iT * 2, 0xFFFF0000, 0xFFFFFF00, 1)
	$hBrush[2] = _GDIPlus_LineBrushCreate(0, $iT * 2, 0, $iT * 3, 0xFFFFFF00, 0xFF00FF00, 1)
	$hBrush[3] = _GDIPlus_BrushCreateSolid(0xFF00FF00)
	$hBrush[4] = _GDIPlus_LineBrushCreate(0, 0, 0, 4, 0x00000000, 0xAA000000, 0)
	_GDIPlus_GraphicsFillRect($hContext, 0, 0, 30, $iT, $hBrush[0])
	_GDIPlus_GraphicsFillRect($hContext, 0, $iT, 30, $iT, $hBrush[1])
	_GDIPlus_GraphicsFillRect($hContext, 0, $iT * 2, 30, $iT, $hBrush[2])
	_GDIPlus_GraphicsFillRect($hContext, 0, $iT * 3, 30, $iT * 9, $hBrush[3])
	_GDIPlus_GraphicsFillRect($hContext, 0, 0, 30, $iT * 12, $hBrush[4])
	For $i = 0 To 4
		_GDIPlus_BrushDispose($hBrush[$i])
	Next
	_GDIPlus_GraphicsDispose($hContext)
	Return $hBitmap
EndFunc   ;==>_BMPCreateMeter

Func _DrawText($hGraphics, $sText, $iX, $iY, $iSize, $hBrush, $bCenter = False)
	Local $hFormat = _GDIPlus_StringFormatCreate()
	Local $hFamily = _GDIPlus_FontFamilyCreate("Arial")
	Local $hFont = _GDIPlus_FontCreate($hFamily, $iSize, 0)
	Local $tLayout = _GDIPlus_RectFCreate($iX, $iY, 0, 0)
	Local $aInfo = _GDIPlus_GraphicsMeasureString($hGraphics, $sText, $hFont, $tLayout, $hFormat)
	If $bCenter Then
		Local $iXPos = DllStructGetData($aInfo[0], 1)
		DllStructSetData($aInfo[0], 1, $iXPos - DllStructGetData($aInfo[0], 3) / 2)
	EndIf
	_GDIPlus_GraphicsDrawStringEx($hGraphics, $sText, $hFont, $aInfo[0], $hFormat, $hBrush)
	_GDIPlus_FontDispose($hFont)
	_GDIPlus_FontFamilyDispose($hFamily)
	_GDIPlus_StringFormatDispose($hFormat)
EndFunc   ;==>_DrawText

Func _Exit()
	_BASS_EXT_ChannelRemoveMaxPeakDsp($aPeak)
	___Debug(@error, "remove peak dsp")

	_BASS_ChannelStop($hStream)
	___Debug(@error, "stop stream")

	_BASS_StreamFree($hStream)
	___Debug(@error, "free stream")

	_BASS_Free()
	___Debug(@error, "free bass")

	_GDIPlus_BitmapDispose($hBmpMeter)
	_GDIPlus_BitmapDispose($hBmpLed)
	_GDIPlus_BitmapDispose($hBmpPhaseMeter)
	_GDIPlus_BitmapDispose($hBmpPhase)
	_GDIPlus_PenDispose($hPenPhase)
	_GDIPlus_BitmapDispose($hBmpWave)
	_GDIPlus_PenDispose($hPenWaveL)
	_GDIPlus_PenDispose($hPenWaveR)
	_GDIPlus_BrushDispose($hBrushFFT)
	_GDIPlus_BitmapDispose($hBmpBk)
	_GDIPlus_GraphicsDispose($hGfxBuffer)
	_GDIPlus_BitmapDispose($hBmpBuffer)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_Shutdown()
	Exit
EndFunc   ;==>_Exit

Func ___DeBug($iError, $sAction)
	Switch $iError
		Case -1
			ConsoleWrite(@CRLF & "-" & $sAction & @CRLF)
		Case -2
			ConsoleWrite(@CRLF & ">" & $sAction & @CRLF)
		Case 0
			ConsoleWrite(@CRLF & "+" & $sAction & " - OK" & @CRLF)
		Case Else
			ConsoleWrite(@CRLF & "!" & $sAction & " - FAILED, @error: " & $iError & @CRLF)
			_Exit()
	EndSwitch
EndFunc   ;==>___DeBug

Func _GDIPlus_LineBrushCreate($nX1, $nY1, $nX2, $nY2, $iARGBClr1, $iARGBClr2, $iWrapMode = 0)
	Local $tPointF1, $pPointF1
	Local $tPointF2, $pPointF2
	Local $aResult

	$tPointF1 = DllStructCreate("float;float")
	$pPointF1 = DllStructGetPtr($tPointF1)
	$tPointF2 = DllStructCreate("float;float")
	$pPointF2 = DllStructGetPtr($tPointF2)

	DllStructSetData($tPointF1, 1, $nX1)
	DllStructSetData($tPointF1, 2, $nY1)
	DllStructSetData($tPointF2, 1, $nX2)
	DllStructSetData($tPointF2, 2, $nY2)

	$aResult = DllCall($ghGDIPDll, "uint", "GdipCreateLineBrush", "ptr", $pPointF1, "ptr", $pPointF2, "uint", $iARGBClr1, "uint", $iARGBClr2, "int", $iWrapMode, "int*", 0)

	If @error Then Return SetError(@error, @extended, 0)
	;$GDIP_STATUS = $aResult[0]
	Return $aResult[6]
EndFunc   ;==>_GDIPlus_LineBrushCreate

Func _GDIPlus_CreatePath($brushMode = 0)
	Local $hPath
	$hPath = DllCall($ghGDIPDll, "int", "GdipCreatePath", "int", $brushMode, "handle*", 0)
	If @error Then Return SetError(1, @error, 0)
	Return SetError($hPath[0], 0, $hPath[2])
EndFunc   ;==>_GDIPlus_CreatePath

Func _GDIPlus_AddPathEllipse($hPath, $iX, $iY, $iWidth, $iHeight)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipAddPathEllipse", "handle", $hPath, "float", $iX, "float", $iY, "float", $iWidth, "float", $iHeight)
	If @error Then Return SetError(1, @error, 0)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_AddPathEllipse

Func _GDIPlus_CreatePathGradientFromPath($hPath)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipCreatePathGradientFromPath", "handle", $hPath, "int*", 0)
	If @error Then Return SetError(1, @error, 0)
	Return SetError($aResult[0], 0, $aResult[2])
EndFunc   ;==>_GDIPlus_CreatePathGradientFromPath

Func _GDIPlus_SetLineGammaCorrection($hBrush, $useGammaCorrection = True)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetLineGammaCorrection", "handle", $hBrush, "int", $useGammaCorrection)
	If @error Then Return SetError(1, @error, 0)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_SetLineGammaCorrection

Func _GDIPlus_SetPathGradientCenterColor($hBrush, $iARGB)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetPathGradientCenterColor", "handle", $hBrush, "int", $iARGB)
	If @error Then Return SetError(1, @error, 0)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_SetPathGradientCenterColor

Func _GDIPlus_FillPath($hGraphic, $hBrushGrad, $hPath)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipFillPath", "handle", $hGraphic, "handle", $hBrushGrad, "handle", $hPath)
	If @error Then Return SetError(1, @error, 0)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_FillPath

Func _GDIPlus_SetPathGradientSurroundColorsWithCount($hBrush, $aArgb)
	Local $iI, $iCount, $aResult, $res, $x, $pArgb
	If IsArray($aArgb) Then
		$iCount = UBound($aArgb)
		Local $tArgb = DllStructCreate("int[" & $iCount & "]")
		Local $pArgb = DllStructGetPtr($tArgb)
		For $iI = 0 To $iCount - 1
			DllStructSetData($tArgb, 1, $aArgb[$iI], $iI + 1)
		Next
	Else
		$iCount = 1
		Local $tArgb = DllStructCreate("int")
		Local $pArgb = DllStructGetPtr($tArgb)
		DllStructSetData($tArgb, 1, $aArgb, 1)
	EndIf
	$aResult = DllCall($ghGDIPDll, "int", "GdipSetPathGradientSurroundColorsWithCount", "handle", $hBrush, "int", $pArgb, "int*", $iCount)
	If @error Then Return SetError(1, @error, 0)
	Return SetError($aResult[0], $aResult[3], $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_SetPathGradientSurroundColorsWithCount

Func _GDIPlus_ClosePathFigure($hPath)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipClosePathFigure", "handle", $hPath)
	If @error Then Return SetError(1, @error, 0)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_ClosePathFigure

Func _GDIPlus_PathDispose($hPath)
	Local $aResult = DllCall($ghGDIPDll, "uint", "GdipDeletePath", "handle", $hPath)
	If @error Then Return SetError(1, @error, 0)
	Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>_GDIPlus_PathDispose