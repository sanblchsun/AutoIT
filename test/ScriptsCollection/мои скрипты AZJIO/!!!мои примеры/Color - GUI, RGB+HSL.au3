#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Color.au3>

; En
$LngTitle = 'Color'
$LngHue = 'Hue'
$LngSaturation = 'Saturation'
$LngLightness = 'Lightness'
$LngRed = 'Red'
$LngGreen = 'Green'
$LngBlue = 'Blue'

; Ru
; если русская локализация, то русский язык
If @OSLang = 0419 Then
	$LngTitle = 'Цвет'
	$LngHue = 'Тон'
	$LngSaturation = 'Насыщенность'
	$LngLightness = 'Светлота'
	$LngRed = 'Красный'
	$LngGreen = 'Зелёный'
	$LngBlue = 'Синий'
EndIf

Global $HSB[3] = [40, 240, 185], $RGB[3]
$GUI = GUICreate($LngTitle, 340, 270)

$iColorLabel = GUICtrlCreateLabel('', 90, 5, 200, 30, $WS_BORDER)
$iNumLabel = GUICtrlCreateLabel('', 20, 12, 70, 17)

GUICtrlCreateGroup('HSL', 3, 45, 333, 103)
GUICtrlCreateGroup('RGB', 3, 155, 333, 103)

GUICtrlCreateLabel($LngHue, 10, 61, 80, 17)
$iValSld1 = GUICtrlCreateLabel($HSB[0], 300, 60, 30, 17)
$slider1 = GUICtrlCreateSlider(90, 55, 200, 30)
GUICtrlSetLimit(-1, 240, 0)
GUICtrlSetData(-1, $HSB[0])
$hSlider_Handle1 = GUICtrlGetHandle(-1)

GUICtrlCreateLabel($LngSaturation, 10, 91, 80, 17)
$iValSld2 = GUICtrlCreateLabel($HSB[1], 300, 90, 30, 17)
$slider2 = GUICtrlCreateSlider(90, 85, 200, 30)
GUICtrlSetLimit(-1, 240, 0)
GUICtrlSetData(-1, $HSB[1])
$hSlider_Handle2 = GUICtrlGetHandle(-1)

GUICtrlCreateLabel($LngLightness, 10, 121, 80, 17)
$iValSld3 = GUICtrlCreateLabel($HSB[2], 300, 120, 30, 17)
$slider3 = GUICtrlCreateSlider(90, 115, 200, 30)
GUICtrlSetLimit(-1, 240, 0)
GUICtrlSetData(-1, $HSB[2])
$hSlider_Handle3 = GUICtrlGetHandle(-1)

GUICtrlCreateLabel($LngRed, 10, 171, 80, 17)
$iValSldRGB1 = GUICtrlCreateLabel($HSB[0], 300, 170, 30, 17)
$sliderRGB1 = GUICtrlCreateSlider(90, 165, 200, 30)
GUICtrlSetLimit(-1, 255, 0)
GUICtrlSetData(-1, $HSB[0])
$hSlider_HandleRGB1 = GUICtrlGetHandle(-1)

GUICtrlCreateLabel($LngGreen, 10, 201, 80, 17)
$iValSldRGB2 = GUICtrlCreateLabel($HSB[1], 300, 200, 30, 17)
$sliderRGB2 = GUICtrlCreateSlider(90, 195, 200, 30)
GUICtrlSetLimit(-1, 255, 0)
GUICtrlSetData(-1, $HSB[1])
$hSlider_HandleRGB2 = GUICtrlGetHandle(-1)

GUICtrlCreateLabel($LngBlue, 10, 231, 80, 17)
$iValSldRGB3 = GUICtrlCreateLabel($HSB[2], 300, 230, 30, 17)
$sliderRGB3 = GUICtrlCreateSlider(90, 225, 200, 30)
GUICtrlSetLimit(-1, 255, 0)
GUICtrlSetData(-1, $HSB[2])
$hSlider_HandleRGB3 = GUICtrlGetHandle(-1)

_SetColorRGB()

GUISetState()
GUIRegisterMsg($WM_HSCROLL, "WM_HSCROLL")

Do
Until GUIGetMsg() = -3

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
	GUICtrlSetData($iNumLabel, $a)
	GUICtrlSetBkColor($iColorLabel, Dec($a))

	GUICtrlSetData($iValSldRGB1, $RGB[0])
	GUICtrlSetData($iValSldRGB2, $RGB[1])
	GUICtrlSetData($iValSldRGB3, $RGB[2])

	GUICtrlSetData($sliderRGB1, $RGB[0])
	GUICtrlSetData($sliderRGB2, $RGB[1])
	GUICtrlSetData($sliderRGB3, $RGB[2])
EndFunc

Func _SetColorHSB()
	$a = _ColorConvertRGBtoHSL($RGB)
	For $i = 0 To 2
		$HSB[$i] = Round($a[$i])
	Next
	$a = Hex($RGB[0], 2) & Hex($RGB[1], 2) & Hex($RGB[2], 2)
	GUICtrlSetData($iNumLabel, $a)
	GUICtrlSetBkColor($iColorLabel, Dec($a))

	GUICtrlSetData($iValSld1, $HSB[0])
	GUICtrlSetData($iValSld2, $HSB[1])
	GUICtrlSetData($iValSld3, $HSB[2])

	GUICtrlSetData($slider1, $HSB[0])
	GUICtrlSetData($slider2, $HSB[1])
	GUICtrlSetData($slider3, $HSB[2])
EndFunc