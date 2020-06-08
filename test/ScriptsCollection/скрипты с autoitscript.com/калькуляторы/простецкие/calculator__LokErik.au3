;I?m Sorry But All of the Helping line and the $Things is on swedich.
;Feel fre to edit if you whant to.

#include <GUIConstants.au3>

GUICreate("MiniRaknaren", 350, 178, 233, 122) ; Programmet
GUICtrlCreateGroup("Raknesatt", 250, 4, 73, 161) ; Grupp
$PLUS = GUICtrlCreateButton("+", 255, 26, 50, 20) ; Knapp
GUICtrlSetFont(-1, 14, 400, 0, "MS Sans Serif") ; Text stolek och annat
$MINUS = GUICtrlCreateButton("-", 255, 53, 50, 20) ; Knapp
GUICtrlSetFont(-1, 14, 400, 0, "MS Sans Serif") ; Text stolek och annat
$GANGER = GUICtrlCreateButton("*", 255, 80, 50, 20) ; Knapp
GUICtrlSetFont(-1, 14, 400, 0, "MS Sans Serif") ; Text stolek och annat
$DELAT = GUICtrlCreateButton("/", 255, 104, 50, 20) ; Knapp
GUICtrlSetFont(-1, 14, 400, 0, "MS Sans Serif") ; Text stolek och annat
$UPPHOJT = GUICtrlCreateButton("^", 255, 130, 50, 20) ; Knapp
GUICtrlSetFont(-1, 14, 400, 0, "MS Sans Serif") ; Text stolek och annat
GUICtrlCreateGroup("", -99, -99, 1, 1) ; Text stolek och annat
$FORSTA = GUICtrlCreateInput("", 8, 48, 81, 21) ; FORSTA Input
$ANDRA = GUICtrlCreateInput("", 120, 48, 89, 21) ; ANDRA Input
GUICtrlCreateLabel("=", 96, 80, 15, 28) ; Likhetstecknet
GUICtrlSetFont(-1, 14, 400, 0, "MS Sans Serif") ; Text stolek och annat
$SVAR = GUICtrlCreateInput("", 40, 112, 129, 21) ; Svar Input
GUICtrlCreateLabel(" Christer Garpenlund ", 0, 160, 100, 17) ; Mitt Namn 
GUISetState(@SW_SHOW) ; Programmets Status

Do
$nMsg = GUIGetMsg()
If $nMsg = $PLUS Then ; Om man trycker pa Plus
$1 = GuiCtrlRead($FORSTA) ; LASER FORSTA INPUT
$2 = GuiCtrlRead($ANDRA) ; LASER ANDRA INPUT
GuiCtrlSetData($SVAR, $1 + $2, "") ; Skriver det SVARET SOM SKA VARA
EndIf

If $nMsg = $MINUS Then ; Om man trycker pa Minus
$1 = GuiCtrlRead($FORSTA) ; LASER FORSTA INPUT
$2 = GuiCtrlRead($ANDRA) ; LASER ANDRA INPUT
GuiCtrlSetData($SVAR, $1 - $2, "") ; Skriver det SVARET SOM SKA VARA
EndIf

If $nMsg = $GANGER Then ; Om man trycker pa Ganger
$1 = GuiCtrlRead($FORSTA) ; LASER FORSTA INPUT
$2 = GuiCtrlRead($ANDRA) ; LASER ANDRA INPUT
GuiCtrlSetData($SVAR, $1 * $2, "") ; Skriver det SVARET SOM SKA VARA
EndIf

If $nMsg = $DELAT Then ; Om man trycker pa Delat
$1 = GuiCtrlRead($FORSTA) ; LASER FORSTA INPUT
$2 = GuiCtrlRead($ANDRA) ; LASER ANDRA INPUT
GuiCtrlSetData($SVAR, $1 / $2, "") ; Skriver det SVARET SOM SKA VARA
EndIf

If $nMsg = $UPPHOJT Then ; Om man trycker pa Delat
$1 = GuiCtrlRead($FORSTA) ; LASER FORSTA INPUT
$2 = GuiCtrlRead($ANDRA) ; LASER ANDRA INPUT
GuiCtrlSetData($SVAR, $1 ^ $2, "") ; Skriver det SVARET SOM SKA VARA
EndIf

Until $nMsg = $GUI_EVENT_CLOSE ; Stanger Programmet.