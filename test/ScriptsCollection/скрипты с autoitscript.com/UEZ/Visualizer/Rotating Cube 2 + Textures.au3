;coded by UEZ 2010
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "Rotating Cube 2 + Textures_Obfuscated.au3"
;~ #AutoIt3Wrapper_Run_After=upx.exe --best "%out%"
#AutoIt3Wrapper_Run_After=upx.exe --ultra-brute "%out%"
#include <Array.au3>
#include <GDIPlus.au3>
#Include <Memory.au3>

Opt('MustDeclareVars', 1)
Opt("GUIOnEventMode", 1)
Opt("MouseCoordMode", 1)

Local $b, $j, $k, $x, $y, $z, $mx, $my, $size, $start_x, $start_y, $mouse_pos, $mouse_sense
Local Const $Width = 800
Local Const $Height = 600

Local $hWnd = GUICreate("GDI+: Rotating Cube 2 with textures v0.85 Beta Build 2010-03-24 by UEZ 2010 (use mouse wheel to zoom)", $Width, $Height)

GUISetState()

If @OSBuild < 7600 Then WinSetTrans($hWnd,"", 0xFF) ;workaround for XP machines when alpha blending is activated on _GDIPlus_GraphicsClear() function to avoid slow drawing

#region GDI+ ini
_GDIPlus_Startup()
Local Const $tagGDIPCOLORMATRIX = "float m[25];"
Local $tColorMatrix, $pColorMatrix, $hIA
Local $hDC  = _WinAPI_GetWindowDC($hWnd)
Local $hGraphics = _GDIPlus_GraphicsCreateFromHDC($hDC)

Local $hBMP = _WinAPI_CreateBitmap($width, $height) ;create a dummy bitmap
Local $hImage = _GDIPlus_BitmapCreateFromHBITMAP($hBMP)
Local $hBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)

Local $hScrDC  = _WinAPI_GetDC(0)
Local $hDC_backbuffer  = _WinAPI_CreateCompatibleDC($hScrDC)
Local $DC_obj = _WinAPI_SelectObject($hDC_backbuffer, $hBitmap)
Local $hBackbuffer = _GDIPlus_GraphicsCreateFromHDC($hDC_backbuffer) ;create back buffer bitmap

_GDIPlus_GraphicsClear($hBackbuffer)
_GDIPlus_GraphicsSetSmoothingMode($hBackbuffer, 2)

$hIA = _GDIPlus_ImageAttributesCreate()
_GDIPlus_GraphicsSetInterpolationMode($hGraphics, 7)

Local $flag1 = Load_BMP_From_Mem(Flag_DE())
Local $flag2 = Load_BMP_From_Mem(Flag_GB())
Local $flag3 = Load_BMP_From_Mem(Flag_GR())
Local $flag4 = Load_BMP_From_Mem(Flag_JA())
Local $flag5 = Load_BMP_From_Mem(Flag_TR())
Local $flag6 = Load_BMP_From_Mem(Flag_US())

Local Const $iX1 = _GDIPlus_ImageGetWidth($flag1)
Local Const $iY1 = _GDIPlus_ImageGetHeight($flag1)
Local $hBMP1 = _GDIPlus_BitmapCreateFromGraphics($iX1, $iY1, $hGraphics)
Local $hBB1 = _GDIPlus_ImageGetGraphicsContext($hBMP1)

Local Const $iX2 = _GDIPlus_ImageGetWidth($flag2)
Local Const $iY2 = _GDIPlus_ImageGetHeight($flag2)
Local $hBMP2 = _GDIPlus_BitmapCreateFromGraphics($iX2, $iY2, $hGraphics)
Local $hBB2 = _GDIPlus_ImageGetGraphicsContext($hBMP2)

Local Const $iX3 = _GDIPlus_ImageGetWidth($flag3)
Local Const $iY3 = _GDIPlus_ImageGetHeight($flag3)
Local $hBMP3 = _GDIPlus_BitmapCreateFromGraphics($iX3, $iY3, $hGraphics)
Local $hBB3 = _GDIPlus_ImageGetGraphicsContext($hBMP3)

Local Const $iX4 = _GDIPlus_ImageGetWidth($flag4)
Local Const $iY4 = _GDIPlus_ImageGetHeight($flag4)
Local $hBMP4 = _GDIPlus_BitmapCreateFromGraphics($iX4, $iY4, $hGraphics)
Local $hBB4 = _GDIPlus_ImageGetGraphicsContext($hBMP4)

Local Const $iX5 = _GDIPlus_ImageGetWidth($flag5)
Local Const $iY5 = _GDIPlus_ImageGetHeight($flag5)
Local $hBMP5 = _GDIPlus_BitmapCreateFromGraphics($iX5, $iY5, $hGraphics)
Local $hBB5 = _GDIPlus_ImageGetGraphicsContext($hBMP5)

Local Const $iX6 = _GDIPlus_ImageGetWidth($flag6)
Local Const $iY6 = _GDIPlus_ImageGetHeight($flag6)
Local $hBMP6 = _GDIPlus_BitmapCreateFromGraphics($iX6, $iY6, $hGraphics)
Local $hBB6 = _GDIPlus_ImageGetGraphicsContext($hBMP6)

Local $hPen = _GDIPlus_PenCreate(0xF0000000, 2)
#endregion

#region Coordinates
Local Const $Pi = ACos(-1)
Local Const $Pi_Div_180 = $Pi / 180
Local Const $amout_of_dots = 14
Local $dot_distance = 150

Local $calc_coordinates[$amout_of_dots][3] = [ _;	X					y					Z
												[-$dot_distance, 	-$dot_distance, 	$dot_distance], _
												[$dot_distance, 	-$dot_distance,		$dot_distance], _
												[$dot_distance, 	$dot_distance, 		$dot_distance], _
												[-$dot_distance, 	$dot_distance, 		$dot_distance], _
												[-$dot_distance, 	-$dot_distance, 	-$dot_distance], _
												[$dot_distance, 	-$dot_distance,		-$dot_distance], _
												[$dot_distance, 	$dot_distance, 		-$dot_distance], _
												[-$dot_distance, 	$dot_distance, 		-$dot_distance]]
												;surface 1 mid point
												$calc_coordinates[08][0] = 0
												$calc_coordinates[08][1] = 0
												$calc_coordinates[08][2] = $dot_distance
												;surface 2 mid point
												$calc_coordinates[09][0] = 0
												$calc_coordinates[09][1] = -$dot_distance
												$calc_coordinates[09][2] = 0
												;surface 3 mid point
												$calc_coordinates[10][0] = $dot_distance
												$calc_coordinates[10][1] = 0
												$calc_coordinates[10][2] = 0
												;surface 4 mid point
												$calc_coordinates[11][0] = 0
												$calc_coordinates[11][1] = $dot_distance
												$calc_coordinates[11][2] = 0
												;surface 5 mid point
												$calc_coordinates[12][0] = -$dot_distance
												$calc_coordinates[12][1] = 0
												$calc_coordinates[12][2] = 0
												;surface 6 mid point
												$calc_coordinates[13][0] = 0
												$calc_coordinates[13][1] = 0
												$calc_coordinates[13][2] = -$dot_distance

;       4 -- - - - 5
;     / |        / |
;    0 - -  - - 1  |
;    |  |       |  |
;    |  7 -- - -|- 6
;    | /        | /
;    3 - -  - - 2
Local $size = 2
Local $distance = 1.0
Local Const $min_brightness = $dot_distance * 1.10
Local $zoom_counter = 100
Local Const $zoom_min = 50
Local Const $zoom_max = 150
$mouse_sense = 100
$start_x = $Width / 2
$start_y = $Height / 2
$j = 0
#endregion

Local $dx = @DesktopWidth * 0.5, $dy = @DesktopHeight * 0.5
MouseMove($dx, $dy, 1)

GUISetOnEvent(-3, "Close")

GUIRegisterMsg(0x020A, "WM_MOUSEWHEEL")

Do
	_GDIPlus_GraphicsClear($hBackbuffer, 0xFF506070)
	$mouse_pos = MouseGetPos()
	For $j = 0 To $amout_of_dots - 1
		Calc(-(-$dy + $mouse_pos[1]) / $mouse_sense, (-$dx + $mouse_pos[0]) / $mouse_sense, $j) ;calculate new coordinates
	Next
	Draw_Textures() ;draw lines to screen
	_WinAPI_BitBlt($hDC, 3, 23, $width, $height, $hDC_backbuffer, 0, 0, 0x00CC0020)
Until Not Sleep(50)

Func Draw_Textures()
	Local $p, $q, $brightness
	For $p =  8 To 13
		Switch $p
			Case 8 ;fill surface 1 (DE) -> front
				If $calc_coordinates[$p][2] > 0 Then
					$brightness = (($calc_coordinates[$p][2] - $dot_distance) / $min_brightness)
					Brightness_Image($flag1, $hBB1, $iX1, $iY1, $brightness)
					_GDIPlus_DrawImagePoints($hBackbuffer, $hBMP1,  $start_x + $calc_coordinates[1][0], $start_y + $calc_coordinates[1][1], _
																	$start_x + $calc_coordinates[0][0], $start_y + $calc_coordinates[0][1], _
																	$start_x + $calc_coordinates[2][0], $start_y + $calc_coordinates[2][1])
					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[0][0], $start_y + $calc_coordinates[0][1], _
															$start_x + $calc_coordinates[1][0], $start_y + $calc_coordinates[1][1], $hPen)
					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[1][0], $start_y + $calc_coordinates[1][1], _
															$start_x + $calc_coordinates[2][0], $start_y + $calc_coordinates[2][1], $hPen)
					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[2][0], $start_y + $calc_coordinates[2][1], _
															$start_x + $calc_coordinates[3][0], $start_y + $calc_coordinates[3][1], $hPen)
					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[3][0], $start_y + $calc_coordinates[3][1], _
															$start_x + $calc_coordinates[0][0], $start_y + $calc_coordinates[0][1], $hPen)
				EndIf

			Case 9 ;fill surface 2 (GB) -> top
				If $calc_coordinates[$p][2] > 0 Then
					$brightness = (($calc_coordinates[$p][2] - $dot_distance) / $min_brightness)
					Brightness_Image($flag2, $hBB2, $iX2, $iY2, $brightness)
					_GDIPlus_DrawImagePoints($hBackbuffer, $hBMP2,	$start_x + $calc_coordinates[5][0], $start_y + $calc_coordinates[5][1], _
																	$start_x + $calc_coordinates[4][0], $start_y + $calc_coordinates[4][1], _
																	$start_x + $calc_coordinates[1][0], $start_y + $calc_coordinates[1][1])
					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[0][0], $start_y + $calc_coordinates[0][1], _
															$start_x + $calc_coordinates[4][0], $start_y + $calc_coordinates[4][1], $hPen)
					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[4][0], $start_y + $calc_coordinates[4][1], _
															$start_x + $calc_coordinates[5][0], $start_y + $calc_coordinates[5][1], $hPen)
					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[5][0], $start_y + $calc_coordinates[5][1], _
															$start_x + $calc_coordinates[1][0], $start_y + $calc_coordinates[1][1], $hPen)
					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[1][0], $start_y + $calc_coordinates[1][1], _
															$start_x + $calc_coordinates[0][0], $start_y + $calc_coordinates[0][1], $hPen)
				EndIf
			Case 10 ;fill surface 3 (GR) -> right
				If $calc_coordinates[$p][2] > 0 Then
					$brightness = (($calc_coordinates[$p][2] - $dot_distance) / $min_brightness)
					Brightness_Image($flag3, $hBB3, $iX3, $iY3, $brightness)
					_GDIPlus_DrawImagePoints($hBackbuffer, $hBMP3,  $start_x + $calc_coordinates[5][0], $start_y + $calc_coordinates[5][1], _
																	$start_x + $calc_coordinates[1][0], $start_y + $calc_coordinates[1][1], _
																	$start_x + $calc_coordinates[6][0], $start_y + $calc_coordinates[6][1])
					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[1][0], $start_y + $calc_coordinates[1][1], _
															$start_x + $calc_coordinates[5][0], $start_y + $calc_coordinates[5][1], $hPen)
					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[5][0], $start_y + $calc_coordinates[5][1], _
															$start_x + $calc_coordinates[6][0], $start_y + $calc_coordinates[6][1], $hPen)
					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[6][0], $start_y + $calc_coordinates[6][1], _
															$start_x + $calc_coordinates[2][0], $start_y + $calc_coordinates[2][1], $hPen)
					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[2][0], $start_y + $calc_coordinates[2][1], _
															$start_x + $calc_coordinates[1][0], $start_y + $calc_coordinates[1][1], $hPen)
				EndIf
			Case 11 ;fill surface 4 (JA) -> bottom
				If $calc_coordinates[$p][2] > 0 Then
					$brightness = (($calc_coordinates[$p][2] - $dot_distance) / $min_brightness)
					Brightness_Image($flag4, $hBB4, $iX4, $iY4, $brightness)
					_GDIPlus_DrawImagePoints($hBackbuffer, $hBMP4,  $start_x + $calc_coordinates[2][0], $start_y + $calc_coordinates[2][1], _
																	$start_x + $calc_coordinates[6][0], $start_y + $calc_coordinates[6][1], _
																	$start_x + $calc_coordinates[3][0], $start_y + $calc_coordinates[3][1])
					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[2][0], $start_y + $calc_coordinates[2][1], _
															$start_x + $calc_coordinates[3][0], $start_y + $calc_coordinates[3][1], $hPen)
					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[3][0], $start_y + $calc_coordinates[3][1], _
															$start_x + $calc_coordinates[7][0], $start_y + $calc_coordinates[7][1], $hPen)
					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[7][0], $start_y + $calc_coordinates[7][1], _
															$start_x + $calc_coordinates[6][0], $start_y + $calc_coordinates[6][1], $hPen)
					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[6][0], $start_y + $calc_coordinates[6][1], _
															$start_x + $calc_coordinates[2][0], $start_y + $calc_coordinates[2][1], $hPen)
				EndIf
			Case 12 ;fill surface 5 (TR) -> left
				If $calc_coordinates[$p][2] > 0 Then
					$brightness = (($calc_coordinates[$p][2] - $dot_distance) / $min_brightness)
					Brightness_Image($flag5, $hBB5, $iX5, $iY5, $brightness)
					_GDIPlus_DrawImagePoints($hBackbuffer, $hBMP5,  $start_x + $calc_coordinates[4][0], $start_y + $calc_coordinates[4][1], _
																	$start_x + $calc_coordinates[0][0], $start_y + $calc_coordinates[0][1], _
																	$start_x + $calc_coordinates[7][0], $start_y + $calc_coordinates[7][1])
					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[0][0], $start_y + $calc_coordinates[0][1], _
															$start_x + $calc_coordinates[4][0], $start_y + $calc_coordinates[4][1], $hPen)
					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[4][0], $start_y + $calc_coordinates[4][1], _
															$start_x + $calc_coordinates[7][0], $start_y + $calc_coordinates[7][1], $hPen)
					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[7][0], $start_y + $calc_coordinates[7][1], _
															$start_x + $calc_coordinates[3][0], $start_y + $calc_coordinates[3][1], $hPen)
					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[3][0], $start_y + $calc_coordinates[3][1], _
															$start_x + $calc_coordinates[0][0], $start_y + $calc_coordinates[0][1], $hPen)
				EndIf

			Case 13 ;fill surface 6 (US) -> back
				If $calc_coordinates[$p][2] > 0 Then
					$brightness = (($calc_coordinates[$p][2] - $dot_distance) / $min_brightness)
					Brightness_Image($flag6, $hBB6, $iX6, $iY6, $brightness)
					_GDIPlus_DrawImagePoints($hBackbuffer, $hBMP6,  $start_x + $calc_coordinates[5][0], $start_y + $calc_coordinates[5][1], _
																	$start_x + $calc_coordinates[4][0], $start_y + $calc_coordinates[4][1], _
																	$start_x + $calc_coordinates[6][0], $start_y + $calc_coordinates[6][1])
					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[4][0], $start_y + $calc_coordinates[4][1], _
															$start_x + $calc_coordinates[5][0], $start_y + $calc_coordinates[5][1], $hPen)
					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[5][0], $start_y + $calc_coordinates[5][1], _
															$start_x + $calc_coordinates[6][0], $start_y + $calc_coordinates[6][1], $hPen)
					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[6][0], $start_y + $calc_coordinates[6][1], _
															$start_x + $calc_coordinates[7][0], $start_y + $calc_coordinates[7][1], $hPen)
					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[7][0], $start_y + $calc_coordinates[7][1], _
															$start_x + $calc_coordinates[4][0], $start_y + $calc_coordinates[4][1], $hPen)
				EndIf
		EndSwitch
	Next
EndFunc   ;==>Draw

Func Calc($angle_x, $angle_y, $i, $angle_z = 0)
;~ 	;calculate 3D rotation
;~ 	$x = ($calc_coordinates[$i][0] * Cos($angle_y * $Pi_Div_180)) + ($calc_coordinates[$i][2] * Sin($angle_y * $Pi_Div_180))
;~ 	$y = $calc_coordinates[$i][1]
;~ 	$z = (-$calc_coordinates[$i][0] * Sin($angle_y * $Pi_Div_180)) + ($calc_coordinates[$i][2] * Cos($angle_y * $Pi_Div_180))
;~ 	$calc_coordinates[$i][0] = $x
;~ 	$calc_coordinates[$i][1] = ($y * Cos($angle_x * $Pi_Div_180)) - ($z * Sin($angle_x * $Pi_Div_180))
;~ 	$calc_coordinates[$i][2] = ($y * Sin($angle_x * $Pi_Div_180)) + ($z * Cos($angle_x * $Pi_Div_180))
	Local $sx, $sy, $sz, $cx, $cy, $cz, $px, $py, $pz

	$sx = Sin($angle_x * $Pi_Div_180)
	$cx = Cos($angle_x * $Pi_Div_180)
	$sy = Sin($angle_y * $Pi_Div_180)
	$cy = Cos($angle_y * $Pi_Div_180)
	$sz = Sin($angle_z * $Pi_Div_180)
	$cz = Cos($angle_z * $Pi_Div_180)

	$px = $calc_coordinates[$i][0]
	$py = $calc_coordinates[$i][1]
	$pz = $calc_coordinates[$i][2]
	;rotation x-axis
	$calc_coordinates[$i][1] = $py * $cx - $pz * $sx
	$calc_coordinates[$i][2] = $py * $sx + $pz * $cx
	$py = $calc_coordinates[$i][1]
	$pz = $calc_coordinates[$i][2]
	;rotation y-axis
	$calc_coordinates[$i][0] = $px * $cy + $pz * $sy
	$calc_coordinates[$i][2] = -$px * $sy + $pz * $cy
	$px = $calc_coordinates[$i][0]
	;rotation z-axis
	$calc_coordinates[$i][0] = $px * $cz - $py * $sz
	$calc_coordinates[$i][1] = $py * $cz + $px * $sz
EndFunc   ;==>Calc

Func Close()
	_GDIPlus_ImageDispose($flag1)
	_GDIPlus_ImageDispose($flag2)
	_GDIPlus_ImageDispose($flag3)
	_GDIPlus_ImageDispose($flag4)
	_GDIPlus_ImageDispose($flag5)
	_GDIPlus_ImageDispose($flag6)
	_GDIPlus_BitmapDispose($hBMP1)
	_GDIPlus_GraphicsDispose($hBB1)
	_GDIPlus_BitmapDispose($hBMP2)
	_GDIPlus_GraphicsDispose($hBB2)
	_GDIPlus_BitmapDispose($hBMP3)
	_GDIPlus_GraphicsDispose($hBB3)
	_GDIPlus_BitmapDispose($hBMP4)
	_GDIPlus_GraphicsDispose($hBB4)
	_GDIPlus_BitmapDispose($hBMP5)
	_GDIPlus_GraphicsDispose($hBB5)
	_GDIPlus_BitmapDispose($hBMP6)
	_GDIPlus_GraphicsDispose($hBB6)
	_GDIPlus_PenDispose($hPen)
	_WinAPI_ReleaseDC($hWnd, $hDC)
	_GDIPlus_GraphicsDispose($hGraphics)
	_WinAPI_DeleteObject($hBMP)
	_GDIPlus_BitmapDispose($hImage)
	_WinAPI_DeleteObject($hBitmap)
	_WinAPI_ReleaseDC(0, $hScrDC)
	_WinAPI_SelectObject($hDC_backbuffer, $DC_obj)
	_GDIPlus_GraphicsDispose($hBackbuffer)
	_GDIPlus_Shutdown()
	Exit
EndFunc   ;==>Close

Func Zoom($factor)
	Local $m
	For $m = 0 To $amout_of_dots - 1
		$calc_coordinates[$m][0] *= $factor
		$calc_coordinates[$m][1] *= $factor
		$calc_coordinates[$m][2] *= $factor
	Next
EndFunc

Func WM_MOUSEWHEEL($hWnd, $iMsg, $wParam, $lParam)
	Local $wheel_Dir = BitAND($wParam, 0x800000)
	If $wheel_Dir > 0 Then
		If $zoom_counter <= $zoom_max Then
			Zoom(1.05)
			$zoom_counter += 1
		EndIf
	Else
		If $zoom_counter >= $zoom_min Then
			Zoom(0.95)
			$zoom_counter -= 1
		EndIf
	EndIf
    Return "GUI_RUNDEFMSG"
EndFunc   ;==>WM_MOUSEWHEEL

Func Load_BMP_From_Mem($pic) ;thanks to ProgAndy for mem allocation lines
	Local $memBitmap, $len, $tMem, $hImage, $hData, $pData, $hStream, $hBitmapFromStream
	$memBitmap = Binary($pic) ;load image  saved in variable (memory) and convert it to binary
    $len =  BinaryLen($memBitmap) ;get length of image

    $hData  = _MemGlobalAlloc($len, 0x0002) ;allocates movable memory  ($GMEM_MOVEABLE = 0x0002)
    $pData = _MemGlobalLock($hData)  ;translate the handle into a pointer
    $tMem =  DllStructCreate("byte[" & $len & "]", $pData) ;create struct
     DllStructSetData($tMem, 1, $memBitmap) ;fill struct with image data
    _MemGlobalUnlock($hData) ;decrements the lock count associated with a memory object that was allocated with GMEM_MOVEABLE

	$hStream = _WinAPI_CreateStreamOnHGlobal($pData) ;Creates a stream object that uses an HGLOBAL memory handle to store the stream contents
	$hBitmapFromStream = _GDIPlus_BitmapCreateFromStream($hStream) ;Creates a Bitmap object based on an IStream COM interface
	$tMem = ""
	Return $hBitmapFromStream
EndFunc

Func _WinAPI_CreateStreamOnHGlobal($hGlobal = 0, $fDeleteOnRelease = True)
	Local $aResult = DllCall("ole32.dll", "int", "CreateStreamOnHGlobal", "hwnd", $hGlobal, "int", $fDeleteOnRelease, "ptr*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return $aResult[3]
EndFunc   ;==>_WinAPI_CreateStreamOnHGlobal

Func _GDIPlus_BitmapCreateFromStream($pStream)
	Local $aResult = DllCall($ghGDIPDll, "uint", "GdipCreateBitmapFromStream", "ptr", $pStream, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return $aResult[2]
EndFunc   ;==>_GDIPlus_BitmapCreateFromStream

Func Brightness_Image($hSourceImg, $hDestIMG, $iX, $iY, $nBrightness = 0.0)
	$tColorMatrix = _GDIPlus_ColorMatrixCreate()
	$pColorMatrix = DllStructGetPtr($tColorMatrix)
    _GDIPlus_ColorMatrixTranslate($tColorMatrix, $nBrightness, $nBrightness, $nBrightness, 0, 1)
    _GDIPlus_ImageAttributesSetColorMatrix($hIA, 0, True, $pColorMatrix)
    _GDIPlus_GraphicsDrawImageRectRectIA($hDestIMG, $hSourceImg, 0, 0, $iX, $iY, 0, 0, $iX, $iY, $hIA)
EndFunc

Func _GDIPlus_ImageAttributesCreate()
	Local $aResult = DllCall($ghGDIPDll, "uint", "GdipCreateImageAttributes", "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return $aResult[1]
EndFunc   ;==>_GDIPlus_ImageAttributesCreate

Func _GDIPlus_GraphicsGetInterpolationMode($hGraphics)
	Local $aResult = DllCall($ghGDIPDll, "uint", "GdipGetInterpolationMode", "hwnd", $hGraphics, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return $aResult[2]
EndFunc   ;==>_GDIPlus_GraphicsGetInterpolationMode

Func _GDIPlus_GraphicsSetInterpolationMode($hGraphics, $iInterpolationMode)
	Local $aResult = DllCall($ghGDIPDll, "uint", "GdipSetInterpolationMode", "hwnd", $hGraphics, "int", $iInterpolationMode)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsSetInterpolationMode

Func _GDIPlus_ColorMatrixCreate()
	Return _GDIPlus_ColorMatrixCreateScale(1, 1, 1, 1)
EndFunc   ;==>_GDIPlus_ColorMatrixCreate

Func _GDIPlus_ColorMatrixCreateScale($nRed, $nGreen, $nBlue, $nAlpha = 1)
	Local $tCM
	$tCM = DllStructCreate($tagGDIPCOLORMATRIX)
	DllStructSetData($tCM, "m", $nRed, 1)
	DllStructSetData($tCM, "m", $nGreen, 7)
	DllStructSetData($tCM, "m", $nBlue, 13)
	DllStructSetData($tCM, "m", $nAlpha, 19)
	DllStructSetData($tCM, "m", 1, 25)
	Return $tCM
EndFunc   ;==>_GDIPlus_ColorMatrixCreateScale

Func _GDIPlus_ColorMatrixTranslate(ByRef $tCM, $nOffsetRed, $nOffsetGreen, $nOffsetBlue, $nOffsetAlpha = 0, $iOrder = 0)
	Local $tTranslateCM
	$tTranslateCM = _GDIPlus_ColorMatrixCreateTranslate($nOffsetRed, $nOffsetGreen, $nOffsetBlue, $nOffsetAlpha)
	_GDIPlus_ColorMatrixMultiply($tCM, $tTranslateCM, $iOrder)
EndFunc   ;==>_GDIPlus_ColorMatrixTranslate

Func _GDIPlus_ColorMatrixCreateTranslate($nRed, $nGreen, $nBlue, $nAlpha = 0)
	Local $iI, $tCM, $aFactors[4] = [$nRed, $nGreen, $nBlue, $nAlpha]
	$tCM = _GDIPlus_ColorMatrixCreate()
	For $iI = 0 To 3
		DllStructSetData($tCM, "m", $aFactors[$iI], 21 + $iI)
	Next
	Return $tCM
EndFunc   ;==>_GDIPlus_ColorMatrixCreateTranslate

Func _GDIPlus_ColorMatrixMultiply(ByRef $tCM1, $tCM2, $iOrder = 0)
	Local $iX, $iY, $iI, $iOffset, $nT, $tA, $tB, $tTmpCM

	If $iOrder Then
		$tA = $tCM2
		$tB = $tCM1
	Else
		$tA = $tCM1
		$tB = $tCM2
	EndIf
	$tTmpCM = DllStructCreate($tagGDIPCOLORMATRIX)
	For $iY = 0 To 4
		For $iX = 0 To 3
			$nT = 0
			For $iI = 0 To 4
				$nT += DllStructGetData($tB, "m", $iY * 5 + $iI + 1) * DllStructGetData($tA, "m", $iI * 5 + $iX + 1)
			Next
			DllStructSetData($tTmpCM, "m", $nT, $iY * 5 + $iX + 1)
		Next
	Next
	For $iY = 0 To 4
		For $iX = 0 To 3
			$iOffset = $iY * 5 + $iX + 1
			DllStructSetData($tCM1, "m", DllStructGetData($tTmpCM, "m", $iOffset), $iOffset)
		Next
	Next
EndFunc   ;==>_GDIPlus_ColorMatrixMultiply

Func _GDIPlus_ImageAttributesSetColorMatrix($hImageAttributes, $iColorAdjustType = 0, $fEnable = False, $pClrMatrix = 0, $pGrayMatrix = 0, $iColorMatrixFlags = 0)
	Local $aResult = DllCall($ghGDIPDll, "uint", "GdipSetImageAttributesColorMatrix", "hwnd", $hImageAttributes, "int", $iColorAdjustType, "int", $fEnable, "ptr", $pClrMatrix, "ptr", $pGrayMatrix, "int", $iColorMatrixFlags)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_ImageAttributesSetColorMatrix

Func _GDIPlus_GraphicsDrawImageRectRectIA($hGraphics, $hImage, $nSrcX, $nSrcY, $nSrcWidth, $nSrcHeight, $nDstX, $nDstY, $nDstWidth, $nDstHeight, $hImageAttributes = 0, $iUnit = 2)
	Local $aResult = DllCall($ghGDIPDll, "int", "GdipDrawImageRectRect", "hwnd", $hGraphics, "hwnd", $hImage, "float", $nDstX, "float", _
			$nDstY, "float", $nDstWidth, "float", $nDstHeight, "float", $nSrcX, "float", $nSrcY, "float", $nSrcWidth, "float", _
			$nSrcHeight, "int", $iUnit, "hwnd", $hImageAttributes, "int", 0, "int", 0)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc   ;==>_GDIPlus_GraphicsDrawImageRectRectIA

Func Flag_DE()
	Local $DE = '0x89504E470D0A1A0A0000000D49484452000001F40000014D02030000008B7D75A400000009504C5445000000FF0000FFBD189B383E42000000AB49444154785EECC03101000000C220FBA7B6C36E58'
		  $DE &= '0300000000000000000000000000676F8E090000601000ADE4FA57B1838F0F14E097EC25BBDD6EB7DBED76BBDD6EB7DBED76BBDD6EB7DBED76BBDD6EB7DBED76BBDD6EB7DBED76BBDD6EB7DBED76BBDD'
		  $DE &= '6EB7A7BD39260000804100B4FE5196D2101E3E50805FB237EC76BBDD6EB7DBED76BBDD6EB7DBED76BBDD6EB7DBED76BBDD6EB7DBED76BBDD6EB7DBED76BBDD6EB7DBED76BB3D42E7D6684A770B070000'
		  $DE &= '000049454E44AE426082'
	Return $DE
EndFunc

Func Flag_GR()
	Local $GR = '0x89504E470D0A1A0A0000000D49484452000001F40000013C01030000000CA3D11000000006504C54454242FFFFFFFF1B7F39620000009849444154785EECD9310A80300C40D1F424BDFFED3C40A1BA'
		  $GR &= '3909AD11C9F0FE1ADE1E92B8EBF36AC4BBF29EE7799EE779BECD858E6DCFF33CCFF33CFF3CCBFA58E943CFF33CCFF33C5F7EFFE2799EE7799EAFFFBFE2799EE7799ECFDF5FF8ED789EE7799EFF3B4992'
		  $GR &= 'A493DD3A26000080411836FF6A71C034F0A77FFEFAB7319EE7799EE7BF1D3826000000401864FFD4B6D8050B0100C0012A79D82A2AF1317E0000000049454E44AE426082'
	Return $GR
EndFunc

Func Flag_GB()
	Local $GB = '0x89504E470D0A1A0A0000000D49484452000001F40000014D0803000000C1CD6D050000004B504C5445F7F7F7DE5A5AC600000800B5D6D6EF3129BDCE0810DE6B6BF7E7E7D64A4A8C8CD64239C61808'
		$GB &= 'B5D63942EFD6D6CE1821EFC6C6DE7B7BBDB5E7CE29317B7BD6EFB5BDE7ADADCEC6EFE78C8C44023D120000098B49444154785EECD7D96A23411044D1A25BFBE27DFBFF2F1D2C3CD30F210643A9F2A220'
		$GB &= 'EA5D08E99037C9367DBFCD57D3F7B99EEFF9BD2CBFE43CFDFE9D978FBDCCF7FCD69F4DDFD7F4FDDADFDFFAD0F4BD05FD6EDF5BD3F7709EFEA1FF67D883EE34E69B6941FF793EB31E74815CFE85051D68'
		$GB &= '7CD081B20B7A41E383CE955DD081C6071D28BBA2171C6F41C70E354507167BD081752EE8058D0F3A577645071A1F74A0EC825ED0F8A0C36557F482E32DE8D8A1A6E8C0620F3AB0CE05BDA0F141E7CAAE'
		$GB &= 'E840E3830E945DD00B1A1F74B8EC8A5E70BC051D3BD4141D58EC4107D6B9A017343EE85CD9151D687CD081B20B7A41E3830E975DD10B8EB7A063879AA2038B3DE8C03A17F482C6079D2BBBA217343EE8'
		$GB &= '58D9157D3FC91BD0F8A0836557F4F6B1E99DF5B52BBAC5A1A6881FADB5DD7E2A58EC4147D6B9BEFDAE5D1ED0F8A03365DFB5E5018D0F3A52F6E5018D0F3A58F665D80B8EB7A043879A8E39B0D8834EAE'
		$GB &= '73A0F14187CB0E343EE86CD9B9C6079D2F3B70BC059D39D480C51E74729D038D0F3A5C76A0F14187CBCE353EE87CD981E32DE8CCA1062CF6A093EB1C687CD0E1B2F38D0F3A5FF603D0F8A0C3659F8F2B'
		$GB &= 'E0780B3A77A8AD8E6D9E4F0760B1079D5AE787D3DC2EDF03343EE848D94FF33CFFA0038D0F3A52F67941071A1F74A4EC0BFAE51D071F6F41070E351DF3051D58EC4107D6B9A057343EE864D9051D687C'
		$GB &= 'D081B20B7A45E3834E965DD18B8EB7A023879AA2038B3DE8C03A1774A0F141AF2BBBA2438D0FFAF5B23F0F28BBA28F6CFCEB53C7B0B3E84CD99F5E87955DD1471D6FD3F3B5610F3A30E6823E70B15F9F'
		$GB &= 'F5A0377DED75D03A5774B8F1FEE87CD9151D6FBC3F3A5F7645E71BEF8FCE975DD1071F6FD7677D6D89CECF79073ABAD87974A775AEE870E3FDD1F9B22B3ADE787F74BEEC8ACE37DE1F9D2FBBA2A3C79B'
		$GB &= '3B3A3FE68ACE2F767F747E9D2B3ADF786374BEEC8A6ED0781C9D2F7B3F3ADF781EDDAEEC8A6E70BC91E8FC9CF7A3F38B9D47775AE78A6ED0781C9D2F7B3F3ADF781EDDA9EC8A6ED0781C9D2F7B3F3A7F'
		$GB &= 'BCF1E84E63AEE8068B1D47E7D7793F3ADF781EDDA9EC8A6ED078001D2F3B804E369E47E7CB0EA0A3C71B8FCECF39808E2E761E9D5FE7003ADA781E9D2F3B800E369E47E7CB0EA0A38DE7D1F9B203E8E8'
		$GB &= 'F1C6A3F3630EA0338B9D41775AE78A3EBEF1DBEEC603E8E565DF8E2BBBA21734FEBDBBF1007A6DD91FDF07965DD12B1ABFED6E3C8BCE971D40EF3EDEDE1FBB8F37109D9F73089D5FEC183ABFCE3974BE'
		$GB &= 'F10C3A5F76149D6F3C804E971D47E71B0FA0C365E7D1F9E30D4087C79C47E7173B808EAF731E9D6F3C800E979D47E71B0FA0C365E7D1F9C603E874D97974FE7803D0E139E7D1F9C50EA0D3EB9C47E71B'
		$GB &= '0FA0D365E7D1F9C603E870D97974BEF1D5E87CD97974FE782B40371873413758EC05E806EB5CD00D1A3F00DDA5EC8A6ED0F8027483B20BBA41E307A05B955DD10D8EB701E82E73AEE8268B7D00BACD3A'
		$GB &= '57749BC60F403729BBA21B357E00BA45D915DDA9F103D06DCAAEE82EC7DBEDD09DC65CD1BD16FBCDD09DD6B9A2DB35FE36E84E655774BFC6DF04DDA9EC8A6ED8F85BA0DB955DD1CD8EB75537FACA69CE'
		$GB &= '15DD72B177A35BAD7345B76B7C3FBA5BD915DDAEF1FDE86E6557749FC6F7A3036507D12D8EB77E74BB31D7F7873D3A360110088200B8888189C9C1F5DFAA1D3C5CF03CC84C0B933A2E4B3DB131BD079E'
		$GB &= 'ACDC755AFE6E9E8E74A4231DE948473AD2918EF49D3EF6E8A00800000601D0CEFEA117C3875081CCA19E8E74A4231DE948473AD2912E1DE948473AD2918E74A4231DE948473AD2918E74A4235D3AD291'
		$GB &= '8E74A4231DE948473AD2918E74A4231DE948473ACFDE1DA3000C0251145C92140191B081DCFFAADE40B0508BCC1C609BD7EF8F853C04467444477444477444477444175DF43F8EE61BCD3F772BFDE6C7'
		$GB &= '809C183D076E3C5F74B4F6EB35A7AD200A827025634C78860001F6BFD2ECE04A163EAA51A7EF02FCC3A5F95AE7F4B0E4CF8EFE78CFC1F7EBF682BFFAED6594F797B70B7EE5F6F0B1DF3FFED7D11F4E87'
		$GB &= 'CFFCF765CF7C20BAF0D8D3A31F3E736E2FA1FD85F1E85CF2D67F1E0FBBFAD689917D207AAAF1A4CAFE79FA76F4D367A8F184CAFEBE5EBF1DFD75851A4FE6A1F6B9AE12FD26F3AD1339E7EFEB3AD1D77A'
		$GB &= '4F1C7612655FEB6AD1D70A349E40D9AF1B3DD078F264BF72F440E3093BD46ED640F4B4C74EDA9C0F448F1B76B2641F881E683C49B28F440F349E20D967A2071A4FCCA136123DF3AD9332E763D103879D'
		$GB &= '10D9E7A2071A4F82ECA3D1038D2740F6D9E881C61370A84D468F7CEC04CCF96CF4C0612740F6D9E881C61320FB6CF440E309907D367AA0F1041C6A83D133DF3A01733E1B3D70D809907D367AA0F104C8'
		$GB &= '3E1B3DD07802649F8D1E683C0187DA64F4C8C74EC09CCF460F1C7602649F8D1E683C01B2CF460F349E00D967A3071A4FC0A136183DF3AD1330E7B3D103879D00D967A3071ACFBCEC7C0CC82E44CF319E'
		$GB &= '79D9EF0664F7A2CF1BFF63DC78A60FB58FF3E0A1361FDD78ECE78FE1C7CEF09CDF0DCCB9103D6BD8D95E763BBA63FCDDA4F16C2EBB1F3DD0783697DD8F1E683C3B1F6A7EF4CCB7CEE673EE470F1C7636'
		$GB &= '97DD8F1E683C9BCBEE470F349ECD65F7A3071ACFD6879A1F3DF2B1B3F99CFBD103879DCD65F7A3071ACFE6B2FBD1038D6773D9FDE881C6B3F3A1E647CF7CEB6C3EE77EF4C0616773D9FDE881C6B3B9EC'
		$GB &= '7EF440E3D95C763F7AA0F16C7DA8F9D1231F3B9BCFB91F3D70D8D95C763F7AA0F1E8B2EF1E3DD0786CD9B78F1E683CEEA1B67BF4CCB78E3CE7FB470F1C7664D9F78F1E683C9AEC8DAE198F257BA37BC6'
		$GB &= '231D6A8D2E3E769C396F7473D89994FDE92079A37BC63327FBF9EB40F646178D674EF6E781672E44D78C7F1A339E8143EDE09DAF9CE8F36FFDEB3CF4D6999AF38177EE441787FDF96966D811646F74D9'
		$GB &= '7804D91B5D361E41F646978D4738D41AFDC2C77EEDE30D61CE1B5D1E7604D91B5D361E41F646978D4790BDD165E3110EB546978F3761CE1B5D1D7641F646178C17646F74CD785FF646F78D170EB54617'
		$GB &= '8E3761CE1BDD1E7643F646F78D17646F74DD7841F646D78D170EB546D78F3761CE1BDD1F7641F646F78D17646F74DD7841F646F78D170EB546D78F3761CE1B5D1F7643F646F78D17646F74DD7841F646'
		$GB &= 'B78D4738D41A5D3EDE10E6BCD1E5614790BDD165E311646F74D97804D91B5D361EE1506B74F9784398F34697871D41F646978D4790BDD165E311646F74D9788443ADD1E5E30D61CE1B5D1E7604D91B5D'
		$GB &= '361E41F646978D4790BDD165E3110EB546978F3784396F7479D811646F74D97804D91B5D361E41F646978D4738D41A5D3EDE10E6BCD1E5614790BDD165E311646F74D97804D91B5D361EE1506B74F978'
		$GB &= '4398F3469787FD1FFC18F07F64FE8C0E0000000049454E44AE426082'
	Return $GB
EndFunc

Func Flag_JA()
	Local $JA = '0x89504E470D0A1A0A0000000D49484452000001F40000014D0803000000C1CD6D050000005D504C5445FFFF00D6D60094940084840031310000000000B50010BD00101000CEF700EFFF0052CE0042C6'
    $JA &= '00EFEF0021BD009CE700BDEF0073D60031C600424200E7E70084DE00ADE700212100A5A500DEF700C6C6008CDE00525200737300B5B5000F8C81C80000095E49444154785EECDB496AC4301046E17F53'
    $JA &= '25CF43CF4392FB1F33BD30816C0C4E842DB5DF778542023D549A5579963056FABBA1F3FCA0D3BF54A3EF08E77C521E3C2738948AA06C3C176814CB33780E109E8AE7DE78FAD0DC1555F0D4A1576455ED'
    $JA &= '6943AD193CDF78A62DD0799A3068B29BB38E51B34835E498E5CE9E169C358354438E21D5906316E93D0108BDD654FBF650695D97E0DB42B8687D836F06DDA06D8C9E2D6E76520D398654438E9957FACA'
    $JA &= 'D0945A8054438E89A60FFE86C831496CC2A0AE14C3679B4DAA41500CADECFAD8D5F70ABE443DAEB297622F773C13FF2ACC4CF6621F6DE2A90607C5D09AFD0CDD8ADB0E520D39E6564C439F1C4F6FBEF6'
    $JA &= '468E391DCD7E0FDD8A543761F0CDDEB926350CC360304EBA601EE115A0509ADEFF981C804E3389842B7B3E5D6127F9B1A3957D36A2FACC1FE8C0D0ACAA918E1980B3D0D9A5260B28E998B4E33C7400C6'
    $JA &= '50FF78CDA78F81830BD05B54352A570E5C860E062F1BF1429156A2C69905E88EFF789BAAD1DCB95038020BD05B5335D2312C436F4DD548C7AC804EEE7DB237E1BB62A0D667564187D479CC966F5DE3B3'
    $JA &= '1135C10AE86DA81AE9982DD061F629A004B274AB34CEB0153A872A4B18952B7B0CD02B5535D23126E8E4537D5E562B5146E8401955A3E95C260306E8F5AA1AE9183B74725FD98522E9183B74987CB237'
    $JA &= 'D1FDCF402D4D60865ED52A95CA950E9CA103E10B28E9187FE8ECE396306A9530402FAB6A344F5EE58A017A53AA463AC60E3D66F6A67B41E3112CD0AB53357A4DEB1DB0416F53D548C7D8A1C394825F28'
    $JA &= '928EF1870EAA1D6DE316A8B9438FBD4AA5D7B41205A0072BA0A463CA4387F16AEF7EE935AD195CA1C757356A124FF8416F4BD548C7D8A1C7C9DE742FC8157A7C55231D03F8428FAF6AA463424087A1DC'
    $JA &= 'BB5FBA1714053AA9C8BB5F2A57761483AE552AFB4AD42F7BF7711B080C0531D449CE39A7DDFECBF4D115084F905903011D08CDE7842F5110FA2F77D0FD6AAB84A18FFF13D78EBDECE78340F7AA261DE3'
    $JA &= 'A17B55938EF1D0C77802DDAF066A003A5035E9180CDD2FA0D2311EFA3899B084E95E10804E544D35AD311474FF95AA2F51EB439FD0FD6AAB04A0A76A404D0B404FD5701DE3A1C3D95B3A667DE87FB7FB'
    $JA &= '05066A003A5135E9180FDD2FA0D2311E3AE87E6D54D322D05335BEA6B53E747FA1A82F511E3AE87E6D52D332D05335BEA6E5A1A76ABC8EF1D0FDECAD7B412B4207DDAF0D6A5A0A7AAA06E998FDA0CFEF'
    $JA &= '7EB555F2D041F76BCB9A96879EAAF13AC643F7178AFA12B51074D0FDDAB0A6E5A1A76ABC8EF1D097BA50948EF1D041F76B93819A87DE572A5DD3F2D05B40011DB32374DFFDF25B250F3D5533BFA61574'
    $JA &= 'A06AAC8E093A98BDE97B414107AAC6D6B4820E540DD5314107178AB48E093AE87ED99A56D0C1572A5AD3FA61EFBE6E140880200A626EF1DE9FCD3F4C32E0F7215D914209C4F6CE4C0FD0830DA8388E81'
    $JA &= '1EF47EB56D5AD083A8A66DD3821E4435E29800BD5C7BEBEF05410FA29AB84D0B7A10D5886302F47AACA6BC1704BDEAFDCADAB4A097A354CD4814F4B8F72BD855829EF77E056D5AD0FBA8268863A0E751'
    $JA &= '4D10C740CF7BBF8A0535E87D5413C431D0FB0DA8208E815EF77E05F782A0F7514DD0A6053D1FA50A46A2A0F7BD5FC1AE12F43EAA09DAB4A0E7514D10C740EFD7DE8238067ADDFB152CA8418FA39A208E'
    $JA &= '811E6F4005710CF4761326D85C811E4735419B16F438970D46A2A0A7BFF1419B16F438AA09DAB4A0C7514D10C7406FD7DE8238067ABC0913B469410FA29A208E811E6DC2F48F69D0FBDEAFA04D0B7A10'
    $JA &= 'D594DF73E8FD85A260240A7AD9FB15B46941EFA31A71CC6B74514D10C740CFB71DFB05B51EDD28D530FC03748F6FC1631AF4A0F72BD855820E1DBA9F77E8FEC805E81ED9A00B67A08B61A17BE102DDAB'
    $JA &= '55E88628A01B97826E3012BA1168E8961DA05B6B0AD02D3042B7AA0CDD5102E8CE8F40776808BA9362D01D0F84EE4C287407817B74A7BFA13BF20F5D9D0774C53DD055744157C6075DEDE6FBA32BD885'
    $JA &= 'AE4A1BBAD27CE8411CF3E2F35E510DF4277BF792A4300CC46058C04C1B1CC624BCE69DFB1F93252BCA0644A05AFD5DA1777F59092DC7D46D5720F8F88BA3DF6904C3606DB2C4DA1112CB95DE1A955EE1'
    $JA &= '2915C4724C5D3ABABF3BDC2F573ABB5606C35B1CFD7939C62A04530DF472CC996AAA81EB81DA6FB2DB24D25BAA38FA4BE518E55403D11C239D6AE0F47B4179B0FB0D6018E3E8132D578A31F43E973090'
    $JA &= '7812D54EE22915FC6D9572674C1D186671F40B40918CCB5FAA815E8E895483C83175C9D9EC0DDE066A8FB106C33E8EFEAC1C13A90691632A1C2EA0E0E5A9445FECD18A97250C9CFC4D2B5BB348351078'
    $JA &= '1255A1F7940A3EB64AD349A0D03DFA0E0CDF769D4835D0CB31916A1039A6157FF6267774E68BA8E981622975F4E589BDF3BA6D0006A218D3E4F4C4292E69FB8F991D7C0624E21E87D007A1779CA963A2'
    $JA &= '6A888E3901F9020A6D4D6B3B66736FED7E61DD24EEC6A944D5902F5105A4178A306E121FC73A1C85DD2F8C3A669488AAA19F8E89AAC13F509BCFA7ACFB856CB9F23656E4CED5FDA29F8E89AA41B5555A'
    $JA &= '99ADA7FB85E765DF8CB5D969D68EF4D3315135E44B5401E985221435ADCDB0A05035F4D331513544C714905E28423050D360E97E21A8699D997CA5223AA6DF020AC156C980AAFB85A0A67566A26AE8A7'
    $JA &= '63A26AB0DD0BAA93D91BB69A569DA81AFAE998A81AA2630A482F1421A869097075BFB0D5B4EAE42B15FD744C1650086A5A025CDD2F6C35AD3A5135F4D331513508EE05097075BFE8A763A26AE8A763A2'
    $JA &= '6A10DC0B12E0EA7E21A869097075BFE8F7252A5FA9C856A980B4FB85A0A625C0D5FDA29F8E89AAA19F8EC9852232502B20ED7ED14FC744D53043C7FCB7771F36964451084419EFBD37BBF9873961A02F'
    $JA &= '0E39744BAF04B7BACF340BA8B8175448D9FB95864DAB1BA8267B952855AA14B64A52F67EA560D32A07AAC91E8E816AB28763CCDE52B06949D9FB953D1C03D5640FC75840A560D392B2F72B059B563950'
    $JA &= '4DF62A512E14A560D392B2F72B059B5639504DF6700C5493C2404DCADEAF146C5A52F67E650FC74035B155DAF37EA560D392B2F72B7B3806AAC95E25CA85A2146C5A52F67E650FC74035D9C3312E14C5'
    $JA &= '406DCFFB953D9B962A55F6708C0554F6B64ABC5FD9FBB343357B3806AA59BB1764F6B667D3826AF6700C543387635C28B25CB18419B069A952C13116506C5AFEF1876DD3826AE018A8C6BD20B3373806'
    $JA &= 'AA8163A09A43AF4A58C2B069F17EF9CE55A96C9578BF0E72B9220F700C5403C74035066ABC5F700C5473E8CF34CFB7BD7B41726FB9E25B578952A5FA031B6EBF6B5A7202730000000049454E44AE4260'
    $JA &= '82'
	Return $JA
EndFunc

Func Flag_TR()
	Local $TR = '0x89504E470D0A1A0A0000000D4948445200000200000001800803000000ECFE2A8D0000014D504C5445DC0204F48284EC424CFCC2C4E42224EC6264F4A2A4FCE2E4E43234E4121CEC7274EC525CF4B2'
    $TR &= 'B4F49294FCD2D4FCF2F4E42634E43644EC7A7CE41A1CF4BABCEC4A54F48A8CFCCACCFCEAECEC5A64F49A9CFCDADCE42E34EC6A74F4AAACFCFAFCEC3E44EC7A84E41E2CF4BAC4E4222CE4323CEC727CE4'
    $TR &= '1A24EC4A5CFCCAD4EC7E84E4020CF4828CEC4654EC626CF4A2ACFCE6ECE41624EC5664F4B2BCF4929CFCD6DCFCF6FCE42A34EC3A44F48A94FCEEF4EC5E6CF49AA4FCDEE4E42E3CF4BEC4E4262CE4363C'
    $TR &= 'EC767CE40204EC464CFCC6CCFCE6E4E4161CEC565CFCD6D4FCF6F4EC3644E41E1CFCBABCEC4E54FCCECCFCEEECEC5E64FCDEDCE40E14EC6E74F4AEB4FCFEFCEC3E4CF47A84EC323CE41E24EC4E5CFCCE'
    $TR &= 'D4E40E1CF47E84F4868CEC666CF4A6ACF4B6BCF4969CEC2A34F48E94F49EA4EC2E3CFCBEC4EC262CF4767CE40A14E40614E40214E40A1C785651F000000C9049444154785EECD2A11100201003C1EF37'
    $TR &= '0FFD4B1014C1C0AECA445FE56B54100002400008000120000480001000024000080001200004800010000240000800012000048000100002400008000120000480001000024000080001200004800010'
    $TR &= '0002B88000100002400008000120000480001000024000080001200004800010000240000800012000048000100002400008000120000480001000024000080001200004800010000240000800012000'
    $TR &= '048000100002985BD2DDE3D8F3BC8F13C062EF5EDFA238B2388EFF822E84C032E4A272591C64B96CF69084D9608644312E8701829B288A274641B904743DA7FBFF7FB90968E23E68D23533DD53CD9CCF'
    $TR &= '3B785BDFA9EE9EA9AE4A533562C62B7C0200BFFA33D1F39B8107600903004DFFB8F5DECDC1C672E52B39B5B930F47DEFE5894B3F2B0030999E2F1EC0EBCFFDEE8DFDB5AAFC917BDFAED44F2BD054CF09'
    $TR &= '0F801848EA2FC725A3EA61CF0300645A7A1E8011800F0F972550E5CB0D2A79031E40AAC4E0A5863469648F01B6544BC9033006F7F44A4B1A5B0A262D1F0F8080FEFDAAB4EE6E4FF91E0C3C000626C7A5'
    $TR &= '5DB6096C5A161E8011786553DAE978BA2C097800C6CC87D2769FD64A91800740E059C9C5E05CF4097800042C4A6E1AFD20D3687900C658955CCD334823E501309E5F97BCED457A1DF00012605F0A70BF'
    $TR &= '06D2E878008CC9AA14E325601A150FC0C09F4861BEA98334221E00A32E859A8DE94EC003607C2D051B329846C1034840E3D21ED5C6D8A3D1A5DB17FF3337F7F1C58BCF7FD83E3A589077E80169043C00'
    $TR &= 'C28CB46EAD31BFC438C1BFC1A9A9BD87CB5539E329583BCE03605C9316EDAC4C2A0026333DCB880170FDC69987CC0B0CD3CEF200B8D587FF833B0C30D91FAD074F532506B8FF5955DEB4A01D2EC00360'
    $TR &= 'BE202D18FC0C60324D33AD2C4E18A81D2DC81B3AFA3CE801186C4D9A767D95C1A4418C81A963F9DD40E70AF0000CEBD2B487DAD4E2FF541306B62BF2DA68A70AF0000CD3D2ACF956167919014FBE9357'
    $TR &= '3EE84C011E80A12E4D9A65B0692B08787F4D4E5DEB44011E80E1B634E79041A6AD4A80271539B1F296021C229DFFAFEE82B52D08F8BC530578004DDEFF8DD4C1A6ED42E0ABF2ABAD820BF000D8A419CF'
    $TR &= '00D33632464F457EB181448BE30130AF49B8BE75B0B659025E945F4CC2B4281E00E185845B049BB61F9D2E44DD8516C40320F44AB84990E622015F11A9106B213C00C34712EC3A23D1BC301E890C81B4'
    $TR &= '081E008625586FF0F41F7E193842A2F9F3009824D804587395A026B205D3BC7900847109B501D29C19A822D3AC39F3000CF3126AB888B9D998FB8449F3E501E0B6849A82691198175EE49C9A07C02CA1'
    $TR &= '6A302D06F3C8044CF3E30124389040BBC50D49CA7C708B343F1E006624D0344C8BC3B50932CD8B0740D89430C3302D120FDF21CD890760F842C20CC0B458549BD39C78003C2C013AB458CB52CD870740'
    $TR &= 'D8912063202D5EBAABB9F000B02441EE83F5FCF0000812C6582364641E4053702441FE0D8D50CA034C1E40138825C818922803C0DD43980710CC785B42DC036B8C52DC9429F600729F00E6A0514AF14F'
    $TR &= '59007900A1B02821E661F1062063200F20D709A002D28803900D98071004131262151A750042EC0184208C48800692C803D801790001784642286BE401C865980790996148022CC2A20F4066E0016495'
    $TR &= 'B24A888435FE0084D903C80AC712600C5686000E401E402E0B8198B50C01C804CC03C8847F9200CFA0E508401EB3079009FE2A0194CB12C032C80368FB428003585902902FB214E001705D02CCB09626'
    $TR &= '007992ADD6D428E9E200F077C96E1356A2008438DBBE94D335EBDA00124880BF40CB13C09FEE2A91A64600FE51E94BBA368094FF2B0140A509E04FBF124E95005A3A10911A77EF2500F361B780E50A40'
    $TR &= 'EAB077CFFCBCD7905F7D06EDDA000C3B92DD0FD0920520CC6F9BF919C0689F9C3A02756F00441280A874019CFD4AD818A86D5D91D746C0DABD01F063C96E0756BA006416A6AFA56A0C245FF7C91B7659'
    $TR &= 'BB39803DC9EE25D2F20520FDACAF240C3C98B827FF6794AD9B034043B2232E63007DA0D7A33F7CB4266FB94474710006C9AE0AD31206205741C48CF543396B93594B091DB8073C86963200B903D49FCA'
    $TR &= '5BDD82767300295F92ECEE70490390879BEFBCABB1EE0E004792DD032A4500017640DAE501EC4866154ECE5B00C4DADD01184624B30BB07316C024B4B450FC2B618B48CF5700379174790029F74B76A3'
    $TR &= '25086037208011B0767D00B724BBE71C7900A9268C6DC96A1DDAF501E09264679107600CCC8D2E4846FF62F3003021D981E2FEECC32E8F48669F807C51A8E2A964B6098D55C2C0C7DB15095065560F40'
    $TR &= '312699DDC76EB4A3FF7C6C41C2FC0CF50054312899BD882F80548919EB3725D8359807A06AB822991D4717003178E6489A30C4A4BFF0007859327B8454A3911A3130795095330216367800E893CCF690'
    $TR &= 'C633F303FCB7ABD2AC1FD9F4840770AF7C5F041A013C3A28CD3B06E9290F6053321B401AC7E8E3D290B4E21E583D80F0D7C256A308607A7E4D5A44500FC003F000FC12E001F84D60B706E08F811E807F'
    $TR &= '11E401F857C15D1C80FF18E401F8CFC11E802F08E9E2007C499807E08B42BB3A005F16EE01F88B2161FCD5B0A8F9AB61FE72A8BF1CEAAF87FBEBE1BE41846F10E15BC4F81631BE49946F12E5DBC4F936'
    $TR &= '71BE51A46F14E95BC5FA56B1BE59B46F16EDDBC5FB76F17E60841F18E147C6F891317E68941F1AE5C7C6F9B1717E70A41F1CE947C7FAD1B17E78B41F1EEDC7C77B00FC930478569A001EB366E1011036'
    $TR &= '250073390298807900D9E058028CC1A20E20F4573E0F206595100997210066F50032320C49804558FC01CC403D80CC78464228471FC0659807901D6144023490441EC00E483D8000989010AB883C0062'
    $TR &= '0DE101104B880A28EA0036601E40182C4A887958C4018C81D403C8750A9039C41BC042F8F87B00C6DBE762B7CD1437658AD503C87D0A1843126700770F611E4013702441FE8D2803E001266D82074090'
    $TR &= '30C61A2123530FA029589220F7C17A8E7800841D09D0A9A7AD745773E101280F4B986B1D28C052CD890760F842C20CC0B458549BD39C78004AD89430C30517C0C37748F3E201286624D074A105706D82'
    $TR &= '4C73E30124389040BBC51590321FDC22CD8F07A0CC12AA565801CC23392FF4F40014B725D414ACA0F15F78814473E50118E625D47011C362CC7DC2A4F9F20094302EA136409A330355649A356F1E8032'
    $TR &= '49B009B0E62A414D640BA6B9F30014C312AC176C9A1FC2AAC811122D800760F848825DE71C8787F1E8EC5E0F1E406E08BD126E32AF014AC057442AC45A0C0F40092F24DC22D8F29AFE4576A145F10094'
    $TR &= '794DC2F5AD8373F8F82F9ECE2FA685F100944D9AF10CED1D2763F4544E1F34132D9007A05897668CD4DB791D20F055F9D516480BE50118A6A5295777C1DA16047C2E27560A1F7F0F400DB7A539870C32'
    $TR &= '6D55023CA9746EFC3D0035D4A549B3DCEA858080F7D702169E7900B95E05C2CD530B0918014FBE93573EE8D0F87B006A5897A63D543069DADC29D06F1C043EDAB1F1F700D4606BD2B4EBAB0C50F8F9CF'
    $TR &= '53C7F2BB810E8EBF07A0CA7C415A30F819C064592682542D61A076B4206FA87776FC3D0065EC4B4B0EEE30C06469FAEE0AD2548901EE7F5695372D284C3BCA0350C63569D1CECAA4026032D3B38C1800'
    $TR &= 'D76F9C29ED02777EFC3D0025CC48EBD61AF34B8C13FC1B9C9ADA7BB85C95339E82B5F33C004D40E3D21ED5C6D8A3D1A5DB171FCFCD7D7CF1E2F31FB68F0E16E41D7A401A030F4095F1B5146CC8601A09'
    $TR &= '0F40197529D42CD8341A1E801AF81329CC37B13DFD7900AA8CC9AA14E325601A190F4013605F0A70BF06D2F87800AA8CE7D7256F7BD15EFD3D0035C6AAE46A9E411A2B0F40958045C94DA31F641A310F'
    $TR &= '4095C0B3928BC1B912CCFE1E801A331F4ADB7D5A0B1A7E07ED1823F0CAA6B4D3F174E0F03B68273130392EEDB24DC1C3EFA09D4540FF7E555A77B7074CA6811CB4D38CC13DBDD292C6968249CBC803D0'
    $TR &= '5489C14B0D69D2C81E036CA936C141A36004E0C3C3650954F97283D0C253BF8346831848EA2FC725A3EA61CF039C9FD1F7003455236660F7C6FE5A55FEC8BD6F57EA00C0A4A9B6C24163630903004DFF'
    $TR &= 'B8F5DECDC1C672E52B39B5B930F47DEFE5894B3F2B8036DDF23B6884D2548D18AFF10900FCEACF44D354DBC2416395FE42D5CC9257CCECF4BFFF63978E0900808120069DDFF8DF6BA2DB8306FA877508'
    $TR &= '0220000220000220000B01100001100001100001100001100001100001100001100001100001100001100001100001100001100001100001100001100001100001100001100001100001100001100001'
    $TR &= '1000011000011000011000011000011000011000011000011000011000011000011000011000011000011000011000011000011000011080D66B070E0A000000088869231CFDDF829C15EC22A3DD006D'
    $TR &= 'C9FFE2A3FE019E0000000049454E44AE426082'
	Return $TR
EndFunc

Func Flag_US()
	Local $US = '0x89504E470D0A1A0A0000000D49484452000001F40000014D0803000000C1CD6D0500000039504C5445F7F7F7DE7B7B0800B5D6D6EF8C8CD6635ACE3129BD2118BD1808B5E7E7F7524AC6ADADDE9C9C'
    $US &= 'DECEC6EF736BCE4239C6BDB5E77B7BD6C60000D6255814000008B949444154785EEC97D9AAE33010050F47BBBC25F3FF1F3B0C8E5018E1DB2D6EF2E4AEA740844B7459D8066FCB9FDB62D16F8545BF13'
    $US &= '16DDA2DF038B6ED12DBA45B7E8815A02D5C4F88DAB86DFF82D7A273A6A71FA92DE5362DE4FF71BBF45EF38A8FBC0A94B029498F77B4CF8E365748B1EA14F0944751E50C984DFCDF83D3B167D180FF4C7'
    $US &= 'C76BF3CC4447FC86DF5D46B7E84E1FDD034E9D07511FDD7FDA4F8C1BB0E824F3F18F0000C709AF384E1C80A05ABA0258CF9F8923CDDF36E0A6FD9917A4F37F0058BBDFA2376AC13B89D7A40D1D94CA6B'
    $US &= '3C3AC219AE78674B1FF113E3062CFA384A390FA9A933DE4B853F32E1F7E84CF82B1B16BDE187E9C8A3F414489B787BCCFB59D1F0F37E8B3E8E122E519D92323859496D4AD9CFE6AF145947BF45EFA4D7'
    $US &= '91A0CC7CF427259A1F13FE4891FD3FBF451F265900ECAA41165D9F243F7CE7FDC46BE936EDB7E8C378F6BC009B2A4FDE8BA6E40EB8188594B37E025872692965FFD6FD16FD9D802D9254A4CC400964DC'
    $US &= 'E4925CB066D22B5286734D2872C9DCFCD8653F32997DF75BF40E1764924C72CAD05E85FD43CE53DB0B7F16F3F8730372C9D0FC7848FEF62DD0FD16BD934BE5C97391F23CF9A2482543AB921F81174CFB'
    $US &= 'D916F028A23F0D7E8B7E4B2CBA4CA29ACA2F90E2C7FD7FD939A3DD8461188A5A6E48523AA7DBFFFFEC3675A80209DD037B8CEF2B528FE118C4C3956DDE38CBE07A16C7E12647711ACD4FE92CC1F51856'
    $US &= 'D9B8C9E0ABA4F9291DA571936158E5C0269BF101243FA55393D4CF30ECA7F1E64B181F40F3533A49E326C3B0CA814D36BE9E1E909FD245F1A4F0E68B81E64B3D5E0FD87C39F8C6F8D793BFBF273DA587'
    $US &= 'DDE779D5BD17BBCF20BD8623DB73E9AFF0E900295DA4283B67EE552E7C9706E65B17C50EB21E29DD659AF278A63C78441BD2153F9847CE4FE9B878625BA7CD97B5F2E6CD0003703E2AE3A5749D0B6DC3'
    $US &= 'B9F7F3274165E3CD970BE71B1920A5733D0BDF8F0AF4F012D5C6F9EC6DA574FEE934BC1F83EB09BE1F9CFF7FE929FDB37BDF58F36577F701FC1CDFF11A6082ED97EF9DF197DD7DAC829FD2656CB81F25'
    $US &= '26FD8FEBE8368012D5DF5FF15EF404ABDDF84DF3BBFFA486E0A774916BF5232D5C6419EEB044F5D16F8F6F8A1FF5C61F94EF829FD245EA3B4D87DD719AE277FC54C84FE9D325A54F7C7326A59F292FD5'
    $US &= '156816EC87F3BDDA3BFC943EE1A1A1943EE1A1A1943EE1A1A1943EE3CD9994FE74F3D72B6FBE147D51441FA3288F0338E7F3EACF373BF78E84300C4351D42609091F8BCFFE17CB50A98B9EEB77B50179'
    $US &= '3874D1DCDCDF6D87D090D5101AF2194243A0D39C013DE47385BD4DA30F9967E67378C8FF8F013AA121C321346433848640A739037AFA5DE51B95A342DF8B2399627FF980F9FDA05B8D293AA121D00D43'
    $US &= '43A05B3667409726DAAAF3C89443968CA63FA0DA0FBA61680874C3D010E886A121D07D9B33A08B3F65A829AAB215B2D63AB95F7E80B41F74C3D010E886A121D00D4343A0BB35677474D06FF72529CF79'
    $US &= '3E79F952F1BC43F2D9FEFB5F8BB8BF1D0FD0CFC73834D46DE7C7CEDDE3300803511046C63F090984DCFFB229ACAD52EC434AAA377B00D6E2A3A0B086D090CB101A029DE60CE8ADA8D38A3CBDFFE3A9ED'
    $US &= 'DA7ED0090D190EA121A72134043ACD19D0571DBDCA375F7A486AE8F5A7FB03B8834E68C80899D010E886A121D04D9B33A07FBFCA55C88F5C6FCE3C4B512987DE9CD9D49B37B11F74C3D010E886A121D0'
    $US &= '0D4343A0DB3667408F79CC4BE823A76CF12B5CCF9C678B1FFE5BCA53E70172C916FB9733FF3CE601623FE87EA121D02D4343A0DB0DE896CD19D0B5D9759E45A61CBAE4AE7F4AD97ED00D4343A01B8786'
    $US &= '3EEC9DBB0EC23010041124C1E03C80FFFF582A1A5BD1AE6977AE77D6BA39A53A8D3F01856808E8386780AEB715940CA2B49B2FBBBFF952CFA18FE4AB0B001DD1505A211A023AA221A0E39C017AF53B39'
    $US &= 'DB24CBC55FA2AA7E7EAA7306D110D0110D011DD110D0239D334097B5FCF3BACE71F54FA9FC627FD5CC077A5C013D503404F440D110D0139D3340EFDBE3A3F47798261FFA40FE6D247F02FAAF02454340'
    $US &= '0F140D013D503404F450E70CD0FB56EA5FACA4D3CF927E4FA7CD376749E537E301F440D110D003454340FFB277C7BA0AC340104523DE8B1D1363E0FF7F16096D4731434135771BCA451C45B8B06E080D'
    $US &= '850DCD19D0EBE759755DC2E039D69092F5CAECD634A5BFBFCCCE6314A5DE5F751AD0090D050CA121D0090D819E35A0EBE9177BAEBF10EACDDF0F3AA121D0090D814E6808F4A4E60CE89A676B2E8F4DB9'
    $US &= '6CC9FECD1F91DA0F7A606808F4C0D010E881A121D0239B33A0EB991F8FB9BAF9324A4750BA3CD3DF6F5CC6033D3034047A606808F4C0D010E891CD19D0F5D473BB8F4D9FB8CEF7A77189AA8EE2C7BFFE'
    $US &= '06B577D794B30E7B4DD469404F0B0D819E181A02FDC5CEB9E3201003512C84906581E577FFC3528F90A299DA769D680AB74FEE584E586CCE00F9973E4A73852CE7849FF2FDD96AF7956E680888A12120'
    $US &= '868688D89C517A6F91FD965FBE8CD5622D5B92192DB217EEE7A73F4A373404C3D010104343246CCE283DF04CCF15B656967EF405D5FBBD30813CC27DA50343434A078686940E6CCE281DD89C89D2957E'
    $US &= '4DCF6566F8B4644B8C646AF7E383FA7DA503513A10A503513A10A503513A10A563F99103070200000008C30AE1F9C306F24D2B6855EBECC03101000000C220FBA7B6C60E580A00000000000000000000'
    $US &= '00C0D9A3031A0000180440CFF0FE61ADE12654E0E750958E74A4231DE948473AD2A5231DE948473AD2918E74A4231DE948473AD2918E74A41376E098000000006190FD535B63072C0500000000000000'
    $US &= '00000000E0ECC0010D00000040B0E95F5A104ECE64DF8E09000000100699C1FE61ADE10115762F3D82970DD1111DD1111DD1115D744447744447744447744447744447744447744447744447743276E0'
    $US &= '800600000020D8F42F2D082767B203C7040000000883EC9FDA1A3B60290000000000000000000000006FDF8E09000000100699C1FE618DE1031576AF4F78D9101DD1111DD1111DD1115D744447744447'
    $US &= '744447744447744447744447744447744447740614191E23736EF6450000000049454E44AE426082'
	Return $US
EndFunc