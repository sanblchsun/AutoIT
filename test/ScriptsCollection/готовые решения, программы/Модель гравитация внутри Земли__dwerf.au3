Global Const $lngError = 'Ошибка'
Global Const $lngErrorGDIPStartup = 'Не грузится GDI+.'
Global Const $lngForm1Name = 'Управление'
Global Const $lngForm2Name = 'Модель'
Global Const $lngForm3Name = 'Графики'
Global Const $lngTunnelOffsetInfo = 'Расстояние между центрами Земли и туннеля в км'
Global Const $lngSecPerSecInfo = 'Секунда реального времени соответствует n секундам модели'
Global Const $lngShowRealTime = 'Показывать реальное время'
Global Const $lngButtonStart = 'Старт (CTRL+S)'
Global Const $lngButtonStop = 'Стоп (CTRL+S)'
Global Const $lngButtonReset = 'Сброс (CTRL+R)'
Global Const $lngButtonClose = 'Закрыть (CTRL+Q)'
Global Const $lngBodyOffset = 'Расстояние'
Global Const $lngAmplitude = 'Амплитуда'
Global Const $lngVelocity = 'Скорость'
Global Const $lngAcceleration = 'Ускорение'
Global Const $lngPeriod = 'Период'
Global Const $lngMax = 'Макс.'
Global Const $lngUnit_km = 'км'
Global Const $lngUnit_m = 'м'
Global Const $lngUnit_s = 'с'


Global Const $GUI_EVENT_CLOSE = -3
Global Const $GUI_RUNDEFMSG = 'GUI_RUNDEFMSG'
Global Const $GUI_CHECKED = 1
Global Const $GUI_ENABLE = 64
Global Const $GUI_DISABLE = 128
Global Const $ES_RIGHT = 2
Global Const $ES_NUMBER = 8192
Global Const $UDS_NOTHOUSANDS = 0x0080
Global Const $BS_DEFPUSHBUTTON = 0x0001
Global Const $WM_PAINT = 0x000F
#include <GDIPlus.au3>

Opt('MustDeclareVars', 1)
Opt('GUICloseOnESC', 0)

If Not _GDIPlus_Startup() Then
	MsgBox(16, $lngError, $lngErrorGDIPStartup)
	Exit(1)
EndIf


Global Const $m_per_pix = 6378000/268
Global Const $mpss_per_m = 9.81/6378000
Global Const $pi = 3.14159265358979

Global Const $fPeriod = 5068.644537067
Global Const $fAngFrequency = 2*$pi/$fPeriod

Global $iTunnelOffset = 0
Global $iSecPerSec = 300
Global $AppRun = False

Global $fAmplitude = Sqrt(6378000^2-$iTunnelOffset^2), $fVelocityMax = $fAmplitude*$fAngFrequency, $fAccelerationMax = $fVelocityMax*$fAngFrequency
Global $fAmplitudeMax = 6378000, $fVelocityMaxMax = $fAmplitudeMax*$fAngFrequency, $fAccelerationMaxMax = $fVelocityMaxMax*$fAngFrequency
Global $fBodyOffset = $fAmplitude
Global $fTimerTime = 0, $fTime = 0, $fVelocity = 0, $fAcceleration = -1*$fAccelerationMax
Global $iTunnelOffsetInPixel = Round($iTunnelOffset/$m_per_pix), $fBodyOffsetInPixel = Round($fBodyOffset/$m_per_pix)
Global $aGraph1Coords_BodyOffset[601][2] = [[0]], $aGraph1Coords_Velocity[601][2] = [[0]], $aGraph1Coords_Acceleration[601][2] = [[0]], $iGraph1X
Global $aGraph2Coords_Velocity[551][2] = [[0]], $aGraph2Coords_Acceleration[551][2] = [[0]], $iGraph2X, $iGraph2Coords_StartX, $iGraph2Coords_StartY, $iGraph2Coords_EllipseWidth, $iGraph2Coords_EllipseHeight, $iGraph2Coords_LineEndX, $iGraph2Coords_LineEndY
Global $hTimer, $fCalculationTime = 0

Global $Form1 = GUICreate($lngForm1Name, 599, 300, 10, 645)

GUICtrlCreateLabel($lngTunnelOffsetInfo, 10, 10, 220, 30)
Global $Form1_iptTunnelOffset = GUICtrlCreateInput(Round($iTunnelOffset/1000), 250, 15, 100, 20, BitOR($ES_RIGHT, $ES_NUMBER))
Global $Form1_updTunnelOffset = GUICtrlCreateUpdown($Form1_iptTunnelOffset, $UDS_NOTHOUSANDS)
_GUICtrlSetLimit($Form1_updTunnelOffset, 6378, -6378)

GUICtrlCreateLabel($lngSecPerSecInfo, 10, 52, 230, 30)
Global $Form1_iptSecPerSec = GUICtrlCreateInput($iSecPerSec, 250, 50, 100, 20, BitOR($ES_RIGHT, $ES_NUMBER))
Global $Form1_updSecPerSec = GUICtrlCreateUpdown($Form1_iptSecPerSec, $UDS_NOTHOUSANDS)
_GUICtrlSetLimit($Form1_updSecPerSec, 5069)

Global $Form1_chkRealTime = GUICtrlCreateCheckbox($lngShowRealTime, 360, 50, 170, 20)

Global $Form1_btnStart = GUICtrlCreateButton($lngButtonStart, 10, 110, 120, 25, $BS_DEFPUSHBUTTON)
Global $Form1_btnReset = GUICtrlCreateButton($lngButtonReset, 140, 110, 120, 25)
Global $Form1_btnClose = GUICtrlCreateButton($lngButtonClose, 270, 110, 120, 25)

GUISetState(@SW_SHOW, $Form1)

Global $Form2 = GUICreate($lngForm2Name, 599, 599, 10, 10)
GUISetBkColor(0, $Form2)
GUISetState(@SW_SHOW, $Form2)
Global $hGDIP_Earth_Graphic = _GDIPlus_GraphicsCreateFromHWND($Form2)
Global $hGDIP_Earth_Backbuffer_Bitmap = _GDIPlus_BitmapCreateFromGraphics(599, 599, $hGDIP_Earth_Graphic)
Global $hGDIP_Earth_Backbuffer_Graphic = _GDIPlus_ImageGetGraphicsContext($hGDIP_Earth_Backbuffer_Bitmap)
Global $hGDIP_Earth_Image = _GDIPlus_ImageLoadFromFile(@ScriptDir & '\Earth.bmp')

Global $Form3 = GUICreate($lngForm3Name, 651, 935, 619, 10)
GUISetBkColor(0, $Form3)
GUISetState(@SW_SHOW, $Form3)
Global $hGDIP_Graph_Graphic = _GDIPlus_GraphicsCreateFromHWND($Form3)
Global $hGDIP_Graph_Backbuffer_Bitmap = _GDIPlus_BitmapCreateFromGraphics(651, 935, $hGDIP_Graph_Graphic)
Global $hGDIP_Graph_Backbuffer_Graphic = _GDIPlus_ImageGetGraphicsContext($hGDIP_Graph_Backbuffer_Bitmap)

Global $hGDIP_String_Format_Normal = _GDIPlus_StringFormatCreate()
Global $hGDIP_String_Format_AlignRight = _GDIPlus_StringFormatCreate()
_GDIPlus_StringFormatSetAlign($hGDIP_String_Format_AlignRight, 2)

Global $hGDIP_String_FontFamily_Arial = _GDIPlus_FontFamilyCreate('Arial')
Global $hGDIP_String_Font_Arial_12x2 = _GDIPlus_FontCreate($hGDIP_String_FontFamily_Arial, 12, 2)

Global $tGDIP_String_Layout_10x10 = _GDIPlus_RectFCreate(10, 10, 0, 0)
Global $tGDIP_String_Layout_25x10 = _GDIPlus_RectFCreate(25, 10, 0, 0)
Global $tGDIP_String_Layout_25x30 = _GDIPlus_RectFCreate(25, 30, 0, 0)
Global $tGDIP_String_Layout_25x50 = _GDIPlus_RectFCreate(25, 50, 0, 0)
Global $tGDIP_String_Layout_635x210 = _GDIPlus_RectFCreate(635, 210, 0, 0)
Global $tGDIP_String_Layout_Xx355 = _GDIPlus_RectFCreate(0, 355, 0, 0)
Global $tGDIP_String_Layout_10x385 = _GDIPlus_RectFCreate(10, 385, 0, 0)
Global $tGDIP_String_Layout_Xx385 = _GDIPlus_RectFCreate(0, 385, 0, 0)
Global $tGDIP_String_Layout_Xx470 = _GDIPlus_RectFCreate(10, 470, 0, 0)
Global $tGDIP_String_Layout_Xx490 = _GDIPlus_RectFCreate(10, 490, 0, 0)
Global $tGDIP_String_Layout_551x708 = _GDIPlus_RectFCreate(551, 708, 0, 0)
Global $tGDIP_String_Layout_Xx515 = _GDIPlus_RectFCreate(00, 515, 0, 0)

Global $hGDIP_Pen_Axis = _GDIPlus_PenCreate(0xFFFFFFFF, 2)
Global $hGDIP_Pen_Axis_Arrow = _GDIPlus_ArrowCapCreate(7, 4)
_GDIPlus_PenSetCustomEndCap($hGDIP_Pen_Axis, $hGDIP_Pen_Axis_Arrow)

Global $hGDIP_Pen_FFFFFFFF_1 = _GDIPlus_PenCreate(0xFFFFFFFF, 1)
Global $hGDIP_Pen_FF00FF00_1 = _GDIPlus_PenCreate(0xFF00FF00, 1)
Global $hGDIP_Pen_FF3333FF_1 = _GDIPlus_PenCreate(0xFF3333FF, 1)
Global $hGDIP_Pen_FF00FFFF_1 = _GDIPlus_PenCreate(0xFF00FFFF, 1)

Global $hGDIP_Brush_FFFFFFFF = _GDIPlus_BrushCreateSolid(0xFFFFFFFF)
Global $hGDIP_Brush_FF0000FF = _GDIPlus_BrushCreateSolid(0xFF0000FF)
Global $hGDIP_Brush_FF3333FF = _GDIPlus_BrushCreateSolid(0xFF3333FF)
Global $hGDIP_Brush_FF00FF00 = _GDIPlus_BrushCreateSolid(0xFF00FF00)
Global $hGDIP_Brush_FF00FFFF = _GDIPlus_BrushCreateSolid(0xFF00FFFF)

HotKeySet('^s', 'AppRun')
HotKeySet('^r', 'Reset')
HotKeySet('^q', '_Exit')

Draw()

WinActivate($Form1)

If $AppRun Then
	$AppRun = False
	AppRun()
EndIf

OnAutoItExitRegister('OnExit')
GUIRegisterMsg($WM_PAINT, 'WM_PAINT')

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE, $Form1_btnClose
			_Exit()
		Case $Form1_btnStart
			AppRun()
		Case $Form1_btnReset
			Reset()
		Case $Form1_chkRealTime
			UpdateModell()
		Case Else
			TunnelOffsetChanged()
			SecPerSecChanged()
	EndSwitch
WEnd

Func SecPerSecChanged()
	Local $Form1_iptSecPerSec_Value = GUICtrlRead($Form1_iptSecPerSec)
	If $Form1_iptSecPerSec_Value > 5069 Then
		$Form1_iptSecPerSec_Value = 5069
		GUICtrlSetData($Form1_iptSecPerSec, '5069')
	ElseIf $Form1_iptSecPerSec_Value < 0 Then
		$Form1_iptSecPerSec_Value = 0
		GUICtrlSetData($Form1_iptSecPerSec, '0')
	EndIf
	If $iSecPerSec <> $Form1_iptSecPerSec_Value Then $iSecPerSec = $Form1_iptSecPerSec_Value
EndFunc

Func TunnelOffsetChanged()
	Local $Form1_iptTunnelOffset_Value = GUICtrlRead($Form1_iptTunnelOffset)
	If $Form1_iptTunnelOffset_Value > 6378 Then
		$Form1_iptTunnelOffset_Value = 6378
		GUICtrlSetData($Form1_iptTunnelOffset, '6378')
	ElseIf $Form1_iptTunnelOffset_Value < -6378 Then
		$Form1_iptTunnelOffset_Value = -6378
		GUICtrlSetData($Form1_iptTunnelOffset, '-6378')
	EndIf
	$Form1_iptTunnelOffset_Value *= 1000
	If $iTunnelOffset <> $Form1_iptTunnelOffset_Value Then
		$iTunnelOffset = $Form1_iptTunnelOffset_Value
		$iTunnelOffsetInPixel = Round($iTunnelOffset/$m_per_pix)
		$fAmplitude = Sqrt(6378000^2-$iTunnelOffset^2)
		$fVelocityMax = $fAmplitude*$fAngFrequency
		$fAccelerationMax = $fVelocityMax*$fAngFrequency
		If $fBodyOffset > $fAmplitude Then
			$fBodyOffset = $fAmplitude
		ElseIf $fBodyOffset < -1*$fAmplitude Then
			$fBodyOffset = -1*$fAmplitude
		EndIf
		Reset()
		Draw()
	EndIf
EndFunc

Func AppRun()
	If $AppRun Then
		AdlibUnRegister('Calculation')
		$AppRun = False
		GUICtrlSetData($Form1_btnStart, $lngButtonStart)
		GUICtrlSetState($Form1_iptTunnelOffset, $GUI_ENABLE)
		GUICtrlSetState($Form1_updTunnelOffset, $GUI_ENABLE)
		GUICtrlSetState($Form1_iptSecPerSec, $GUI_ENABLE)
		GUICtrlSetState($Form1_updSecPerSec, $GUI_ENABLE)
	Else
		Reset()
		Local $fLProductTAF, $fLCosProductTAF, $fLBodyOffset, $fLVelocity, $fLAcceleration, $fLRotPerPix
		$fLRotPerPix = $pi/300
		For $i = 1 To 600 Step +1
			$fLProductTAF = $fLRotPerPix*$i
			$fLCosProductTAF = Cos($fLProductTAF)
			$fLBodyOffset = $fAmplitude*$fLCosProductTAF
			$fLVelocity = -1*$fVelocityMax*Sin($fLProductTAF)
			$fLAcceleration = -1*$fAccelerationMax*$fLCosProductTAF
			$aGraph1Coords_BodyOffset[$i][0] = $i+10
			$aGraph1Coords_BodyOffset[$i][1] = Round(220-(110/$fAmplitudeMax*$fLBodyOffset))
			$aGraph1Coords_Velocity[$i][0] = $i + 10
			$aGraph1Coords_Velocity[$i][1] = Round(220-(125/$fVelocityMaxMax*$fLVelocity))
			$aGraph1Coords_Acceleration[$i][0] = $i + 10
			$aGraph1Coords_Acceleration[$i][1] = Round(220-(90/$fAccelerationMaxMax*$fLAcceleration))
		Next
		$fLRotPerPix = $pi/275
		For $i = 1 To 550 Step +1
			$fLProductTAF = $fLRotPerPix*$i
			$fLCosProductTAF = Cos($fLProductTAF)
			$fLBodyOffset = $fAmplitude*$fLCosProductTAF
			$fLVelocity = -1*$fVelocityMax*Sin($fLProductTAF)
			$fLAcceleration = -1*$fAccelerationMax*$fLCosProductTAF
			$aGraph2Coords_Velocity[$i][0] = Round(281+(225/$fAmplitudeMax*$fLBodyOffset))
			$aGraph2Coords_Velocity[$i][1] = Round(718-(162.5/$fVelocityMaxMax*$fLVelocity))
			$aGraph2Coords_Acceleration[$i][0] = Round(281+(225/$fAmplitudeMax*$fLBodyOffset))
			$aGraph2Coords_Acceleration[$i][1] = Round(718-(162.5/$fAccelerationMaxMax*$fLAcceleration))
		Next
		$iGraph2Coords_StartX = 281-Round($fAmplitude*225/$fAmplitudeMax)
		$iGraph2Coords_StartY = 718-Round($fAngFrequency*$fAmplitude*162.5/$fVelocityMaxMax)
		$iGraph2Coords_LineEndX = 562-$iGraph2Coords_StartX
		$iGraph2Coords_LineEndY = 1436-$iGraph2Coords_StartY
		$iGraph2Coords_EllipseWidth = $iGraph2Coords_LineEndX-$iGraph2Coords_StartX
		$iGraph2Coords_EllipseHeight = $iGraph2Coords_LineEndY-$iGraph2Coords_StartY
		GUICtrlSetState($Form1_iptTunnelOffset, $GUI_DISABLE)
		GUICtrlSetState($Form1_updTunnelOffset, $GUI_DISABLE)
		GUICtrlSetState($Form1_iptSecPerSec, $GUI_DISABLE)
		GUICtrlSetState($Form1_updSecPerSec, $GUI_DISABLE)
		GUICtrlSetData($Form1_btnStart, $lngButtonStop)
		$hTimer = TimerInit()
		$AppRun = True
		AdlibRegister('Calculation', 40)
	EndIf
EndFunc

Func Reset()
	$fBodyOffset = $fAmplitude
	$fVelocity = 0
	$fAcceleration = -1*$fAccelerationMax
	$fTime = 0
	$fTimerTime = 0
	$iGraph1X = 0
	$iGraph2X = 0
	$aGraph1Coords_BodyOffset[0][0] = 0
	$aGraph1Coords_Velocity[0][0] = 0
	$aGraph1Coords_Acceleration[0][0] = 0
	$aGraph2Coords_Velocity[0][0] = 0
	$aGraph2Coords_Acceleration[0][0] = 0
	If $AppRun Then $hTimer = TimerInit()
	Draw()
EndFunc

Func _GUICtrlSetLimit($hControl, $iMaxLimit, $iMinLimit = 0)
	GUICtrlSendMsg($hControl, 1135, $iMinLimit, $iMaxLimit)
EndFunc

Func _Exit()
	Exit(0)
EndFunc

Func Calculation()
	Local $hCTimer = TimerInit(), $fCTimerTime
	$fTimerTime = TimerDiff($hTimer)
	$fTime = $fTimerTime/1000*$iSecPerSec
	If $fTime >= $fPeriod*1000 Then AppRun()
	Local $fProductTAF = $fTime*$fAngFrequency
	Local $fCosProductTAF = Cos($fProductTAF)
	Local $fNegAF = -1*$fAngFrequency
	$fBodyOffset = $fAmplitude*$fCosProductTAF
	$fVelocity = $fNegAF*$fAmplitude*Sin($fProductTAF)
	$fAcceleration = $fNegAF*$fAngFrequency*$fBodyOffset
	$iGraph1X = Mod(Round($fTime), 5069)
	$iGraph2X = Round($iGraph1X*550/$fPeriod)
	$iGraph1X = Round($iGraph1X*600/$fPeriod)
	If $fTime < $fPeriod Then
		$aGraph1Coords_BodyOffset[0][0] = $iGraph1X
		$aGraph1Coords_Velocity[0][0] = $iGraph1X
		$aGraph1Coords_Acceleration[0][0] = $iGraph1X
		$aGraph2Coords_Velocity[0][0] = $iGraph2X
		If $fTime <= $fPeriod/2 Then
			$aGraph2Coords_Acceleration[0][0] = $iGraph2X
		Else
			$aGraph2Coords_Acceleration[0][0] = UBound($aGraph2Coords_Acceleration)-1
		EndIf
	Else
		$aGraph1Coords_BodyOffset[0][0] = UBound($aGraph1Coords_BodyOffset)-1
		$aGraph1Coords_Velocity[0][0] = UBound($aGraph1Coords_Velocity)-1
		$aGraph1Coords_Acceleration[0][0] = UBound($aGraph1Coords_Acceleration)-1
		$aGraph2Coords_Velocity[0][0] = UBound($aGraph2Coords_Velocity)-1
	EndIf
	Draw()
	$fCTimerTime = TimerDiff($hCTimer)
	If Abs($fCalculationTime-$fCTimerTime) >= 5 Then
		$fCalculationTime = $fCTimerTime
		AdlibUnRegister('Calculation')
		AdlibRegister('Calculation', Int($fCTimerTime)+5)
	EndIf
EndFunc

Func WM_PAINT($hWnd, $Msg, $wParam, $lParam)
	Switch $hWnd
		Case $Form2
			UpdateModell()
		Case $Form3
			UpdateGraph()
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc

Func Draw()
	UpdateModell()
	UpdateGraph()
EndFunc

Func UpdateModell()
	$fBodyOffsetInPixel = Round($fBodyOffset/$m_per_pix)
	If BitAND(GUICtrlRead($Form1_chkRealTime), $GUI_CHECKED) = $GUI_CHECKED Then
		Local $sDataText = Round($fTime) & ' ' & $lngUnit_s & @CRLF & Int($fTimerTime/1000) & ' ' & $lngUnit_s
	Else
		Local $sDataText = Round($fTime) & ' ' & $lngUnit_s
	EndIf
	_GDIPlus_GraphicsClear($hGDIP_Earth_Backbuffer_Graphic, 0xFF000000)
	_GDIPlus_GraphicsFillEllipse($hGDIP_Earth_Backbuffer_Graphic, 33, 31, 532, 535, $hGDIP_Brush_FF0000FF)
	If $hGDIP_Earth_Image <> -1 Then _GDIPlus_GraphicsDrawImageRect($hGDIP_Earth_Backbuffer_Graphic, $hGDIP_Earth_Image, 0, 0, 599, 599)
	_GDIPlus_GraphicsFillRect($hGDIP_Earth_Backbuffer_Graphic, 289+$iTunnelOffsetInPixel, 0, 20, 599)
	If $iTunnelOffset = 0 Then
		_GDIPlus_GraphicsFillEllipse($hGDIP_Earth_Backbuffer_Graphic, 291+$iTunnelOffsetInPixel, Round(290-$fBodyOffsetInPixel), 15, 15, $hGDIP_Brush_FFFFFFFF)
	ElseIf $iTunnelOffset > 0 Then
		_GDIPlus_GraphicsFillEllipse($hGDIP_Earth_Backbuffer_Graphic, 288+$iTunnelOffsetInPixel, Round(290-$fBodyOffsetInPixel), 15, 15, $hGDIP_Brush_FFFFFFFF)
	ElseIf $iTunnelOffset < 0 Then
		_GDIPlus_GraphicsFillEllipse($hGDIP_Earth_Backbuffer_Graphic, 294+$iTunnelOffsetInPixel, Round(290-$fBodyOffsetInPixel), 15, 15, $hGDIP_Brush_FFFFFFFF)
	EndIf
	Local $aGDIP_MSInfo = _GDIPlus_GraphicsMeasureString($hGDIP_Earth_Backbuffer_Graphic, $sDataText, $hGDIP_String_Font_Arial_12x2, $tGDIP_String_Layout_10x10, $hGDIP_String_Format_Normal)
	_GDIPlus_GraphicsDrawStringEx ($hGDIP_Earth_Backbuffer_Graphic, $sDataText, $hGDIP_String_Font_Arial_12x2, $aGDIP_MSInfo[0], $hGDIP_String_Format_Normal, $hGDIP_Brush_FFFFFFFF)
	_GDIPlus_GraphicsDrawImage($hGDIP_Earth_Graphic, $hGDIP_Earth_Backbuffer_Bitmap, 0, 0)
EndFunc

Func UpdateGraph()
	Local $aGDIP_MSInfo, $sText
	_GDIPlus_GraphicsClear($hGDIP_Graph_Backbuffer_Graphic)

	_GDIPlus_GraphicsFillRect($hGDIP_Graph_Backbuffer_Graphic, 10, 16, 10, 10, $hGDIP_Brush_FF00FFFF)
	$aGDIP_MSInfo = _GDIPlus_GraphicsMeasureString($hGDIP_Graph_Backbuffer_Graphic, $lngBodyOffset, $hGDIP_String_Font_Arial_12x2, $tGDIP_String_Layout_25x10, $hGDIP_String_Format_Normal)
	_GDIPlus_GraphicsDrawStringEx ($hGDIP_Graph_Backbuffer_Graphic, $lngBodyOffset, $hGDIP_String_Font_Arial_12x2, $aGDIP_MSInfo[0], $hGDIP_String_Format_Normal, $hGDIP_Brush_FF00FFFF)

	_GDIPlus_GraphicsFillRect($hGDIP_Graph_Backbuffer_Graphic, 10, 36, 10, 10, $hGDIP_Brush_FF00FF00)
	$aGDIP_MSInfo = _GDIPlus_GraphicsMeasureString($hGDIP_Graph_Backbuffer_Graphic, $lngVelocity, $hGDIP_String_Font_Arial_12x2, $tGDIP_String_Layout_25x30, $hGDIP_String_Format_Normal)
	_GDIPlus_GraphicsDrawStringEx ($hGDIP_Graph_Backbuffer_Graphic, $lngVelocity, $hGDIP_String_Font_Arial_12x2, $aGDIP_MSInfo[0], $hGDIP_String_Format_Normal, $hGDIP_Brush_FF00FF00)

	_GDIPlus_GraphicsFillRect($hGDIP_Graph_Backbuffer_Graphic, 10, 56, 10, 10, $hGDIP_Brush_FF3333FF)
	$aGDIP_MSInfo = _GDIPlus_GraphicsMeasureString($hGDIP_Graph_Backbuffer_Graphic, $lngAcceleration, $hGDIP_String_Font_Arial_12x2, $tGDIP_String_Layout_25x50, $hGDIP_String_Format_Normal)
	_GDIPlus_GraphicsDrawStringEx ($hGDIP_Graph_Backbuffer_Graphic, $lngAcceleration, $hGDIP_String_Font_Arial_12x2, $aGDIP_MSInfo[0], $hGDIP_String_Format_Normal, $hGDIP_Brush_FF3333FF)

	$aGDIP_MSInfo = _GDIPlus_GraphicsMeasureString($hGDIP_Graph_Backbuffer_Graphic, 't', $hGDIP_String_Font_Arial_12x2, $tGDIP_String_Layout_635x210, $hGDIP_String_Format_Normal)
	_GDIPlus_GraphicsDrawStringEx ($hGDIP_Graph_Backbuffer_Graphic, 't', $hGDIP_String_Font_Arial_12x2, $aGDIP_MSInfo[0], $hGDIP_String_Format_Normal, $hGDIP_Brush_FFFFFFFF)

	_GDIPlus_GraphicsDrawLine($hGDIP_Graph_Backbuffer_Graphic, 10, 220, 631, 220, $hGDIP_Pen_Axis)
	_GDIPlus_GraphicsDrawLine($hGDIP_Graph_Backbuffer_Graphic, 10, 370, 10, 70, $hGDIP_Pen_Axis)

	_GDIPlus_GraphicsDrawCurve($hGDIP_Graph_Backbuffer_Graphic, $aGraph1Coords_BodyOffset, $hGDIP_Pen_FF00FFFF_1)
	_GDIPlus_GraphicsDrawCurve($hGDIP_Graph_Backbuffer_Graphic, $aGraph1Coords_Velocity, $hGDIP_Pen_FF00FF00_1)
	_GDIPlus_GraphicsDrawCurve($hGDIP_Graph_Backbuffer_Graphic, $aGraph1Coords_Acceleration, $hGDIP_Pen_FF3333FF_1)

	$sText = $lngAmplitude & ':' & @CRLF & $lngMax & ' ' & $lngVelocity & ':' & @CRLF & $lngMax & ' ' & $lngAcceleration & ':' & @CRLF & $lngPeriod & ':'
	$aGDIP_MSInfo = _GDIPlus_GraphicsMeasureString($hGDIP_Graph_Backbuffer_Graphic, $sText, $hGDIP_String_Font_Arial_12x2, $tGDIP_String_Layout_10x385, $hGDIP_String_Format_Normal)
	_GDIPlus_GraphicsDrawStringEx ($hGDIP_Graph_Backbuffer_Graphic, $sText, $hGDIP_String_Font_Arial_12x2, $aGDIP_MSInfo[0], $hGDIP_String_Format_Normal, $hGDIP_Brush_FFFFFFFF)

	DllStructSetData($tGDIP_String_Layout_Xx385, 1, DllStructGetData($aGDIP_MSInfo[0], 1)+DllStructGetData($aGDIP_MSInfo[0], 3)+5)
	$sText = Round($fAmplitude/1000) & @CRLF & Round($fVelocityMax) & @CRLF & StringFormat('%.2f', Round($fAccelerationMax, 2)) & @CRLF & Round($fPeriod)
	$aGDIP_MSInfo = _GDIPlus_GraphicsMeasureString($hGDIP_Graph_Backbuffer_Graphic, $sText, $hGDIP_String_Font_Arial_12x2, $tGDIP_String_Layout_Xx385, $hGDIP_String_Format_Normal)
	_GDIPlus_GraphicsDrawStringEx ($hGDIP_Graph_Backbuffer_Graphic, $sText, $hGDIP_String_Font_Arial_12x2, $aGDIP_MSInfo[0], $hGDIP_String_Format_AlignRight, $hGDIP_Brush_FFFFFFFF)

	DllStructSetData($tGDIP_String_Layout_Xx385, 1, DllStructGetData($aGDIP_MSInfo[0], 1)+DllStructGetData($aGDIP_MSInfo[0], 3)+5)
	$sText = $lngUnit_km & @CRLF & $lngUnit_m & '/' & $lngUnit_s & @CRLF & $lngUnit_m & '/' & $lngUnit_s & '^2' & @CRLF & $lngUnit_s
	$aGDIP_MSInfo = _GDIPlus_GraphicsMeasureString($hGDIP_Graph_Backbuffer_Graphic, $sText, $hGDIP_String_Font_Arial_12x2, $tGDIP_String_Layout_Xx385, $hGDIP_String_Format_Normal)
	_GDIPlus_GraphicsDrawStringEx ($hGDIP_Graph_Backbuffer_Graphic, $sText, $hGDIP_String_Font_Arial_12x2, $aGDIP_MSInfo[0], $hGDIP_String_Format_Normal, $hGDIP_Brush_FFFFFFFF)

	DllStructSetData($tGDIP_String_Layout_Xx385, 1, DllStructGetData($aGDIP_MSInfo[0], 1)+DllStructGetData($aGDIP_MSInfo[0], 3)+50)
	$sText = $lngBodyOffset & ':' & @CRLF & $lngVelocity & ':' & @CRLF & $lngAcceleration & ':'
	$aGDIP_MSInfo = _GDIPlus_GraphicsMeasureString($hGDIP_Graph_Backbuffer_Graphic, $sText, $hGDIP_String_Font_Arial_12x2, $tGDIP_String_Layout_Xx385, $hGDIP_String_Format_Normal)
	_GDIPlus_GraphicsDrawStringEx ($hGDIP_Graph_Backbuffer_Graphic, $sText, $hGDIP_String_Font_Arial_12x2, $aGDIP_MSInfo[0], $hGDIP_String_Format_Normal, $hGDIP_Brush_FFFFFFFF)

	DllStructSetData($tGDIP_String_Layout_Xx385, 1, DllStructGetData($aGDIP_MSInfo[0], 1)+DllStructGetData($aGDIP_MSInfo[0], 3)+5)
	$sText = Round($fBodyOffset/1000) & @CRLF & Round($fVelocity) & @CRLF & StringFormat('%.2f', Round($fAcceleration, 2))
	$aGDIP_MSInfo = _GDIPlus_GraphicsMeasureString($hGDIP_Graph_Backbuffer_Graphic, $sText, $hGDIP_String_Font_Arial_12x2, $tGDIP_String_Layout_Xx385, $hGDIP_String_Format_Normal)
	_GDIPlus_GraphicsDrawStringEx ($hGDIP_Graph_Backbuffer_Graphic, $sText, $hGDIP_String_Font_Arial_12x2, $aGDIP_MSInfo[0], $hGDIP_String_Format_AlignRight, $hGDIP_Brush_FFFFFFFF)

	DllStructSetData($tGDIP_String_Layout_Xx385, 1, DllStructGetData($aGDIP_MSInfo[0], 1)+DllStructGetData($aGDIP_MSInfo[0], 3)+5)
	$sText = $lngUnit_km & @CRLF & $lngUnit_m & '/' & $lngUnit_s & @CRLF & $lngUnit_m & '/' & $lngUnit_s & '^2'
	$aGDIP_MSInfo = _GDIPlus_GraphicsMeasureString($hGDIP_Graph_Backbuffer_Graphic, $sText, $hGDIP_String_Font_Arial_12x2, $tGDIP_String_Layout_Xx385, $hGDIP_String_Format_Normal)
	_GDIPlus_GraphicsDrawStringEx ($hGDIP_Graph_Backbuffer_Graphic, $sText, $hGDIP_String_Font_Arial_12x2, $aGDIP_MSInfo[0], $hGDIP_String_Format_Normal, $hGDIP_Brush_FFFFFFFF)


	$aGDIP_MSInfo = _GDIPlus_GraphicsMeasureString($hGDIP_Graph_Backbuffer_Graphic, $lngVelocity, $hGDIP_String_Font_Arial_12x2, $tGDIP_String_Layout_Xx470, $hGDIP_String_Format_Normal)
	DllStructSetData($aGDIP_MSInfo[0], 1, 281-Round(DllStructGetData($aGDIP_MSInfo[0], 3)/2+12.5)+15)
	_GDIPlus_GraphicsFillRect($hGDIP_Graph_Backbuffer_Graphic, 281-Round(DllStructGetData($aGDIP_MSInfo[0], 3)/2+12.5), 476, 10, 10, $hGDIP_Brush_FF00FF00)
	_GDIPlus_GraphicsDrawStringEx ($hGDIP_Graph_Backbuffer_Graphic, $lngVelocity, $hGDIP_String_Font_Arial_12x2, $aGDIP_MSInfo[0], $hGDIP_String_Format_Normal, $hGDIP_Brush_FF00FF00)

	$aGDIP_MSInfo = _GDIPlus_GraphicsMeasureString($hGDIP_Graph_Backbuffer_Graphic, $lngAcceleration, $hGDIP_String_Font_Arial_12x2, $tGDIP_String_Layout_Xx490, $hGDIP_String_Format_Normal)
	DllStructSetData($aGDIP_MSInfo[0], 1, 281-Round((DllStructGetData($aGDIP_MSInfo[0], 3)+25)/2)+15)
	_GDIPlus_GraphicsFillRect($hGDIP_Graph_Backbuffer_Graphic, 281-Round(DllStructGetData($aGDIP_MSInfo[0], 3)/2+12.5), 496, 10, 10, $hGDIP_Brush_FF3333FF)
	_GDIPlus_GraphicsDrawStringEx ($hGDIP_Graph_Backbuffer_Graphic, $lngAcceleration, $hGDIP_String_Font_Arial_12x2, $aGDIP_MSInfo[0], $hGDIP_String_Format_Normal, $hGDIP_Brush_FF3333FF)

	$aGDIP_MSInfo = _GDIPlus_GraphicsMeasureString($hGDIP_Graph_Backbuffer_Graphic, $lngBodyOffset, $hGDIP_String_Font_Arial_12x2, $tGDIP_String_Layout_551x708, $hGDIP_String_Format_Normal)
	_GDIPlus_GraphicsDrawStringEx ($hGDIP_Graph_Backbuffer_Graphic, $lngBodyOffset, $hGDIP_String_Font_Arial_12x2, $aGDIP_MSInfo[0], $hGDIP_String_Format_Normal, $hGDIP_Brush_FFFFFFFF)

	_GDIPlus_GraphicsDrawLine($hGDIP_Graph_Backbuffer_Graphic, 10, 718, 541, 718, $hGDIP_Pen_Axis)
	_GDIPlus_GraphicsDrawLine($hGDIP_Graph_Backbuffer_Graphic, 281, 925, 281, 510, $hGDIP_Pen_Axis)

	If $fTime <= $fPeriod/2 Then
		_GDIPlus_GraphicsDrawCurve($hGDIP_Graph_Backbuffer_Graphic, $aGraph2Coords_Velocity, $hGDIP_Pen_FF00FF00_1)
		_GDIPlus_GraphicsDrawCurve($hGDIP_Graph_Backbuffer_Graphic, $aGraph2Coords_Acceleration, $hGDIP_Pen_FF3333FF_1)
	ElseIf $fTime <= $fPeriod Then
		_GDIPlus_GraphicsDrawCurve($hGDIP_Graph_Backbuffer_Graphic, $aGraph2Coords_Velocity, $hGDIP_Pen_FF00FF00_1)
		_GDIPlus_GraphicsDrawLine($hGDIP_Graph_Backbuffer_Graphic, $iGraph2Coords_StartX, $iGraph2Coords_StartY, $iGraph2Coords_LineEndX, $iGraph2Coords_LineEndY, $hGDIP_Pen_FF3333FF_1)
	Else
		_GDIPlus_GraphicsDrawEllipse($hGDIP_Graph_Backbuffer_Graphic, $iGraph2Coords_StartX, $iGraph2Coords_StartY, $iGraph2Coords_EllipseWidth, $iGraph2Coords_EllipseHeight, $hGDIP_Pen_FF00FF00_1)
		_GDIPlus_GraphicsDrawLine($hGDIP_Graph_Backbuffer_Graphic, $iGraph2Coords_StartX, $iGraph2Coords_StartY, $iGraph2Coords_LineEndX, $iGraph2Coords_LineEndY, $hGDIP_Pen_FF3333FF_1)
	EndIf

	$sText = Round($fTime) & ' ' & $lngUnit_s
	$aGDIP_MSInfo = _GDIPlus_GraphicsMeasureString($hGDIP_Graph_Backbuffer_Graphic, $sText, $hGDIP_String_Font_Arial_12x2, $tGDIP_String_Layout_Xx355, $hGDIP_String_Format_Normal)
	If $iGraph1X Then
		_GDIPlus_GraphicsDrawLine($hGDIP_Graph_Backbuffer_Graphic, $aGraph1Coords_BodyOffset[$iGraph1X][0]+1, 90, $aGraph1Coords_BodyOffset[$iGraph1X][0]+1, 350, $hGDIP_Pen_FFFFFFFF_1)
		Local $iTextWidthHalf = Round(DllStructGetData($aGDIP_MSInfo[0], 3)/2)
		If $iTextWidthHalf < $aGraph1Coords_BodyOffset[$iGraph1X][0]-11 Then
			DllStructSetData($aGDIP_MSInfo[0], 1, $aGraph1Coords_BodyOffset[$iGraph1X][0]-$iTextWidthHalf)
		Else
			DllStructSetData($aGDIP_MSInfo[0], 1, 11)
		EndIf
		_GDIPlus_GraphicsDrawStringEx ($hGDIP_Graph_Backbuffer_Graphic, $sText, $hGDIP_String_Font_Arial_12x2, $aGDIP_MSInfo[0], $hGDIP_String_Format_Normal, $hGDIP_Brush_FFFFFFFF)
	ElseIf $AppRun Then
		DllStructSetData($aGDIP_MSInfo[0], 1, 11)
		_GDIPlus_GraphicsDrawStringEx ($hGDIP_Graph_Backbuffer_Graphic, $sText, $hGDIP_String_Font_Arial_12x2, $aGDIP_MSInfo[0], $hGDIP_String_Format_Normal, $hGDIP_Brush_FFFFFFFF)
	EndIf

	$sText = Round($fBodyOffset/1000) & ' ' & $lngUnit_km
	$aGDIP_MSInfo = _GDIPlus_GraphicsMeasureString($hGDIP_Graph_Backbuffer_Graphic, $sText, $hGDIP_String_Font_Arial_12x2, $tGDIP_String_Layout_Xx515, $hGDIP_String_Format_Normal)
	If $iGraph2X Then
		_GDIPlus_GraphicsDrawLine($hGDIP_Graph_Backbuffer_Graphic, $aGraph2Coords_Velocity[$iGraph2X][0], 535, $aGraph2Coords_Velocity[$iGraph2X][0], 900, $hGDIP_Pen_FFFFFFFF_1)
		If Abs($aGraph2Coords_Velocity[$iGraph2X][0]-281) > DllStructGetData($aGDIP_MSInfo[0], 3)/2+10 Then
			DllStructSetData($aGDIP_MSInfo[0], 1, $aGraph2Coords_Velocity[$iGraph2X][0]-(DllStructGetData($aGDIP_MSInfo[0], 3)/2))
		ElseIf $fBodyOffset >= 0 Then
			DllStructSetData($aGDIP_MSInfo[0], 1, 291)
		ElseIf $fBodyOffset < 0 Then
			DllStructSetData($aGDIP_MSInfo[0], 1, 271-DllStructGetData($aGDIP_MSInfo[0], 3))
		EndIf
		_GDIPlus_GraphicsDrawStringEx ($hGDIP_Graph_Backbuffer_Graphic, $sText, $hGDIP_String_Font_Arial_12x2, $aGDIP_MSInfo[0], $hGDIP_String_Format_Normal, $hGDIP_Brush_FFFFFFFF)
	ElseIf $AppRun Then
		_GDIPlus_GraphicsDrawLine($hGDIP_Graph_Backbuffer_Graphic, $aGraph2Coords_Velocity[1][0], 535, $aGraph2Coords_Velocity[1][0], 900, $hGDIP_Pen_FFFFFFFF_1)
		$aGDIP_MSInfo = _GDIPlus_GraphicsMeasureString($hGDIP_Graph_Backbuffer_Graphic, Round($fBodyOffset/1000) & ' ' & $lngUnit_km, $hGDIP_String_Font_Arial_12x2, $tGDIP_String_Layout_Xx515, $hGDIP_String_Format_Normal)
		If Abs($aGraph2Coords_Velocity[1][0]-281) > DllStructGetData($aGDIP_MSInfo[0], 3)/2+10 Then
			DllStructSetData($aGDIP_MSInfo[0], 1, $aGraph2Coords_Velocity[1][0]-(DllStructGetData($aGDIP_MSInfo[0], 3)/2))
		ElseIf $fBodyOffset >= 0 Then
			DllStructSetData($aGDIP_MSInfo[0], 1, 291)
		ElseIf $fBodyOffset < 0 Then
			DllStructSetData($aGDIP_MSInfo[0], 1, 271-DllStructGetData($aGDIP_MSInfo[0], 3))
		EndIf
		_GDIPlus_GraphicsDrawStringEx ($hGDIP_Graph_Backbuffer_Graphic, $sText, $hGDIP_String_Font_Arial_12x2, $aGDIP_MSInfo[0], $hGDIP_String_Format_Normal, $hGDIP_Brush_FFFFFFFF)
	EndIf

	_GDIPlus_GraphicsFillEllipse($hGDIP_Graph_Backbuffer_Graphic, $aGraph2Coords_Acceleration[$iGraph2X][0]-5, $aGraph2Coords_Acceleration[$iGraph2X][1]-5, 9, 9, $hGDIP_Brush_FF3333FF)
	_GDIPlus_GraphicsFillEllipse($hGDIP_Graph_Backbuffer_Graphic, $aGraph2Coords_Velocity[$iGraph2X][0]-5, $aGraph2Coords_Velocity[$iGraph2X][1]-5, 9, 9, $hGDIP_Brush_FF00FF00)

	_GDIPlus_GraphicsDrawImage($hGDIP_Graph_Graphic, $hGDIP_Graph_Backbuffer_Bitmap, 0, 0)
EndFunc

Func OnExit()
	AdlibUnRegister('Calculation')
	GUIRegisterMsg($WM_PAINT, '')
	_GDIPlus_GraphicsClear($hGDIP_Earth_Backbuffer_Graphic)
	_GDIPlus_GraphicsClear($hGDIP_Earth_Graphic)
	_GDIPlus_GraphicsClear($hGDIP_Graph_Backbuffer_Graphic)
	_GDIPlus_GraphicsClear($hGDIP_Graph_Graphic)
	_GDIPlus_BrushDispose($hGDIP_Brush_FF00FFFF)
	_GDIPlus_BrushDispose($hGDIP_Brush_FF00FF00)
	_GDIPlus_BrushDispose($hGDIP_Brush_FF3333FF)
	_GDIPlus_BrushDispose($hGDIP_Brush_FF0000FF)
	_GDIPlus_BrushDispose($hGDIP_Brush_FFFFFFFF)
	_GDIPlus_PenDispose($hGDIP_Pen_FF3333FF_1)
	_GDIPlus_PenDispose($hGDIP_Pen_FF00FFFF_1)
	_GDIPlus_PenDispose($hGDIP_Pen_FF00FF00_1)
	_GDIPlus_PenDispose($hGDIP_Pen_FFFFFFFF_1)
	_GDIPlus_PenDispose($hGDIP_Pen_Axis)
	_GDIPlus_ArrowCapDispose($hGDIP_Pen_Axis_Arrow)
	_GDIPlus_FontDispose($hGDIP_String_Font_Arial_12x2)
	_GDIPlus_FontFamilyDispose($hGDIP_String_FontFamily_Arial)
	_GDIPlus_StringFormatDispose($hGDIP_String_Format_Normal)
	_GDIPlus_StringFormatDispose($hGDIP_String_Format_AlignRight)
	_GDIPlus_GraphicsDispose($hGDIP_Graph_Graphic)
	_GDIPlus_GraphicsDispose($hGDIP_Graph_Backbuffer_Bitmap)
	_GDIPlus_GraphicsDispose($hGDIP_Graph_Backbuffer_Graphic)
	_GDIPlus_ImageDispose($hGDIP_Earth_Image)
	_GDIPlus_GraphicsDispose($hGDIP_Earth_Graphic)
	_GDIPlus_BitmapDispose($hGDIP_Earth_Backbuffer_Bitmap)
	_GDIPlus_GraphicsDispose($hGDIP_Earth_Backbuffer_Graphic)
	_GDIPlus_Shutdown()
EndFunc