; ===============================================================================================================================
; File     : DragDropEvent_Example_1.au3 (2012/3/9)
; Purpose  : Demonstrate the usage of DragDropEvent UDF
; Author   : Ward
; ===============================================================================================================================

#Include <GUIConstantsEx.au3>
#Include <WindowsConstants.au3>
#Include "DragDropEvent.au3"

Opt("MustDeclareVars", 1)

DragDropEvent_Startup()
Main()
Exit

Func Main()
	Local $MainWin = GUICreate("DragDropEvent Example", 380, 130, -1, -1, -1, $WS_EX_TOPMOST)
	GUISetFont(12, 900)
	GUICtrlCreateLabel("(Drop text or files on me)", 40, 40)

	DragDropEvent_Register($MainWin)

	GUIRegisterMsg($WM_DRAGENTER, "OnDragDrop")
	GUIRegisterMsg($WM_DRAGOVER, "OnDragDrop")
	GUIRegisterMsg($WM_DRAGLEAVE, "OnDragDrop")
	GUIRegisterMsg($WM_DROP, "OnDragDrop")

	GUISetState(@SW_SHOW)
	While GUIGetMsg() <> $GUI_EVENT_CLOSE
	WEnd
	GUIDelete()
EndFunc

Func OnDragDrop($hWnd, $Msg, $wParam, $lParam)
	Static $DropAccept

	Switch $Msg
		Case $WM_DRAGENTER, $WM_DROP
			ToolTip("")
			Select
				Case DragDropEvent_IsFile($wParam)
					If $Msg = $WM_DROP Then
						Local $FileList = DragDropEvent_GetFile($wParam)
						MsgBox(262144, "DragDropEvent", StringReplace($FileList, "|", @LF))
					EndIf
					$DropAccept = $DROPEFFECT_COPY

				Case DragDropEvent_IsText($wParam)
					If $Msg = $WM_DROP Then
						MsgBox(262144, "DragDropEvent", DragDropEvent_GetText($wParam))
					EndIf
					$DropAccept = $DROPEFFECT_COPY

				Case Else
					$DropAccept = $DROPEFFECT_NONE

			EndSelect
			Return $DropAccept

		Case $WM_DRAGOVER
			Local $X = DragDropEvent_GetX($wParam)
			Local $Y = DragDropEvent_GetY($wParam)
			ToolTip("(" & $X & "," & $Y & ")")
			Return $DropAccept

		Case $WM_DRAGLEAVE
			ToolTip("")

	EndSwitch
EndFunc
