; http://www.autoitscript.com/forum/topic/118808-how-to-use-help-button-in-msgbox/
; #STRUCTURE# ===================================================================================================================
; Name...........: $tagHELPINFO
; Description ...: Contains information about an item for which context-sensitive Help has been requested
; Fields ........: Size             - The structure size, in bytes
;               ContextType     - The type of context for which Help is requested. This member can be one of the following values:
;           HELPINFO_WINDOW   = 1: Help requested for a control or window.
;           HELPINFO_MENUITEM = 2: Help requested for a menu item.
;               CtrlID          - The identifier of the window or control if ContextType is HELPINFO_WINDOW,
;                                   or identifier of the menu item if ContextType is HELPINFO_MENUITEM
;               ItemHandle      - The identifier of the child window or control if ContextType is HELPINFO_WINDOW,
;                                   or identifier of the associated menu if ContextType is HELPINFO_MENUITEM.
;               ContextID       - The help context identifier of the window or control.
;               PointX          - X position that of the mouse at the time the event occurred
;               PointY          - Y position that of the mouse at the time the event occurred
; Author ........: funkey
; Remarks .......:
; ===============================================================================================================================
Global Const $tagHELPINFO = "uint Size;int ContextType;int CtrlID;handle ItemHandle;dword ContextID;int PointX;int PointY"

Global Const $MB_HELP = 0x4000

Opt("GUIOnEventMode", 1)

Global $Toggle = False

#Region Help GUI
Global $hGuiHelp = GUICreate("Help-GUI", 220, 100, -1, -1, 0x80880000, 0x00000088)
GUISetBkColor(0xFFFFE1) ;tooltip color
GUICtrlCreateLabel("Help for abort button", 10, 10)
GUICtrlCreateLabel("Help for retry button", 10, 30)
GUICtrlCreateLabel("Help for ignore button", 10, 50)
#EndRegion Help GUI

Global $hGui = GUICreate("Main Application")
GUISetOnEvent(-3, "_Exit")
GUIRegisterMsg(0x0053, "_Help") ;WM_HELP

Global $Button = GUICtrlCreateButton("Show MsgBox", 50, 50)
GUICtrlSetOnEvent(-1, "_Show_MsgBox")

GUISetState()

While 1
	Sleep(20000)
WEnd

Func _Help($hWnd, $Msg, $wParam, $lParam)
	Local $tInfo, $ContextType, $CtrlID, $ItemHandle, $ContextID, $X, $Y

	$tInfo = DllStructCreate($tagHELPINFO, $lParam)
	$ContextType = DllStructGetData($tInfo, "ContextType")
	$CtrlID = DllStructGetData($tInfo, "CtrlID")
	$ItemHandle = HWnd(DllStructGetData($tInfo, "ItemHandle"))
	$ContextID = DllStructGetData($tInfo, "ContextID")
	$X = DllStructGetData($tInfo, "PointX")
	$Y = DllStructGetData($tInfo, "PointY")

	ConsoleWrite("ContextType: " & $ContextType & @CR)
	ConsoleWrite("CtrlID:  " & $CtrlID & @CR)
	ConsoleWrite("ItemHandle: " & $ItemHandle & @CR)
	ConsoleWrite("ContextID: " & $ContextID & @CR)
	ConsoleWrite("PointX:  " & $X & @CR)
	ConsoleWrite("PointY:  " & $Y & @CR & @CR)

	Local $aPos = ControlGetPos($ItemHandle, "", $CtrlID)

	$Toggle = Not $Toggle
	If $Toggle Then
		_ClientToScreen($ItemHandle, $aPos[0], $aPos[1])
		WinMove($hGuiHelp, "", $aPos[0], $aPos[1] + $aPos[3])
		GUISetState(@SW_SHOW, $hGuiHelp)
		Switch StringRight(@OSLang, 2)
			Case "07" ;german
				ControlSetText($ItemHandle, "", $CtrlID, "Schlie?e Hilfe")
			Case "09" ;english
				ControlSetText($ItemHandle, "", $CtrlID, "Close Help")
		EndSwitch
	Else
		GUISetState(@SW_HIDE, $hGuiHelp)
		Switch StringRight(@OSLang, 2)
			Case "07" ;german
				ControlSetText($ItemHandle, "", $CtrlID, "Hilfe")
			Case "09" ;english
				ControlSetText($ItemHandle, "", $CtrlID, "Help")
		EndSwitch
	EndIf
EndFunc

Func _Show_MsgBox()
	Local $ret = MsgBox($MB_HELP + 2 + 48, "Hello", "What do you want to do?", 0, $hGui)
	ConsoleWrite($ret & @CR)
	GUISetState(@SW_HIDE, $hGuiHelp)
	$Toggle = False
EndFunc

; Convert the client (GUI) coordinates to screen (desktop) coordinates
Func _ClientToScreen($hWnd, ByRef $X, ByRef $Y)
	Local $stPoint = DllStructCreate("int;int")

	DllStructSetData($stPoint, 1, $X)
	DllStructSetData($stPoint, 2, $Y)

	DllCall("user32.dll", "int", "ClientToScreen", "hwnd", $hWnd, "ptr", DllStructGetPtr($stPoint))

	$X = DllStructGetData($stPoint, 1)
	$Y = DllStructGetData($stPoint, 2)
	; release Struct not really needed as it is a local
	$stPoint = 0
EndFunc

Func _Exit()
	Exit
EndFunc