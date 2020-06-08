; Multi-Color Changing Background

#include <GUIConstantsEx.au3>

Dim $color, $redm = 1, $bluem = 2, $greenm = 3, $index

GUICreate("test")
GUISetState()

While GUIGetMsg() <> -3
	Sleep(10)
	$index += 0.01
	$color = "0x" & Hex(255 * ((Sin($index * $redm) + 1) / 2), 2) & Hex(255 * ((Sin($index * $greenm) + 1) / 2), 2) & Hex(255 * ((Sin($index * $bluem) + 1) / 2), 2)
	GUISetBkColor($color)
WEnd