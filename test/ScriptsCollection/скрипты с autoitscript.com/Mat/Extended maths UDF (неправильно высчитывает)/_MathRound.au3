
#include<MathExt.au3>

Opt ("GUIOnEventMode", 1)

$hGUI = GUICreate ("Advanced rounding version 1", 400, 200, -1, -1)
   GUISetOnEvent (-3, "_Exit")

   GUICtrlCreateLabel ("Number:", 2, 4, 40, 20)
      Global $hNum = GUICtrlCreateInput ("", 44, 2, 100, 20)
      GUICtrlSetLimit (-1, 15)

   GUICtrlCreateLabel ("Round type: ", 146, 4, 60, 20)
      Global $hType = GUICtrlCreateCombo ("", 208, 2, 110, 20, 0x0003)
         GUICtrlSetData (-1, "Decimal Places|Significant Figures|Digit Precision", "Decimal Places")

   GUICtrlCreateLabel ("Round to: ", 2, 26, 50, 20)
      Global $hPlaces = GUICtrlCreateInput ("2", 54, 24, 40, 20)
      GUICtrlCreateUpDown (-1)
      GUICtrlSetLimit (-1, 15, -15)

   GUICtrlCreateLabel ("Direction:", 146, 26, 50, 20)
      Global $hDir = GUICtrlCreateCombo ("", 208, 24, 110, 20, 0x0003)
         GUICtrlSetData (-1, "Nearest|Up|Down|To Zero|From Zero|Dither", "Nearest")

   Global $hPad = GUICtrlCreateCheckBox ("Pad result", 2, 48, 100, 20)

   GUICtrlCreateLabel ("Tie Break:", 146, 48, 50, 20)
      Global $hTie = GUICtrlCreateCombo ("", 208, 46, 110, 20, 0x003)
         GUICtrlSetData (-1, "Up|Down|To Zero|From Zero|To Even|To Odd|Stochastic|Alternative", "Up")

   GUICtrlCreateLabel ("", 0, 70, 318, 2)
      GUICtrlSetBKColor (-1, 0xAAAAFF)

   GUICtrlCreateLabel ("Result:", 2, 78, 40, 20)
      Global $hResult = GUICtrlCreateInput ("", 44, 76, 274, 20)
      GUICtrlSetState (-1, 128)

   GUICtrlCreateButton ("Reset", 74, 98, 80, 20)
      GUICtrlSetOnEvent (-1, "_Reset")
   GUICtrlCreateButton ("Cancel", 156, 98, 80, 20)
      GUICtrlSetOnEvent (-1, "_Exit")
   GUICtrlCreateButton ("OK", 238, 98, 80, 20)
      GUICtrlSetOnEvent (-1, "_Exit")

GUIRegisterMsg (0x0111, "_TextChanged")
GUISetState ()
While 1
   Sleep (500)
   If BitAnd (GUICtrlGetState ($hTie), 128) Then
      If GUICtrlRead ($hDir) <> "Nearest" Then ContinueLoop
      GUICtrlSetState ($hTie, 64)
   Else
      If GUICtrlRead ($hDir) = "Nearest" Then ContinueLoop
      GUICtrlSetState ($hTie, 128)
   EndIf
WEnd

Func _Reset ()
   GUICtrlSetData ($hNum, "")
   GUICtrlSetData ($hType, "Decimal Places|Significant Figures|Digit Precision", "Decimal Places")
   GUICtrlSetData ($hPlaces, 2)
   GUICtrlSetData ($hDir, "Nearest|Up|Down|To Zero|From Zero|Dither", "Nearest")
   GUICtrlSetData ($hTie, "Up|Down|To Zero|From Zero|To Even|To Odd|Stochastic|Alternative", "Up")
   GUICtrlSetData ($hResult, "")
   GUICtrlSetState ($hPad, 4)
EndFunc ; ==> _Reset

Func _TextChanged ($hWnd, $msgID, $r, $l)
   If ($r = 0x03000004) Or ($r = 0x03000008) Or ($r = 0x0000000C) Or ($r = 0x00090006) Or ($r = 0x0009000B) Or ($r = 0x0009000E) Then ; text changed
      If (GUICtrlRead ($hNum) = "") Or (StringRight (GUICtrlRead ($hNum), 1) = ".") Then
         GUICtrlSetData ($hResult, "")
         Return "GUI_RUNDEFMSG"
      EndIf
      $nNum = GUICtrlRead ($hNum)
      $nPlaces = GUICtrlRead ($hPlaces)
      Switch GUICtrlRead ($hType)
         Case "Decimal Places"
            $nType = 1
         Case "Significant Figures"
            $nType = 2
         Case "Digit Precision"
            $nType = 3
         Case Else
            $nType = 1
      EndSwitch
      Switch GUICtrlRead ($hDir)
         Case "Nearest"
            $nDir = 1
         Case "Up"
            $nDir = 2
         Case "Down"
            $nDir = 3
         Case "To Zero"
            $nDir = 4
         Case "From Zero"
            $nDir = 5
         Case "Dither"
            $nDir = 6
         Case Else
            $nDir = 1
      EndSwitch
      Switch GUICtrlRead ($hTie)
         Case "Up"
            $nTie = 1
         Case "Down"
            $nTie = 2
         Case "To Zero"
            $nTie = 3
         Case "From Zero"
            $nTie = 4
         Case "To Even"
            $nTie = 5
         Case "To Odd"
            $nTie = 6
         Case "Stochastic"
            $nTie = 7
         Case "Alternative"
            $nTie = 8
         Case Else
            $nTie = 5
      EndSwitch
      $nPad = 1
      If BitAND (GUICtrlRead ($hPad), 4) Then $nPad = 0
      $nNum += 0
      $nPlaces += 0
      $nDir += 0
      $nType += 0
      $nTie += 0
      $nPad += 0
      GUICtrlSetData ($hResult, _MathRound ($nNum, $nPlaces, $nDir, $nType, $nTie, $nPad))
   EndIf
EndFunc ; ==> _TextChanged

Func _Exit ()
   Exit
EndFunc ; ==> _Exit