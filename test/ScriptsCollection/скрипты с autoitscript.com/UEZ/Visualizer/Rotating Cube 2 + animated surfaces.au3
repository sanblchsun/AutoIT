;coded by UEZ 2010
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "Rotating Cube 2 + animated surfaces_Obfuscated.au3"
;~ #AutoIt3Wrapper_Run_After=upx.exe --best "%out%"
#AutoIt3Wrapper_Run_After=upx.exe --ultra-brute "%out%"
#include <Array.au3>
#include <GDIPlus.au3>
#Include <Memory.au3>
#include <String.au3>

Opt('MustDeclareVars', 1)
Opt("GUIOnEventMode", 1)
Opt("MouseCoordMode", 1)

Local Const $Width = 800
Local Const $Height = 600

Local $hwnd = GUICreate("GDI+: Rotating Cube 2 with animated surfaces v0.60 Beta Build 2010-03-15 by UEZ 2010 (use mouse wheel to zoom)", $Width, $Height)

GUISetState()

If @OSBuild < 7600 Then WinSetTrans($hwnd,"", 0xFF) ;workaround for XP machines when alpha blending is activated on _GDIPlus_GraphicsClear() function to avoid slow drawing

_GDIPlus_Startup()
Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hwnd)
Local $hBitmap = _GDIPlus_BitmapCreateFromGraphics($Width, $Height, $hGraphics)
Local $hBackbuffer = _GDIPlus_ImageGetGraphicsContext($hBitmap)
_GDIPlus_GraphicsClear($hBackbuffer)
_GDIPlus_GraphicsSetSmoothingMode($hBackbuffer, 2)
Local $hPen = _GDIPlus_PenCreate(0xF0000000, 2)

Local $b, $j, $x, $y, $z, $mx, $my, $size, $start_x, $start_y, $mouse_pos, $mouse_sense
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
Local $zoom_counter = 100
Local $zoom_min = 50
Local $zoom_max = 150
$mouse_sense = 100
$start_x = $Width / 2
$start_y = $Height / 2
$j = 0

#region Demo1
Local Const $max_dots = 30
Local Const $max_speed = 6
Local Const $iWidth = 10
Local Const $iHeight = 10
Local Const $width_D1 = 300
Local Const $height_D1 = 300
Local $hBrush_Clear_D1 = _GDIPlus_BrushCreateSolid(0xFFF0FFE0)
Local $hImage_D1 = _GDIPlus_BitmapCreateFromGraphics($width_D1, $height_D1, $hGraphics)
Local $hImage_BB_D1 = _GDIPlus_ImageGetGraphicsContext($hImage_D1)
_GDIPlus_GraphicsSetSmoothingMode($hImage_BB_D1, 2)
Dim $coordinates[$max_dots][5], $angle_D1
Dim $hBrush[$max_dots]
Initialize()
#endregion

#region Demo2
Local Const $width_D2 = 300
Local Const $height_D2 = $width_D2
Local $hImage_D2 = _GDIPlus_BitmapCreateFromGraphics($width_D2, $height_D2, $hGraphics)
Local $hImage_BB_D2 = _GDIPlus_ImageGetGraphicsContext($hImage_D2)
_GDIPlus_GraphicsSetSmoothingMode($hImage_BB_D2, 2)
Local $xcoord1_D2, $ycoord1_D2, $xcoord2_D2, $ycoord2_D2, $size_D2, $red_D2, $green_D2, $blue_D2
Local $i_D2 = -500
Local $l = $i_D2
Local $starting_point_D2 = 0
Local $min_size_D2 = 10
Local $Brush1_D2 = _GDIPlus_BrushCreateSolid(0)
Local $Brush2_D2 = _GDIPlus_BrushCreateSolid(0)
#endregion

#region Demo3
Local Const $width_D3 = 300
Local Const $height_D3 = $width_D3
Local $hImage_D3 = _GDIPlus_BitmapCreateFromGraphics($width_D3, $height_D3, $hGraphics)
Local $hImage_BB_D3 = _GDIPlus_ImageGetGraphicsContext($hImage_D3)
_GDIPlus_GraphicsSetSmoothingMode($hImage_BB_D3, 2)
Local $Pen_D3 = _GDIPlus_PenCreate(0, 1)
Local $red_D3, $green_D3, $blue_D3
Local $start_D3 = -25
Local $i_D3 = $start_D3
Local $starting_point_D3 = 0
#endregion

#region Demo4
Local Const $width_D4 = 300
Local Const $height_D4 = $width_D3
Local $hImage_D4 = _GDIPlus_BitmapCreateFromGraphics($width_D4, $height_D4, $hGraphics)
Local $hImage_BB_D4 = _GDIPlus_ImageGetGraphicsContext($hImage_D4)
_GDIPlus_GraphicsSetSmoothingMode($hImage_BB_D4, 2)
Local $fontsize_txt1_D4 = 32
Local $fontsize_txt2_D4 = 12
Local $i_D4 = 0, $j_D4 = 360, $m_D4 = 0, $n_D4 = 0
Local $width_mul_045_D4 = $width_D4 * 0.45
Local $height_mul_045_D4 = $height_D4 * 0.45
Local $radius_x1_D4 = ($width_mul_045_D4) * 0.95
Local $radius_y1_D4 = ($height_mul_045_D4) * 0.95
Local $radius_x2_D4 = ($width_mul_045_D4) * 0.45
Local $radius_y2_D4 = ($height_mul_045_D4) * 0.45
Local $text1_D4 = _StringReverse(" Rotating Letters using GDI+")
Local $text2_D4 = " By UEZ '09 ;-)"
Local $arrTxt1_D4 = StringSplit($text1_D4, "")
Local $arrTxt2_D4 = StringSplit($text2_D4, "")
Dim $arrX1_D4[UBound($arrTxt1_D4)]
Dim $arrY1_D4[UBound($arrTxt1_D4)]
Dim $arrX2_D4[UBound($arrTxt2_D4)]
Dim $arrY2_D4[UBound($arrTxt2_D4)]
Dim $brush1_D4[UBound($arrTxt1_D4)]
Dim $brush2_D4[UBound($arrTxt2_D4)]

Local $r_D4 = 1
Local $c_D4 = (255 / UBound($arrTxt1_D4) - 1) * 2 - 1
Local $r_D4 = 0x80
Local $g_D4 = 0xA0
Local $b_D4 = $c_D4
Local $brush_color_D4
For $k = 0 To UBound($arrTxt1_D4) - 1
	$brush_color_D4 = "0xFF" & Hex($r_D4, 2) & Hex($g_D4, 2) & Hex($b_D4, 2)
	$brush1_D4[$k] = _GDIPlus_BrushCreateSolid($brush_color_D4)
	If $r_D4 = 1 Then
		$b_D4 += $c_D4
	Else
		$b_D4 -= $c_D4
	EndIf
	If $b_D4 >= 255 Then $r_D4 = 0
	If $b_D4 <= $c_D4 Then $r_D4 = 1
Next

For $k = 0 To (UBound($arrTxt2_D4) - 1)
	$brush_color_D4 = 0xFF808080
	$brush2_D4[$k] = _GDIPlus_BrushCreateSolid($brush_color_D4)
Next
_GDIPlus_BrushSetSolidColor($brush2_D4[0], 0xFFD08020)
_GDIPlus_BrushSetSolidColor($brush2_D4[1], 0xFFFFA060)
_GDIPlus_BrushSetSolidColor($brush2_D4[2], 0xFFD08020)

Local $hFormat_D4 = _GDIPlus_StringFormatCreate()
Local $hFamily1_D4 = _GDIPlus_FontFamilyCreate("Arial")
Local $hFamily2_D4 = _GDIPlus_FontFamilyCreate("Comic Sans MS")
Local $hFont1_D4 = _GDIPlus_FontCreate($hFamily1_D4, $fontsize_txt1_D4, 2)
Local $hFont2_D4 = _GDIPlus_FontCreate($hFamily2_D4, $fontsize_txt2_D4, 2)
Local $tLayout_D4 = _GDIPlus_RectFCreate(0, 0)
Local $a_D4 = 360 / (UBound($arrTxt1_D4) - 1)
Local $b_D4 = 360 / (UBound($arrTxt2_D4) - 1)
Local $y_D4 = 0
#endregion

#region Demo5
Local Const $width_D5 = 300
Local Const $height_D5 = $width_D5
Local $hImage_D5 = _GDIPlus_BitmapCreateFromGraphics($width_D5, $height_D5, $hGraphics)
Local $hImage_BB_D5 = _GDIPlus_ImageGetGraphicsContext($hImage_D5)
_GDIPlus_GraphicsSetSmoothingMode($hImage_BB_D5, 2)
_GDIPlus_GraphicsClear($hImage_BB_D5, 0xFF000000)
Local Const $pi_Div_60 = $Pi / 60
Local Const $pi_Mul_4 = $Pi * 4
Local $Pen_D5, $Brush_D5, $ellipse_size_D5, $ellipse_size_double_D5
Local $i_D5, $k_D5 = 0, $xcoord_D5, $ycoord_D5, $red_D5, $green_D5, $blue_D5
Local $x1_D5, $x2_D5, $x3_D5, $x4_D5, $y1_D5, $y2_D5, $y3_D5, $y4_D5
$Pen_D5 = _GDIPlus_PenCreate(0, 2)
$Brush_D5 = _GDIPlus_BrushCreateSolid(0xFF000000)
$ellipse_size_D5 = 1.025
$ellipse_size_double_D5 = $ellipse_size_D5 * 2
$i_D5 = 1
#endregion

#region Demo6
Local Const $width_D6 = 300
Local Const $height_D6 = $width_D6
Local Const $font_size_D6 = Int(($width_D6 + $height_D6) / 16)
Local $tLayout_D6
Local Const $height_div_2_D6 = $height_D6 * 0.5
Local Const $width_div_2_D6 = $width_D6 * 0.5
Local $hImage_D6 = _GDIPlus_BitmapCreateFromGraphics($width_D6, $height_D6, $hGraphics)
Local $hImage_BB_D6 = _GDIPlus_ImageGetGraphicsContext($hImage_D6)
_GDIPlus_GraphicsSetSmoothingMode($hImage_BB_D6, 2)
Local $hFormat_D6  = _GDIPlus_StringFormatCreate()
Local $hFamily_D6  = _GDIPlus_FontFamilyCreate("Arial")
Local $hFont_D6  = _GDIPlus_FontCreate($hFamily_D6, $font_size_D6, 2)
Local $pen_D6  = _GDIPlus_PenCreate(0)
Local $brush_D6  = _GDIPlus_BrushCreateSolid(0)
Local $text_color_D6 = 0xA0F0F0FF
$brush_D6 = _GDIPlus_HatchBrushCreate(39, $text_color_D6)
Local $letter_distance_D6 = $font_size_D6
Local $lenght_D6 = $font_size_D6 * 1.666 * 0.36
Local $k_D6 = $width_D6
Local $end_D6 = 0
Local $text_scroller_D6 = "Welcome to GDI+ rotating cube with my GDI+ examples on each surface! You can use your mouse wheel to zoom cube ;-)    Have fun!            "
Local $scroller_length_D6 = StringLen($text_scroller_D6) * $lenght_D6
Local $y_D6 = -($font_size_D6 * 0.2) + ($height_div_2_D6 - $font_size_D6 * 0.5)
$tLayout_D6 = _GDIPlus_RectFCreate(0, 0)
#endregion

MouseMove(@DesktopWidth * 0.5, @DesktopHeight * 0.5, 0)

GUISetOnEvent(-3, "Close")

GUIRegisterMsg(0x020A, "WM_MOUSEWHEEL")


Do
	_GDIPlus_GraphicsClear($hBackbuffer, 0xFF506070)
	$mouse_pos = MouseGetPos()
	For $j = 0 To $amout_of_dots - 1
		Calc(-(-@DesktopHeight * 0.5 + $mouse_pos[1]) / $mouse_sense, (-@DesktopWidth * 0.5 + $mouse_pos[0]) / $mouse_sense, $j) ;calculate new coordinates
	Next
	Draw_Lines() ;draw lines to screen
	_GDIPlus_GraphicsDrawImageRect($hGraphics, $hBitmap, 0, 0, $Width, $Height)
Until Not Sleep(10)

Func Draw_Lines()
	Local $p, $q
	For $p =  8 To 13
		Switch $p
			Case 8  ;fill surface 1 -> front
				If $calc_coordinates[$p][2] > 0 Then
					Demo6()
					_GDIPlus_DrawImagePoints($hBackbuffer, $hImage_D6,  $start_x + $calc_coordinates[0][0], $start_y + $calc_coordinates[0][1], _
																		$start_x + $calc_coordinates[1][0], $start_y + $calc_coordinates[1][1], _
																		$start_x + $calc_coordinates[3][0], $start_y + $calc_coordinates[3][1])
;~ 					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[0][0], $start_y + $calc_coordinates[0][1], _
;~ 															$start_x + $calc_coordinates[1][0], $start_y + $calc_coordinates[1][1], $hPen)
;~ 					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[1][0], $start_y + $calc_coordinates[1][1], _
;~ 															$start_x + $calc_coordinates[2][0], $start_y + $calc_coordinates[2][1], $hPen)
;~ 					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[2][0], $start_y + $calc_coordinates[2][1], _
;~ 															$start_x + $calc_coordinates[3][0], $start_y + $calc_coordinates[3][1], $hPen)
;~ 					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[3][0], $start_y + $calc_coordinates[3][1], _
;~ 															$start_x + $calc_coordinates[0][0], $start_y + $calc_coordinates[0][1], $hPen)
				EndIf

			Case 9	;fill surface 2 -> top
				If $calc_coordinates[$p][2] > 0 Then
					Demo2()
					_GDIPlus_DrawImagePoints($hBackbuffer, $hImage_D2, 	$start_x + $calc_coordinates[4][0], $start_y + $calc_coordinates[4][1], _
																		$start_x + $calc_coordinates[5][0], $start_y + $calc_coordinates[5][1], _
																		$start_x + $calc_coordinates[0][0], $start_y + $calc_coordinates[0][1])
;~ 					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[0][0], $start_y + $calc_coordinates[0][1], _
;~ 															$start_x + $calc_coordinates[4][0], $start_y + $calc_coordinates[4][1], $hPen)
;~ 					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[4][0], $start_y + $calc_coordinates[4][1], _
;~ 															$start_x + $calc_coordinates[5][0], $start_y + $calc_coordinates[5][1], $hPen)
;~ 					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[5][0], $start_y + $calc_coordinates[5][1], _
;~ 															$start_x + $calc_coordinates[1][0], $start_y + $calc_coordinates[1][1], $hPen)
;~ 					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[1][0], $start_y + $calc_coordinates[1][1], _
;~ 															$start_x + $calc_coordinates[0][0], $start_y + $calc_coordinates[0][1], $hPen)
				EndIf
			Case 10 ;fill surface 3 -> right
				If $calc_coordinates[$p][2] > 0 Then
					Demo3()
					_GDIPlus_DrawImagePoints($hBackbuffer, $hImage_D3,  $start_x + $calc_coordinates[5][0], $start_y + $calc_coordinates[5][1], _
																		$start_x + $calc_coordinates[1][0], $start_y + $calc_coordinates[1][1], _
																		$start_x + $calc_coordinates[6][0], $start_y + $calc_coordinates[6][1])
;~ 					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[1][0], $start_y + $calc_coordinates[1][1], _
;~ 															$start_x + $calc_coordinates[5][0], $start_y + $calc_coordinates[5][1], $hPen)
;~ 					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[5][0], $start_y + $calc_coordinates[5][1], _
;~ 															$start_x + $calc_coordinates[6][0], $start_y + $calc_coordinates[6][1], $hPen)
;~ 					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[6][0], $start_y + $calc_coordinates[6][1], _
;~ 															$start_x + $calc_coordinates[2][0], $start_y + $calc_coordinates[2][1], $hPen)
;~ 					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[2][0], $start_y + $calc_coordinates[2][1], _
;~ 															$start_x + $calc_coordinates[1][0], $start_y + $calc_coordinates[1][1], $hPen)
				EndIf
			Case 11 ;fill surface 4 -> bottom
				If $calc_coordinates[$p][2] > 0 Then
					Demo4()
					_GDIPlus_DrawImagePoints($hBackbuffer, $hImage_D4,  $start_x + $calc_coordinates[3][0], $start_y + $calc_coordinates[3][1], _
																		$start_x + $calc_coordinates[2][0], $start_y + $calc_coordinates[2][1], _
																		$start_x + $calc_coordinates[7][0], $start_y + $calc_coordinates[7][1])
;~ 					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[2][0], $start_y + $calc_coordinates[2][1], _
;~ 															$start_x + $calc_coordinates[3][0], $start_y + $calc_coordinates[3][1], $hPen)
;~ 					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[3][0], $start_y + $calc_coordinates[3][1], _
;~ 															$start_x + $calc_coordinates[7][0], $start_y + $calc_coordinates[7][1], $hPen)
;~ 					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[7][0], $start_y + $calc_coordinates[7][1], _
;~ 															$start_x + $calc_coordinates[6][0], $start_y + $calc_coordinates[6][1], $hPen)
;~ 					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[6][0], $start_y + $calc_coordinates[6][1], _
;~ 															$start_x + $calc_coordinates[2][0], $start_y + $calc_coordinates[2][1], $hPen)
				EndIf
			Case 12 ;fill surface 5 -> left
				If $calc_coordinates[$p][2] > 0 Then
					Demo5()
					_GDIPlus_DrawImagePoints($hBackbuffer, $hImage_D5,  $start_x + $calc_coordinates[4][0], $start_y + $calc_coordinates[4][1], _
																		$start_x + $calc_coordinates[0][0], $start_y + $calc_coordinates[0][1], _
																		$start_x + $calc_coordinates[7][0], $start_y + $calc_coordinates[7][1])
;~ 					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[0][0], $start_y + $calc_coordinates[0][1], _
;~ 															$start_x + $calc_coordinates[4][0], $start_y + $calc_coordinates[4][1], $hPen)
;~ 					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[4][0], $start_y + $calc_coordinates[4][1], _
;~ 															$start_x + $calc_coordinates[7][0], $start_y + $calc_coordinates[7][1], $hPen)
;~ 					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[7][0], $start_y + $calc_coordinates[7][1], _
;~ 															$start_x + $calc_coordinates[3][0], $start_y + $calc_coordinates[3][1], $hPen)
;~ 					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[3][0], $start_y + $calc_coordinates[3][1], _
;~ 															$start_x + $calc_coordinates[0][0], $start_y + $calc_coordinates[0][1], $hPen)
				EndIf

			Case 13 ;fill surface 6 -> back
				If $calc_coordinates[$p][2] > 0 Then
					Demo1()
					_GDIPlus_DrawImagePoints($hBackbuffer, $hImage_D1,  $start_x + $calc_coordinates[5][0], $start_y + $calc_coordinates[5][1], _
																		$start_x + $calc_coordinates[4][0], $start_y + $calc_coordinates[4][1], _
																		$start_x + $calc_coordinates[6][0], $start_y + $calc_coordinates[6][1])
;~ 					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[4][0], $start_y + $calc_coordinates[4][1], _
;~ 															$start_x + $calc_coordinates[5][0], $start_y + $calc_coordinates[5][1], $hPen)
;~ 					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[5][0], $start_y + $calc_coordinates[5][1], _
;~ 															$start_x + $calc_coordinates[6][0], $start_y + $calc_coordinates[6][1], $hPen)
;~ 					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[6][0], $start_y + $calc_coordinates[6][1], _
;~ 															$start_x + $calc_coordinates[7][0], $start_y + $calc_coordinates[7][1], $hPen)
;~ 					_GDIPlus_GraphicsDrawLine($hBackbuffer, $start_x + $calc_coordinates[7][0], $start_y + $calc_coordinates[7][1], _
;~ 															$start_x + $calc_coordinates[4][0], $start_y + $calc_coordinates[4][1], $hPen)
				EndIf
		EndSwitch
	Next
EndFunc   ;==>Draw

Func Calc($angle_x, $angle_y, $i)
	;calculate 3D rotation
	$x = ($calc_coordinates[$i][0] * Cos($angle_y * $Pi_Div_180)) + ($calc_coordinates[$i][2] * Sin($angle_y * $Pi_Div_180))
	$y = $calc_coordinates[$i][1]
	$z = (-$calc_coordinates[$i][0] * Sin($angle_y * $Pi_Div_180)) + ($calc_coordinates[$i][2] * Cos($angle_y * $Pi_Div_180))
	$calc_coordinates[$i][0] = $x
	$calc_coordinates[$i][1] = ($y * Cos($angle_x * $Pi_Div_180)) - ($z * Sin($angle_x * $Pi_Div_180))
	$calc_coordinates[$i][2] = ($y * Sin($angle_x * $Pi_Div_180)) + ($z * Cos($angle_x * $Pi_Div_180))
EndFunc   ;==>Calc

Func Close()
	Close_Demo1()
	Close_Demo2()
	Close_Demo3()
	Close_Demo4()
	Close_Demo5()
	Close_Demo6()
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_BitmapDispose($hBitmap)
	_GDIPlus_GraphicsDispose($hBackbuffer)
	_GDIPlus_GraphicsDispose($hGraphics)
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

#region Demo1
Func Demo1()
	Draw_Dots()
	Calculate_New_Position()
EndFunc

Func Initialize()
	Local $k
	For $k = 0 To $max_dots - 1
		$hBrush[$k] = _GDIPlus_BrushCreateSolid(Random(0xA0101010, 0xA0808080, 1))
		New_Coordinates($k)
	Next
EndFunc   ;==>Initialize

Func Draw_Dots()
	Local $i
	_GDIPlus_GraphicsFillRect($hImage_BB_D1, 0, 0, $width_D1, $height_D1, $hBrush_Clear_D1)
	For $i = 0 To $max_dots - 1
		_GDIPlus_GraphicsFillEllipse($hImage_BB_D1, $coordinates[$i][0], $coordinates[$i][1], $iWidth, $iHeight, $hBrush[$i])
	Next
EndFunc   ;==>Draw_Dots

Func New_Coordinates($k)
	$coordinates[$k][0] = $width_D1 / 2
	$coordinates[$k][1] = $height_D1 / 2
	$coordinates[$k][2] = Random(1, $max_speed, 1)
	$angle_D1 = Random(0, 359, 0)
	$coordinates[$k][3] = $coordinates[$k][2] * Cos($angle_D1 * $Pi_Div_180)
	$coordinates[$k][4] = $coordinates[$k][2] * Sin($angle_D1 * $Pi_Div_180)
EndFunc   ;==>New_Coordinates

Func Calculate_New_Position()
	Local $k
	For $k = 0 To $max_dots - 1
		$coordinates[$k][0] += $coordinates[$k][3] ;increase x coordinate with appropriate slope
		$coordinates[$k][1] += $coordinates[$k][4] ;increase y coordinate with appropriate slope
		If $coordinates[$k][0] <= 0 Then ;border collision x left
			$coordinates[$k][0] = 1
			$coordinates[$k][3] *= -1
		ElseIf $coordinates[$k][0] >= $width_D1 - $iWidth Then ;border collision x right
			$coordinates[$k][0] = $width_D1 - ($iWidth + 1)
			$coordinates[$k][3] *= -1
		EndIf
		If $coordinates[$k][1] <= 0 Then ;border collision y top
			$coordinates[$k][1] = 1
			$coordinates[$k][4] *= -1
		ElseIf $coordinates[$k][1] >= $height_D1 - $iHeight Then ;border collision y bottom
			$coordinates[$k][1] = $height_D1 - ($iHeight + 1)
			$coordinates[$k][4] *= -1
		EndIf
	Next
EndFunc   ;==>Calculate_New_Position

Func Close_Demo1()
	Local $k
	For $k = 0 To $max_dots - 1
		_GDIPlus_BrushDispose($hBrush[$k])
	Next
	_GDIPlus_BrushDispose($hBrush_Clear_D1)
	_GDIPlus_BitmapDispose($hImage_D1)
	_GDIPlus_GraphicsDispose($hImage_BB_D1)
EndFunc
#endregion

#region Demo2
Func Demo2()
	Local $k, $j, $x
	_GDIPlus_GraphicsClear($hImage_BB_D2, 0xFFFFFFFF) ;clear buffer
    $k = 1024 ;2^12
    $starting_point_D2 -= 0.05
    For $j = 0 To $k Step 64
        $red_D2 = ((Sin(2 * ($i_D2 + $j) / 1024) + 1) * 0.5) * 256
        $green_D2 = ((Sin(4 * ($i_D2 + $j) / 512) + 1) * 0.5) * 256
        $blue_D2 = ((Sin(8 * ($i_D2 + $j) / 256) + 1) * 0.5) * 256
        _GDIPlus_BrushSetSolidColor($Brush1_D2, "0xCF" & Hex($red_D2, 2) & Hex($green_D2, 2) & Hex($blue_D2, 2))
        _GDIPlus_BrushSetSolidColor($Brush2_D2, "0xCF" & Hex($blue_D2, 2) & Hex($red_D2, 2) & Hex($green_D2, 2))
		$size_D2 = $i_D2 - $j
        $xcoord1_D2 = $width_D2 * 0.5 - (($i_D2 - $j) / 2) + Sin($starting_point_D2) * -Sin(($i_D2 - $j) * $Pi / 90) * 64
        $ycoord1_D2 = $height_D2 * 0.5 - (($i_D2 - $j) / 2) + -Cos($starting_point_D2) * Cos(($i_D2 - $j) * $Pi / 90) * 32
		_GDIPlus_GraphicsFillEllipse($hImage_BB_D2, $xcoord1_D2, $ycoord1_D2, $size_D2 / 6, $size_D2 / 6, $Brush1_D2)
        $xcoord2_D2 = $width_D2 * 0.5 - (-($i_D2 - $j) / -1.75) - Sin($starting_point_D2) * Sin(($i_D2 - $j) * $Pi / 120) * 32
        $ycoord2_D2 = $height_D2 * 0.5 - (($i_D2 - $j) / -1.75) - Cos($starting_point_D2) * Cos(($i_D2 - $j) * $Pi / 75) * 16
        _GDIPlus_GraphicsFillEllipse($hImage_BB_D2, $xcoord2_D2, $ycoord2_D2, $size_D2 * 0.125 , $size_D2 * 0.125, $Brush2_D2)
    Next
    $i_D2 += 3
    If $i_D2 > $k + Abs($l) Then $i_D2 = $l
EndFunc

Func Close_Demo2()
	_GDIPlus_BrushDispose($Brush1_D2)
	_GDIPlus_BrushDispose($Brush2_D2)
	_GDIPlus_BitmapDispose($hImage_D2)
	_GDIPlus_GraphicsDispose($hImage_BB_D2)
EndFunc
#endregion

#region Demo3
Func Demo3()
	Local $k, $j, $size_D3, $xcoord_D3, $ycoord_D3
    _GDIPlus_GraphicsClear($hImage_BB_D3, 0xFF000000)
    $k = 256
    $starting_point_D3 -= 0.025
    For $j = $k To 0 Step -16
		$red_D3 = ((Sin(($j - $i_D3) / 32) + 1) * 0.5) * 256
		$green_D3 = ((Sin(($j - $i_D3) / 128) + 1) * 0.5) * 256
		$blue_D3 = ((Sin(($j - $i_D3) / 512) + 1) * 0.5) * 256
		_GDIPlus_PenSetColor($Pen_D3, "0xEF" & Hex($red_D3, 2) & Hex($green_D3, 2) & Hex($blue_D3, 2))
		$size_D3 = $i_D3 - $j
        $xcoord_D3 = $width_D3 * 0.5 - (($i_D3 - $j) * 0.5) + Sin($starting_point_D3) * -Sin(($i_D3 - $j) * $Pi_Div_180) * 64
        $ycoord_D3 = $height_D3 * 0.5 - (($i_D3 - $j) * 0.5) + -Cos($starting_point_D3) * Cos(($i_D3 - $j) * $Pi_Div_180) * 32
        _GDIPlus_GraphicsDrawRect($hImage_BB_D3, $xcoord_D3, $ycoord_D3, $size_D3, $size_D3, $Pen_D3)
    Next
    $i_D3 += 2
    If $i_D3 > $k + 512 Then $i_D3 = $start_D3
EndFunc

Func Close_Demo3()
	_GDIPlus_PenDispose($Pen_D3)
	_GDIPlus_BitmapDispose($hImage_D3)
	_GDIPlus_GraphicsDispose($hImage_BB_D3)
EndFunc
#endregion

#region Demo4
Func Demo4()
	Local $x, $x1, $x2, $y1, $y2
	_GDIPlus_GraphicsClear($hImage_BB_D4, 0xFF000000)
	For $x = 1 To UBound($arrTxt1_D4) - 1
		$x1 = $width_mul_045_D4 + Cos(($i_D4 + $m_D4) * $pi_div_180) * $radius_x1_D4
		$y1 = $height_mul_045_D4 + Sin(($i_D4 + $m_D4) * $pi_div_180) * $radius_y1_D4 - $fontsize_txt1_D4 * 0.25
		$arrX1_D4[$x] = $x1
		$arrY1_D4[$x] = $y1
		DllStructSetData($tLayout_D4, "x", $arrX1_D4[$x])
		DllStructSetData($tLayout_D4, "y", $arrY1_D4[$x])
		_GDIPlus_GraphicsDrawStringEx($hImage_BB_D4, $arrTxt1_D4[$x], $hFont1_D4, $tLayout_D4, $hFormat_D4, $brush1_D4[$x])
		$m_D4 += $a_D4
	Next
	For $x = 1 To UBound($arrTxt2_D4) - 1
		$x2 = $width_mul_045_D4 + Cos(($j_D4 + $n_D4) * $pi_div_180) * $radius_x2_D4 * Cos($y_D4 * $pi_div_180)
		$y2 = $height_mul_045_D4 + Sin(($j_D4 + $n_D4) * $pi_div_180) * $radius_y2_D4 - $fontsize_txt2_D4 * 0.25
		$arrX2_D4[$x] = $x2
		$arrY2_D4[$x] = $y2
		DllStructSetData($tLayout_D4, "x", $arrX2_D4[$x])
		DllStructSetData($tLayout_D4, "y", $arrY2_D4[$x])
		_GDIPlus_GraphicsDrawStringEx($hImage_BB_D4, $arrTxt2_D4[$x], $hFont2_D4, $tLayout_D4, $hFormat_D4, $brush2_D4[$x])
		$n_D4 += $b_D4
	Next
	If Mod($y_D4, 2) = 1 Then Array_Rot($brush2_D4, 1)
	$y_D4 += 1
	$i_D4 += 1
	If $i_D4 >= 360 Then
		$i_D4 = 0
		$m_D4 = 0
	EndIf
	$j_D4 -= 2
	If $j_D4 <= 0 Then
		$j_D4 = 360
		$n_D4 = 0
	EndIf
EndFunc

Func Array_Rot(ByRef $arr, $dir = 0) ;0 for left, 1 for right
	Local $tmp, $p,$q
	If $dir = 0 Then ;left rotation
		$tmp = $arr[0]
		$q = 0
		For $p = 1 To UBound($arr) - 1
			$arr[$q] = $arr[$p]
			$q += 1
		Next
		$arr[UBound($arr) - 1] = $tmp
	ElseIf $dir = 1 Then ;right rotation
		$tmp = $arr[UBound($arr) - 1]
		$q = UBound($arr) - 1
		For $p = UBound($arr) - 2 To 0 Step - 1
			$arr[$q] = $arr[$p]
			$q -= 1
		Next
		$arr[0] = $tmp
	EndIf
EndFunc

Func Close_Demo4()
	Local $x
	For $x = 0 To UBound($arrTxt1_D4) - 1
		_GDIPlus_BrushDispose($brush1_D4[$x])
	Next
	For $x = 0 To UBound($arrTxt2_D4) - 1
		_GDIPlus_BrushDispose($brush2_D4[$x])
	Next
	_GDIPlus_FontDispose($hFont1_D4)
	_GDIPlus_FontDispose($hFont2_D4)
	_GDIPlus_FontFamilyDispose($hFamily1_D4)
	_GDIPlus_FontFamilyDispose($hFamily2_D4)
	_GDIPlus_StringFormatDispose($hFormat_D4)
	_GDIPlus_GraphicsDispose($hImage_BB_D4)
	_GDIPlus_BitmapDispose($hImage_D4)
EndFunc
#endregion

#region Demo5
Func Demo5()
	Local $j
	_GDIPlus_GraphicsFillRect($hImage_BB_D5, $width_D5 * 0.5 - $ellipse_size_D5 * $k_D5,  $height_D5 *  0.5 - $ellipse_size_D5 * $k_D5, _
											 $ellipse_size_double_D5 * $k_D5, $ellipse_size_double_D5 * $k_D5, $Brush_D5) ;clear only area where the squares are drawn
	If $k_D5 <= 3 * $width_D5 / 5  Then $k_D5 += 1
    For $j = 8 To $k_D5 Step 24 + Cos($i_D5 * $pi_Div_60) * 12
        $red_D5 = ((Sin(($j - $i_D5) / 32) + 1) * 0.5) * 256
        $green_D5 = ((Sin(($j - $i_D5) / 128) + 1) * 0.5) * 256
        $blue_D5 = ((Sin(($j - $i_D5) / 512) + 1) * 0.5) * 256
		_GDIPlus_PenSetColor($Pen_D5, "0xEF" & Hex($red_D5, 2) & Hex($green_D5, 2) & Hex($blue_D5, 2)) ;Set the pen color
        $xcoord_D5 = $j
        $ycoord_D5 = $j
        Square($xcoord_D5, $ycoord_D5, $j * Sin($i_D5 / $k_D5 * $pi_Mul_4) * 0.75)
    Next
    $i_D5 += 1.5
EndFunc

Func Close_Demo5()
	_GDIPlus_BrushDispose($Brush_D5)
	_GDIPlus_PenDispose($Pen_D5)
	_GDIPlus_BitmapDispose($hImage_D5)
	_GDIPlus_GraphicsDispose($hImage_BB_D5)
EndFunc

Func Square($xx1, $yy1, $i) ;coded by UEZ
	Local $degree = 45
    $x1_D5 = $xx1 * Cos(($i + $degree + 0) * $pi_Div_180) + $width_D5 *  0.5
    $y1_D5 = $yy1 * Sin(($i + $degree + 0) * $pi_Div_180) + $height_D5 *  0.5
    $x2_D5 = $xx1 * Cos(($i + $degree + 90) * $pi_Div_180) + $width_D5 *  0.5
    $y2_D5 = $yy1 * Sin(($i + $degree + 90) * $pi_Div_180) + $height_D5 *  0.5
    $x3_D5 = $xx1 * Cos(($i + $degree + 180) * $pi_Div_180) + $width_D5 *  0.5
    $y3_D5 = $yy1 * Sin(($i + $degree + 180) * $pi_Div_180) + $height_D5 *  0.5
    $x4_D5 = $xx1 * Cos(($i + $degree + 270) * $pi_Div_180) + $width_D5 *  0.5
    $y4_D5 = $yy1 * Sin(($i + $degree + 270) * $pi_Div_180) + $height_D5 *  0.5
    _GDIPlus_GraphicsDrawLine($hImage_BB_D5, $x1_D5, $y1_D5, $x2_D5, $y2_D5, $Pen_D5)
    _GDIPlus_GraphicsDrawLine($hImage_BB_D5, $x2_D5, $y2_D5, $x3_D5, $y3_D5, $Pen_D5)
    _GDIPlus_GraphicsDrawLine($hImage_BB_D5, $x3_D5, $y3_D5, $x4_D5, $y4_D5, $Pen_D5)
    _GDIPlus_GraphicsDrawLine($hImage_BB_D5, $x4_D5, $y4_D5, $x1_D5, $y1_D5, $Pen_D5)
EndFunc
#endregion

#region Demo6
Func Demo6()
	Local $x
	_GDIPlus_GraphicsClear($hImage_BB_D6, 0xFF000000)
	$x = $k_D6 + $letter_distance_D6
	DllStructSetData($tLayout_D6, "x", $x)
	DllStructSetData($tLayout_D6, "y", $y_D6)
	_GDIPlus_GraphicsDrawStringEx($hImage_BB_D6, $text_scroller_D6, $hFont_D6, $tLayout_D6, $hFormat_D6, $brush_D6)
	$k_D6 -= 1
	If -$scroller_length_D6 >= $k_D6 Then
		$k_D6 = $width_D6
	EndIf
EndFunc

Func _GDIPlus_HatchBrushCreate($iHatchStyle = 0, $iARGBForeground = 0xFFFFFFFF, $iARGBBackground = 0xFFFFFFFF)
	Local $aResult = DllCall($ghGDIPDll, "uint", "GdipCreateHatchBrush", "int", $iHatchStyle, "uint", $iARGBForeground, "uint", $iARGBBackground, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return $aResult[4]
EndFunc

Func Close_Demo6()
	$tLayout_D6 = 0
	_GDIPlus_BrushDispose($brush_D6)
	_GDIPlus_FontDispose($hFont_D6)
	_GDIPlus_FontFamilyDispose($hFamily_D6)
	_GDIPlus_StringFormatDispose($hFormat_D6)
	_GDIPlus_BitmapDispose($hImage_D6)
	_GDIPlus_GraphicsDispose($hImage_BB_D6)
EndFunc
#endregion
