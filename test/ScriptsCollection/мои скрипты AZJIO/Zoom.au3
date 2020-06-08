#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=Zoom.exe
#AutoIt3Wrapper_Icon=Zoom.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=Zoom.exe
#AutoIt3Wrapper_Res_Fileversion=0.1.0.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Field=Version|0.1
#AutoIt3Wrapper_Res_Field=Build|2012.06.15
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

; Стартовой темой для создания утилиты послужил пример от greenmachine, который можно увидеть по ниже указанной ссылке
; greenmachine
; http://www.autoitscript.com/forum/topic/24154-au3-zoom/page__p__168674#entry168674

#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WinAPI.au3>
#include <Color.au3>
#include <ButtonConstants.au3>
#include <Misc.au3>

Opt("GUIResizeMode", 802)
Opt("GUIOnEventMode", 1)

; En
$LngTitle = 'Zoom'
$LngAbout = 'About'
$LngVer = 'Version'
$LngSite = 'Site'
$LngCopy = 'Copy'
$LngClr = 'Color'
$LngCrd = 'Coord'
$LngHue = 'Hue'
$LngSaturation = 'Saturation'
$LngLightness = 'Lightness'
$LngRed = 'Red'
$LngGreen = 'Green'
$LngBlue = 'Blue'
$LngHLP1 = 'The first program start Zoom'
$LngHLP2 = 'Use the Esc key to close the magnifier, re-Esc - exit from the program.' & @CRLF & 'The mouse wheel controls the zoom.' & @CRLF & 'Hold down the Ctrl or Shift key and rotating the mouse wheel you can change the size of the magnifier.' & @CRLF & 'At the close the magnifier, color coordinates are copied to the clipboard. In the configuration file Zoom.ini can set some parameters. More details can be found in Readme.txt.'

; Ru
; если русская локализация, то русский язык
If @OSLang = 0419 Then
	$LngAbout = 'О программе'
	$LngVer = 'Версия'
	$LngSite = 'Сайт'
	$LngCopy = 'Копировать'
	$LngClr = 'Цвет'
	$LngCrd = 'Координаты'
	$LngHue = 'Тон'
	$LngSaturation = 'Насыщенность'
	$LngLightness = 'Светлота'
	$LngRed = 'Красный'
	$LngGreen = 'Зелёный'
	$LngBlue = 'Синий'
	$LngHLP1 = 'Первый запуск программы Zoom'
	$LngHLP2 = 'Esc - выход из программы.' & @CRLF & 'Колёсико мыши изменяет увеличение.' & @CRLF & 'Используя колёсико с одновременным удержанием одной из клавиш Ctrl, Shift позволит изменять размер окна увеличителя.' & @CRLF & 'При выходе цвет и координаты копируются в буфер обмена. В конфигурационном файле Zoom.ini можно установить некоторые параметры. Более подробнее можно прочитать в Readme.txt.'
EndIf

Global $HSB[3] = [40, 240, 185], $RGB[3]

; установка параметров
Global $Zoom, $CaptureWidth, $CaptureHeight, $GuiWidth, $GuiHeight, $LastZoom, $Color, $Tr1 = 1, $Ini = @ScriptDir & '\Zoom.ini'
; $d = Int($CaptureWidth/2 + 5)

If Not FileExists($Ini) And DriveStatus(StringLeft(@ScriptDir, 1)) <> 'NOTREADY' Then
	$hFile = FileOpen($Ini, 2)
	FileWrite($hFile, _
			'[Set]' & @CRLF & _
			'FirstStart=0' & @CRLF & _
			'Clipboard=%c, %x, %y' & @CRLF & _
			'SightColor=FF0000' & @CRLF & _
			'SightWidth=2' & @CRLF & _
			'Zoom=4' & @CRLF & _
			'Region=40')
	FileClose($hFile)
EndIf

			; 'SetCoord=0' & @CRLF & _
; $SetCoord = Number(IniRead($Ini, 'Set', 'SetCoord', 0))
$Zoom = Number(IniRead($Ini, 'Set', 'Zoom', 4))
If $Zoom < 2 Then $Zoom = 2
If $Zoom > 50 Then $Zoom = 50
$CaptureWidth = Number(IniRead($Ini, 'Set', 'Region', 40))
If $CaptureWidth * $Zoom > @DesktopHeight Then $CaptureWidth = @DesktopHeight / $Zoom - @DesktopHeight / $Zoom / 3
If $CaptureWidth < 10 Then $CaptureWidth = 10
If $CaptureWidth > 200 Then $CaptureWidth = 200
$CaptureHeight = $CaptureWidth
$GuiWidth = $CaptureWidth * $Zoom
$GuiHeight = $GuiWidth
$SightColor = (IniRead($Ini, 'Set', 'SightColor', 'FF0000'))
$SightColor = Dec(StringRight($SightColor, 2) & StringMid($SightColor, 3, 2) & StringLeft($SightColor, 2))
$Clipboard = IniRead($Ini, 'Set', 'Clipboard', '%c%x%y')
$SightWidth = Number(IniRead($Ini, 'Set', 'SightWidth', 4))
If $SightWidth < 1 Then $SightWidth = 1
If $SightWidth > 5 Then $SightWidth = 5
$FirstStart = Number(IniRead($Ini, 'Set', 'FirstStart', 0))
If Not $FirstStart Then
	MsgBox(0, $LngHLP1, $LngHLP2)
	IniWrite($Ini, 'Set', 'FirstStart', 1)
EndIf

; Global $SRCCOPY = 0x00CC0020
Global $user32_dll, $gdi32_dll, $DeskHDC, $hGuiHDC, $hGui, $hGuiClr, $AccelKeys, $iLbClr, $iStrClr, $LastPos, $hPen, $hGuiMain, $TrgSt = 0

$user32_dll = DllOpen("user32.dll")
$gdi32_dll = DllOpen("gdi32.dll")
$LastPos = MouseGetPos()

If @Compiled Then
	$AutoItExe = @AutoItExe
Else
	$AutoItExe = @ScriptDir & '\Zoom.ico'
EndIf

$hGuiMain = GUICreate($LngTitle, 340, 300)
GUISetIcon($AutoItExe, 0)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Quit")

GUICtrlCreateButton('@', 0, 0, 18, 18)
GUICtrlSetOnEvent(-1, "_About")

$iZoom = GUICtrlCreateButton('Zoom', 290, 20, 40, 40, $BS_ICON)
GUICtrlSetImage(-1, $AutoItExe, 0)
GUICtrlSetOnEvent(-1, "_Create_GUI")

$iColorLabel = GUICtrlCreateLabel('', 90, 15, 100, 50, $WS_BORDER)
GUICtrlSetOnEvent(-1, "_SelColor")

GUICtrlCreateLabel($LngClr, 20, 3, 60, 17, $SS_CENTERIMAGE + $SS_CENTER)
$iHexLabel = GUICtrlCreateInput('', 5, 20, 75, 20)
$iDecLabel = GUICtrlCreateInput('', 5, 43, 75, 20)

GUICtrlCreateLabel($LngCrd, 200, 3, 80, 17, $SS_CENTERIMAGE + $SS_CENTER)
GUICtrlCreateLabel('X:', 200, 22, 20, 17, $SS_RIGHT)
GUICtrlCreateLabel('Y:', 200, 45, 20, 17, $SS_RIGHT)
$iCoordX = GUICtrlCreateInput('', 224, 20, 40, 20)
$iCoordY = GUICtrlCreateInput('', 224, 43, 40, 20)

; $iSetCoordCh = GUICtrlCreateCheckbox('', 270, 30, 17, 17)
; GUICtrlSetOnEvent(-1, "_SetCoordCh")
; If $SetCoord Then GUICtrlSetState(-1, 1)

GUICtrlCreateGroup('HSL', 3, 75, 333, 103)
GUICtrlCreateGroup('RGB', 3, 185, 333, 103)

GUICtrlCreateLabel($LngHue, 10, 91, 80, 17)
$iValSld1 = GUICtrlCreateLabel($HSB[0], 300, 90, 30, 17)
$slider1 = GUICtrlCreateSlider(90, 85, 200, 30)
GUICtrlSetLimit(-1, 240, 0)
GUICtrlSetData(-1, $HSB[0])
$hSlider_Handle1 = GUICtrlGetHandle(-1)

GUICtrlCreateLabel($LngSaturation, 10, 121, 80, 17)
$iValSld2 = GUICtrlCreateLabel($HSB[1], 300, 120, 30, 17)
$slider2 = GUICtrlCreateSlider(90, 115, 200, 30)
GUICtrlSetLimit(-1, 240, 0)
GUICtrlSetData(-1, $HSB[1])
$hSlider_Handle2 = GUICtrlGetHandle(-1)

GUICtrlCreateLabel($LngLightness, 10, 151, 80, 17)
$iValSld3 = GUICtrlCreateLabel($HSB[2], 300, 150, 30, 17)
$slider3 = GUICtrlCreateSlider(90, 145, 200, 30)
GUICtrlSetLimit(-1, 240, 0)
GUICtrlSetData(-1, $HSB[2])
$hSlider_Handle3 = GUICtrlGetHandle(-1)

GUICtrlCreateLabel($LngRed, 10, 201, 80, 17)
$iValSldRGB1 = GUICtrlCreateLabel($HSB[0], 300, 200, 30, 17)
$sliderRGB1 = GUICtrlCreateSlider(90, 195, 200, 30)
GUICtrlSetLimit(-1, 255, 0)
GUICtrlSetData(-1, $HSB[0])
$hSlider_HandleRGB1 = GUICtrlGetHandle(-1)

GUICtrlCreateLabel($LngGreen, 10, 231, 80, 17)
$iValSldRGB2 = GUICtrlCreateLabel($HSB[1], 300, 230, 30, 17)
$sliderRGB2 = GUICtrlCreateSlider(90, 225, 200, 30)
GUICtrlSetLimit(-1, 255, 0)
GUICtrlSetData(-1, $HSB[1])
$hSlider_HandleRGB2 = GUICtrlGetHandle(-1)

GUICtrlCreateLabel($LngBlue, 10, 261, 80, 17)
$iValSldRGB3 = GUICtrlCreateLabel($HSB[2], 300, 260, 30, 17)
$sliderRGB3 = GUICtrlCreateSlider(90, 255, 200, 30)
GUICtrlSetLimit(-1, 255, 0)
GUICtrlSetData(-1, $HSB[2])
$hSlider_HandleRGB3 = GUICtrlGetHandle(-1)

_SetColorRGB()

GUISetState(@SW_SHOW, $hGuiMain)

GUIRegisterMsg($WM_HSCROLL, "WM_HSCROLL")

_Create_GUI()

While 1
	Sleep(1000)
WEnd

Func _Reset()
	$TrgSt = 1
EndFunc

Func _Create_GUI()
	Local $iL, $iR, $iT, $iB, $hGuiClr
	
	; If $SetCoord Then
		; $iCoordX0 = GUICtrlRead($iCoordX)
		; $iCoordY0 = GUICtrlRead($iCoordY)
		; If $iCoordX0 And $iCoordY0 Then MouseMove($iCoordX0, $iCoordY0, 0)
		; $LastPos[0]=$iCoordX0
		; $LastPos[1]=$iCoordY0
	; EndIf
	$TrgSt = 0
	HotKeySet("{ESC}", "_Reset")
	GUISetState(@SW_MINIMIZE, $hGuiMain)
	$hPen = _WinAPI_CreatePen($PS_SOLID, $SightWidth, $SightColor)
	$hGui = GUICreate('', $GuiWidth, $GuiHeight, $LastPos[0], $LastPos[1], $WS_POPUP + $WS_BORDER, $WS_EX_TOOLWINDOW + $WS_EX_TOPMOST, $hGuiMain)

	GUISetState(@SW_SHOW, $hGui)

	$hGuiClr = GUICreate('', 160, 19, $LastPos[0], $LastPos[1], $WS_POPUP + $WS_BORDER, $WS_EX_TOOLWINDOW, $hGui)
	$iLbClr = GUICtrlCreateLabel('', -2, -2, 20, 20, $WS_BORDER)
	$iStrClr = GUICtrlCreateLabel('', 17, -2, 142, 20, $SS_CENTERIMAGE + $SS_CENTER + $WS_BORDER)

	; GUISetOnEvent($GUI_EVENT_PRIMARYDOWN, "_Quit")
	; GUISetOnEvent($GUI_EVENT_PRIMARYUP, "_Quit")
	; GUISetOnEvent($GUI_EVENT_SECONDARYDOWN, "_Quit")
	; GUISetOnEvent($GUI_EVENT_SECONDARYUP, "_Quit")
	HotKeySet("{LEFT}", "_Arrow_Left")
	HotKeySet("{RIGHT}", "_Arrow_Right")
	HotKeySet("{UP}", "_Arrow_Up")
	HotKeySet("{DOWN}", "_Arrow_Down")
	; $iL = GUICtrlCreateDummy()
	; GUICtrlSetOnEvent(-1, "_Arrow_Left")
	; $iR = GUICtrlCreateDummy()
	; GUICtrlSetOnEvent(-1, "_Arrow_Right")
	; $iT = GUICtrlCreateDummy()
	; GUICtrlSetOnEvent(-1, "_Arrow_Up")
	; $iB = GUICtrlCreateDummy()
	; GUICtrlSetOnEvent(-1, "_Arrow_Down")
	; Dim $AccelKeys[4][2] = [["{LEFT}", $iL],["{RIGHT}", $iR],["{UP}", $iT],["{DOWN}", $iB]]
	; GUISetAccelerators($AccelKeys, $hGuiClr)
	GUISetState(@SW_SHOW, $hGuiClr)
	GUIRegisterMsg($WM_MOUSEWHEEL, "WM_MOUSEWHEEL")

	While 1
		$MousePos = MouseGetPos() ; получаем координаты мыши
		If $LastPos[0] <> $MousePos[0] Or $LastPos[1] <> $MousePos[1] Or $Tr1 Then ; если позиция мыши и зум изменилась, то выполняем перемещение
			WinMove($hGui, '', $MousePos[0] + $CaptureWidth / 2 + 5, $MousePos[1], $CaptureWidth * $Zoom, $CaptureHeight * $Zoom)
			WinMove($hGuiClr, '', $MousePos[0] + $CaptureWidth / 2 + 5, $MousePos[1], 160, 19)
			$LastPos[0] = $MousePos[0] ; и темпируем координаты и зум
			$LastPos[1] = $MousePos[1]
			$LastZoom = $Zoom
			$Tr1 = 0
			_gdi32_StretchBlt()
		EndIf
		If $TrgSt Then
			; GUISetAccelerators(0, $hGuiClr)
			GUIDelete($hGui)
			GUIDelete($hGuiClr)
			_WinAPI_DeleteObject($hPen)
			GUISetState(@SW_RESTORE, $hGuiMain)
			HotKeySet("{ESC}", "_Quit")
			$RGB = StringRegExp(Hex(Int($Color), 6), '^(..)(..)(..)$', 3)
			For $i = 0 To 2
				$RGB[$i] = Dec($RGB[$i])
			Next
			_SetColorHSB()
			_SetColorRGB()
			GUICtrlSetData($iCoordX, $LastPos[0])
			GUICtrlSetData($iCoordY, $LastPos[1])
			GUIRegisterMsg($WM_MOUSEWHEEL, '')
			HotKeySet("{LEFT}")
			HotKeySet("{RIGHT}")
			HotKeySet("{UP}")
			HotKeySet("{DOWN}")
			; _Quit()
			ExitLoop
		EndIf
		Sleep(10)
	WEnd

EndFunc

Func _Arrow_Left()
	MouseMove($LastPos[0] - 1, $LastPos[1], 0)
EndFunc

Func _Arrow_Right()
	MouseMove($LastPos[0] + 1, $LastPos[1], 0)
EndFunc

Func _Arrow_Up()
	MouseMove($LastPos[0], $LastPos[1] - 1, 0)
EndFunc

Func _Arrow_Down()
	MouseMove($LastPos[0], $LastPos[1] + 1, 0)
EndFunc

; $LastPos[0] + $CaptureWidth / 2 + 5 - X позиция окна
; $LastPos[1] - Y позиция окна

; $CaptureWidth * $Zoom - ширина окна
; $CaptureHeight * $Zoom - высота окна

; $LastPos[0] - $CaptureWidth / 2 - X фотографируемого участка
; $LastPos[1] - $CaptureHeight / 2 - Y фотографируемого участка

; $CaptureWidth - ширина участка
; $CaptureHeight - высота участка

Func _gdi32_StretchBlt()
	Local $DeskHDC, $hGuiHDC, $obj_orig, $x
	$DeskHDC = DllCall($user32_dll, "int", "GetDC", "hwnd", 0)
	$hGuiHDC = DllCall($user32_dll, "int", "GetDC", "hwnd", $hGui)
	If Not @error Then ; если без ошибок открыли DLL, то
		DllCall($gdi32_dll, "int", "StretchBlt", "int", $hGuiHDC[0], "int", _
				0, "int", 0, "int", $CaptureWidth * $Zoom, "int", $CaptureHeight * $Zoom, "int", $DeskHDC[0], "int", _
				$LastPos[0] - Ceiling($CaptureWidth / 2), "int", $LastPos[1] - Ceiling($CaptureHeight / 2), "int", $CaptureWidth, "int", $CaptureHeight, _
				"long", $SRCCOPY)

		; Создание прицела
		$obj_orig = _WinAPI_SelectObject($DeskHDC[0], $hPen)
		; $x = Round($LastPos[0] + ($CaptureWidth * (1 + $Zoom)) / 2 + 5 + $Zoom / 2)
		; позиция окна + половина ширины окна + половина зума. (половина зума = половина увеличенного пиксела)
		$x = $LastPos[0] + $CaptureWidth / 2 + 5 + (Ceiling($CaptureWidth / 2) + 1) * $Zoom
		_WinAPI_DrawLine($DeskHDC[0], $x, $LastPos[1] + $CaptureHeight * $Zoom - $SightWidth - 1, $x, _
				$LastPos[1] + (Ceiling($CaptureHeight / 2) + 1) * $Zoom) ; вертикальная линия, прицел

		$Color = PixelGetColor($LastPos[0], $LastPos[1])
		; GUISetBkColor($Color, $hGuiClr)
		GUICtrlSetData($iStrClr, Hex(Int($Color), 6) & ', z' & $Zoom & ', x' & $LastPos[0] & ', y' & $LastPos[1])
		GUICtrlSetBkColor($iLbClr, $Color)
		
		DllCall($user32_dll, "int", "ReleaseDC", "int", $DeskHDC[0], "hwnd", 0)
		DllCall($user32_dll, "int", "ReleaseDC", "int", $hGuiHDC[0], "hwnd", $hGui)
	EndIf
EndFunc

Func WM_MOUSEWHEEL($hWndGui, $MsgId, $wParam, $lParam)
	Local $direction, $KeysHeld
	$KeysHeld = BitAND($wParam, 0xFFFF) ; нажатый модификатор
	$direction = BitShift($wParam, 16)
	; $X = BitShift($lParam, 16) ; координаты мыши
	; $Y = BitAND($lParam, 0xFFFF)

	If $direction > 0 Then
		$Zoom += 1
	Else
		$Zoom -= 1
	EndIf
	If $Zoom < 2 Then $Zoom = 2

	Switch $KeysHeld
		Case 0 ; ничего
			$CaptureWidth = $GuiWidth / $Zoom
			$CaptureHeight = $GuiHeight / $Zoom
		Case 4 ; Shift
			If $direction > 0 Then
				$GuiWidth = $CaptureWidth * $Zoom
				$GuiHeight = $CaptureHeight * $Zoom

				$Zoom -= 2

				$CaptureWidth = $GuiWidth / $Zoom
				$CaptureHeight = $GuiHeight / $Zoom
			Else
				$GuiWidth = $CaptureWidth * $Zoom
				$GuiHeight = $CaptureHeight * $Zoom

				$Zoom += 2

				$CaptureWidth = $GuiWidth / $Zoom
				$CaptureHeight = $GuiHeight / $Zoom
			EndIf
			$Zoom = $LastZoom
		Case 8 ; Ctrl
			$GuiWidth = $CaptureWidth * $Zoom
			$GuiHeight = $CaptureHeight * $Zoom
	EndSwitch
	$Tr1 = 1
EndFunc

Func _Quit()
	IniWrite($Ini, 'Set', 'Zoom', $Zoom)
	IniWrite($Ini, 'Set', 'Region', Int($CaptureWidth))
	ClipPut(StringReplace(StringReplace(StringReplace($Clipboard, '%y', $LastPos[1]), '%x', $LastPos[0]), '%c', Hex(Int($Color), 6)))
	DllClose($user32_dll)
	DllClose($gdi32_dll)
	Exit
EndFunc

Func WM_HSCROLL($hWnd, $Msg, $wParam, $lParam)
	#forceref $Msg, $wParam, $lParam
	Local $nScrollCode = BitAND($wParam, 0xFFFF) ; _WinAPI_LoWord
	Local $value = BitShift($wParam, 16) ; _WinAPI_HiWord

	If $nScrollCode = 5 Then
		Switch $lParam
			Case $hSlider_Handle1
				GUICtrlSetData($iValSld1, $value)
				$HSB[0] = $value
				_SetColorRGB()
			Case $hSlider_Handle2
				GUICtrlSetData($iValSld2, $value)
				$HSB[1] = $value
				_SetColorRGB()
			Case $hSlider_Handle3
				GUICtrlSetData($iValSld3, $value)
				$HSB[2] = $value
				_SetColorRGB()
			Case $hSlider_HandleRGB1
				GUICtrlSetData($iValSldRGB1, $value)
				$RGB[0] = $value
				_SetColorHSB()
			Case $hSlider_HandleRGB2
				GUICtrlSetData($iValSldRGB2, $value)
				$RGB[1] = $value
				_SetColorHSB()
			Case $hSlider_HandleRGB3
				GUICtrlSetData($iValSldRGB3, $value)
				$RGB[2] = $value
				_SetColorHSB()
		EndSwitch
	EndIf

	Return $GUI_RUNDEFMSG
EndFunc

Func _SetColorRGB()
	$a = _ColorConvertHSLtoRGB($HSB)
	For $i = 0 To 2
		$RGB[$i] = Round($a[$i])
	Next
	$a = Hex($RGB[0], 2) & Hex($RGB[1], 2) & Hex($RGB[2], 2)
	GUICtrlSetData($iHexLabel, $a)
	GUICtrlSetData($iDecLabel, $RGB[0]&', '&$RGB[1]&', '&$RGB[2])
	GUICtrlSetBkColor($iColorLabel, Dec($a))

	GUICtrlSetData($iValSldRGB1, $RGB[0])
	GUICtrlSetData($iValSldRGB2, $RGB[1])
	GUICtrlSetData($iValSldRGB3, $RGB[2])

	GUICtrlSetData($sliderRGB1, $RGB[0])
	GUICtrlSetData($sliderRGB2, $RGB[1])
	GUICtrlSetData($sliderRGB3, $RGB[2])
EndFunc

Func _SetColorHSB()
	$HSB = _ColorConvertRGBtoHSL($RGB)
	; For $i = 0 To 2
		; $HSB[$i] = $a[$i]
	; Next
	$a = Hex($RGB[0], 2) & Hex($RGB[1], 2) & Hex($RGB[2], 2)
	GUICtrlSetData($iHexLabel, $a)
	GUICtrlSetData($iDecLabel, $RGB[0]&', '&$RGB[1]&', '&$RGB[2])
	GUICtrlSetBkColor($iColorLabel, Dec($a))

	GUICtrlSetData($iValSld1, Round($HSB[0]))
	GUICtrlSetData($iValSld2, Round($HSB[1]))
	GUICtrlSetData($iValSld3, Round($HSB[2]))

	GUICtrlSetData($slider1, Round($HSB[0]))
	GUICtrlSetData($slider2, Round($HSB[1]))
	GUICtrlSetData($slider3, Round($HSB[2]))
EndFunc

Func _SelColor()
	Local $Choose
	$Choose = '0x'&Hex($RGB[0], 2) & Hex($RGB[1], 2) & Hex($RGB[2], 2)
	$Choose = _ChooseColor(2, $Choose, 2, $hGuiMain)
	If $Choose <> -1 Then
		$RGB = StringRegExp(Hex(Int($Choose), 6), '^(..)(..)(..)$', 3)
		For $i = 0 To 2
			$RGB[$i] = Dec($RGB[$i])
		Next
		_SetColorHSB()
		_SetColorRGB()
	EndIf
EndFunc

; Func _SetCoordCh()
	; If GUICtrlRead($iSetCoordCh)=1 Then
		; $SetCoord = 1
	; Else
		; $SetCoord = 0
	; EndIf
; EndFunc

Func _About()
	Local $font, $Gui1, $OptGui, $url, $WbMn
	$OptGui = Opt("GUIOnEventMode", 0)
	$font = "Arial"
	$Gui1 = GUICreate($LngAbout, 270, 180, -1, -1, BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $hGuiMain)
	GUISetIcon($AutoItExe, 0)
	GUISetBkColor(0xE1E3E7)
	GUICtrlCreateLabel($LngTitle, 0, 0, 270, 63, 0x01 + 0x0200)
	GUICtrlSetFont(-1, 15, 600, -1, $font)
	GUICtrlSetColor(-1, 0x3a6a7e)
	GUICtrlSetBkColor(-1, 0xF1F1EF)
	GUICtrlCreateLabel("-", 2, 64, 268, 1, 0x10)
	
	GUISetFont(9, 600, -1, $font)

	GUICtrlCreateLabel($LngVer & ' 0.1  15.06.2012', 55, 100, 210, 17)
	GUICtrlCreateLabel($LngSite & ':', 55, 115, 40, 17)
	$url = GUICtrlCreateLabel('http://azjio.ucoz.ru', 92, 115, 170, 17)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney:', 55, 130, 85, 17)
	$WbMn = GUICtrlCreateLabel('R939163939152', 130, 130, 125, 17)
	GUICtrlSetColor(-1, 0x3a6a7e)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel('Copyright AZJIO © 2012', 55, 145, 210, 17)
	GUISetState(@SW_SHOW, $Gui1)
	; GUISwitch($Gui1)
	While 1
		Switch GUIGetMsg()
			Case $url
				ShellExecute('http://azjio.ucoz.ru')
			Case $WbMn
				ClipPut('R939163939152')
			Case -3
				GUIDelete($Gui1)
				Opt("GUIOnEventMode", $OptGui)
				ExitLoop
		EndSwitch
	WEnd
EndFunc