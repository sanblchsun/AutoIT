
$hGui = GUICreate('RGB to BGR', 250, 260)
$iButton = GUICtrlCreateButton('Из красного в синий', 10, 10, 180, 22)
GUICtrlSetBkColor(-1, _Rev(0xFF0000))
$iStatusBar = GUICtrlCreateLabel('StatusBar', 5, 260 - 20, 240, 17)
GUICtrlSetBkColor(-1, _Rev('FF0000'))
GUISetState()
While 1
	Switch GUIGetMsg()
		Case $iButton
			GUICtrlSetData($iStatusBar, 'Done')
		Case -3
			Exit
	EndSwitch
WEnd

; тест скорости - очень быстро
; $timer = TimerInit()
; For $i = 1 To 10000
	; _Rev(0xFF0000)
; Next
; MsgBox(0, "Время выполнения", 'Время : ' & Round(TimerDiff($timer) / 1000, 2) & ' сек')

Func _Rev($Color)
	If IsString($Color) Then $Color = Dec(StringReplace($Color, "0x", ""))
	Return Dec(Hex(BinaryMid($Color, 1, 3)))
EndFunc

; как вариант для 0xFF0000 от ProgAndy
; http://autoitscript.com/forum/topic/140291-solved-bitwise-op/#entry985416
Func _Rev1($color)
    Return BitOr(BitAnd($color, 0xFF000000), BitShift(BitAnd($color, 0x00FF0000), 16), BitAnd($color, 0x0000FF00), BitShift(BitAnd($color, 0xFF), -16))
EndFunc