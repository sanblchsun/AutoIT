;=========================================================
; Produces an array of pixel colours used in an image that are below the colour 0x202020 (array[n][0]),
; Number of times that colour is used (array[n][1]), and,
; the percentage of the numer of times the colour is used over the total number of pixels in the image (array[n][2]).
; Array[0][0] contains the number of unique pixels used in the image below 0x202020 colour.
; Array[0][1] contains the total number of pixels used in the image below 0x202020 colour.
; Array[0][2] contains the percentage of the total number of pixels used in the image below 0x202020 colour.
;============================================================

#include <WinAPI.au3>
#include <ScreenCapture.au3>
#include <GDIPlus.au3>
#include <Array.au3>

Dim $pixels, $iTotalReplace
Local $Path = FileOpenDialog("Choose Image File", @ScriptDir & "", "Images (*.gif;*.png;*.jpg;*.bmp)| All (*.*)")
If $Path <> "" Then
	_GDIPlus_Startup()

	$hImage = _GDIPlus_ImageLoadFromFile($Path)
	$width = _GDIPlus_ImageGetWidth($hImage)
	$height = _GDIPlus_ImageGetHeight($hImage)
	$hBmp = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)

	$aSize = DllCall('gdi32.dll', 'int', 'GetBitmapBits', 'ptr', $hBmp, 'int', 0, 'ptr', 0)
	If $aSize[0] Then
		$tBits = DllStructCreate('byte[' & $aSize[0] & ']')
		DllCall('gdi32.dll', 'int', 'GetBitmapBits', 'ptr', $hBmp, 'int', $aSize[0], 'ptr', DllStructGetPtr($tBits))
		$sHex = Hex(DllStructGetData($tBits, 1))

		; Selects all pixels below/less than 0x202020
		$pixels = StringRegExp($sHex, "([01][0-9A-F][01][0-9A-F][01][0-9A-F])FF", 3)

		; Selects all pixels below/less than 0x505050 (Can take a while)
		;$pixels = StringRegExp($sHex, "([0-5][0-9A-F][0-5][0-9A-F][0-5][0-9A-F])FF", 3)

		$sHexReduced = _ArrayToString($pixels) & "|"

		Dim $pixels[1][3]
		While StringLen($sHexReduced) > 6
			ReDim $pixels[UBound($pixels) + 1][3]
			$PixTemp = StringLeft($sHexReduced, 7)
			$sHexReduced = StringReplace($sHexReduced, $PixTemp, "", 0)
			$numreplacements = @extended

			$pixels[UBound($pixels) - 1][1] = $numreplacements
			$pixels[UBound($pixels) - 1][0] = StringTrimRight($PixTemp, 1)
			$pixels[UBound($pixels) - 1][2] = StringFormat("%1.4f%%", $numreplacements * 100 / ($height * $width))
			$iTotalReplace += $numreplacements

		WEnd
		$pixels[0][0] = UBound($pixels) - 1
		$pixels[0][1] = $iTotalReplace
		$pixels[0][2] = StringFormat("%1.4f%%", $iTotalReplace * 100 / ($height * $width))
	EndIf
	_ArraySort($pixels, 0, 1, 0, 0)
	_ArrayDisplay($pixels, $Path)
	_WinAPI_DeleteObject($hBmp)
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_Shutdown()
EndIf