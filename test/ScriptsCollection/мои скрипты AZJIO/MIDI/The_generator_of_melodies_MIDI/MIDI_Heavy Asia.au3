;  @AZJIO
;  Heavy Asia
#include <Midiudf.au3>
$openmidi = _midiOutopen ()
If @error Then MsgBox(0, "Error", "MIDI-device occupied")

Global $nTempo=1
Global $iTone=9
Global $volume=127
HotKeySet('{ESC}', "_Quit")


SetInstrument($openmidi, 90) ; выбор музыкального инструмента
; вариация 1
_Beep(5,5,130)
_Beep(7,5,130)
_Beep(11,5,130)
_Beep(7,5,130)
_Beep(11,5,130)
_Beep(12,5,130)
_Beep(11,5,450,70)
_Beep(7,5,130,130)
_Beep(7,5,130)
_Beep(5,5,250,130)
_Beep(7,5,260)
_Beep(5,5,65,65)
_Beep(7,5,260)
_Beep(5,5,65,65)
_Beep(7,5,86,130)
_Beep(7,5,65,65)
_Beep(8,5,65,65)
_Beep(8,5,130,130)
_Beep(8,5,170,350)

_Beep(5,5,130)
_Beep(7,5,130)
_Beep(11,5,130)
_Beep(7,5,130)
_Beep(11,5,130)
_Beep(12,5,130)
_Beep(11,5,390)
_Beep(12,5,86)
_Beep(11,5,43)
_Beep(7,5,130,130)
_Beep(7,5,130)
_Beep(5,5,250,130)
_Beep(7,5,260)
_Beep(5,5,65,65)
_Beep(7,5,260)
_Beep(5,5,65,65)
_Beep(5,5,170,86)
_Beep(7,5,65,65)
_Beep(8,5,65,65)
_Beep(8,5,130,130)
_Beep(8,5,170,350)

SetInstrument($openmidi, 30)
; вариация 2
_Beep(7,3,130,130)
_Beep(7,3,170,86)
_Beep(5,3,86,43)
_Beep(7,3,217,43)
_Beep(5,3,86,43)
_Beep(7,3,170,86)
_Beep(7,3,216,434)

_Beep(5,3,86,43)
_Beep(7,3,130,130)
_Beep(7,3,170,86)
_Beep(5,3,86,43)
_Beep(7,3,217,43)
_Beep(5,3,86,43)
_Beep(7,3,170,86)
_Beep(7,3,217,43)

_Beep(8,3,43,86)
_Beep(8,3,43,86)
_Beep(8,3,43,86)
_Beep(8,3,43,86)

_Beep(7,3,130,130)
_Beep(7,3,170,86)
_Beep(5,3,86,43)
_Beep(7,3,217,43)
_Beep(5,3,86,43)
_Beep(7,3,170,86)
_Beep(7,3,216,434)

_Beep(5,3,86,43)
_Beep(7,3,130,130)
_Beep(7,3,170,86)
_Beep(5,3,86,43)
_Beep(7,3,217,43)
_Beep(5,3,86,43)
_Beep(7,3,170,86)
_Beep(7,3,217,43)

_Beep(8,3,520)

; вариация 3
_Beep(12,3,390)
_Beep(7,4,390)
_Beep(6,4,520)
_Beep(5,4,450)
_Beep(3,4,330)

_Beep(12,3,390)
_Beep(7,4,390)
_Beep(6,4,520)
_Beep(5,4,450)
_Beep(3,4,330)

_Beep(5,3,390)
_Beep(12,3,390)
_Beep(11,3,520)
_Beep(10,3,450)
_Beep(8,3,330)

_Beep(5,3,390)
_Beep(12,3,390)
_Beep(11,3,520)
_Beep(10,3,450)
_Beep(8,3,330)

_MidiOutClose ($openmidi)

Func _Beep($iNote,$iOctave=4,$iDuration=200,$iPause=0)
$iNote=$iNote+$iTone+12*$iOctave
_MidiOutShortMsg($openmidi, 0x90 + ($iNote   * 256) + ($volume * 0x10000))
Sleep($iDuration/$nTempo)
_MidiOutShortMsg($openmidi, 0x90 + ($iNote   * 256) + (0 * 0x10000))
If $iPause<>0 Then Sleep($iPause/$nTempo)
EndFunc

Func SetInstrument($openmidi, $inct)
    _MidiOutShortMsg($openmidi,256 * $inct + 192)
EndFunc

Func _Quit()
    Exit
EndFunc