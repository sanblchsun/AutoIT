#include <GUIConstantsEx.au3>
#include <ButtonConstants.au3>

Opt("GUIOnEventMode", 1)

Global $SSB = StringSplit("1|2|3|4|5|6|7|8|9|-|0|+|/|*|.|=", "|"), $bX = 8, $bY = 40

$Form1 = GUICreate("Lc", 108, 233, 193, 125)
GUISetOnEvent($GUI_EVENT_CLOSE, "Close", $Form1)
GUISetBkColor(0xFFFF00)
$som = GUICtrlCreateInput("", 8, 8, 89, 21)
For $i = 1 To $SSB[0]
    GUICtrlCreateButton($SSB[$i], $bX, $bY, 27, 25, $BS_CENTER)
    GUICtrlSetOnEvent(-1, "Event")
    GUICtrlSetFont(-1, 10, 700, 0, "MS Sans Serif")
    If Not Mod($i, 3) Then
        $bX = 8
        $bY += 32
    Else
        $bX += 32
    EndIf
Next
$SSB = 0
GUISetState(@SW_SHOW)

While 1
    Sleep(100)
WEnd

Func Event()
    Switch GUICtrlRead(@GUI_CtrlId)
        Case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "+", "-", "*", "/", "."
            GUICtrlSetData($som,  GUICtrlRead($som) & GUICtrlRead(@GUI_CtrlId))
        Case "="
            If Execute(GUICtrlRead($som)) Then GUICtrlSetData($som, Execute(GUICtrlRead($som)))
    EndSwitch
EndFunc

Func Close()
    Exit
EndFunc