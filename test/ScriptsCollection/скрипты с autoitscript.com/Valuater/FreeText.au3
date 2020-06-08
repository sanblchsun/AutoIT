#include-once
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>
; AutoIt Ver 3.2.12.0"

$FT_Ver = "Ver 2.5.2 " ; 11/26/2008

; By  Valuater... 8)

;Opt("MustDeclareVars", 1)
_FreeText_Functions()

Func _FreeText_Create($String, $Left = -1, $Top = -1, $Size = 50, $Color = "Black", $Font = "Arial", $Weight = 1000)
	Local $TL_S = StringSplit($String, ""), $T_GUI[UBound($TL_S)][2], $rgn, $Space = 2 ; Adjust as needed
	If $Left = -1 Then $Left = (@DesktopWidth * .5) - (($TL_S[0] * $Size) * .6) ; Adjust as needed
	If StringIsXDigit($Color) = 0 Then $Color = _GetColorByName($Color)
	For $x = 1 To $TL_S[0]
		$T_GUI[$x][0] = GUICreate("", $Size + $Space, $Size + $Space, $Left + ($x * ($Size + $Space)), $Top, $WS_POPUP, BitOR($WS_EX_TOPMOST, $WS_EX_TOOLWINDOW))
		GUISetBkColor($Color)
		$rgn = CreateTextRgn($T_GUI[$x][0], $TL_S[$x], $Size, $Font, $Weight)
		SetWindowRgn($T_GUI[$x][0], $rgn)
		$T_GUI[$x][1] = $TL_S[$x]
		GUISetState()
	Next
	Return $T_GUI
EndFunc   ;==>_FreeText_Create

Func _FreeText_CreateBackGround($Color = "Random", $trans = 200)
	If $Color = "Random" Then $Color = Random(0xFFFFFF, 0x2B1B1B1, 0)
	Local $BK_GUI = GUICreate("", @DesktopWidth, @DesktopHeight, 0, 0, $WS_POPUP, BitOR($WS_EX_TOPMOST, $WS_EX_TOOLWINDOW))
	GUISetBkColor($Color)
	GUISetState()
	WinSetTrans($BK_GUI, "", $trans)
	Return $BK_GUI
EndFunc   ;==>_FreeText_CreateBackGround

Func _FreeText_CreateBalls($Count, $Left = -1, $Top = -1, $Size = 40, $Color = "Random")
	Local $Arc = $Size * .5
	Local $Ball_GUI = FreeText_CreateMachine($Count, $Left, $Top, $Size + 10, $Color, $Arc, 1)
	Return $Ball_GUI
EndFunc   ;==>_FreeText_CreateBalls

Func _FreeText_CreateBlocks($Count, $Left = -1, $Top = -1, $Size = 20, $Color = "Random")
	Local $Block_GUI = FreeText_CreateMachine($Count, $Left, $Top, $Size, $Color)
	Return $Block_GUI
EndFunc   ;==>_FreeText_CreateBlocks

Func _FreeText_CreateCubes($Count, $Left = -1, $Top = -1, $Size = 20, $Color = "Random")
	Local $Arc = $Size * .2
	Local $Cube_GUI = FreeText_CreateMachine($Count, $Left, $Top, $Size, $Color, $Arc)
	Return $Cube_GUI
EndFunc   ;==>_FreeText_CreateCubes

Func _FreeText_CreateGlitter($Color = "Random", $Count = 100, $time = 4000, $delete = 0, $delay = 1)
	Local $Stars = FreeText_CreateMachine($Count, -1, -1, 7, $Color, 2); white for snow
	_FreeText_Scatter($Stars, 300, 1, 1, 0)
	If $time > 0 Then _FreeText_Rainbow($Stars, $time, $delay)
	If $delete Then $Stars = _FreeText_Delete($Stars)
	Return $Stars
EndFunc   ;==>_FreeText_CreateGlitter

Func _FreeText_Animate($T_GUI, $style = 1, $speed = 500)
	; $style - 1=Fade, 3=Explode, 5=L-Slide, 7=R-Slide, 9=T-Slide, 11=B-Slide,
	; $style - 13=TL-Diag-Slide, 15=TR-Diag-Slide, 17=BL-Diag-Slide, 19=BR-Diag-Slide
	If Not IsArray($T_GUI) Then Return 0
	Local $pick = StringSplit('80000,90000,40010,50010,40001,50002,40002,50001,40004,50008,40008,50004,40005,5000a,40006,50009,40009,50006,4000a,50005', ",")
	If $style > $pick[0] Then $style = 1
	For $x = 1 To UBound($T_GUI) - 1
		Local $ret = DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $T_GUI[$x][0], "int", $speed, "long", "0x000" & $pick[$style])
		Sleep(50)
	Next
	Return 1
EndFunc   ;==>_FreeText_Animate

Func _FreeText_Blink($T_GUI, $delay = 20, $reverse = 1)
	If Not IsArray($T_GUI) Then Return 0
	Local $1st = 1, $2nd = UBound($T_GUI) - 1, $how = 1
	If $reverse = "now" Then Local $2nd = 1, $1st = UBound($T_GUI) - 1, $how = -1
	For $x = $1st To $2nd Step $how
		Sleep($delay)
		GUISetState(@SW_HIDE, $T_GUI[$x][0])
		Sleep($delay)
		GUISetState(@SW_SHOW, $T_GUI[$x][0])
	Next
	Sleep($delay)
	If $reverse = 1 Then _FreeText_Blink($T_GUI, $delay, "now")
	Return 1
EndFunc   ;==>_FreeText_Blink

Func _FreeText_Bump($T_GUI, $bump = 15, $delay = 20, $reverse = 1)
	If Not IsArray($T_GUI) Then Return 0 ; same as Vertical Shockwave
	Local $1st = 1, $2nd = UBound($T_GUI) - 1, $how = 1, $Tpos
	If $reverse = "now" Then Local $2nd = 1, $1st = UBound($T_GUI) - 1, $how = -1
	For $x = $1st To $2nd Step $how
		$Tpos = WinGetPos($T_GUI[$x][0])
		Sleep($delay)
		WinMove($T_GUI[$x][0], "", $Tpos[0], $Tpos[1] + $bump)
		Sleep($delay)
		WinMove($T_GUI[$x][0], "", $Tpos[0], $Tpos[1] - $bump)
		Sleep($delay)
		WinMove($T_GUI[$x][0], "", $Tpos[0], $Tpos[1])
	Next
	If $reverse = 1 Then _FreeText_Bump($T_GUI, $bump, $delay, "now")
	Return 1
EndFunc   ;==>_FreeText_Bump

Func _FreeText_ColorStrobe($T_GUI, $delay = 20, $colors = "yellow,green,blue,Red", $reverse = 1)
	If Not IsArray($T_GUI) Then Return 0
	Local $1st = 1, $2nd = UBound($T_GUI) - 1, $how = 1, $rcolors = $colors, $Color_Hold, $Color
	If $reverse = "now" Then Local $2nd = 1, $1st = UBound($T_GUI) - 1, $how = -1
	$colors = StringSplit($colors, ",")
	For $i = 0 To UBound($colors) - 1
		$Color = $colors[$i]
		If StringIsXDigit($Color) = 0 Then $Color = _GetColorByName($Color)
		For $x = $1st To $2nd Step $how
			Sleep($delay)
			GUISetBkColor($Color, $T_GUI[$x][0])
		Next
	Next
	Sleep($delay)
	If $reverse = 1 Then _FreeText_ColorStrobe($T_GUI, $delay, $rcolors, "now")
	Return 1
EndFunc   ;==>_FreeText_ColorStrobe

Func _FreeText_Delete($T_GUI)
	If Not IsArray($T_GUI) Then Return 0
	For $x = 1 To UBound($T_GUI) - 1
		Sleep(1)
		GUIDelete($T_GUI[$x][0])
	Next
	Return 1
EndFunc   ;==>_FreeText_Delete

Func _FreeText_DeleteOne(ByRef $T_GUI, $Char_Number_or_Random = "Random")
	If Not IsArray($T_GUI) Then Return 0
	If StringIsXDigit($Char_Number_or_Random) = 0 Then $Char_Number_or_Random = _FreeText_Random($T_GUI)
	If $Char_Number_or_Random >= UBound($T_GUI) Then Return 0
	Local $1st = UBound($T_GUI, 1) - 1, $2nd = UBound($T_GUI, 2) - 1
	GUIDelete($T_GUI[$Char_Number_or_Random][0])
	For $i = $Char_Number_or_Random To $1st - 1
		For $x = 0 To $2nd
			$T_GUI[$i][$x] = $T_GUI[$i + 1][$x]
		Next
	Next
	ReDim $T_GUI[$1st][$2nd + 1]
	Return $T_GUI
EndFunc   ;==>_FreeText_DeleteOne

Func _FreeText_Explode($T_GUI, $delete = 1, $delay = 3)
	If Not IsArray($T_GUI) Then Return 0
	Local $cnt = 5, $Stars = FreeText_CreateMachine($cnt, 0, -10, 6, "random", 0, 0, @SW_HIDE)
	Local $Tpos, $RColor
	For $x = 1 To UBound($T_GUI) - 1
		Sleep($delay)
		$Tpos = WinGetPos($T_GUI[$x][0])
		For $s = 1 To $cnt
			WinMove($Stars[$s][0], "", $Tpos[0], $Tpos[1])
		Next
		For $c = 1 To $cnt
			GUISetState(@SW_SHOW, $Stars[$c][0])
		Next
		If $delete = 1 Then GUIDelete($T_GUI[$x][0])
		If $delete = 0 Then GUISetState(@SW_HIDE, $T_GUI[$x][0])
		_FreeText_Scatter($Stars, 40, 1, 1, 0)
		For $p = 1 To 6
			For $t = 1 To $cnt
				Sleep($delay)
				$RColor = Random(0xFFFFFF, 0x2B1B1B1, 0)
				GUISetBkColor($RColor, $Stars[$t][0])
				If $p = 6 Then GUISetState(@SW_HIDE, $Stars[$t][0])
			Next
		Next
	Next
	Return _FreeText_Delete($Stars)
EndFunc   ;==>_FreeText_Explode

Func _FreeText_ExplodeOne(ByRef $T_GUI, $Char_Number_or_Random = "Random", $delete = 1, $delay = 3)
	If Not IsArray($T_GUI) Then Return 0
	If StringIsXDigit($Char_Number_or_Random) = 0 Then $Char_Number_or_Random = _FreeText_Random($T_GUI)
	Local $cnt = 5, $Stars = FreeText_CreateMachine($cnt, 0, -10, 6, "random", 0, 0, @SW_HIDE)
	Local $Tpos, $RColor
	ConsoleWrite($Char_Number_or_Random & @CRLF)
	$Tpos = WinGetPos($T_GUI[$Char_Number_or_Random][0])
	For $s = 1 To $cnt
		WinMove($Stars[$s][0], "", $Tpos[0], $Tpos[1])
	Next
	For $c = 1 To $cnt
		GUISetState(@SW_SHOW, $Stars[$c][0])
	Next
	If $delete = 1 Then _FreeText_DeleteOne($T_GUI, $Char_Number_or_Random)
	If $delete = 0 Then GUISetState(@SW_HIDE, $T_GUI[$Char_Number_or_Random][0])
	_FreeText_Scatter($Stars, 40, 1, 1, 0)
	For $p = 1 To 6
		For $t = 1 To $cnt
			Sleep($delay)
			$RColor = Random(0xFFFFFF, 0x2B1B1B1, 0)
			GUISetBkColor($RColor, $Stars[$t][0])
			If $p = 6 Then GUISetState(@SW_HIDE, $Stars[$t][0])
		Next
	Next
	_FreeText_Delete($Stars)
	Return $T_GUI
EndFunc   ;==>_FreeText_ExplodeOne

Func _FreeText_FireWorks($T_GUI, $delete = 1, $speed = 3, $delay = 3)
	If Not IsArray($T_GUI) Then Return 0
	_FreeText_Implode($T_GUI, 0)
	Local $cnt = 5, $Stars = FreeText_CreateMachine($cnt, 0, -10, 6, "random", 0, 0, @SW_HIDE)
	Local $xr, $yr, $Tpos, $RColor
	For $x = 1 To UBound($T_GUI) - 1
		Sleep($delay)
		$xr = Random(-100, 100, 1)
		$yr = Random(150, 350, 1)
		$Tpos = WinGetPos($T_GUI[$x][0])
		WinMove($T_GUI[$x][0], "", $Tpos[0] + $xr, $Tpos[1] - $yr, $Tpos[2], $Tpos[3], $speed)
		For $s = 1 To $cnt
			WinMove($Stars[$s][0], "", $Tpos[0] + $xr, $Tpos[1] - $yr)
		Next
		For $c = 1 To $cnt
			GUISetState(@SW_SHOW, $Stars[$c][0])
		Next
		If $delete = 1 Then GUIDelete($T_GUI[$x][0])
		If $delete = 0 Then GUISetState(@SW_HIDE, $T_GUI[$x][0])
		_FreeText_Scatter($Stars, 40, 1, 1, 0)
		For $p = 1 To 6
			For $t = 1 To $cnt
				Sleep($delay)
				$RColor = Random(0xFFFFFF, 0x2B1B1B1, 0)
				GUISetBkColor($RColor, $Stars[$t][0])
				If $p = 6 Then GUISetState(@SW_HIDE, $Stars[$t][0])
			Next
		Next
	Next
	Return _FreeText_Delete($Stars)
EndFunc   ;==>_FreeText_FireWorks

Func _FreeText_GetPosition($T_GUI)
	If Not IsArray($T_GUI) Then Return 0
	Local $Tpos, $pHold[UBound($T_GUI)][2]
	For $x = 1 To UBound($T_GUI) - 1
		$Tpos = WinGetPos($T_GUI[$x][0])
		$pHold[$x][0] = $Tpos[0]
		$pHold[$x][1] = $Tpos[1]
	Next
	Return $pHold
EndFunc   ;==>_FreeText_GetPosition

Func _FreeText_HorseRace($T_GUI, $Distance = -1, $time = 60000, $speed = 2, $delay = 1)
	If Not IsArray($T_GUI) Then Return 0
	Local $Tpos, $iDif, $ibegin, $ret = _FreeText_GetPosition($T_GUI)
	Local $slpr = 700, $Run, $Trot
	If $Distance = -1 Then $Distance = @DesktopWidth - 250
	_FreeText_StairCase($T_GUI, -25, 2, 100, 0)
	Sleep($slpr)
	_FreeText_MoveVertical($T_GUI, 100, 20)
	Sleep($slpr)
	_FreeText_ShockWave($T_GUI)
	Sleep($slpr)
	$ibegin = TimerInit()
	While $iDif < $time
		Sleep($delay)
		$Run = Random(1, (UBound($T_GUI) - 1), 1)
		$Trot = Random(20, 200, 1)
		$Tpos = WinGetPos($T_GUI[$Run][0])
		WinMove($T_GUI[$Run][0], "", $Tpos[0] + $Trot, $Tpos[1], $Tpos[2], $Tpos[3], $speed)
		If $Tpos[0] >= $Distance Then Return $Run
		$iDif = TimerDiff($ibegin)
	WEnd
	Return _FreeText_SetPosition($T_GUI, $ret)
EndFunc   ;==>_FreeText_HorseRace

Func _FreeText_Implode($T_GUI, $delete = 0, $speed = 2, $delay = 20)
	If Not IsArray($T_GUI) Then Return 0
	Local $xr, $yr, $Tpos, $ret = _FreeText_GetPosition($T_GUI)
	Local $Width = @DesktopWidth, $Height = @DesktopHeight, $MidX = $Width / 2, $MidY = $Height / 2
	For $x = 1 To UBound($T_GUI) - 1
		Sleep($delay)
		$xr = Random(5, 25, 1)
		$yr = Random(5, 25, 1)
		$Tpos = WinGetPos($T_GUI[$x][0])
		WinMove($T_GUI[$x][0], "", $MidX + $xr, $MidY + $yr, $Tpos[2], $Tpos[3], $speed)
	Next
	If $delete Then $ret = _FreeText_Delete($T_GUI)
	Return $ret
EndFunc   ;==>_FreeText_Implode

Func _FreeText_MixUp($T_GUI, $speed = 2, $delay = 5)
	If Not IsArray($T_GUI) Then Return 0
	Local $Son = UBound($T_GUI) - 1, $Mom, $Dad, $Sis = _FreeText_GetPosition($T_GUI)
	For $Dad = 1 To $Son
		Sleep($delay)
		$Mom = Random(1, $Son, 1)
		_FreeText_MoveSwitch($T_GUI, $Dad, $Mom, 2)
	Next
	Return $Sis
EndFunc   ;==>_FreeText_MixUp

Func _FreeText_Move($T_GUI, $XX, $YY, $speed = 2, $delay = 20)
	If Not IsArray($T_GUI) Then Return 0
	Local $tHold = "", $Tpos
	For $x = 1 To UBound($T_GUI) - 1
		Sleep($delay)
		$Tpos = WinGetPos($T_GUI[$x][0])
		$tHold += $Tpos[2]
		WinMove($T_GUI[$x][0], "", $tHold + $XX, $YY, $Tpos[2], $Tpos[3], $speed)
		; The style will not allow a re-size of the GUI?? reset style ??
	Next
	Return 1
EndFunc   ;==>_FreeText_Move

Func _FreeText_MoveAsIs($T_GUI, $XX = 0, $YY = 0, $speed = 2, $delay = 20)
	If Not IsArray($T_GUI) Then Return 0
	If $XX = 0 And $YY = 0 Then Return 0
	For $x = 1 To UBound($T_GUI) - 1
		Sleep($delay)
		Local $Tpos = WinGetPos($T_GUI[$x][0])
		WinMove($T_GUI[$x][0], "", $Tpos[0] + $XX, $Tpos[1] + $YY, $Tpos[2], $Tpos[3], $speed)
	Next
	Return 1
EndFunc   ;==>_FreeText_MoveAsIs

Func _FreeText_MoveOne($T_GUI, $Char_Number, $XX, $YY, $speed = 2)
	If Not IsHWnd($T_GUI[$Char_Number][0]) Then Return 0
	If Not IsArray($T_GUI) Then Return 0
	Local $Tpos = WinGetPos($T_GUI[$Char_Number][0])
	WinMove($T_GUI[$Char_Number][0], "", $XX, $YY, $Tpos[2], $Tpos[3], $speed)
	Return $Tpos
EndFunc   ;==>_FreeText_MoveOne

Func _FreeText_MoveSwitch($T_GUI, $1st_Char, $2nd_Char, $speed = 2)
	If Not IsHWnd($T_GUI[$1st_Char][0]) Or Not IsHWnd($T_GUI[$2nd_Char][0]) Then Return 0
	If Not IsArray($T_GUI) Then Return 0
	Local $Opos = WinGetPos($T_GUI[$1st_Char][0])
	Local $Tpos = WinGetPos($T_GUI[$2nd_Char][0])
	WinMove($T_GUI[$1st_Char][0], "", $Tpos[0], $Tpos[1], $Tpos[2], $Tpos[3], $speed)
	WinMove($T_GUI[$2nd_Char][0], "", $Opos[0], $Opos[1], $Opos[2], $Opos[3], $speed)
	Return 1
EndFunc   ;==>_FreeText_MoveSwitch

Func _FreeText_MoveVertical($T_GUI, $XX, $YY, $speed = 2, $delay = 20)
	If Not IsArray($T_GUI) Then Return 0
	Local $tHold = "", $Tpos, $ret = _FreeText_GetPosition($T_GUI)
	For $x = 1 To UBound($T_GUI) - 1
		Sleep($delay)
		$Tpos = WinGetPos($T_GUI[$x][0])
		$tHold += $Tpos[3]
		WinMove($T_GUI[$x][0], "", $XX, $tHold + $YY, $Tpos[2], $Tpos[3], $speed)
	Next
	Return $ret
EndFunc   ;==>_FreeText_MoveVertical

Func _FreeText_Rain($T_GUI, $time = 30000, $speed = 1, $delay = 10)
	If Not IsArray($T_GUI) Then Return 0
	Local $Tpos, $iDif, $ibegin = TimerInit(), $ret = _FreeText_GetPosition($T_GUI)
	Local $yMax = @DesktopHeight - 200, $Rain, $Drop
	While $iDif < $time
		Sleep($delay)
		$Rain = Random(1, (UBound($T_GUI) - 1), 1)
		$Drop = Random(50, 300, 1)
		$Tpos = WinGetPos($T_GUI[$Rain][0])
		If $Tpos[1] >= $yMax Then
			$Tpos[1] = 0
			GUISetState(@SW_HIDE, $T_GUI[$Rain][0])
			WinMove($T_GUI[$Rain][0], "", $Tpos[0], $Tpos[1])
			GUISetState(@SW_SHOW, $T_GUI[$Rain][0])
		EndIf
		WinMove($T_GUI[$Rain][0], "", $Tpos[0], $Tpos[1] + $Drop, $Tpos[2], $Tpos[3], $speed)
		$iDif = TimerDiff($ibegin)
	WEnd
	Return _FreeText_SetPosition($T_GUI, $ret)
EndFunc   ;==>_FreeText_Rain

Func _FreeText_Rainbow($T_GUI, $time = 1000, $delay = 20, $iUse = 0)
	If Not IsArray($T_GUI) Then Return 0
	Local $iDif, $RColor, $ibegin = TimerInit()
	While $iDif < $time
		For $x = 1 To UBound($T_GUI) - 1
			Sleep($delay)
			$RColor = Random(0xFFFFFF, 0x2B1B1B1, 0)
			If $iUse = 0 Then GUISetBkColor($RColor, $T_GUI[$x][0])
			If $iUse = 1 Then GUICtrlSetColor($T_GUI[$x][1], $RColor)
		Next
		$iDif = TimerDiff($ibegin)
	WEnd
	Return 1
EndFunc   ;==>_FreeText_Rainbow

Func _FreeText_Random($T_GUI)
	If Not IsArray($T_GUI) Then Return 0
	If UBound($T_GUI) - 1 = 1 Then Return 1
	Local $rand = Random(1, UBound($T_GUI) - 1, 1)
	Return $rand ; $T_GUI[$rand][0]
EndFunc   ;==>_FreeText_Random

Func _FreeText_Scatter($T_GUI, $Step = 100, $speed = 2, $delay = 20, $reverse = 1)
	If Not IsArray($T_GUI) Then Return 0
	Local $Tpos, $pHold[UBound($T_GUI)][2], $xs, $ys, $xm, $ym, $xpos, $ypos
	For $x = 1 To UBound($T_GUI) - 1
		$Tpos = WinGetPos($T_GUI[$x][0])
		$pHold[$x][0] = $Tpos[0]
		$pHold[$x][1] = $Tpos[1]
		$xm = Random(1, $Step, 1)
		$ym = Random(1, $Step, 1)
		$xs = Random(1, 2, 1)
		$ys = Random(1, 2, 1)
		If $xs = 1 Then $xpos = $Tpos[0] + $xm
		If $xs = 2 Then $xpos = $Tpos[0] - $xm
		If $ys = 1 Then $ypos = $Tpos[1] + $ym
		If $ys = 2 Then $ypos = $Tpos[1] - $ym
		Sleep($delay)
		WinMove($T_GUI[$x][0], "", $xpos, $ypos, $Tpos[2], $Tpos[3], $speed)
	Next
	Sleep($delay)
	If $reverse = 1 Then Return _FreeText_SetPosition($T_GUI, $pHold)
	Return $pHold
EndFunc   ;==>_FreeText_Scatter

Func _FreeText_SetColor($T_GUI, $Color = "Black")
	If Not IsArray($T_GUI) Then Return 0
	If Not StringIsXDigit($Color) Then $Color = _GetColorByName($Color)
	For $x = 1 To UBound($T_GUI) - 1
		GUISetBkColor($Color, $T_GUI[$x][0])
	Next
	Return 1
EndFunc   ;==>_FreeText_SetColor

Func _FreeText_SetOneColor($T_GUI, $Char_Number, $Color = "black")
	If Not IsHWnd($T_GUI[$Char_Number][0]) Then Return 0
	If StringIsXDigit($Color) = 0 Then $Color = _GetColorByName($Color)
	GUISetBkColor($Color, $T_GUI[$Char_Number][0])
	Return 1
EndFunc   ;==>_FreeText_SetOneColor

Func _FreeText_SetParent($T_GUI, $h_parent, $delay = 50)
	If Not IsArray($T_GUI) Then Return 0
	Local $opt = Opt("WinTitleMatchMode", 2), $ret = 1
	If Not IsHWnd($h_parent) Then $h_parent = WinGetHandle($h_parent)
	For $x = 1 To UBound($T_GUI) - 1
		$ret = DllCall("user32.dll", "hwnd", "SetParent", "hwnd", $T_GUI[$x][0], "hwnd", $h_parent)
		Sleep($delay)
	Next
	If $ret <> 0 Then Return SetError(1, Opt("WinTitleMatchMode", $opt), 1)
	Return SetError(0, Opt("WinTitleMatchMode", $opt), 0)
EndFunc   ;==>_FreeText_SetParent

Func _FreeText_SetPosition($T_GUI, $xArray, $speed = 2, $delay = 20)
	If Not IsArray($T_GUI) Or Not IsArray($xArray) Then Return 0
	For $x = 1 To UBound($T_GUI) - 1
		Sleep($delay)
		Local $Tpos = WinGetPos($T_GUI[$x][0])
		WinMove($T_GUI[$x][0], "", $xArray[$x][0], $xArray[$x][1], $Tpos[2], $Tpos[3], $speed)
	Next
	Return 1
EndFunc   ;==>_FreeText_SetPosition

Func _FreeText_SetOneState($B_GUI, $Char_Number, $state = @SW_SHOW)
	If Not IsHWnd($B_GUI[$Char_Number][0]) Then Return 0
	GUISetState($state, $B_GUI[$Char_Number][1])
	Return 1
EndFunc   ;==>_FreeText_SetOneState

Func _FreeText_SetState($T_GUI, $state = @SW_SHOW, $delay = 10)
	If Not IsArray($T_GUI) Then Return 0
	For $x = 1 To UBound($T_GUI) - 1
		Sleep($delay)
		GUISetState($state, $T_GUI[$x][0])
	Next
	Return 1
EndFunc   ;==>_FreeText_SetState

Func _FreeText_SetTrans($T_GUI, $transparency = 255, $delay = 20)
	If Not IsArray($T_GUI) Then Return 0
	If $transparency > 255 Then $transparency = 255
	For $x = 1 To UBound($T_GUI) - 1
		Sleep($delay)
		WinSetTrans($T_GUI[$x][0], "", $transparency)
	Next
	Return 1
EndFunc   ;==>_FreeText_SetTrans

Func _FreeText_Shape_ClearText($B_GUI, $delay = 20)
	If Not IsArray($B_GUI) Then Return 0
	For $x = 1 To UBound($B_GUI) - 1
		Sleep($delay)
		GUICtrlSetData($B_GUI[$x][1], "")
	Next
	Return 1
EndFunc   ;==>_FreeText_Shape_ClearText

Func _FreeText_Shape_RainbowText($B_GUI, $time = 1000, $delay = 20)
	_FreeText_Rainbow($B_GUI, $time, $delay, 1)
	Return 1
EndFunc   ;==>_FreeText_Shape_RainbowText

Func _FreeText_Shape_SetText($B_GUI, $Text, $Size = 20, $Color = "black", $Font = "Arial", $Weight = 1000, $delay = 20)
	If Not IsArray($B_GUI) Then Return 0
	Local $TL_S = StringSplit($Text, ""), $tControl, $Tpos, $ret, $rgn
	If UBound($TL_S) > UBound($B_GUI) Then Return 0
	If StringIsXDigit($Color) = 0 Then $Color = _GetColorByName($Color)
	;_FreeText_Shape_ClearText($B_GUI, $delay)
	For $x = 1 To $TL_S[0]
		Sleep($delay)
		GUICtrlSetData($B_GUI[$x][1], $TL_S[$x])
		GUICtrlSetColor($B_GUI[$x][1], $Color)
		GUICtrlSetFont($B_GUI[$x][1], $Size, $Weight, "", $Font)
	Next
	Return 1
EndFunc   ;==>_FreeText_Shape_SetText

Func _FreeText_Shape_SetTextColor($B_GUI, $Color = "black", $delay = 20)
	If Not IsArray($B_GUI) Then Return 0
	If StringIsXDigit($Color) = 0 Then $Color = _GetColorByName($Color)
	For $x = 1 To UBound($B_GUI) - 1
		Sleep($delay)
		GUICtrlSetColor($B_GUI[$x][1], $Color)
	Next
	Return 1
EndFunc   ;==>_FreeText_Shape_SetTextColor

Func _FreeText_Shape_SetOneText($B_GUI, $Char_Number, $Text)
	If Not IsHWnd($B_GUI[$Char_Number][0]) Then Return 0
	GUICtrlSetData($B_GUI[$Char_Number][1], $Text)
	Return 1
EndFunc   ;==>_FreeText_Shape_SetOneText

Func _FreeText_Shape_SetOneTextColor($B_GUI, $Char_Number, $Color = "black")
	If Not IsHWnd($B_GUI[$Char_Number][0]) Then Return 0
	If StringIsXDigit($Color) = 0 Then $Color = _GetColorByName($Color)
	GUICtrlSetColor($B_GUI[$Char_Number][1], $Color)
	Return 1
EndFunc   ;==>_FreeText_Shape_SetOneTextColor

Func _FreeText_Shape_StrobeText($B_GUI, $delay = 20, $colors = "yellow,green,blue,Red", $reverse = 1)
	If Not IsArray($B_GUI) Then Return 0
	Local $1st = 1, $2nd = UBound($B_GUI) - 1, $how = 1, $rcolors = $colors, $Color_Hold, $Color
	If $reverse = "now" Then Local $2nd = 1, $1st = UBound($B_GUI) - 1, $how = -1
	$colors = StringSplit($colors, ",")
	For $i = 0 To UBound($colors) - 1
		$Color = $colors[$i]
		If StringIsXDigit($Color) = 0 Then $Color = _GetColorByName($Color)
		For $x = $1st To $2nd Step $how
			Sleep($delay)
			GUICtrlSetColor($B_GUI[$x][1], $Color)
		Next
	Next
	Sleep($delay)
	If $reverse = 1 Then _FreeText_Shape_StrobeText($B_GUI, $delay, $rcolors, "now")
	Return 1
EndFunc   ;==>_FreeText_Shape_StrobeText

Func _FreeText_ShockWave($T_GUI, $wave = 15, $delay = 20, $reverse = 1)
	If Not IsArray($T_GUI) Then Return 0 ; same as Vertical Bump
	Local $1st = 1, $2nd = UBound($T_GUI) - 1, $how = 1, $Tpos
	If $reverse = "now" Then Local $2nd = 1, $1st = UBound($T_GUI) - 1, $how = -1
	For $x = $1st To $2nd Step $how
		$Tpos = WinGetPos($T_GUI[$x][0])
		Sleep($delay)
		WinMove($T_GUI[$x][0], "", $Tpos[0] + $wave, $Tpos[1])
		Sleep($delay)
		WinMove($T_GUI[$x][0], "", $Tpos[0] - $wave, $Tpos[1])
		Sleep($delay)
		WinMove($T_GUI[$x][0], "", $Tpos[0], $Tpos[1])
	Next
	If $reverse = 1 Then _FreeText_ShockWave($T_GUI, $wave, $delay, "now")
	Return 1
EndFunc   ;==>_FreeText_ShockWave

Func _FreeText_SpinIn($T_GUI, $Points = 8, $delete = 1, $delay = 1, $Out = 0)
	Local Const $PI = 3.1415926535897932384626433832795 ; thanks green
	Local $Width = @DesktopWidth, $Height = @DesktopHeight, $MidX = $Width / 2, $MidY = $Height / 2
	Local $Radius = $MidY - 5, $Step = $PI / $Points
	If $Out Then $Radius = 5
	For $x = 1 To UBound($T_GUI) - 1
		While 1
			For $angle = 0 To 2 * $PI Step $Step
				Sleep($delay)
				If $Out = 0 Then $Radius -= 5
				If $Out = 1 Then $Radius += 5
				WinMove($T_GUI[$x][0], "", $MidX - (Cos($angle) * $Radius), $MidY - (Sin($angle) * $Radius))
			Next
			If $Out = 0 And $Radius <= 50 Then ExitLoop
			If $Out = 1 And $Radius >= $MidY Then ExitLoop
		WEnd
		If $delete Then GUIDelete($T_GUI[$x][0])
		If $Out = 0 Then $Radius = $MidY - 5
		If $Out = 1 Then $Radius = 5
	Next
	Return 1
EndFunc   ;==>_FreeText_SpinIn

Func _FreeText_SpinOut($T_GUI, $Points = 8, $delete = 1, $delay = 1)
	_FreeText_SpinIn($T_GUI, $Points, $delete, $delay, 1)
	Return 1
EndFunc   ;==>_FreeText_SpinOut

Func _FreeText_StairCase($T_GUI, $Step = 15, $speed = 1, $delay = 20, $reverse = 1)
	If Not IsArray($T_GUI) Then Return 0
	Local $1st = 1, $2nd = UBound($T_GUI) - 1, $how = 1, $Tpos, $Steps = $Step, $ret = 1
	If $reverse == "now" Then Local $2nd = 1, $1st = UBound($T_GUI) - 1, $how = -1
	If $reverse == 0 Then $ret = _FreeText_GetPosition($T_GUI)
	For $x = $1st To $2nd Step $how
		Sleep($delay)
		$Tpos = WinGetPos($T_GUI[$x][0])
		WinMove($T_GUI[$x][0], "", $Tpos[0], $Tpos[1] + $Steps, $Tpos[2], $Tpos[3], $speed)
		$Steps += $Step
	Next
	Sleep($delay)
	If $reverse = 1 Then _FreeText_StairCase($T_GUI, $Step, $speed, $delay, "now")
	Return $ret
EndFunc   ;==>_FreeText_StairCase

Func _FreeText_Functions()
	Local $fList = "", $aArray, $iPath
	$iPath = StringLeft(@AutoItExe, StringInStr(@AutoItExe, "\", 0, -1)) & "Include\FreeText.au3"
	If FileExists($iPath) Then $fList = $iPath
	If $fList = "" Then $iPath = StringLeft(@ScriptFullPath, StringInStr(@ScriptFullPath, "\", 0, -1)) & "FreeText.au3"
	If FileExists($iPath) Then $fList = $iPath
	If $fList = "" Then Return SetError(1, -1, 0)
	$aArray = StringSplit(FileRead($fList, FileGetSize($fList)), @LF)
	For $x = 1 To UBound($aArray) - 1
		If StringLeft($aArray[$x], 15) = "Func _FreeText_" Then ConsoleWrite(StringTrimLeft($aArray[$x], 4) & @LF)
	Next
EndFunc   ;==>_FreeText_Functions

; **************************************** Internal Functions *************************************
; *************************************************************************************************
; By Valuater...
Func FreeText_CreateMachine($Count, $Left = -1, $Top = -1, $Size = 20, $Color = "Black", $Arc = 0, $balls = 0, $show = @SW_SHOW)
	Local $B_GUI[($Count + 1)][2], $Space = 2 ; Adjust as needed
	If $Left = -1 Then $Left = (@DesktopWidth * .5) - (($Count * $Size) * .6) ; Adjust as needed
	If StringIsXDigit($Color) = 0 Then $Color = _GetColorByName($Color)
	For $x = 1 To $Count
		$B_GUI[$x][0] = GUICreate("", $Size + $Space, $Size + $Space, $Left + ($x * ($Size + $Space)), $Top, $WS_POPUP, BitOR($WS_EX_TOPMOST, $WS_EX_TOOLWINDOW))
		If $Color = "Random" Then $Color = Random(0xFFFFFF, 0x2B1B1B1, 0)
		GUISetBkColor($Color)
		If $balls == 0 Then
			$B_GUI[$x][1] = GUICtrlCreateLabel("", 2, 2, $Size + ($Space / 2), $Size + $Space, $SS_CENTER + $SS_CENTERIMAGE)
		Else
			$B_GUI[$x][1] = GUICtrlCreateLabel("", 10, 8, $Size + $Space, $Size + $Space, $SS_CENTER + $SS_CENTERIMAGE)
		EndIf
		If $Arc <> 0 Then _GuiRoundCorners($B_GUI[$x][0], $Arc, $Arc, $Arc, $Arc)
		GUISetState($show)
	Next
	Return $B_GUI
EndFunc   ;==>FreeText_CreateMachine

; Thanks Gary Frost... you learned me alot!  8)
Func _GuiRoundCorners($h_win, $i_x1, $i_y1, $i_x3, $i_y3)
	Local $XS_pos, $XS_ret, $XS_ret2
	$XS_pos = WinGetPos($h_win)
	$XS_ret = DllCall("gdi32.dll", "long", "CreateRoundRectRgn", "long", $i_x1, "long", $i_y1, "long", $XS_pos[2], "long", $XS_pos[3], "long", $i_x3, "long", $i_y3)
	If $XS_ret[0] Then
		$XS_ret2 = DllCall("user32.dll", "long", "SetWindowRgn", "hwnd", $h_win, "long", $XS_ret[0], "int", 1)
	EndIf
EndFunc   ;==>_GuiRoundCorners

Func _SetParent($h_child, $h_parent)
	Return DllCall("user32.dll", "hwnd", "SetParent", "hwnd", $h_child, "hwnd", $h_parent)
EndFunc   ;==>_SetParent

; Thanks Larry!
Func SetWindowRgn($h_win, $rgn)
	DllCall("user32.dll", "long", "SetWindowRgn", "hwnd", $h_win, "long", $rgn, "int", 1)
EndFunc   ;==>SetWindowRgn

Func CreateTextRgn(ByRef $CTR_hwnd, $CTR_Text, $CTR_height, $CTR_font = "Microsoft Sans Serif", $CTR_weight = 1000)
	Local Const $ANSI_CHARSET = 0
	Local Const $OUT_CHARACTER_PRECIS = 2
	Local Const $CLIP_DEFAULT_PRECIS = 0
	Local Const $PROOF_QUALITY = 2
	Local Const $FIXED_PITCH = 1
	Local Const $RGN_XOR = 3
	If $CTR_font = "" Then $CTR_font = "Microsoft Sans Serif"
	If $CTR_weight = -1 Then $CTR_weight = 1000
	Local $gdi_dll = DllOpen("gdi32.dll")
	Local $CTR_hDC = DllCall("user32.dll", "int", "GetDC", "hwnd", $CTR_hwnd)
	Local $CTR_hMyFont = DllCall($gdi_dll, "hwnd", "CreateFont", "int", $CTR_height, "int", 0, "int", 0, "int", 0, _
			"int", $CTR_weight, "int", 0, "int", 0, "int", 0, "int", $ANSI_CHARSET, "int", $OUT_CHARACTER_PRECIS, _
			"int", $CLIP_DEFAULT_PRECIS, "int", $PROOF_QUALITY, "int", $FIXED_PITCH, "str", $CTR_font)
	Local $CTR_hOldFont = DllCall($gdi_dll, "hwnd", "SelectObject", "int", $CTR_hDC[0], "hwnd", $CTR_hMyFont[0])
	DllCall($gdi_dll, "int", "BeginPath", "int", $CTR_hDC[0])
	DllCall($gdi_dll, "int", "TextOut", "int", $CTR_hDC[0], "int", 0, "int", 0, "str", $CTR_Text, "int", StringLen($CTR_Text))
	DllCall($gdi_dll, "int", "EndPath", "int", $CTR_hDC[0])
	Local $CTR_hRgn1 = DllCall($gdi_dll, "hwnd", "PathToRegion", "int", $CTR_hDC[0])
	Local $CTR_rc = DllStructCreate("int;int;int;int")
	DllCall($gdi_dll, "int", "GetRgnBox", "hwnd", $CTR_hRgn1[0], "ptr", DllStructGetPtr($CTR_rc))
	Local $CTR_hRgn2 = DllCall($gdi_dll, "hwnd", "CreateRectRgnIndirect", "ptr", DllStructGetPtr($CTR_rc))
	DllCall($gdi_dll, "int", "CombineRgn", "hwnd", $CTR_hRgn2[0], "hwnd", $CTR_hRgn2[0], "hwnd", $CTR_hRgn1[0], "int", $RGN_XOR)
	DllCall($gdi_dll, "int", "DeleteObject", "hwnd", $CTR_hRgn1[0])
	DllCall("user32.dll", "int", "ReleaseDC", "hwnd", $CTR_hwnd, "int", $CTR_hDC[0])
	DllCall($gdi_dll, "int", "SelectObject", "int", $CTR_hDC[0], "hwnd", $CTR_hOldFont[0])
	DllClose($gdi_dll)
	Return $CTR_hRgn2[0]
EndFunc   ;==>CreateTextRgn

; Created by Valuater, peethebee and XDrop 0.17
Func _GetColorByName($name)
	Select
		Case $name = "black"
			Return "0x000000"
		Case $name = "white"
			Return "0xffffff"
		Case $name = "red"
			Return "0xff0000"
		Case $name = "blue"
			Return "0x0000ff"
		Case $name = "green"
			Return "0x00ff00"
		Case $name = "yellow"
			Return "0xffff00"
		Case $name = "violet"
			Return "0xAE7BE1"
		Case $name = "win_xp_bg"
			Return "0xECE9D8"
		Case $name = "Random"
			Return "Random"
		Case Else
			Return "0x000000" ; just return black
	EndSelect
EndFunc   ;==>_GetColorByName

;     ENJOY!   Valuater... 8)

; ************************************* Testing Area *************************************************
; ****************************************************************************************************
;
; Arc the letters , Slideout, , clock,


