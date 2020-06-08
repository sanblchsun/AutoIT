#include <ButtonConstants.au3>
#include <WindowsConstants.au3>
$hGui = GUICreate('My Program', 250, 260)
$iButton = _IconButton('Старт', 'shell32.dll', 4, 10, 10)
GUISetState()
Do
Until GUIGetMsg() = -3


;===============================================================================
;
; Function Name:	_IconButton()
; Description:: 		Creates a button with Icon and Text
; Parameter(s):		$text - text
;					$dll - Icon FileName
;					$iconID - ID of icon in File
;					$x - top
;					$y - left
;					$w - width, is min. 40
;					$h - height, is min. 55
; Requirement(s):	AutoIT :P
; Return Value(s): ControlID of the button, to cnage the Icon use the functions below :)
; Author(s):	Prog@ndy
;
;===============================================================================
;
Func _IconButton($text, $dll, $iconID, $x, $y, $w = 50, $h = 60)
	Local $space, $spaceh = 9
	If $w < 40 Then $w = 40
	Local $space = Floor(($w - 32) / 2)
	If $h < 55 Then $h = 55
	If $h < 60 Then $spaceh = 5
	GUICtrlCreateIcon($dll, $iconID, $x + $space, $y + $spaceh, 32, 32, 0) ; --> die letzte 0, damit kein Klick-Ereignis ausgelost wird (Click-Through)
	Return GUICtrlCreateButton($text, $x, $y, $w, $h, BitOR($WS_CLIPSIBLINGS, $BS_BOTTOM, $BS_MULTILINE))
EndFunc

; by Prog@ndy
Func _IconButtonSetIco($btn, $dll, $iconID = 0)
	GUICtrlSetImage($btn - 1, $dll, $iconID)
EndFunc
; by Prog@ndy
Func _IconButtonDelete($btn)
	GUICtrlDelete($btn - 1)
	GUICtrlDelete($btn)
EndFunc
; by Prog@ndy
Func _IconButtonIconSetStyle($btn, $style, $styleEx)
	GUICtrlSetStyle($btn - 1, $style, $styleEx)
EndFunc

; Gets The Control ID of the Icon, so you can use all GUICtrl... Functions on it :)
; by Prog@ndy
Func _IconButtonIconGetCtrlID($btn)
	Return $btn - 1
EndFunc