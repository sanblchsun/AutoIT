#include <Array.au3>
#include <HSB_RGB_BGR.au3>

Local $data[4] = ['C738B9', 0xC738B9, 13056185, '199, 56, 185']

; ������ ��������������� RGB � HSB � ������� ��������� ������.
For $i = 0 To 3
	_ArrayDisplay(_RGB_to_HSB(_ColorToArray($data[$i])), $data[$i] & ' (_RGB_to_HSB)')
Next

Local $aRGB[3] = [0xC7, 0x38, 0xB9]
_ArrayDisplay(_RGB_to_HSB($aRGB), 'Array (_RGB_to_HSB)')


; ������ ��������������� HSB � RGB.
Local $aHSB[3] = [306, 72, 78]
_ArrayDisplay(_HSB_to_RGB($aHSB, 0), 'Array (_HSB_to_RGB)')