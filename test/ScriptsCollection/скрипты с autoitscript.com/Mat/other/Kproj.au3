#region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_outfile=..\Projects\Kinematics\Kinematics.exe
#AutoIt3Wrapper_Res_Description=A 2-d kinematics modeller
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_LegalCopyright=Matt Diesel (Mat) 2010
#endregion ;**** Directives created by AutoIt3Wrapper_GUI ****


#include<GDIPlus.au3>
#include<GUIConstantsEx.au3>
#include<Math.au3>

_GDIPlus_Startup()

; Globals

Global $aScreen[2] = [500, 400]
Global $iScale = 100

Global $iUx, $iUy
Global $iRx

Global Enum $OPT_H = 0, $OPT_U, $OPT_Theta, $OPT_G, $OPT_TINC, $OPT_TMUL, $OPT_MAX
Global Enum $OUT_Sx = 0, $OUT_Sy, $OUT_Vx, $OUT_Vy, $OUT_T, $OUT_MAX

Global $aOptDef[$OPT_MAX]
$aOptDef[$OPT_H] = 0
$aOptDef[$OPT_U] = 8
$aOptDef[$OPT_Theta] = 45
$aOptDef[$OPT_G] = 9.81
$aOptDef[$OPT_TINC] = 0.01
$aOptDef[$OPT_TMUL] = 1

Global $aOptName[$OPT_MAX]
$aOptName[$OPT_H] = 'Initial Height'
$aOptName[$OPT_U] = 'Initial Velocity'
$aOptName[$OPT_Theta] = 'Angle'
$aOptName[$OPT_G] = 'Gravity'
$aOptName[$OPT_TINC] = 'Time increment'
$aOptName[$OPT_TMUL] = 'Time multiplier'

Global $aOptUnit[$OPT_MAX]
$aOptUnit[$OPT_H] = 'm'
$aOptUnit[$OPT_U] = 'm/s'
$aOptUnit[$OPT_Theta] = Chr(176)
$aOptUnit[$OPT_G] = 'm/s/s'
$aOptUnit[$OPT_TINC] = 's'
$aOptUnit[$OPT_TMUL] = 's'

Global $aOptListItem[$OPT_MAX]

Global $aOptVal[$OPT_MAX]
$aOptVal[$OPT_H] = $aOptDef[$OPT_H]
$aOptVal[$OPT_U] = $aOptDef[$OPT_U]
$aOptVal[$OPT_Theta] = $aOptDef[$OPT_Theta]
$aOptVal[$OPT_G] = $aOptDef[$OPT_G]
$aOptVal[$OPT_TINC] = $aOptDef[$OPT_TINC]
$aOptVal[$OPT_TMUL] = $aOptDef[$OPT_TMUL]


Global $aOutName[$OUT_MAX]
$aOutName[$OUT_Sx] = '   Horz'
$aOutName[$OUT_Sy] = '   Vert'
$aOutName[$OUT_Vx] = '   Horz'
$aOutName[$OUT_Vy] = '   Vert'
$aOutName[$OUT_T] = 'Time'

Global $aOutUnit[$OUT_MAX]
$aOutUnit[$OUT_Sx] = 'm'
$aOutUnit[$OUT_Sy] = 'm'
$aOutUnit[$OUT_Vx] = 'm/s'
$aOutUnit[$OUT_Vy] = 'm/s'
$aOutUnit[$OUT_T] = 's'

Global $aOutListItem[$OUT_MAX]

Global $aOutVal[$OUT_MAX]
$aOutVal[$OUT_Sx] = 0
$aOutVal[$OUT_Sy] = 0
$aOutVal[$OUT_Vx] = 0
$aOutVal[$OUT_Vy] = 0
$aOutVal[$OUT_T] = 0


Global $g_hWnd, $g_hInList, $g_hCanvas, $g_hOutList, $g_hRun, $g_hPause

$g_hWnd = GUICreate('Kinematic projections', $aScreen[0] + 404, $aScreen[1] + 36)

$g_hInList = GUICtrlCreateListView(' Name | Value', 0, 0, 200, $aScreen[1] + 36)
For $i = 0 To $OPT_MAX - 1
	$aOptListItem[$i] = GUICtrlCreateListViewItem($aOptName[$i] & '|' & $aOptDef[$i] & ' ' & $aOptUnit[$i], $g_hInList)
Next

$g_hRun = GUICtrlCreateButton('Go!', 204, 2, 80, 30)
$g_hPause = GUICtrlCreateButton('Pause', 288, 2, 80, 30)
GUICtrlSetState($g_hPause, $GUI_HIDE)

$g_hCanvas = GUICtrlCreateLabel('', 202, 34, $aScreen[0], $aScreen[1])

$g_hOutList = GUICtrlCreateListView(' Name | Value', $aScreen[0] + 204, 0, 200, $aScreen[1] + 36)
GUICtrlCreateListViewItem('Displacement:|', $g_hOutList)
$aOutListItem[$OUT_Sx] = GUICtrlCreateListViewItem($aOutName[$OUT_Sx] & '|' & Round($aOutVal[$OUT_Sx], 2) & ' ' & $aOutUnit[$OUT_Sx], $g_hOutList)
$aOutListItem[$OUT_Sy] = GUICtrlCreateListViewItem($aOutName[$OUT_Sy] & '|' & Round($aOutVal[$OUT_Sy], 2) & ' ' & $aOutUnit[$OUT_Sy], $g_hOutList)
GUICtrlCreateListViewItem('|', $g_hOutList)
GUICtrlCreateListViewItem('Velocity:|', $g_hOutList)
$aOutListItem[$OUT_Vx] = GUICtrlCreateListViewItem($aOutName[$OUT_Vx] & '|' & Round($aOutVal[$OUT_Vx], 2) & ' ' & $aOutUnit[$OUT_Vx], $g_hOutList)
$aOutListItem[$OUT_Vy] = GUICtrlCreateListViewItem($aOutName[$OUT_Vy] & '|' & Round($aOutVal[$OUT_Vy], 2) & ' ' & $aOutUnit[$OUT_Vy], $g_hOutList)
$aOutListItem[$OUT_T] = GUICtrlCreateListViewItem($aOutName[$OUT_T] & '|' & Round($aOutVal[$OUT_T], 2) & ' ' & $aOutUnit[$OUT_T], $g_hOutList)
GUICtrlCreateListViewItem('|', $g_hOutList)
GUICtrlCreateListViewItem('Stats:|', $g_hOutList)
Global $hMaxHeight = GUICtrlCreateListViewItem('   Max Height|', $g_hOutList)
Global $hRange = GUICtrlCreateListViewItem('   Range|', $g_hOutList)
Global $hScale = GUICtrlCreateListViewItem('   Scale|', $g_hOutList)


Global $penBlue = _GDIPlus_PenCreate(0xFF0000FF, 3)
Global $penTrail = _GDIPlus_PenCreate(0xFF00FF00, 1)
Global $brushWhite = _GDIPlus_BrushCreateSolid(0xFFFFFFFF)
Global $hGraph = _GDIPlus_GraphicsCreateFromHWND(GUICtrlGetHandle($g_hCanvas))
Global $hBmpBuffer = _GDIPlus_BitmapCreateFromGraphics($aScreen[0], $aScreen[1], $hGraph)
Global $hBuffer = _GDIPlus_ImageGetGraphicsContext($hBmpBuffer)
Global $hBmpBk = _GDIPlus_BitmapCreateFromGraphics($aScreen[0], $aScreen[1], $hGraph)
Global $hBk = _GDIPlus_ImageGetGraphicsContext($hBmpBk)
_GDIPlus_GraphicsFillRect($hBk, 0, 0, $aScreen[0], $aScreen[1], $brushWhite)
GUISetState()

Global $iState = 0
While 1
	$msg = GUIGetMsg()
	If $iState Then
		Switch $msg
			Case -3
				_Stop()
				ExitLoop
			Case $g_hRun
				_Stop()
			Case $g_hPause
				_Pause()
		EndSwitch
	Else
		Switch $msg
			Case -3
				ExitLoop
			Case $g_hRun
				_Go()
			Case Else
				For $i = 0 To $OPT_MAX - 1
					If $msg = $aOptListItem[$i] Then
						_OptUpdate($i)
						ContinueLoop 2
					EndIf
				Next
		EndSwitch
	EndIf
WEnd

_GDIPlus_GraphicsDispose($hBk)
_GDIPlus_ImageDispose($hBmpBk)
_GDIPlus_GraphicsDispose($hBuffer)
_GDIPlus_ImageDispose($hBmpBuffer)
_GDIPlus_GraphicsDispose($hGraph)
_GDIPlus_BrushDispose($brushWhite)
_GDIPlus_PenDispose($penTrail)
_GDIPlus_PenDispose($penBlue)
_GDIPlus_Shutdown()

Func _OptUpdate($i)
	$n = InputBox($aOptName[$i], 'Please enter the value for ' & $aOptName[$i] & ' in ' & $aOptUnit[$i] & @CRLF & @CRLF & _
			'Default is ' & $aOptDef[$i], $aOptVal[$i])
	If @error Then Return 0

	If Not StringIsFloat($n) And Not StringIsInt($n) Then Return 0 * MsgBox(16, 'Error', 'Numbers are the ones with the digits 0 to 9, or maybe a dot ( . ) as well....')

	$aOptVal[$i] = $n
	GUICtrlSetData($aOptListItem[$i], $aOptName[$i] & '|' & $aOptVal[$i] & ' ' & $aOptUnit[$i])

	Return 1
EndFunc   ;==>_OptUpdate

Func _Stop()
	AdlibUnRegister()
	$iState = 0
	GUICtrlSetData($g_hRun, 'Go!')
	GUICtrlSetData($g_hPause, 'Pause')
	GUICtrlSetState($g_hPause, $GUI_HIDE)
EndFunc   ;==>_Stop

Func _Pause()
	If $iState = 2 Then
		AdlibRegister('_Draw', $aOptVal[$OPT_TINC] * 1000)
		$iState = 1
		GUICtrlSetData($g_hPause, 'Pause')
	Else
		AdlibUnRegister()
		$iState = 2
		GUICtrlSetData($g_hPause, 'Continue')
	EndIf
EndFunc   ;==>_Pause

Func _Go()
	$iUx = $aOptVal[$OPT_U] * Cos(_Radian($aOptVal[$OPT_Theta]))
	$iUy = $aOptVal[$OPT_U] * Sin(_Radian($aOptVal[$OPT_Theta]))

	If Not _Range() Then Return

	_GDIPlus_GraphicsClear($hBk, 0xFFFFFFFF)

	$aOutVal[$OUT_T] = 0
	$aOutVal[$OUT_Sx] = 0
	$aOutVal[$OUT_Sy] = $aOptVal[$OPT_H]
	$aOutVal[$OUT_Vx] = $iUx
	$aOutVal[$OUT_Vy] = $iUy

	AdlibRegister('_Draw', $aOptVal[$OPT_TINC] * 1000)
	$iState = 1
	GUICtrlSetData($g_hRun, 'Stop')
	GUICtrlSetState($g_hPause, $GUI_SHOW)
EndFunc   ;==>_Go

Func _Draw()
	$aOutVal[$OUT_T] += $aOptVal[$OPT_TINC] * $aOptVal[$OPT_TMUL]
	$aOutVal[$OUT_Vy] -= $aOptVal[$OPT_G]
	$aOutVal[$OUT_Sy] = $aOptVal[$OPT_H] + ($iUy * $aOutVal[$OUT_T]) - ($aOptVal[$OPT_G] * ($aOutVal[$OUT_T] ^ 2)) / 2
	If $aOutVal[$OUT_Sy] <= 0 Then
		$aOutVal[$OUT_T] = ($iUy / $aOptVal[$OPT_G]) * 2
		$aOutVal[$OUT_Sy] = 0
		$aOutVal[$OUT_Sx] = $iRx
	Else
		$aOutVal[$OUT_Sx] += $aOptVal[$OPT_TINC] * $aOptVal[$OPT_TMUL] * $aOutVal[$OUT_Vx]
	EndIf

	For $i = 0 To $OUT_MAX - 1
		$s = $aOutName[$i] & '|' & Round($aOutVal[$i], 2) & ' ' & $aOutUnit[$i]
		If GUICtrlRead($aOutListItem[$i]) = $s Then ContinueLoop
		GUICtrlSetData($aOutListItem[$i], $s)
	Next

	_GDIPlus_GraphicsClear($hBuffer)
	_GDIPlus_GraphicsDrawImage($hBuffer, $hBmpBk, 0, 0)
	_DrawBall()
	_GDIPlus_GraphicsDrawImage($hGraph, $hBmpBuffer, 0, 0)

	If $aOutVal[$OUT_Sy] = 0 Then _Stop()
EndFunc   ;==>_Draw

Func _DrawBall()
	_GDIPlus_GraphicsDrawEllipse($hBuffer, Round($aOutVal[$OUT_Sx] * $iScale - 1), Round($aScreen[1] - $aOutVal[$OUT_Sy] * $iScale - 1), 2, 2, $penBlue)
	_GDIPlus_GraphicsDrawEllipse($hBk, Round($aOutVal[$OUT_Sx] * $iScale - 1), Round($aScreen[1] - $aOutVal[$OUT_Sy] * $iScale - 1), 1, 1, $penTrail)
EndFunc   ;==>_DrawBall

Func _Range()
	$g = $aOptVal[$OPT_G]

	$t = $iUy / $g
	$s = ($iUy * $t) - ($g * $t ^ 2) / 2 + $aOptVal[$OPT_H]
	$iScale = $aScreen[1] / $s
	GUICtrlSetData($hMaxHeight, '   Max Height|' & Round($s, 2) & ' m')

	$t *= 2
	$u = $iUy - $g * $t
	$s = -$aOptVal[$OPT_H]
	$t += (($u + Sqrt($u ^ 2 - 2 * $g * $s)) / $g)

	If $t / $aOptVal[$OPT_TMUL] > 60 * 1000 Then
		If MsgBox(52, 'Ummm...', 'Thats going to running for a while. Do you want to go back and set a higher time multiplier?') = 6 Then Return False
	EndIf

	$s = $iUx * $t

	$iRx = $s
	GUICtrlSetData($hRange, '   Range|' & Round($s, 2) & ' m')

	If $aScreen[0] / $s < $iScale Then $iScale = $aScreen[0] / $s

	GUICtrlSetData($hScale, '   Scale|' & Round($iScale, 2) & 'px : 1m')

	Return True
EndFunc   ;==>_Range