#include <GDIPlus.au3>
#include <Misc.au3>

Opt("MustDeclareVars", 1)
Opt("GUIOnEventMode", 1)
Opt("MouseCoordMode", 1)

Global $user32_dll = DllOpen("user32.dll")
Global $Reset, $hPenDotted, $hPenDash, $ResetCube, $CubeX, $CubeY, $CubeZ
Global $CubeX1, $CubeY1, $CubeX2, $CubeY2, $CubeX3, $CubeY3, $CubeX4, $CubeY4
Global $Tog, $Tog1, $Tog2, $Tog3, $Tog4 = True, $Tog5, $Tog6, $Tog7 = True, $T, $Delay = 100
Global $Text  = "Press F1 to F6 to Toogle Cube Faces (F7 Toggles the Autoit Logo being Painted)"
Global $text1 = "Left Mouse Button to Rotate, Right Mouse Button to Reset (Mouse wheel to Zoom)"

Local $dot_distance = 150
Local Const $Width = 600
Local Const $Height = $Width
Local Const $W2 = $Width / 2
Local Const $H2 = $Height / 2
Local Const $deg = 180 / ACos(-1)
Local $hwnd = GUICreate("Orginal Code by UEZ ", $Width, $Height)

GUISetState()

If @OSBuild < 7600 Then WinSetTrans($hwnd,"", 0xFF) ;workaround for XP machines when alpha blending is activated on _GDIPlus_GraphicsClear() function to avoid slow drawing

_GDIPlus_Startup()
Local $hGraphics = _GDIPlus_GraphicsCreateFromHWND($hwnd)
Local $hBitmap = _GDIPlus_BitmapCreateFromGraphics($Width, $Height, $hGraphics)
Local $hBackbuffer = _GDIPlus_ImageGetGraphicsContext($hBitmap)
_GDIPlus_GraphicsClear($hBackbuffer)
_GDIPlus_GraphicsSetSmoothingMode($hBackbuffer, 2)

Local $hImage = _GDIPlus_ImageLoadFromFile ("C:\Program Files\AutoIt3\Examples\GUI\logo4.gif")

Local $Str
Local $pColor = 0xFF0000F0
Local $hPen = _GDIPlus_PenCreate($pColor, 8)
        _GDIPlus_PenSetEndCap($hPen, $GDIP_LINECAPARROWANCHOR)
Local $hCubePen = _GDIPlus_PenCreate(0x400000F0, 8)
        _GDIPlus_PenSetEndCap($hCubePen, $GDIP_LINECAPARROWANCHOR)
Local $hBrush = _GDIPlus_BrushCreateSolid ()
Local $hBrush1 = _GDIPlus_BrushCreateSolid(0x60FFFF00)
Local $hBrush2 = _GDIPlus_BrushCreateSolid(0x60FF8000)
$hPenDash = _GDIPlus_PenCreate (0xFF000000, 2)
    _GDIPlus_PenSetDashStyle ($hPenDash, $GDIP_DASHSTYLEDASH)
$hPenDotted = _GDIPlus_PenCreate (0xFF000000, 2)
    _GDIPlus_PenSetDashStyle ($hPenDotted, $GDIP_DASHSTYLEDOT)
Local Const $length = 250
Local Const $Pi = ACos(-1)
Local Const $amout_of_dots = 6
Local Const $amout_of_cube_dots = 9

#cs
        X           Y           Z
---------------------------------------
1    [-$length,     0,          0 ], _
2    [ $length,     0,          0 ], _
3    [  0,      -$length,       0 ], _
4    [  0,       $length,       0 ], _
5    [  0,          0,      -$length ], _
6    [  0,          0,       $length ]]
#ce

; Axis Coords
Local $draw_coordinates[$amout_of_dots][4] = [ _;   X                   y                   Z
                                                [-$length,              0,                  0   ], _
                                                [$length,               0,                  0   ], _
                                                [0,                     -$length,           0   ], _
                                                [0,                     $length,            0   ], _
                                                [0,                     0,                  -$length   ], _
                                                [0,                     0,                  $length    ]]
$Reset = $draw_coordinates

Local $cube_coordinates[$amout_of_cube_dots][4] = [ _;  X                   y                   Z
                                                [-$dot_distance,    -$dot_distance,     -$dot_distance  ], _
                                                [$dot_distance,     -$dot_distance,     -$dot_distance  ], _
                                                [$dot_distance,     $dot_distance,      -$dot_distance  ], _
                                                [-$dot_distance,    $dot_distance,      -$dot_distance  ], _
                                                [-$dot_distance,    -$dot_distance,     $dot_distance   ], _
                                                [$dot_distance,     -$dot_distance,     $dot_distance   ], _
                                                [$dot_distance,     $dot_distance,      $dot_distance   ], _
                                                [-$dot_distance,    $dot_distance,      $dot_distance   ]]
$ResetCube = $cube_coordinates


Local $x1, $y1, $x2, $y2
Local $b, $j, $x, $y, $z, $mx, $my, $MPos
Local $zoom_counter = 100
Local Const $zoom_min = 50
Local Const $zoom_max = 125
Local Const $mouse_sense = 4000
Local Const $start_x = $Width / 2
Local Const $start_y = $Height / 2
Local Const $dx = @DesktopWidth / 2, $dy = @DesktopHeight / 2
Local Const $Red    = 0xFFF00000
Local Const $Green = 0xFF00F000
Local Const $Blue = 0xFF0000F0
Local $mwx, $mwy, $mwz, $angle, $rad = 180 / $Pi

MouseMove($dx, $dy, 1)

GUIRegisterMsg(0x020A, "WM_MOUSEWHEEL")

GUISetOnEvent(-3, "Close")

Do
    _GDIPlus_GraphicsClear($hBackbuffer, 0xF0FFFFFF)

    For $b = 0 To $amout_of_dots - 1        ;correct axis perspective
        $draw_coordinates[$b][3] = 1 + $draw_coordinates[$b][2] / 1500
    Next
        For $c = 0 To $amout_of_cube_dots - 1 ;correct  cube perspective
        $cube_coordinates[$c][3] = 1 + $cube_coordinates[$c][2] / 0x600
    Next

    ;draw axis lines
    Draw_Lines(0, 1, $Red)                  ;draw x axis - red
    Draw_Lines(2, 3, $Green)                ;draw y axis - green
    Draw_Lines(4, 5, $Blue)                 ;draw z axis - blue
;--------------------------------------------------------------------

Select
    Case _IsPressed("70", $user32_dll)
        Sleep($Delay)
        $Tog1 = NOT $Tog1
;       Beep(100,50)

    Case _IsPressed("71",$user32_dll)
        Sleep($Delay)
        $Tog2 = NOT $Tog2
;       Beep(200,50)

    Case _IsPressed("72",$user32_dll)
        Sleep($Delay)
        $Tog3 = NOT $Tog3
;       Beep(300,50)

    Case _IsPressed("73", $user32_dll)
        Sleep($Delay)
        $Tog4 = NOT $Tog4
;       Beep(400,50)

    Case _IsPressed("74", $user32_dll)
        Sleep($Delay)
        $Tog5 = NOT $Tog5
;       Beep(500,50)

    Case _IsPressed("75", $user32_dll)
        Sleep($Delay)
        $Tog6 = NOT $Tog6
;       Beep(600,50)

    Case _IsPressed("76", $user32_dll)
        Sleep($Delay)
        $Tog7 = NOT $Tog7
;       Beep(700,50)
EndSelect

;       4 -- - - - 5
;     / |        / |
;    0 - -  - - 1  |
;    |  |       |  |
;    |  7 -- - -|- 6
;    | /        | /
;    3 - -  - - 2
    If $Tog1 = True then        Draw_Cube_Lines(3, 2, 6, 7)     ;F1 bottom
    If $Tog2 = True then        Draw_Cube_Lines(5, 1, 0, 4)     ;F2 top
    If $Tog3 = True then        Draw_Cube_Lines(1, 2, 3, 0)     ;F3 front
    If $Tog4 = True then        Draw_Cube_Lines(7, 6, 5 ,4)     ;F4 rear
    If $Tog5 = True then        Draw_Cube_Lines(6, 2, 1, 5)     ;F5 right
    If $Tog6 = True then        Draw_Cube_Lines(0, 3, 7, 4)     ;F6 left

    If _IsPressed("01", $user32_dll) Then   ; Left mouse button to Rotate
        $MPos = MouseGetPos()
        For $j = 0 To $amout_of_dots - 1
            $Mx = ($dx - $MPos[0]) / $mouse_sense
            $My = -($dy - $Mpos[1]) / $mouse_sense
            Calc($My, $Mx, $j)              ;calculate axis coordinates
        Next
        For $j = 0 To $amout_of_Cube_dots - 1
            CubeCalc($My, $Mx, $j)          ;calculate cube coordinates
        Next
    EndIF
    If _IsPressed("02", $user32_dll) Then   ;Right mouse button to Reset CoOrds and Toggles to inital values
       $draw_coordinates = $Reset
       $cube_coordinates = $ResetCube
       $Tog1 = False
       $Tog2 = False
       $Tog3 = False
       $Tog4 = True     ;Draw this Face as Default
       $Tog5 = False
       $Tog6 = False
       $Tog7 = True     ;Paint Logo
    Endif

    _GDIPlus_GraphicsDrawImageRect($hGraphics, $hBitmap, 0, 0, $Width, $Height)
Until Not Sleep(30)

;Draw Axis Lines
Func Draw_Lines($p1, $p2, $pColor)
    $x1 = $start_x + $draw_coordinates[$p1][0] * $draw_coordinates[$p1][3]
    $y1 = $start_y + $draw_coordinates[$p1][1] * $draw_coordinates[$p1][3]

    $x2 = $start_x + $draw_coordinates[$p2][0] * $draw_coordinates[$p2][3]
    $y2 = $start_y + $draw_coordinates[$p2][1] * $draw_coordinates[$p2][3]

    _GDIPlus_PenSetColor($hPen, $pColor)
    _GDIPlus_GraphicsDrawLine($hBackbuffer, $x1, $y1, $x2, $y2, $hPen)

    _GDIPlus_BrushSetSolidColor($hBrush, $pColor)
   _GDIPlus_GraphicsFillEllipse($hBackbuffer, $x1 - 10, $y1 - 10 , 20, 20, $hBrush)

    $angle = Mod(360 - Abs(Angle($draw_coordinates[$p1][0], $draw_coordinates[$p2][1])), 360)
    Select
        Case $pColor = $Red
            $Str = "XAngle = " & StringFormat("%.2f", $angle)
        Case $pColor = $Green
            $Str = "YAngle = " & StringFormat("%.2f", $angle)
        Case $pColor = $Blue
            $Str = "ZAngle = " & StringFormat("%.2f", $angle)
    EndSelect
    _GDIPlus_GraphicsFillEllipse($hBackbuffer, $Start_X - 10, $Start_Y - 10, 20, 20, 0) ; Origin
    _GDIPlus_GraphicsDrawString ($hBackbuffer, "Origin", $Start_X - 20, $Start_Y - 30)
    _GDIPlus_GraphicsDrawString ($hBackbuffer, $Str, $x2 - 20, $y2 - 30)
EndFunc ;==>Draw

Func Draw_Cube_Lines($Cp1, $Cp2, $Cp3, $Cp4)
    $CubeX1 = $start_x + $Cube_coordinates[$Cp1][0] * $Cube_coordinates[$Cp1][3]
    $CubeY1 = $start_y + $Cube_coordinates[$Cp1][1] * $Cube_coordinates[$Cp1][3]

    $CubeX2 = $start_x + $Cube_coordinates[$Cp2][0] * $Cube_coordinates[$Cp2][3]
    $CubeY2 = $start_y + $Cube_coordinates[$Cp2][1] * $Cube_coordinates[$Cp2][3]

    $CubeX3 = $start_x + $Cube_coordinates[$Cp3][0] * $Cube_coordinates[$Cp3][3]
    $CubeY3 = $start_y + $Cube_coordinates[$Cp3][1] * $Cube_coordinates[$Cp3][3]

    $CubeX4 = $start_x + $Cube_coordinates[$Cp4][0] * $Cube_coordinates[$Cp4][3]
    $CubeY4 = $start_y + $Cube_coordinates[$Cp4][1] * $Cube_coordinates[$Cp4][3]

;#######                    For Front Face              #########
;------------------------------- Top -------------------------------------------------------
    _GDIPlus_GraphicsDrawLine($hBackbuffer, $CubeX4, $CubeY4, $CubeX1, $CubeY1, $hCubePen)                  ; top 0 - 1
    _GDIPlus_GraphicsFillEllipse($hBackbuffer, $CubeX4 - 5, $CubeY4 - 5 , 10, 10, 0)

    _GDIPlus_GraphicsDrawLine   ($hBackbuffer, $Start_X, $Start_Y, $CubeX4, $CubeY4,  $hPenDash)
   _GDIPlus_GraphicsDrawString ($hBackbuffer, $Cp4, $CubeX4- 10, $CubeY4 -20, "Arial", 12)
    _GDIPlus_GraphicsDrawString ($hBackbuffer, $Cp1, $CubeX1, $CubeY1 -20,  "Arial", 12)
;-------------------------------------------------------------------------------------------
;------------------------------- Right -------------------------------------------------------
    _GDIPlus_GraphicsDrawLine($hBackbuffer, $CubeX1, $CubeY1, $CubeX2, $CubeY2, $hCubePen)                  ; right 2 - 1
;---------------------------------------------------------------------------------------------
;------------------------------- Bottom -------------------------------------------------------
    _GDIPlus_GraphicsDrawLine($hBackbuffer, $CubeX2, $CubeY2, $CubeX3, $CubeY3, $hCubePen)                  ; bottom 3 - 2
    _GDIPlus_GraphicsFillEllipse($hBackbuffer, $CubeX2 - 5, $CubeY2 - 5 , 10, 10, 0)

    _GDIPlus_GraphicsDrawLine   ($hBackbuffer, $Start_X, $Start_Y, $CubeX2, $CubeY2,  $hPenDash)
    _GDIPlus_GraphicsDrawString ($hBackbuffer, $Cp2, $CubeX2 +5, $CubeY2, "Arial", 12)
    _GDIPlus_GraphicsDrawString ($hBackbuffer, $Cp3, $CubeX3 -10, $CubeY3,"Arial", 12)
;----------------------------------------------------------------------------------------------
    _GDIPlus_GraphicsDrawString ($hBackbuffer, $Text, 5, 550,"Arial", 12)                               ;Instructions
    _GDIPlus_GraphicsDrawString ($hBackbuffer, $Text1, 5, 570,"Arial", 12)

;------------------------------- Left --------------------------------------------------------
    _GDIPlus_GraphicsDrawLine($hBackbuffer, $CubeX3, $CubeY3, $CubeX4, $CubeY4, $hCubePen)                  ; left
;----------------------------------------------------------------------------------------------
    _GDIPlus_GraphicsDrawString ($hBackbuffer, $Cp3, $CubeX3 -10, $CubeY3,"Arial", 12)
;--------------------------- Put the Autoit Logo image on one Face ----------------------------------------------
    if $Cp1 = 7 and $Tog7 = True then
    _GDIPlus_DrawImagePoints($hBackbuffer, $hImage, $start_x + $Cube_coordinates[$Cp4][0], $start_y + $Cube_coordinates[$Cp4][1], _
                                                    $start_x + $Cube_coordinates[$Cp3][0], $start_y + $Cube_coordinates[$Cp3][1], _
                                                    $start_x + $Cube_coordinates[$Cp1][0], $start_y + $Cube_coordinates[$Cp1][1])
    Endif
EndFunc   ;==>Draw

Func Angle($x, $y)
    Local $angle
    If $x = 0 Then
        $angle = 0
    Else
        $angle = -ATan($y / -$x) * $deg
    EndIf
    If -$x < 0 Then
        $angle = -180 + $angle
    ElseIf -$x >= 0 And $y < 0 Then
        $angle = -360 + $angle
    EndIf
    Return $angle
EndFunc

Func Calc($angle_x, $angle_y, $i, $angle_z = 0)
    ;calculate axis 3D rotation
    $x = $draw_coordinates[$i][0] * Cos($angle_y) + $draw_coordinates[$i][2] * Sin($angle_y)
    $y = $draw_coordinates[$i][1]
    $z = -$draw_coordinates[$i][0] * Sin($angle_y) + $draw_coordinates[$i][2] * Cos($angle_y)

    $draw_coordinates[$i][0] = $x
    $draw_coordinates[$i][1] = $y * Cos($angle_x) - $z * Sin($angle_x)
    $draw_coordinates[$i][2] = $y * Sin($angle_x) + $z * Cos($angle_x)
EndFunc ;==>Calc

Func CubeCalc($angle_x, $angle_y, $i)
    ;calculate Cube 3D rotation
    $CubeX = $Cube_coordinates[$i][0] * Cos($angle_y) + $Cube_coordinates[$i][2] * Sin($angle_y)
    $CubeY = $Cube_coordinates[$i][1]
    $CubeZ = -$Cube_coordinates[$i][0] * Sin($angle_y) + $Cube_coordinates[$i][2] * Cos($angle_y)

    $Cube_coordinates[$i][0] = $CubeX
    $Cube_coordinates[$i][1] = $CubeY * Cos($angle_x) - $CubeZ * Sin($angle_x)
    $Cube_coordinates[$i][2] = $CubeY * Sin($angle_x) + $CubeZ * Cos($angle_x)
EndFunc

Func Close()
    _GDIPlus_BrushDispose($hBrush1)
    _GDIPlus_BrushDispose($hBrush2)
    _GDIPlus_PenDispose($hPen)
    _GDIPlus_PenDispose($hPenDash)
    _GDIPlus_PenDispose($hPenDotted)
    _GDIPlus_BitmapDispose($hBitmap)
    _GDIPlus_GraphicsDispose($hBackbuffer)
    _GDIPlus_GraphicsDispose($hGraphics)
    _GDIPlus_Shutdown()
    DllClose($User32_dll)
    Exit
EndFunc ;==>Close

Func Zoom($factor)
    Local $m
    For $m = 0 To $amout_of_dots - 1
        $draw_coordinates[$m][0] *= $factor
        $draw_coordinates[$m][1] *= $factor
        $draw_coordinates[$m][2] *= $factor
    Next
    For $m = 0 To $amout_of_Cube_dots - 1
        $Cube_coordinates[$m][0] *= $factor
        $Cube_coordinates[$m][1] *= $factor
        $Cube_coordinates[$m][2] *= $factor
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
EndFunc ;==>WM_MOUSEWHEEL
 