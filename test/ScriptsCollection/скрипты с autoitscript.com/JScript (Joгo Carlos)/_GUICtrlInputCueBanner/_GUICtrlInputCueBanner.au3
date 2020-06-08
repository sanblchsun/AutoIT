#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w- 4 -w 5 -w 6 -w- 7 ; Uncomment this line to Au3Check!
#include-once
; #INDEX# =======================================================================================================================
; Title .........: _GUICtrlInputCueBanner
; Version .......: 0.9.1012.2600b
; AutoIt Version.: 3.3.8.1
; Language.......: English
; Description ...: Creates a cuebanner/placehold (background comment) in the control using Call Back!
; Author ........: JScript (João Carlos)
; Remarks .......:
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
; _GuiCtrlInput_SetCueBanner
; _GuiCtrlInput_UnSetCueBanner
; ===============================================================================================================================

; #INTERNAL_USE_ONLY# ===========================================================================================================
; __GIC_GetMsgIndex
; __GIC_ShutDown
; ===============================================================================================================================

; #INCLUDES# ====================================================================================================================
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <EditConstants.au3>
#include <Constants.au3>
#include <WinApi.au3>
; ===============================================================================================================================

; #VARIABLES# ===================================================================================================================
Global $avGIC_MSGIDS[1][11]
; ===============================================================================================================================

; #EXIT_REGISTER# ===============================================================================================================
OnAutoItExitRegister("__GIC_ShutDown")
; ===============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name ..........: _GuiCtrlInput_SetCueBanner
; Description ...: Creates a cuebanner/placehold (background comment) in the control using Call Back!
; Syntax ........: _GuiCtrlInput_SetCueBanner( iCtrlID,  "sText", iFrontColor, iBackColor )
; Parameters ....: $iCtrlID             - An integer value.
;                  $sText               - A string value.
;                  $iFrontColor         - [optional] An integer value. Default is -1 (COLOR_GRAYTEXT).
;                  $iBackColor          - [optional] An integer value. Default is 0xFFFFFF.
; Return values .: Success 	 			- Returns a handle to be used with _GUICtrlMsg_UnRegister function.
;				   Failure 	 			- Returns 0 and sets @error!
; Author ........: JScript
; Modified ......:
; Remarks .......:
; Related .......: _GuiCtrlInput_UnSetCueBanner
; Link ..........:
; Example .......: _GuiCtrlInput_SetCueBanner( -1, "Confirm new password", 0x9C9C9C, 0xE8E8E8 )
; ===============================================================================================================================
Func _GuiCtrlInput_SetCueBanner($iCtrlID, $sText, $iFrontColor = -1, $iBackColor = -1)
	Local $hCtrlID, $hWndForm, $hWnd, $hPrior, $hNext
	Local $iIndex

	If $iCtrlID = -1 Then $iCtrlID = _WinAPI_GetDlgCtrlID(GUICtrlGetHandle(-1))

	If IsHWnd($iCtrlID) Then Return SetError(1, 0, 0)
	If Not IsString($sText) Or Not $sText Then Return SetError(2, 0, 0)

	$iIndex = __GIC_GetMsgIndex($iCtrlID)
	If $iIndex Then Return SetError(3, 0, 0)

	; Get window handle...
	$hCtrlID = GUICtrlGetHandle($iCtrlID)
	$hWndForm = _WinAPI_GetParent($hCtrlID)
	If Not $hWndForm Then Return SetError(4, 0, 0)

	$hWnd = DllCallbackRegister("__GIC_CommentMsg", "ptr", "hwnd;uint;long;ptr")
	If Not $hWnd Then Return SetError(5, 0, 0)

	$hPrior = _WinAPI_SetWindowLong($hCtrlID, $GWL_WNDPROC, DllCallbackGetPtr($hWnd))
	$hNext = _WinAPI_SetWindowLong($hCtrlID, $GWL_WNDPROC, DllCallbackGetPtr($hWnd))
	If Not $hPrior Or Not $hNext Then
		DllCallbackFree($hWnd)
		Return SetError(6, 0, 0)
	EndIf

	If $iFrontColor = -1 Then $iFrontColor = _WinAPI_GetSysColor($COLOR_GRAYTEXT); 0x9C9C9C
	If $iBackColor = -1 Then $iBackColor = _WinAPI_GetSysColor($COLOR_WINDOW)

	;----> Fills array with the control data!
	$iIndex = $avGIC_MSGIDS[0][0] + 1
	ReDim $avGIC_MSGIDS[$iIndex + 1][11]
	$avGIC_MSGIDS[0][0] = $iIndex
	$avGIC_MSGIDS[$iIndex][0] = $iCtrlID
	$avGIC_MSGIDS[$iIndex][1] = $hCtrlID
	$avGIC_MSGIDS[$iIndex][2] = $sText
	$avGIC_MSGIDS[$iIndex][3] = $iFrontColor
	$avGIC_MSGIDS[$iIndex][4] = $iBackColor
	$avGIC_MSGIDS[$iIndex][5] = $hWnd ; Handle to use with DllCallbackFree.
	$avGIC_MSGIDS[$iIndex][6] = $hPrior
	$avGIC_MSGIDS[$iIndex][7] = _WinAPI_GetSysColor($COLOR_WINDOWTEXT)
	$avGIC_MSGIDS[$iIndex][8] = _WinAPI_GetSysColor($COLOR_WINDOW)
	; Get styles of control!
	$avGIC_MSGIDS[$iIndex][9] = _WinAPI_GetWindowLong($hCtrlID, $GWL_STYLE)
	$avGIC_MSGIDS[$iIndex][10] = _WinAPI_GetWindowLong($hCtrlID, $GWL_EXSTYLE)
	;<----

	__GIC_CommentMsg($hCtrlID, $WM_KILLFOCUS, 0, 0)
	Return SetError(0, 0, 1)
EndFunc   ;==>_GuiCtrlInput_SetCueBanner

; #FUNCTION# ====================================================================================================================
; Name ..........: _GuiCtrlInput_UnSetCueBanner
; Description ...: Removes a background comment in the control.
; Syntax ........: _GuiCtrlInput_UnSetCueBanner( iCtrlID )
; Parameters ....: $hWnd                - A value returned by _GuiCtrlInput_SetCueBanner function.
; Return values .: Success 	 			- Returns 1.
;				   Failure 	 			- Returns 0.
; Author ........: JScript
; Modified ......:
; Remarks .......:
; Related .......: _GuiCtrlInput_SetCueBanner
; Link ..........:
; Example .......: _GuiCtrlInput_UnSetCueBanner($iCtrlID)
; ===============================================================================================================================
Func _GuiCtrlInput_UnSetCueBanner($iCtrlID)
	Local $iIndex

	$iIndex = __GIC_GetMsgIndex($iCtrlID)
	If Not $iIndex Then Return 0

	_WinAPI_SetWindowLong($avGIC_MSGIDS[$iIndex][1], $GWL_WNDPROC, $avGIC_MSGIDS[$iIndex][6])
	DllCallbackFree($avGIC_MSGIDS[$iIndex][5])

	GUICtrlSetData($avGIC_MSGIDS[$iIndex][0], "")
	GUICtrlSetColor($avGIC_MSGIDS[$iIndex][0], $avGIC_MSGIDS[$iIndex][7])
	GUICtrlSetBkColor($avGIC_MSGIDS[$iIndex][0], $avGIC_MSGIDS[$iIndex][8])

	For $i = $iIndex To UBound($avGIC_MSGIDS) - 2
		For $j = 0 To 10
			$avGIC_MSGIDS[$i][$j] = $avGIC_MSGIDS[$i + 1][$j]
		Next
	Next
	ReDim $avGIC_MSGIDS[$avGIC_MSGIDS[0][0]][11]
	$avGIC_MSGIDS[0][0] -= 1

	Return 1
EndFunc   ;==>_GuiCtrlInput_UnSetCueBanner

; #FUNCTION# ====================================================================================================================
; Name ..........: __GIC_CommentMsg
; Description ...:
; Syntax ........: __GIC_CommentMsg($hWnd, $iMsg, $wParam, $lParam)
; Parameters ....: $hWnd                - Handle to the window procedure to receive the message.
;                  $iMsg                - Specifies the message.
;                  $wParam              - Specifies additional message-specific information.
;                  $lParam              - Specifies additional message-specific information.
; Return values .: Returns the return value specifies the result of the message processing and depends on the message sent!
; Author ........: JScript
; Modified ......:
; Remarks .......: Same as _WinAPI_CallWindowProc function!
;				   $wParam and $lParam: contents of this parameters depend on the value of the Msg parameter!
; Related .......: _GuiCtrlInput_SetCueBanner
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func __GIC_CommentMsg($hWnd, $iMsg, $wParam, $lParam)
	Local $iIndex, $sCtrlRead

	$iIndex = __GIC_GetMsgIndex($hWnd)

	Switch $iMsg
		Case $WM_CHAR
			$sCtrlRead = GUICtrlRead($avGIC_MSGIDS[$iIndex][0])

			If $wParam And $sCtrlRead = $avGIC_MSGIDS[$iIndex][2] Then
				If BitAND($avGIC_MSGIDS[$iIndex][9], $ES_PASSWORD) = $ES_PASSWORD Then
					__GIC_ToggleStyle($avGIC_MSGIDS[$iIndex][0], 1)
				EndIf
				GUICtrlSetData($avGIC_MSGIDS[$iIndex][0], "")
				GUICtrlSetColor($avGIC_MSGIDS[$iIndex][0], $avGIC_MSGIDS[$iIndex][7])
			EndIf
		Case $WM_KILLFOCUS;, $WM_MOUSELEAVE
			$sCtrlRead = GUICtrlRead($avGIC_MSGIDS[$iIndex][0])

			If Not $sCtrlRead Or $sCtrlRead = $avGIC_MSGIDS[$iIndex][2] Then
				If BitAND($avGIC_MSGIDS[$iIndex][9], $ES_PASSWORD) = $ES_PASSWORD Then
					__GIC_ToggleStyle($avGIC_MSGIDS[$iIndex][0], 0)
				EndIf
				GUICtrlSetData($avGIC_MSGIDS[$iIndex][0], $avGIC_MSGIDS[$iIndex][2])
				GUICtrlSetBkColor($avGIC_MSGIDS[$iIndex][0], $avGIC_MSGIDS[$iIndex][4])
				GUICtrlSetColor($avGIC_MSGIDS[$iIndex][0], $avGIC_MSGIDS[$iIndex][3])
				;Send("{HOME}")
			EndIf
		Case $WM_SETFOCUS, $WM_LBUTTONDOWN;, $WM_MOUSEHOVER
			$sCtrlRead = GUICtrlRead($avGIC_MSGIDS[$iIndex][0])

			If $sCtrlRead = $avGIC_MSGIDS[$iIndex][2] Then
				If BitAND($avGIC_MSGIDS[$iIndex][9], $ES_PASSWORD) = $ES_PASSWORD Then
					__GIC_ToggleStyle($avGIC_MSGIDS[$iIndex][0], 0)
				EndIf
				GUICtrlSetBkColor($avGIC_MSGIDS[$iIndex][0], $avGIC_MSGIDS[$iIndex][8])
				Send("{HOME}")
			EndIf
	EndSwitch
	; Pass the unhandled messages to default WindowProc
	Return _WinAPI_CallWindowProc($avGIC_MSGIDS[$iIndex][6], $hWnd, $iMsg, $wParam, $lParam)
EndFunc   ;==>__GIC_CommentMsg

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name ..........: __GIC_GetMsgIndex
; Description ...: Return array index based on $vCtrlID
; Syntax ........: __GIC_GetMsgIndex($vCtrlID)
; Parameters ....: $vCtrlID                - A value returned by _GuiCtrlInput_SetCueBanner function.
; Return values .: Array Index
; Author ........: JScript
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func __GIC_GetMsgIndex($vCtrlID)
	If $avGIC_MSGIDS[0][0] Then
		For $iIndex = 1 To $avGIC_MSGIDS[0][0]
			Switch $vCtrlID
				Case $avGIC_MSGIDS[$iIndex][0], $avGIC_MSGIDS[$iIndex][1]
					Return $iIndex
			EndSwitch
		Next
	EndIf
	Return 0
EndFunc   ;==>__GIC_GetMsgIndex

;void ToggleStyle(HWND hEdit)
;{
;    if(SendMessage(hEdit,EM_GETPASSWORDCHAR,0,0) == '*')
;        SendMessage(hEdit,EM_SETPASSWORDCHAR,0,0);
;    else
;        SendMessage(hEdit,EM_SETPASSWORDCHAR,(WPARAM)'*',0);
;    SetFocus(hEdit);
;}
Func __GIC_ToggleStyle($iCtrlID, $iToggleState = 0)
	Local Const $EM_SETPASSWORDCHAR = 0xCC
	Local Const $EM_GETPASSWORDCHAR = 0xD2

	; Get window handle...
	Local $hCtrlID = GUICtrlGetHandle($iCtrlID)
	If Not $hCtrlID Then Return SetError(1, 0, 0)

	Local Static $iPassChar = _SendMessage($hCtrlID, $EM_GETPASSWORDCHAR, 0, 0)

	If $iToggleState Then
		_SendMessage($hCtrlID, $EM_SETPASSWORDCHAR, $iPassChar, 0) ; 9679
	Else
		_SendMessage($hCtrlID, $EM_SETPASSWORDCHAR, 0, 0)
	EndIf

	;Return ControlFocus($hWndForm, "", $iCtrlID)
EndFunc   ;==>__GIC_ToggleStyle

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name ..........: __GIC_ShutDown
; Description ...: Function to be called when AutoIt exits.
; Syntax ........: __GIC_ShutDown()
; Parameters ....:
; Return values .: None
; Author ........: JScript
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func __GIC_ShutDown()
	;----> Frees handles created with DllCallbackRegister.
	If $avGIC_MSGIDS[0][0] Then
		For $iIndex = 1 To $avGIC_MSGIDS[0][0]
			_WinAPI_SetWindowLong($avGIC_MSGIDS[$iIndex][1], $GWL_WNDPROC, $avGIC_MSGIDS[$iIndex][6])
			DllCallbackFree($avGIC_MSGIDS[$iIndex][5])
		Next
	EndIf
	;<----
EndFunc   ;==>__GIC_ShutDown