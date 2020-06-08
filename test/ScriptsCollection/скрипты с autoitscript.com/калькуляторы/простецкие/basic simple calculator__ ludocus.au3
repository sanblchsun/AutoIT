#cs ----------------------------------------------------------------------------

AutoIt Version: 3.2.10.0
Author: ludocus

Script Function:
Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#include <GUIConstants.au3>
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Lc", 116, 225, 193, 125)
GUISetBkColor(0xFFFF00)
$1 = GUICtrlCreateButton("1", 8, 40, 27, 25, 0)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
;GUICtrlSetColor(-1, 0x800000)
$2 = GUICtrlCreateButton("2", 40, 40, 27, 25, 0)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
;GUICtrlSetColor(-1, 0x800000)
$3 = GUICtrlCreateButton("3", 72, 40, 27, 25, 0)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
;GUICtrlSetColor(-1, 0x800000)
$4 = GUICtrlCreateButton("4", 8, 72, 27, 25, 0)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
;GUICtrlSetColor(-1, 0x800000)
$5 = GUICtrlCreateButton("5", 40, 72, 27, 25, 0)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
;GUICtrlSetColor(-1, 0x800000)
$6 = GUICtrlCreateButton("6", 72, 72, 27, 25, 0)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
;GUICtrlSetColor(-1, 0x800000)
$7 = GUICtrlCreateButton("7", 8, 104, 27, 25, 0)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
;GUICtrlSetColor(-1, 0x800000)
$8 = GUICtrlCreateButton("8", 40, 104, 27, 25, 0)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
;GUICtrlSetColor(-1, 0x800000)
$9 = GUICtrlCreateButton("9", 72, 104, 27, 25, 0)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
;GUICtrlSetColor(-1, 0x800000)
$o = GUICtrlCreateButton("0", 40, 136, 27, 25, 0)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
;GUICtrlSetColor(-1, 0x800000)
$min = GUICtrlCreateButton("-", 8, 136, 27, 25, 0)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
;GUICtrlSetColor(-1, 0x800000)
$plus = GUICtrlCreateButton("+", 72, 136, 27, 25, 0)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
;GUICtrlSetColor(-1, 0x800000)
$som = GUICtrlCreateInput("", 8, 8, 89, 21)
$clear = GUICtrlCreateButton('c', 97, 8, 20, 20 )
$deel = GUICtrlCreateButton("/", 8, 168, 27, 25, 0)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
;GUICtrlSetColor(-1, 0x800000)
$keer = GUICtrlCreateButton("x", 40, 168, 27, 25, 0)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
;GUICtrlSetColor(-1, 0x800000)
$c = GUICtrlCreateButton(",", 72, 168, 27, 25, 0)
GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
;GUICtrlSetColor(-1, 0x800000)
$is = GUICtrlCreateButton("=", 8, 200, 92, 25, 0)
GUICtrlSetFont(-1, 14, 800, 0, "MS Sans Serif")
;GUICtrlSetColor(-1, 0x800000)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
$nMsg = GUIGetMsg()
Switch $nMsg
Case $GUI_EVENT_CLOSE
Exit

Case $1
calc(1)

Case $2
calc(2)

Case $3
calc(3)

Case $4
calc(4)

Case $5
calc(5)

Case $6
calc(6)

Case $7
calc(7)

Case $8
calc(8)

Case $9
calc(9)

Case $o
calc('nul')

Case $deel
calc('/')

Case $keer
calc('x')

Case $is
calc('get')

Case $plus
calc('+')

Case $min
calc('-')

Case $c
calc('.')

Case $clear
GUICtrlSetData($som, '' )

EndSwitch
WEnd

func calc($num)
if $num='get' then
get()
Else
if $num='nul' then
GUICtrlSetData($som, GUICtrlRead($som)&0)
Else
GUICtrlSetData($som, GUICtrlRead($som)&$num)
EndIf

EndIf
EndFunc

func get()
$p = Execute(StringReplace(GUICtrlRead($som), 'x', '*'))
if @error then
GUICtrlSetData($som, 'Error' )
Else
GUICtrlSetData($som, $p )
EndIf

EndFunc