; ===============================================================================================================================
; File     : DragDropEvent_Example_2.au3 (2012/3/9)
; Purpose  : Demonstrate the usage of DragDropEvent UDF
; Author   : Ward
; ===============================================================================================================================

#Include <GUIConstantsEx.au3>
#Include <WindowsConstants.au3>
#Include "DragDropEvent.au3"

Opt("MustDeclareVars", 1)

Global $Button1, $Button2, $Button3, $Button4

DragDropEvent_Startup()
Main()
Exit

Func Main()
	Local $MainWin = GUICreate("DragDropEvent Example", 460, 400, -1, -1, -1, $WS_EX_TOPMOST)
	GUISetFont(12, 900)

	$Button1 = GUICtrlCreateButton("Drop Text", 20, 20, 200, 150)
	$Button2 = GUICtrlCreateButton("Drop Files", 240, 20, 200, 150)
	$Button3 = GUICtrlCreateButton("Drop Anything", 20, 190, 200, 150)
	$Button4 = GUICtrlCreateButton("Don't Drop", 240, 190, 200, 150)
	GUICtrlCreateLabel("(Click button to revoke the target)", 40, 350)

	DragDropEvent_Register(GUICtrlGetHandle($Button1), $MainWin)
	DragDropEvent_Register(GUICtrlGetHandle($Button2), $MainWin)
	DragDropEvent_Register(GUICtrlGetHandle($Button3), $MainWin)
	DragDropEvent_Register(GUICtrlGetHandle($Button4), $MainWin)

	GUIRegisterMsg($WM_DRAGENTER, "OnDragDrop")
	GUIRegisterMsg($WM_DRAGOVER, "OnDragDrop")
	GUIRegisterMsg($WM_DRAGLEAVE, "OnDragDrop")
	GUIRegisterMsg($WM_DROP, "OnDragDrop")

	GUISetState(@SW_SHOW)
	While 1
		Local $Msg = GUIGetMsg()
		Switch $Msg
			Case $Button1, $Button2, $Button3, $Button4
				DragDropEvent_Revoke(GUICtrlGetHandle($Msg))

			Case $GUI_EVENT_CLOSE
				ExitLoop
		EndSwitch
	WEnd

	GUIDelete()
EndFunc

Func OnDragDrop($hWnd, $Msg, $wParam, $lParam)
	Static $DropAccept

	Switch $Msg
		Case $WM_DRAGENTER, $WM_DROP
			ToolTip("")
			Local $Target = DragDropEvent_GetHWnd($wParam)
			Select
				Case DragDropEvent_IsFile($wParam)
					If $Target = GUICtrlGetHandle($Button1) Or $Target = GUICtrlGetHandle($Button4) Then
						$DropAccept = $DROPEFFECT_NONE
					Else
						If $Msg = $WM_DROP Then
							Local $FileList = DragDropEvent_GetFile($wParam)
							MsgBox(262144, "DragDropEvent", StringReplace($FileList, "|", @LF))
						EndIf
						$DropAccept = $DROPEFFECT_COPY
					EndIf

				Case DragDropEvent_IsText($wParam)
					If $Target = GUICtrlGetHandle($Button2) Or $Target = GUICtrlGetHandle($Button4) Then
						$DropAccept = $DROPEFFECT_NONE
					Else
						If $Msg = $WM_DROP Then
							MsgBox(262144, "DragDropEvent", DragDropEvent_GetText($wParam))
						EndIf
						$DropAccept = $DROPEFFECT_COPY
					EndIf

				Case Else
					$DropAccept = $DROPEFFECT_NONE

			EndSelect
			Return $DropAccept

		Case $WM_DRAGOVER
			Local $X = DragDropEvent_GetX($wParam)
			Local $Y = DragDropEvent_GetY($wParam)
			Local $KeyState = DragDropEvent_GetKeyState($wParam)
			ToolTip("(" & $X & "," & $Y & "," & $KeyState & ")")
			Return $DropAccept

		Case $WM_DRAGLEAVE
			ToolTip("")

	EndSwitch
EndFunc

