#include "FFLabels.au3"
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

_FlickerExample()
_FlickerFreeExample()
_FlickerExample2()
_FlickerFreeExample2()

Func _FlickerExample()

	#region ### START Koda GUI section ### Form=
	Local $hGUI = GUICreate("Flicker Example", 522, 193)
	Local $lb1 = GUICtrlCreateLabel("", 163, 16, 67, 17)
	Local $lb2 = GUICtrlCreateLabel("", 164, 40, 67, 17)
	Local $lb3 = GUICtrlCreateLabel("", 163, 64, 67, 17)
	Local $lb4 = GUICtrlCreateLabel("", 163, 88, 67, 17)
	Local $lb5 = GUICtrlCreateLabel("", 163, 112, 67, 17)
	Local $lb6 = GUICtrlCreateLabel("", 427, 16, 67, 17)
	Local $lb7 = GUICtrlCreateLabel("", 427, 40, 67, 17)
	Local $lb8 = GUICtrlCreateLabel("", 427, 64, 67, 17)
	Local $lb9 = GUICtrlCreateLabel("", 427, 88, 67, 17)
	Local $lb10 = GUICtrlCreateLabel("", 427, 112, 67, 17)
	Local $lb11 = GUICtrlCreateLabel("", 274, 142, 67, 17)
	Local $lb12 = GUICtrlCreateLabel("", 275, 166, 67, 17)
	GUICtrlCreateLabel("Title 1 =", 27, 16, 42, 17)
	GUICtrlCreateLabel("TitleABCE 3 =", 27, 40, 85, 17)
	GUICtrlCreateLabel("TitleAB 5 =", 27, 64, 118, 17)
	GUICtrlCreateLabel("Title 7 =", 27, 88, 42, 17)
	GUICtrlCreateLabel("Title 9 =", 27, 112, 42, 17)
	GUICtrlCreateLabel("TitleA 2 =", 291, 16, 42, 17)
	GUICtrlCreateLabel("TitleEFG 4 =", 291, 40, 85, 17)
	GUICtrlCreateLabel("TitleABC 6 =", 291, 64, 118, 17)
	GUICtrlCreateLabel("Title 8 =", 291, 88, 42, 17)
	GUICtrlCreateLabel("Title 10 =", 291, 112, 48, 17)
	GUICtrlCreateLabel("Title 11 =", 178, 142, 48, 17)
	GUICtrlCreateLabel("TitleABCE 12 =", 178, 166, 91, 17)
	GUISetState(@SW_SHOW)
	#endregion ### END Koda GUI section ###

	Local $i = 10000
	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				GUIDelete($hGUI)
				Return
			Case Else
				$i += 1
				GUICtrlSetData($lb1, $i)
				GUICtrlSetData($lb2, $i)
				GUICtrlSetData($lb3, $i)
				GUICtrlSetData($lb4, $i)
				GUICtrlSetData($lb5, $i)
				GUICtrlSetData($lb6, $i)
				GUICtrlSetData($lb7, $i)
				GUICtrlSetData($lb8, $i)
				GUICtrlSetData($lb9, $i)
				GUICtrlSetData($lb10, $i)
				GUICtrlSetData($lb11, $i)
				GUICtrlSetData($lb12, $i)
		EndSwitch
	WEnd
EndFunc   ;==>_FlickerExample

Func _FlickerFreeExample()
	Local $width = 521
	Local $hGUI = GUICreate("Flicker Free Example", $width, 193)
	Local $lb1 = _GUICtrlFFLabel_Create($hGUI, "", 1, 15, $width, 17, 9, -1, -1, 3)
	Local $lb2 = _GUICtrlFFLabel_Create($hGUI, "", 1, 40, $width, 17, 9, -1, -1, 3)
	Local $lb3 = _GUICtrlFFLabel_Create($hGUI, "", 1, 65, $width, 17, 9, -1, -1, 3)
	Local $lb4 = _GUICtrlFFLabel_Create($hGUI, "", 1, 90, $width, 17, 9, -1, -1, 3)
	Local $lb5 = _GUICtrlFFLabel_Create($hGUI, "", 1, 115, $width, 17, 9, -1, -1, 3)
	Local $lb6 = _GUICtrlFFLabel_Create($hGUI, "", 1, 140, $width, 17, 9, -1, -1, 3)
	Local $lb7 = _GUICtrlFFLabel_Create($hGUI, "", 1, 165, $width, 17, 9, -1, -1, 3)
	GUISetState(@SW_SHOW)

	Local $i = 10000
	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				GUIDelete($hGUI)
				Return
			Case Else
				$i += 1
				_GUICtrlFFLabel_SetData($lb1, StringFormat('   \tTitle 1 = \t\t%5d      \t\t\tTitle 2 = \t\t%5d', $i, $i, $i))
				_GUICtrlFFLabel_SetData($lb2, StringFormat('   \tTitleABCD 3 = \t%5d      \t\t\tTitleAB 3 = \t%5d', $i, $i, $i))
				_GUICtrlFFLabel_SetData($lb3, StringFormat('   \tTitle 4 = \t\t%5d      \t\t\tTitleA 5 = \t%5d', $i, $i, $i))
				_GUICtrlFFLabel_SetData($lb4, StringFormat('   \tTitleABC 6 = \t%5d      \t\t\tTitleAB 7 = \t%5d', $i, $i, $i))
				_GUICtrlFFLabel_SetData($lb5, StringFormat('   \tTitle 8 = \t\t%5d      \t\t\tTitleABC 9 = \t%5d', $i, $i, $i))
				_GUICtrlFFLabel_SetData($lb6, StringFormat('   \t\t\t\tTitle 6 = \t\t%5d', $i))
				_GUICtrlFFLabel_SetData($lb7, StringFormat('   \t\t\t\tTitleABCDE 8 = \t%5d', $i))
		EndSwitch
	WEnd
EndFunc   ;==>_FlickerFreeExample

Func _FlickerExample2()

	Local $Form1 = GUICreate("Flickering Labels", 409, 218)
	Local $Label1 = GUICtrlCreateLabel("Label 1 =", 80, 40, 55, 19)
	Local $Label2 = GUICtrlCreateLabel("Label 2 =", 80, 80, 55, 19)
	Local $Label3 = GUICtrlCreateLabel("Label 3 = ", 80, 120, 58, 19)
	Local $Label4 = GUICtrlCreateLabel("", 146, 40, 183, 19)
	Local $Label5 = GUICtrlCreateLabel("", 146, 80, 183, 19)
	Local $Label6 = GUICtrlCreateLabel("", 80, 120, 240, 17)
	GUISetFont(9, 200, 0, 'Microsoft Sans Serif')
	GUISetState(@SW_SHOW)

	Local $iCount
	While 1
		Switch GUIGetMsg()
			Case -3; $GUI_EVENT_CLOSE
				GUIDelete($Form1)
				Return
			Case Else
				GUICtrlSetData($Label4, Round(Random(1, 100000), 3))
				GUICtrlSetData($Label5, Random(1, 100000))
				GUICtrlSetData($Label6, 'Label 1 =       ' & Random(1, 100000))
		EndSwitch
	WEnd
EndFunc   ;==>_FlickerExample

Func _FlickerFreeExample2()

	Local $hGUI = GUICreate("Flicker Free Labels", 409, 218, -1, -1, BitOR($WS_MINIMIZEBOX, $WS_MAXIMIZEBOX, $WS_SIZEBOX))
	Local $button_move = GUICtrlCreateButton("Move", 90, 150, 113, 21)
	Local $button_delete = GUICtrlCreateButton("Delete", 220, 150, 113, 21)
	GUICtrlSetResizing(-1, $GUI_DOCKALL)

	Local $Label1 = _GUICtrlFFLabel_Create($hGUI, "Label 1 ", 80, 40, 240, 17)
	Local $Label2 = _GUICtrlFFLabel_Create($hGUI, "Label Two", 80, 80, 240, 17, 9, 'Times', 1, 0, 0xFFFF0000)
	Local $Label3 = _GUICtrlFFLabel_Create($hGUI, "Label 3", 80, 120, 240, 17)
	Local $Label8 = _GUICtrlFFLabel_Create($hGUI, "Flicker Free", 140, 10, 129, 33, 16)

	GUISetState(@SW_SHOW)
	$bMove = 0
	While 1
		Switch GUIGetMsg()
			Case -3;$GUI_EVENT_CLOSE
				GUIDelete($hGUI)
				Return
			Case $button_delete
				_GUICtrlFFLabel_Delete($Label2)
			Case $button_move
				$bMove = BitXOR($bMove, 1);toggle
				If $bMove Then
					_GUICtrlFFLabel_Move($Label1, 20)
				Else
					_GUICtrlFFLabel_Move($Label1, 200)
				EndIf
			Case Else
				_GUICtrlFFLabel_SetData($Label1, "Label One     = " & Random(1, 100000))
				_GUICtrlFFLabel_SetData($Label2, "Label Two     = " & Random(1, 100000))
				_GUICtrlFFLabel_SetData($Label3, "Label Three  = " & Random(1, 100000))
		EndSwitch
	WEnd

EndFunc   ;==>_FlickerFreeExample1