; SadBunny
; http://www.autoitscript.com/forum/topic/62779-nice-looking-graphical-analogdigital-clock
#include <GUIConstantsEx.au3>
#include <Sound.au3>

Dim $aDigChar[13]
_initDigChar($aDigChar)

Dim $aXY[2]
Global $sec = @SEC
Global $MinDegree = 0
Global $HourDegree = 0
Global $AlarmDegree = 0
Global $alarmHour = 0
Global $alarmMin = 0
Global $alarmSec = 0
Global $alarmIsSet = False
Global $alarmIsSounding = False
Global $previousMinDegree = 0
Global $previousHourDegree = 0
Global $previousAlarmDegree = 0
Global $pi = 3.14159265358979
Global $degToRad = $pi / 180
Global $RadToDeg = 1 / $degToRad

#include <Sound.au3>
Global $alarmFile = @WindowsDir & "\media\ringin.wav"
Global $soundHandle = _SoundOpen($alarmFile)

$gui = GUICreate("Test", 702, 702)
GUISetBkColor(0x000000)

GUISetState()

$megavierkant = GUICtrlCreateGraphic(0, 0, 700, 700)
$vierkant = GUICtrlCreateGraphic(150, 150, 400, 400)
$secSquare = GUICtrlCreateGraphic(0, 0, 0, 0)
$timeSquare = GUICtrlCreateGraphic(5, 5, 200, 30)
$alarmSquare = GUICtrlCreateGraphic(560, 5, 200, 30)

_drawInitBorder($megavierkant)

Dim $msg[1]

While 1
    ; main loop, waits until @sec changes and then executes main drawing management function
    While @SEC = $sec
        $msg = GUIGetMsg(1)
        If $msg[0] = -3 Then Exit
        If $msg[0] = $GUI_EVENT_PRIMARYDOWN Then
            $alarmIsSounding = False
            _SoundStop($soundHandle)
            $mX = $msg[3] - 350
            $mY = $msg[4] - 350
            $clickAngle = Int(ATan($mY / $mX) * $RadToDeg) + 90
            If $mX < 0 Then $clickAngle += 180
            $alarmHour = Int($clickAngle / 30)
            $alarmMin = Mod($clickAngle, 30) * 2
            $alarmSec = 0
            $alarmIsSet = True
            _draw()
        EndIf
        If $msg[0] = $GUI_EVENT_SECONDARYDOWN Then
            $alarmIsSounding = False
            _SoundStop($soundHandle)
            GUICtrlDelete($alarmSquare)
            $alarmIsSet = False
            $alarmHour = -1
            _draw(True)
        EndIf
        Sleep(20)
        If $alarmIsSounding Then _soundAlarm()
    WEnd
    _draw()
    Sleep(50)
    $sec = @SEC
    If (@HOUR = $alarmHour Or @HOUR = 12 + $alarmHour) And @MIN = $alarmMin And $alarmIsSet Then
        $alarmIsSounding = True
    EndIf
WEnd
Exit


Func _soundAlarm()
    If _SoundStatus($soundHandle) = "stopped" Then
        _SoundSeek($soundHandle,0,0,0)
        _SoundPlay($soundHandle, 0)
    EndIf
EndFunc   ;==>_soundAlarm


Func _draw($forceDraw = False)
    ; calculates angles for min/sec dials, manages execution of drawing routines
    Local $doDraw = False
    $MinDegree = Int((90 - @MIN * 6) - @SEC * 0.1)
    $HourDegree = Int((90 - @HOUR * 30) - @MIN * .5)
    $AlarmDegree = Int((90 - $alarmHour * 30) - $alarmMin * .5)
    If $MinDegree <> $previousMinDegree Or $AlarmDegree <> $previousAlarmDegree Then
        $doDraw = True
        $previousMinDegree = $MinDegree
        $previousAlarmDegree = $AlarmDegree
    EndIf

    If $doDraw Or $forceDraw Then
        GUICtrlDelete($vierkant)
        $vierkant = GUICtrlCreateGraphic(150, 150, 400, 400)
        _drawHourPie($vierkant)
        _drawMinPie($vierkant)
        If $alarmIsSet Then _drawAlarmPie($vierkant)
        GUICtrlSetGraphic($vierkant, $GUI_GR_REFRESH)
        $doDraw = False
    EndIf
    Sleep(25)
    _drawSec()
    _drawTime()
    If $alarmIsSet Then _drawAlarmTime()
    GUICtrlSetGraphic($secSquare, $GUI_GR_REFRESH)
EndFunc   ;==>_draw

Func _drawTime()
    ; manages execution of write commands for HH MM SS characters
    GUICtrlDelete($timeSquare)
    $timeSquare = GUICtrlCreateGraphic(5, 5, 200, 30)
    _timeWrite(1, Int(@HOUR / 10), "regular", $timeSquare)
    _timeWrite(20, Mod(@HOUR, 10), "regular", $timeSquare)
    _timeWrite(50, Int(@MIN / 10), "regular", $timeSquare)
    _timeWrite(70, Mod(@MIN, 10), "regular", $timeSquare)
    _timeWrite(100, Int(@SEC / 10), "regular", $timeSquare)
    _timeWrite(120, Mod(@SEC, 10), "regular", $timeSquare)
EndFunc   ;==>_drawTime

Func _drawAlarmTime()
    ; manages execution of write commands for HH MM SS characters for the alarm time
    GUICtrlDelete($alarmSquare)
    $alarmSquare = GUICtrlCreateGraphic(480, 5, 220, 30)
    _timeWrite(1, 10, "alarm", $alarmSquare)
    _timeWrite(20, 11, "alarm", $alarmSquare)
    _timeWrite(50, 12, "alarm", $alarmSquare)
    _timeWrite(80, Int($alarmHour / 10), "alarm", $alarmSquare)
    _timeWrite(100, Mod($alarmHour, 10), "alarm", $alarmSquare)
    _timeWrite(130, Int($alarmMin / 10), "alarm", $alarmSquare)
    _timeWrite(150, Mod($alarmMin, 10), "alarm", $alarmSquare)
    _timeWrite(180, Int($alarmSec / 10), "alarm", $alarmSquare)
    _timeWrite(200, Mod($alarmSec, 10), "alarm", $alarmSquare)
EndFunc   ;==>_drawAlarmTime

Func _timeWrite($pos, $num, $type, $graph) ; $type is "regular" or "alarm"
    ; manages coloring and writing of LEDs for time writing
    
    _setColorAndPenForWrite(StringMid($aDigChar[$num], 1, 1), $type);0
    _line($graph, $pos + 5, 2, $pos + 3, 10)
    
    _setColorAndPenForWrite(StringMid($aDigChar[$num], 2, 1), $type);1
    _line($graph, $pos + 2, 14, $pos + 0, 22)
    
    _setColorAndPenForWrite(StringMid($aDigChar[$num], 3, 1), $type);2
    _line($graph, $pos + 5 + 2, 0, $pos + 5 + 8, 0)
    
    _setColorAndPenForWrite(StringMid($aDigChar[$num], 4, 1), $type);3
    _line($graph, $pos + 2 + 2, 12, $pos + 2 + 8, 12)
    
    _setColorAndPenForWrite(StringMid($aDigChar[$num], 5, 1), $type);4
    _line($graph, $pos + 2, 24, $pos + 8, 24)
    
    _setColorAndPenForWrite(StringMid($aDigChar[$num], 6, 1), $type);5
    _line($graph, $pos + 5 + 10, 2, $pos + 3 + 10, 10)
    
    _setColorAndPenForWrite(StringMid($aDigChar[$num], 7, 1), $type);6
    _line($graph, $pos + 2 + 10, 14, $pos + 10, 22)
EndFunc   ;==>_timeWrite

Func _line($graph, $x1, $y1, $x2, $y2)
    ; draws line for time writing
    GUICtrlSetGraphic($graph, $GUI_GR_MOVE, $x1 + 2, $y1 + 2)
    GUICtrlSetGraphic($graph, $GUI_GR_LINE, $x2 + 2, $y2 + 2)
EndFunc   ;==>_line

Func _setColorAndPenForWrite($char, $type)
    ; sets color and pen for next line in time writing, based on '0' or '1' in the DigChar array
    If $char = "1"  Then
        If $type = "alarm"  Then
            GUICtrlSetGraphic($alarmSquare, $GUI_GR_PENSIZE, 2)
            GUICtrlSetGraphic($alarmSquare, $GUI_GR_COLOR, 0xCCCCCC, 0xCCCCCC)
        Else
            GUICtrlSetGraphic($timeSquare, $GUI_GR_PENSIZE, 2)
            GUICtrlSetGraphic($timeSquare, $GUI_GR_COLOR, 0xEE0000, 0xEE0000)
        EndIf
    Else
        If $type = "alarm"  Then
            GUICtrlSetGraphic($alarmSquare, $GUI_GR_PENSIZE, 2)
            GUICtrlSetGraphic($alarmSquare, $GUI_GR_COLOR, 0x444444, 0x444444)
        Else
            GUICtrlSetGraphic($timeSquare, $GUI_GR_PENSIZE, 2)
            GUICtrlSetGraphic($timeSquare, $GUI_GR_COLOR, 0x660000, 0x660000)
        EndIf
    EndIf
EndFunc   ;==>_setColorAndPenForWrite

Func _drawSec()
    ; draws circle seconds indicator
    $aXY = _getXY(@SEC, 240)
    GUICtrlDelete($secSquare)
    $secSquare = GUICtrlCreateGraphic(350 + $aXY[0] - 8, 350 + $aXY[1] - 8, 16, 16)
    GUICtrlSetGraphic($secSquare, $GUI_GR_COLOR, 0x0000FF, 0x0000FF)
    GUICtrlSetGraphic($secSquare, $GUI_GR_ELLIPSE, 0, 0, 16, 16)
EndFunc   ;==>_drawSec

Func _drawAlarmPie($graph)
    ; draws alarm dial
    GUICtrlSetGraphic($graph, $GUI_GR_COLOR, 0xDDDDDD, 0xDDDDDD)
    GUICtrlSetGraphic($graph, $GUI_GR_PIE, 200, 200, 228, $AlarmDegree, 0)
    GUICtrlSetGraphic($graph, $GUI_GR_COLOR, 0xBB9999, 0x000000)
    GUICtrlSetGraphic($graph, $GUI_GR_PIE, 200, 200, 120, $AlarmDegree - 1, 2)
    GUICtrlSetGraphic($graph, $GUI_GR_COLOR, 0x996666, 0x000000)
    GUICtrlSetGraphic($graph, $GUI_GR_PIE, 200, 200, 70, $AlarmDegree - 2, 4)
    GUICtrlSetGraphic($graph, $GUI_GR_COLOR, 0x773333, 0x000000)
    GUICtrlSetGraphic($graph, $GUI_GR_PIE, 200, 200, 20, $AlarmDegree - 4, 8)
    Return True
EndFunc   ;==>_drawAlarmPie

Func _drawMinPie($graph)
    ; draws minute dial
    GUICtrlSetGraphic($graph, $GUI_GR_COLOR, 0xBBBB00, 0xBBBB00)
    GUICtrlSetGraphic($graph, $GUI_GR_PIE, 200, 200, 200, $MinDegree - 2, 4)
    GUICtrlSetGraphic($graph, $GUI_GR_PIE, 200, 200, 220, $MinDegree, 0)
    GUICtrlSetGraphic($graph, $GUI_GR_COLOR, 0x000000, 0x000000)
    GUICtrlSetGraphic($graph, $GUI_GR_PIE, 200, 200, 150, $MinDegree - 1, 2)
    Return True
EndFunc   ;==>_drawMinPie

Func _drawHourPie($graph)
    ; draws hour dial
    GUICtrlSetGraphic($graph, $GUI_GR_COLOR, 0xAA0000, 0xAA0000)
    GUICtrlSetGraphic($graph, $GUI_GR_PIE, 200, 200, 140, $HourDegree - 4, 8)
    GUICtrlSetGraphic($graph, $GUI_GR_PIE, 200, 200, 160, $HourDegree, 0)
    GUICtrlSetGraphic($graph, $GUI_GR_COLOR, 0x000000, 0x000000)
    GUICtrlSetGraphic($graph, $GUI_GR_PIE, 200, 200, 120, $HourDegree - 1, 2)
    Return True
EndFunc   ;==>_drawHourPie

Func _getXY($sec, $hypo)
    ; returns array with X,Y coordinates for the seconds points for $sec seconds, with $hypo(tenuse) distance from center
    Dim $result[2]
    Local $pi = 3.14159265358979
    Local $degToRad = $pi / 180
    Local $degrees = $sec * 6 - 90
    Local $x = Cos($degrees * $degToRad) * $hypo
    Local $y = Sin($degrees * $degToRad) * $hypo
    $result[0] = $x
    $result[1] = $y
    Return $result
EndFunc   ;==>_getXY

Func _drawInitBorder($megavierkant)
    ; draws initial border 'circle'
    For $count = 1 To 60
        If $count / 5 = Int($count / 5) Then
            Dim $a1 = _getXY($count, 260)
            Dim $a2 = _getXY($count, 280)
            GUICtrlSetGraphic($megavierkant, $GUI_GR_PENSIZE, 4)
            GUICtrlSetGraphic($megavierkant, $GUI_GR_COLOR, 0x00CC00, 0x00CC00)
            GUICtrlSetGraphic($megavierkant, $GUI_GR_MOVE, 350 + $a1[0], 350 + $a1[1])
            GUICtrlSetGraphic($megavierkant, $GUI_GR_LINE, 350 + $a2[0], 350 + $a2[1])
        Else
            Dim $a1 = _getXY($count, 270)
            Dim $a2 = _getXY($count, 280)
            GUICtrlSetGraphic($megavierkant, $GUI_GR_PENSIZE, 3)
            GUICtrlSetGraphic($megavierkant, $GUI_GR_COLOR, 0x008800, 0x008800)
            GUICtrlSetGraphic($megavierkant, $GUI_GR_MOVE, 350 + $a1[0], 350 + $a1[1])
            GUICtrlSetGraphic($megavierkant, $GUI_GR_LINE, 350 + $a2[0], 350 + $a2[1])
        EndIf
    Next
EndFunc   ;==>_drawInitBorder

Func _initDigChar(ByRef $aDigChar)
    ; define leds for digital numbers: 1 or 0 for leds on/off in 7-led digital clock characters
    $aDigChar[0] = "1110111"
    $aDigChar[1] = "0000011"
    $aDigChar[2] = "0111110"
    $aDigChar[3] = "0011111"
    $aDigChar[4] = "1001011"
    $aDigChar[5] = "1011101"
    $aDigChar[6] = "1111101"
    $aDigChar[7] = "0010011"
    $aDigChar[8] = "1111111"
    $aDigChar[9] = "1011111"
    $aDigChar[10] = "1111011" ; A
    $aDigChar[11] = "1100100" ; L
    $aDigChar[12] = "0001000" ; -
EndFunc   ;==>_initDigChar