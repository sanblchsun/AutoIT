#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <HSB_RGB_BGR.au3>

; При округлении происходит небольшое изменение цвета при двойной конвертации, поэтому внутрение рассчёты лучше не округлять, а вывод в GUI делать с округлением.

; En
$LngTitle = 'Color'
$LngHue = 'Hue'
$LngSaturation = 'Saturation'
$LngBrightness = 'Brightness'
$LngRed = 'Red'
$LngGreen = 'Green'
$LngBlue = 'Blue'

; Ru
; если русская локализация, то русский язык
If @OSLang = 0419 Then
	$LngTitle = 'Цвет'
	$LngHue = 'Тон'
	$LngSaturation = 'Насыщенность'
	$LngBrightness = 'Яркость'
	$LngRed = 'Красный'
	$LngGreen = 'Зелёный'
	$LngBlue = 'Синий'
EndIf

Global $HSB[3] = [60, 45, 100], $RGB[3], $iScale1 = 360, $iScale2 = 100, $iScale3 = 100
$GUI = GUICreate($LngTitle, 340, 270)

$iColorLabel = GUICtrlCreateLabel('', 90, 5, 200, 30, $WS_BORDER)
$iNumLabel = GUICtrlCreateLabel('', 20, 12, 70, 17)

GUICtrlCreateGroup('HSB', 3, 45, 333, 103)
GUICtrlCreateGroup('RGB', 3, 155, 333, 103)

GUICtrlCreateLabel($LngHue, 10, 61, 80, 17)
$iValSld1 = GUICtrlCreateLabel($HSB[0], 300, 60, 30, 17)
$slider1 = GUICtrlCreateSlider(90, 55, 200, 30)
GUICtrlSetLimit(-1, $iScale1, 0)
GUICtrlSetData(-1, $HSB[0])
$hSlider_Handle1 = GUICtrlGetHandle(-1)

GUICtrlCreateLabel($LngSaturation, 10, 91, 80, 17)
$iValSld2 = GUICtrlCreateLabel($HSB[1], 300, 90, 30, 17)
$slider2 = GUICtrlCreateSlider(90, 85, 200, 30)
GUICtrlSetLimit(-1, $iScale2, 0)
GUICtrlSetData(-1, $HSB[1])
$hSlider_Handle2 = GUICtrlGetHandle(-1)

GUICtrlCreateLabel($LngBrightness, 10, 121, 80, 17)
$iValSld3 = GUICtrlCreateLabel($HSB[2], 300, 120, 30, 17)
$slider3 = GUICtrlCreateSlider(90, 115, 200, 30)
GUICtrlSetLimit(-1, $iScale3, 0)
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
	$RGB = _HSB_to_RGB($HSB, 0, $iScale1, $iScale2, $iScale3)
	$a = Hex($RGB[0], 2) & Hex($RGB[1], 2) & Hex($RGB[2], 2)
	GUICtrlSetData($iNumLabel, $a)
	GUICtrlSetBkColor($iColorLabel, Dec($a))

	Local $aRGB = $RGB
	_Round($aRGB)
	GUICtrlSetData($iValSldRGB1, $aRGB[0])
	GUICtrlSetData($iValSldRGB2, $aRGB[1])
	GUICtrlSetData($iValSldRGB3, $aRGB[2])

	GUICtrlSetData($sliderRGB1, $aRGB[0])
	GUICtrlSetData($sliderRGB2, $aRGB[1])
	GUICtrlSetData($sliderRGB3, $aRGB[2])
EndFunc

Func _SetColorHSB()
	$HSB = _RGB_to_HSB($RGB, $iScale1, $iScale2, $iScale3)
	$a = Hex($RGB[0], 2) & Hex($RGB[1], 2) & Hex($RGB[2], 2)
	GUICtrlSetData($iNumLabel, $a)
	GUICtrlSetBkColor($iColorLabel, Dec($a))

	Local $aHSB = $HSB
	_Round($aHSB)
	GUICtrlSetData($iValSld1, $aHSB[0])
	GUICtrlSetData($iValSld2, $aHSB[1])
	GUICtrlSetData($iValSld3, $aHSB[2])

	GUICtrlSetData($slider1, $aHSB[0])
	GUICtrlSetData($slider2, $aHSB[1])
	GUICtrlSetData($slider3, $aHSB[2])
EndFunc