; http://www.autoitscript.com/forum/topic/135749-show-a-clock-over-a-full-screen-application/#entry948322
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Icone\Full ico\clock.ico
#AutoIt3Wrapper_UseX64=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <Date.au3>
#include <Timers.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GUIConstants.au3>
#include <GDIPlus.au3>
#include <String.au3>
#include <GuiMenu.au3>
#include <Misc.au3>
Opt("MustDeclareVars", 1)
Opt("GUIOnEventMode", 1)
Global $hGUI, $hGraphics, $hBackbuffer, $hBitmap, $hPen1, $hPen2, $hPen3, $hPen4
Global $iWidth = 600, $iHeight = $iWidth, $iW = $iWidth, $iH = $iHeight
Global Const $p2_hm = $iWidth / 35
Global Const $p3_hm = $iWidth / 35
Global Const $p4_hm = $iWidth / 100
Global $newY = $iWidth, $newX = $iHeight
Global Const $minSize = $iWidth * 0.25
Global Const $maxSize = $iWidth * 1.5
Global Const $cX = $iWidth * 0.5, $cY = $iHeight * 0.5
Global Const $deg = ACos(-1) / 180
Global Const $radius = $iWidth * 0.85, $cR = $radius * 0.50
Global Const $cR1 = $cR * 0.90, $cR2 = $cR * 0.20
Global Const $cR3 = $cR * 0.80, $cR4 = $cR * 0.15
Global Const $cR5 = $cR * 0.50, $cR6 = $cR * 0.10
Global $sek = @SEC * 6 - 90
Global $min = @MIN * 6 + (@SEC / 10) - 90
Global $std = @HOUR * 30 + (@MIN / 2) - 90
Global Const $fs = $iHeight / 30, $tms = $iHeight / 20, $tmh = $iHeight * 0.725
Global $x1, $y1, $x2, $y2, $x3, $y3, $x4, $y4, $x5, $x6, $y5, $y6, $tm
Global $T_Font, $T_Brush, $T_Format, $T_Family, $T_Layout, $T_String
Global $ScreenDc, $dc, $tSize, $pSize, $tSource, $pSource, $tBlend, $pBlend, $tPoint, $pPoint, $gdibitmap
Global $contextmenu, $button, $buttoncontext, $buttonitem
Global $newsubmenu, $textitem, $fileitem, $saveitem, $infoitem
Global $SliderGUI, $Trans, $Trans_Handle, $Size, $Size_Handle, $TransValue, $SizeValue
Global Enum $item1 = 1000, $item2, $item3, $item4, $item5, $item6
Global $title = "GDI+ Simple Clock by UEZ 2011 / "
Global $digi = 0 ; NSC 2011 / digital on/off
Global $cifre = 0 ; NSC 2011 / analog clock numbers or dots
Global $ampm = 0 ; NSC 2011 / analog clock AM PM on/off
Global $seconds = 0; NSC 2011 / analog clock seconds on/off
Opt("GUIOnEventMode", 1)
; ====== Create Properties GUI but hide it =====================
$SliderGUI = GUICreate("Properties", 220, 150, 100, 200)
GUISetOnEvent($GUI_EVENT_CLOSE, "SliderGUIhide", $SliderGUI)
GUICtrlCreateLabel("Transparency", 20, 5)
$Trans = GUICtrlCreateSlider(10, 20, 200, 20)
$Trans_Handle = GUICtrlGetHandle(-1)
GUICtrlSetLimit(-1, 255, 0) ; change min/max value
GUICtrlSetData($Trans, 125) ; set cursor
GUICtrlCreateLabel("Size", 20, 50)
$Size = GUICtrlCreateSlider(10, 65, 200, 20)
$Size_Handle = GUICtrlGetHandle(-1)
GUICtrlSetLimit(-1, 100, 10) ; change min/max value
GUICtrlSetData($Size, 100) ; set cursor
GUISetState(@SW_HIDE, $SliderGUI)
GUIRegisterMsg($WM_HSCROLL, "WM_H_Slider")
;==============================================================
; Initialize GDI+
_GDIPlus_Startup()
$hGUI = GUICreate($title, $iWidth, $iHeight, -1, -1, 0, $WS_EX_LAYERED + $WS_EX_TOPMOST)
;If @OSBuild < 7600 Then WinSetTrans($hGui,"", 0xFF)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
GUIRegisterMsg($WM_MOUSEWHEEL, "WM_MOUSEWHEEL") ;Adjust Trans
$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
$hBitmap = _GDIPlus_BitmapCreateFromGraphics($iWidth, $iHeight, $hGraphics)
$hBackbuffer = _GDIPlus_ImageGetGraphicsContext($hBitmap)
; _WinAPI_UpdateLayeredWindow parameters
$tSize = DllStructCreate($tagSIZE)
$pSize = DllStructGetPtr($tSize)
DllStructSetData($tSize, "X", $iWidth)
DllStructSetData($tSize, "Y", $iHeight)
$tSource = DllStructCreate($tagPOINT)
$pSource = DllStructGetPtr($tSource)
Global $alpha = 200
Global $alpha_steps = 5
$tBlend = DllStructCreate($tagBLENDFUNCTION)
$pBlend = DllStructGetPtr($tBlend)
DllStructSetData($tBlend, "Alpha", $alpha)
DllStructSetData($tBlend, "Format", 1)
$tPoint = DllStructCreate($tagPOINT) ; For Custom Line Caps
$pPoint = DllStructGetPtr($tPoint)
DllStructSetData($tPoint, "X", 0)
DllStructSetData($tPoint, "Y", 0)
GUISetState()
Global $aPos = WinGetPos($hGUI)
GUIRegisterMsg($WM_NCHITTEST, "WM_NCHITTEST") ;Drag Window
GUIRegisterMsg($WM_MOUSEWHEEL, "WM_MOUSEWHEEL") ;Adjust Trans
GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")
$ScreenDc = _WinAPI_GetDC($hGUI)
$gdibitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap)
$dc = _WinAPI_CreateCompatibleDC($ScreenDc)
_WinAPI_SelectObject($dc, $gdibitmap)
; Using antialiasing
_GDIPlus_GraphicsSetSmoothingMode($hBackbuffer, 2)
DllCall($ghGDIPDll, "uint", "GdipSetTextRenderingHint", "handle", $hBackbuffer, "int", 3)
; Create a Pen object
$hPen1 = _GDIPlus_PenCreate(0xFF800010, 4)
$hPen2 = _GDIPlus_PenCreate(0xA01010F0, $p2_hm)
$hPen3 = _GDIPlus_PenCreate(0xA01010F0, $p3_hm)
$hPen4 = _GDIPlus_PenCreate(0x9010D040, $p4_hm)
Global Const $LineCapRound = 2, $LineCapTriangle = 3, $DashCapFlat = 0
Global $hPath, $hCustomLineCap, $avCaps
Global $avPoints[3][2] = [[2],[0, 0],[0, 0]]
$hPath = _GDIPlus_PathCreate()
_GDIPlus_PathAddLines($hPath, $avPoints)
$hCustomLineCap = _GDIPlus_CustomLineCapCreate(0, $hPath)
_GDIPlus_CustomLineCapSetStrokeCaps($hCustomLineCap, $LineCapTriangle, $LineCapRound)
$avCaps = _GDIPlus_CustomLineCapGetStrokeCaps($hCustomLineCap)
_GDIPlus_PenSetLineCap($hPen2, $avCaps[0], $avCaps[1], $DashCapFlat)
_GDIPlus_PenSetLineCap($hPen3, $avCaps[0], $avCaps[1], $DashCapFlat)
_GDIPlus_PenSetLineCap($hPen4, $avCaps[0], $avCaps[1], $DashCapFlat)
Global $ws = WinGetPos($hGUI)
Global $ratio = $ws[3] / $ws[2]
Global $font = "Verdana"
If FileExists(@WindowsDir & "\fonts\Copperplate Gothic Bold") Then $font = "Copperplate Gothic Bold"
;Time init
$T_Brush = _GDIPlus_BrushCreateSolid(0xFF008080)
$T_Format = _GDIPlus_StringFormatCreate()
$T_Family = _GDIPlus_FontFamilyCreate("Verdana")
$T_Font = _GDIPlus_FontCreate($T_Family, 32, 3)
$T_Layout = _GDIPlus_RectFCreate(0, 0, $iWidth, 80)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
AdlibRegister("Ticker", 50)
Global $timer = 100, $speak = False, $speak_init = True, $SpeakingClock = True
Global $oVoice = ObjCreate("SAPI.SpVoice")
If @error Then
	$speak_init = False
Else
	$oVoice.Rate = -3
EndIf
GUIRegisterMsg($WM_TIMER, "Draw") ;$WM_TIMER = 0x0113
DllCall("User32.dll", "int", "SetTimer", "hwnd", $hGUI, "int", 0, "int", $timer, "int", 0)
AdlibRegister("SpeakingClock", 1000)
While Sleep(100000000)
WEnd
Func Draw()
	_GDIPlus_GraphicsClear($hBackbuffer, 0x00000000)
	_GDIPlus_GraphicsDrawLine($hBackbuffer, $cX - $cR, $cY, $cX - $cR + 35, $cY, $hPen1)
	_GDIPlus_GraphicsDrawLine($hBackbuffer, $cX + $cR, $cY, $cX + $cR - 35, $cY, $hPen1)
	_GDIPlus_GraphicsDrawLine($hBackbuffer, $cX, $cY - $cR, $cX, $cY - $cR + 35, $hPen1)
	_GDIPlus_GraphicsDrawLine($hBackbuffer, $cX, $cY + $cR, $cX, $cY + $cR - 35, $hPen1)
	_GDIPlus_GraphicsDrawEllipse($hBackbuffer, $cX - $cR, $cY - $cR, $radius, $radius, $hPen1)
	If $cifre = 1 Then ;analog clock numbers or dots
		For $i = 0 To 11
			_GDIPlus_GraphicsDrawString($hBackbuffer, $i + 1, -$fs / 2 + $cX + Cos(-45 + $i * 29.7 * $deg) * $cR3, -$fs * 0.9 + $cY + Sin(-45 + $i * 29.7 * $deg) * $cR3, $font, $fs)
		Next
	Else
		For $i = 0 To 11
			_GDIPlus_GraphicsDrawString($hBackbuffer, "•", -$fs / 2 + $cX + Cos(-45 + $i * 29.7 * $deg) * $cR3, -$fs * 0.9 + $cY + Sin(-45 + $i * 29.7 * $deg) * $cR3, $font, $fs)
		Next
	EndIf
	If $ampm = 1 Then ;analog clock AM PM on off
		If Int(StringLeft(_NowTime(4), 2) / 12) Then
			$tm = "PM"
		Else
			$tm = "AM"
		EndIf
	Else
		$tm = ""
	EndIf
	_GDIPlus_GraphicsDrawString($hBackbuffer, $tm, -$tms * 1.1 + $cX, $tmh, $font, $tms)
	$x5 = $cX + Cos($std * $deg) * $cR5
	$y5 = $cY + Sin($std * $deg) * $cR5
	_GDIPlus_GraphicsDrawLine($hBackbuffer, $x5, $y5, $cX, $cY, $hPen2) ;hours
	$x3 = $cX + Cos($min * $deg) * $cR3
	$y3 = $cY + Sin($min * $deg) * $cR3
	_GDIPlus_GraphicsDrawLine($hBackbuffer, $x3, $y3, $cX, $cY, $hPen3) ;minutes
	$x1 = $cX + Cos($sek * $deg) * $cR1
	$y1 = $cY + Sin($sek * $deg) * $cR1
	$x2 = $cX + Cos(($sek + 180) * $deg) * $cR2
	$y2 = $cY + Sin(($sek + 180) * $deg) * $cR2
	If $seconds = 1 Then _GDIPlus_GraphicsDrawLine($hBackbuffer, Floor($x1), Floor($y1), Floor($x2), Floor($y2), $hPen4) ;seconds ON / OFF
	_GDIPlus_GraphicsDrawEllipse($hBackbuffer, $cX - 3, $cY - 3, 6, 6, $hPen1)
	;   <<<< ================= Digital Time =======================
	If $digi = 1 Then DrawTime() ;digital clock on/off
	;   =========  Update layered Window  ============================
	; creates an empty bitmap with the new size, This bitmap will be used for the transparent GUI.
	Local $hBmp = DllCall($ghGDIPDll, "uint", "GdipCreateBitmapFromScan0", "int", $iW, "int", $iH, "int", 0, "int", 0x0026200A, "ptr", 0, "int*", 0)
	$hBmp = $hBmp[6]
	Local $hContext = _GDIPlus_ImageGetGraphicsContext($hBmp)
	_GDIPlus_GraphicsDrawImageRect($hContext, $hBitmap, 0, 0, $iW, $iH)
	$gdibitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBmp)
	_WinAPI_SelectObject($dc, $gdibitmap)
	DllStructSetData($tSize, "X", $iW)
	DllStructSetData($tSize, "Y", $iH)
	_WinAPI_UpdateLayeredWindow($hGUI, $ScreenDc, 0, $pSize, $dc, $pSource, 0, $pBlend, 2)
	_WinAPI_DeleteObject($gdibitmap)
	_WinAPI_RedrawWindow($hGUI)
	_GDIPlus_GraphicsDispose($hContext)
	_GDIPlus_BitmapDispose($hBmp)
EndFunc
;=================================================================
; ================== Draw the digital time =============================
Func DrawTime()
	Local $sString, $aSize
	;   WinSetTitle($hGui, "", $title & @HOUR & ":" & @MIN & ":" & @SEC)
	$sString = StringFormat("%02d:%02d:%02d", @HOUR, @MIN, @SEC)
	$aSize = _GDIPlus_GraphicsMeasureString($hBackbuffer, $sString, $T_Font, $T_Layout, $T_Format)
	DllStructSetData($T_Layout, "X", (DllStructGetData($aSize[0], "Width") * 0.77)) ; Middle of Window
	DllStructSetData($T_Layout, "Y", (DllStructGetData($aSize[0], "Height") - 64)) ; Clock at Top
	_GDIPlus_GraphicsDrawStringEx($hBackbuffer, $sString, $T_Font, $T_Layout, $T_Format, $T_Brush)
EndFunc
; ============= Handle the WM_NCHITTEST message  ===============
Func WM_NCHITTEST($hWnd, $iMsg, $iwParam, $ilParam)
	Local $hMenu, $Win, $WinX, $WinY, $mX, $mY
	If $hWnd = $hGUI And _IsPressed(01) Then Return $HTCAPTION
	If $hWnd = $hGUI And _IsPressed(02) Then
		; ConsoleWrite($GUI &" HIT!! "&@CRLF)
		#cs
			$WinPos = WingetPos($GUI)
			$WinX = $WinPos[0]
			$WinY = $WinPos[0]
			$aPos = MouseGetPos()
			$mX = $aPos [0]
			$mY = $aPos [1]
			ConsoleWrite("MouseCoords = " &$WinX + $mX &" " &$WinY + $mY &@CRLF)
		#ce
		$hMenu = _GUICtrlMenu_CreatePopup()
		_GUICtrlMenu_InsertMenuItem($hMenu, 0, "Properties", $item1)
		_GUICtrlMenu_InsertMenuItem($hMenu, 1, "Digital On/Off", $item2)
		_GUICtrlMenu_InsertMenuItem($hMenu, 2, "Numbers / Dots", $item3)
		_GUICtrlMenu_InsertMenuItem($hMenu, 3, "AM/PM  On/Off", $item4)
		_GUICtrlMenu_InsertMenuItem($hMenu, 3, "Seconds  On/Off", $item5)
		_GUICtrlMenu_InsertMenuItem($hMenu, 5, "", 0)
		_GUICtrlMenu_InsertMenuItem($hMenu, 6, "Exit", $item6)
		_GUICtrlMenu_TrackPopupMenu($hMenu, $hGUI, -1, -1, 1, 0)
		_GUICtrlMenu_DestroyMenu($hMenu)
		Return True
	EndIf
EndFunc
;==================================================================
; =========  Handle WM_COMMAND messages =======================
Func WM_COMMAND($hWnd, $iMsg, $iwParam, $ilParam)
	Switch $iwParam
		Case $item1
			Properties()
			ConsoleWrite("Item 1 = " & $item1 & @CRLF)
		Case $item2
			If $digi = 1 Then ;NSC 2011 on off digital clock
				$digi = 0
			Else
				$digi = 1
			EndIf
			ConsoleWrite("Item 2 = " & $item2 & @CRLF)
		Case $item3
			If $cifre = 1 Then ;NSC 2011 analog clock numbers or dots
				$cifre = 0
			Else
				$cifre = 1
			EndIf
		Case $item4
			If $ampm = 1 Then ;NSC 2011 analog clock AM PM on off
				$ampm = 0
			Else
				$ampm = 1
			EndIf
		Case $item5
			If $seconds = 1 Then ;NSC 2011 analog clock seconds on off
				$seconds = 0
			Else
				$seconds = 1
			EndIf
		Case $item6
			_Exit()
			ConsoleWrite("Item 5 = " & $item3 & @CRLF)
	EndSwitch
EndFunc
;=============================================================
Func Properties()
	GUISetState(@SW_SHOW, $SliderGUI)
EndFunc
Func SliderGUIhide()
	GUISetState(@SW_HIDE, $SliderGUI)
EndFunc
; ============ React to slider movement ========================
Func WM_H_Slider($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $wParam
	If $lParam = $Trans_Handle Then
		$TransValue = GUICtrlRead($Trans)
		DllStructSetData($tBlend, "Alpha", $TransValue) ; Set Alpha (Transparency) Level
		DllStructSetData($tBlend, "Format", 1)
		ToolTip($TransValue)
	EndIf
	If $lParam = $Size_Handle Then
		$SizeValue = GUICtrlRead($Size)
		$iW = $iWidth * $SizeValue * 0.01
		$iH = $iHeight * $SizeValue * 0.01
	EndIf
	Return "GUI_RUNDEFMSG"
EndFunc
;===============================================================
; MouseWheel for Win Trans
Func WM_MOUSEWHEEL($hWnd, $iMsg, $wParam, $lParam)
	Local $mouseData, $n1
	$mouseData = _WinAPI_HiWord($wParam) ;/ $WHEEL_DELTA
	Select
		;WM_MOUSEWHEEL = 0x020A
		Case WinActive($hGUI)
			If $mouseData > 0 Then ;wheel up
				If $alpha + $alpha_steps <= 512 Then $alpha += $alpha_steps
				Switch $alpha
					Case 0 To 255
						DllStructSetData($tBlend, "Alpha", $alpha) ; Set Alpha (Transparency) Level
						DllStructSetData($tBlend, "Format", 1)
					Case 256 To 512
						DllStructSetData($tBlend, "Alpha", $alpha - 256)
						DllStructSetData($tBlend, "Format", 0)
				EndSwitch
			Else ;wheel down
				If $alpha - $alpha_steps > 0 Then $alpha -= $alpha_steps
				Switch $alpha
					Case 0 To 255
						DllStructSetData($tBlend, "Alpha", $alpha) ;wheel up
						DllStructSetData($tBlend, "Format", 1)
					Case 256 To 512
						DllStructSetData($tBlend, "Alpha", $alpha - 256) ;wheel up
						DllStructSetData($tBlend, "Format", 0)
				EndSwitch
			EndIf
			ConsoleWrite($alpha & @CRLF)
	EndSelect
EndFunc
Func SpeakingClock()
	;   If  $min = -90.00 And $speak_init And $SpeakingClock Then $oVoice.Speak("It is " & Mod(@HOUR, 12) & " " & $tm, 1)
EndFunc
Func Ticker()
	$sek = @SEC * 6 - 90
	$min = @MIN * 6 + (@SEC * 0.10) - 90
	$std = @HOUR * 30 + (@MIN * 0.50) - 90
EndFunc
Func _Exit()
	AdlibUnRegister("Ticker")
	AdlibUnRegister("SpeakingClock")
	$oVoice = 0
	GUIRegisterMsg($WM_TIMER, "")
	GUIRegisterMsg($WM_GETMINMAXINFO, "")
	GUIRegisterMsg($WM_SIZE, "")
	GUIRegisterMsg($WM_ERASEBKGND, "")
	GUIRegisterMsg($WM_SIZING, "")
	_WinAPI_DeleteDC($dc)
	_WinAPI_ReleaseDC($hGUI, $ScreenDc)
	; Clean up GDI+ resources
	_GDIPlus_CustomLineCapDispose($hCustomLineCap)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_PenDispose($hPen1)
	_GDIPlus_PenDispose($hPen2)
	_GDIPlus_PenDispose($hPen3)
	_GDIPlus_PenDispose($hPen4)
	_GDIPlus_BitmapDispose($hBitmap)
	_GDIPlus_GraphicsDispose($hBackbuffer)
	_GDIPlus_GraphicsDispose($hGraphics)
	_GDIPlus_FontDispose($T_Font)
	_GDIPlus_FontFamilyDispose($T_Family)
	_GDIPlus_StringFormatDispose($T_Format)
	_GDIPlus_BrushDispose($T_Brush)
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
	GUIDelete($hGUI)
	Exit
EndFunc
Func _GDIPlus_PathCreate($iFillMode = 0)
	Local $aResult = DllCall($ghGDIPDll, "uint", "GdipCreatePath", "int", $iFillMode, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return $aResult[2]
EndFunc
Func _GDIPlus_PathAddLines($hPath, $aPoints)
	Local $iI, $iCount, $pPoints, $tPoints, $aResult
	$iCount = $aPoints[0][0]
	$tPoints = DllStructCreate("float[" & $iCount * 2 & "]")
	$pPoints = DllStructGetPtr($tPoints)
	For $iI = 1 To $iCount
		DllStructSetData($tPoints, 1, $aPoints[$iI][0], (($iI - 1) * 2) + 1)
		DllStructSetData($tPoints, 1, $aPoints[$iI][1], (($iI - 1) * 2) + 2)
	Next
	$aResult = DllCall($ghGDIPDll, "uint", "GdipAddPathLine2", "hwnd", $hPath, "ptr", $pPoints, "int", $iCount)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc
Func _GDIPlus_PathDispose($hPath)
	Local $aResult = DllCall($ghGDIPDll, "uint", "GdipDeletePath", "hwnd", $hPath)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc
Func _GDIPlus_CustomLineCapCreate($hPathFill, $hPathStroke, $iLineCap = 0, $nBaseInset = 0)
	Local $aResult = DllCall($ghGDIPDll, "uint", "GdipCreateCustomLineCap", "hwnd", $hPathFill, "hwnd", $hPathStroke, "int", $iLineCap, "float", $nBaseInset, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return $aResult[5]
EndFunc
Func _GDIPlus_CustomLineCapSetStrokeCaps($hCustomLineCap, $iStartCap, $iEndCap)
	Local $aResult = DllCall($ghGDIPDll, "uint", "GdipSetCustomLineCapStrokeCaps", "hwnd", $hCustomLineCap, "int", $iStartCap, "int", $iEndCap)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc
Func _GDIPlus_CustomLineCapGetStrokeCaps($hCustomLineCap)
	Local $aCaps[2], $aResult
	$aResult = DllCall($ghGDIPDll, "uint", "GdipGetCustomLineCapStrokeCaps", "hwnd", $hCustomLineCap, "int*", 0, "int*", 0)
	If @error Then Return SetError(@error, @extended, -1)
	If $aResult[0] Then Return -1
	$aCaps[0] = $aResult[2]
	$aCaps[1] = $aResult[3]
	Return $aCaps
EndFunc
Func _GDIPlus_PenSetLineCap($hPen, $iStartCap, $iEndCap, $iDashCap)
	Local $aResult = DllCall($ghGDIPDll, "uint", "GdipSetPenLineCap197819", "hwnd", $hPen, "int", $iStartCap, "int", $iEndCap, "int", $iDashCap)
	If @error Then Return SetError(@error, @extended, False)
	Return $aResult[0] = 0
EndFunc