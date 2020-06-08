Opt("GUIResizeMode", 802)

$GUI = GUICreate("GUI расширить/сжать", 275, 208)
$EX = GUICtrlCreateButton(ChrW('0x25BA') , 245, 5, 25, 25)
GUICtrlSetFont (-1,-1, -1, -1, 'Arial')

GUISetState()

While 1
    $Msg = GUIGetMsg()
    Switch $Msg
		Case $EX
			$GuiPos = WinGetPos($Gui)
			If $GuiPos[2] > 250 And $GuiPos[2] < 300 Then
				WinMove($Gui, "", $GuiPos[0], $GuiPos[1], $GuiPos[2]+235, $GuiPos[3])
				GUICtrlSetData($EX,ChrW ('0x25C4'))
			Else
				WinMove($Gui, "", $GuiPos[0], $GuiPos[1], $GuiPos[2]-235, $GuiPos[3])
				GUICtrlSetData($EX,ChrW ('0x25BA'))
			EndIf
        Case -3
            Exit
    EndSwitch
WEnd
