;#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w- 4 -w 5 -w 6 -w- 7 ; Uncomment this line to Au3Check!
#include-once
; #INDEX# =======================================================================================================================
; Title .........: _GUIRegisterMsgEx
; Version .......: 0.9.1412.2600b
; AutoIt Version.: 3.3.8.1
; Language.......: English
; Description ...: Register a user defined function for a known Windows Message ID (WM_MSG) to an individual ctrl using Call Back!
; Author ........: JScript (João Carlos)
; Remarks .......: For controls that consume internally specific Windows Message ID that we could not register with the
;				GUIRegisterMsg function, eg: WM_CHAR, WM_KEYDOWN, WM_KEYUP are consumed by an edit control.
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
; _GUICtrlMsg_Register
; _GUICtrlMsg_UnRegister
; ===============================================================================================================================

; #INTERNAL_USE_ONLY# ===========================================================================================================
; __GRM_GetHWndIndex
; __GRM_GetMsgIndex
; __GRM_CallBack
; __GRM_ShutDown
; ===============================================================================================================================

; #INCLUDES# ====================================================================================================================
#include <Constants.au3>
#include <WinApi.au3>
; ===============================================================================================================================

; #VARIABLES# ===================================================================================================================
Global $avGRM_MSGIDS[1][5]
; ===============================================================================================================================

; #EXIT_REGISTER# ===============================================================================================================
OnAutoItExitRegister("__GRM_ShutDown")
; ===============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name ..........: _GUICtrlMsg_Register
; Description ...: Register a user defined function for a known Windows Message ID (WM_MSG) to an ctrl using Call Back!
; Syntax ........: _GUICtrlMsg_Register( $iCtrlID, $iMsgID, $sFunction )
; Parameters ....: $iCtrlID             - A control ID to register msg.
;                  $iMsgID              - An integer value.
;                  $sFunction           - The name of the user function to call when the message appears.
; Return values .: Success 	 			- Returns a handle to be used with_GUICtrlMsg_UnRegister function.
;				   Failure 	 			- Returns 0 and sets @error!
; Author ........: JScript
; Modified ......: SmOke_N - autoitscript.com/forum/topic/144041-guiregistermsgex-udf-like-native-but-for-controls/#entry1016135
; Remarks .......: --------------------------------------------------------------------------------------------------------------
;				To make the user function workable you have to define it with EXACTLY 4 function parameters, otherwise the
;				function won't be called!
;				I.e:
;				Func _MyRegisterFunc( $hCtrlID, $iMsgID, $WParam, $LParam )
;				...
;				EndFunc
;
;				The 4 parameters have the following values:
;				-----------------------------------------------------------------------------------------------------------------
;				|Position 	|Parameter 	|Meaning
;				|1 			|hCtrlID 	|The control handle in which the message is registered.
;				|2 			|iMsg 		|The Windows message ID.
;				|3 			|wParam 	|The first message parameter as hex value.
;				|4 			|lParam 	|The second message parameter as hex value.
;				-----------------------------------------------------------------------------------------------------------------
;				Up to 256 user functions can be registered for message IDs.
;
;				By default after finishing the user function the UDF pass the unhandled messages to default WindowProc,
;				same as if you use the variable $GUI_RUNDEFMSG (in GUIConstantsEx.au3) in return keyword.
;
;				Note: You can blocking of running user functions which executes window messages with commands such as "Msgbox()".
;
;				You can use in controls that consume internally specific Windows Message ID eg: WM_CHAR, WM_KEYDOWN, WM_KEYUP!
;				-----------------------------------------------------------------------------------------------------------------
; Related .......: _GUICtrlMsg_UnRegister
; Link ..........:
; Example .......: _GUICtrlMsg_Register($iInput1, $WM_CONTEXTMENU, "_WM_CONTEXTMENU")
; ===============================================================================================================================
Func _GUICtrlMsg_Register($iCtrlID, $iMsgID, $sFunction)
	Local $hCtrlID, $hWndForm, $hWnd, $hPrior
	Local $iIndex, $iIndex2, $asSubArray[2][2]

	If $iCtrlID = -1 Then $iCtrlID = _WinAPI_GetDlgCtrlID(GUICtrlGetHandle(-1))
	If $iMsgID < 0x0000 Or $iMsgID > 0x8000 Then SetError(1, 0, 0)
	If Not IsString($sFunction) Or Not $sFunction Then Return SetError(2, 0, 0)

	If Not IsHWnd($iCtrlID) Then
		$hCtrlID = GUICtrlGetHandle($iCtrlID)
	Else
		$hCtrlID = $iCtrlID
	EndIf

	$iIndex = __GRM_GetHWndIndex($hCtrlID)
	If $iIndex Then
		If __GRM_GetMsgIndex($iMsgID, $iIndex) Then Return SetError(4, 0, 0) ; Same msg for the same ctrl!

		$asSubArray = $avGRM_MSGIDS[$iIndex][3]
		;----> Fills sub array
		$iIndex2 = $asSubArray[0][0] + 1
		ReDim $asSubArray[$iIndex2 + 1][2]
		$asSubArray[0][0] = $iIndex2
		$asSubArray[$iIndex2][0] = $iMsgID
		$asSubArray[$iIndex2][1] = $sFunction
		;--
		$avGRM_MSGIDS[$iIndex][3] = $asSubArray
		;<----
		Return $hCtrlID
	EndIf

	; Get window handle...
	; by SmOke_N - autoitscript.com/forum/topic/144041-guiregistermsgex-udf-like-native-but-for-controls/#entry1016135
	;----------------------------------------------------------------------------------------------------------------------------
	$hWndForm = _WinAPI_GetParent($hCtrlID)
	If Not $hWndForm Then
		$hWndForm = _WinAPI_GetAncestor($hCtrlID)
		Return SetError(4, 0, 0)
	EndIf
	;----------------------------------------------------------------------------------------------------------------------------

	$hWnd = DllCallbackRegister("__GRM_CallBack", "ptr", "hwnd;uint;long;ptr")
	If Not $hWnd Then Return SetError(5, 0, 0)

	$hPrior = _WinAPI_SetWindowLong($hCtrlID, $GWL_WNDPROC, DllCallbackGetPtr($hWnd))
	If Not $hPrior Then
		DllCallbackFree($hWnd)
		Return SetError(6, 0, 0)
	EndIf

	;----> Fills array with the control data!
	; Sub-array
	$asSubArray[0][0] = 1
	$asSubArray[1][0] = $iMsgID
	$asSubArray[1][1] = $sFunction
	; Main array
	$iIndex = $avGRM_MSGIDS[0][0] + 1
	ReDim $avGRM_MSGIDS[$iIndex + 1][5]
	$avGRM_MSGIDS[0][0] = $iIndex
	$avGRM_MSGIDS[$iIndex][0] = $hCtrlID
	$avGRM_MSGIDS[$iIndex][1] = $hWnd ; Handle to use with DllCallbackFree.
	$avGRM_MSGIDS[$iIndex][2] = $hPrior
	$avGRM_MSGIDS[$iIndex][3] = $asSubArray
	;<----
	Return $hCtrlID
EndFunc   ;==>_GUICtrlMsg_Register

; #FUNCTION# ====================================================================================================================
; Name ..........: _GUICtrlMsg_UnRegister
; Description ...: Unregister an idividual message or all messages for the control!
; Syntax ........: _GUICtrlMsg_UnRegister( $hWnd [, $iMsgID = -1] )
; Parameters ....: $hWnd                - A handle value returned by _GUICtrlMsg_Register.
;                  $iMsgID              - [optional] Message to unregister. Default is -1 (all messages).
; Return values .: Success 	 			- Returns 1.
;				   Failure 	 			- Returns 0.
; Author ........: JScript
; Modified ......:
; Remarks .......:
; Related .......: _GUICtrlMsg_Register
; Link ..........:
; Example .......: _GUICtrlMsg_UnRegister($hWnd, $WM_CUT)
; ===============================================================================================================================
Func _GUICtrlMsg_UnRegister($hWnd, $iMsgID = -1)
	Local $iIndex, $iIndex2, $asSubArray

	$iIndex = __GRM_GetHWndIndex($hWnd)
	If Not $iIndex Then Return 0

	Switch $iMsgID
		Case -1
			_WinAPI_SetWindowLong($avGRM_MSGIDS[$iIndex][0], $GWL_WNDPROC, $avGRM_MSGIDS[$iIndex][2])
			DllCallbackFree($avGRM_MSGIDS[$iIndex][1])

			For $i = $iIndex To UBound($avGRM_MSGIDS) - 2
				For $j = 0 To 4
					$avGRM_MSGIDS[$i][$j] = $avGRM_MSGIDS[$i + 1][$j]
				Next
			Next
			ReDim $avGRM_MSGIDS[$avGRM_MSGIDS[0][0]][5]
			$avGRM_MSGIDS[0][0] -= 1
		Case Else
			$iIndex2 = __GRM_GetMsgIndex($iMsgID, $iIndex)
			If Not $iIndex2 Then Return 0

			$asSubArray = $avGRM_MSGIDS[$iIndex][3]

			For $i = $iIndex2 To UBound($asSubArray) - 2
				For $j = 0 To 1
					$asSubArray[$i][$j] = $asSubArray[$i + 1][$j]
				Next
			Next
			ReDim $asSubArray[$asSubArray[0][0]][2]
			$asSubArray[0][0] -= 1
			$avGRM_MSGIDS[$iIndex][3] = $asSubArray
	EndSwitch
	Return 1
EndFunc   ;==>_GUICtrlMsg_UnRegister

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name ..........: __GRM_GetHWndIndex
; Description ...:
; Syntax ........: __GRM_GetHWndIndex($hCtrlID)
; Parameters ....: $hCtrlID             - A handle value.
; Return values .: None
; Author ........: JScript
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func __GRM_GetHWndIndex($hCtrlID)
	If $avGRM_MSGIDS[0][0] Then
		For $iIndex = 1 To $avGRM_MSGIDS[0][0]
			Switch $hCtrlID
				Case $avGRM_MSGIDS[$iIndex][0]
					Return $iIndex
			EndSwitch
		Next
	EndIf
	Return 0
EndFunc   ;==>__GRM_GetHWndIndex

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name ..........: __GRM_GetMsgIndex
; Description ...:
; Syntax ........: __GRM_GetMsgIndex($iMsgID, $iMainIdx)
; Parameters ....: $iMsgID              - An integer value.
;                  $iMainIdx            - An integer value.
; Return values .: None
; Author ........: JScript
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func __GRM_GetMsgIndex($iMsgID, $iMainIdx)
	Local $asSubArray = $avGRM_MSGIDS[$iMainIdx][3]

	For $iIndex = 1 To $asSubArray[0][0]
		Switch $iMsgID
			Case $asSubArray[$iIndex][0]
				Return $iIndex
		EndSwitch
	Next
	Return 0
EndFunc   ;==>__GRM_GetMsgIndex

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name ..........: __GRM_CallBack
; Description ...:
; Syntax ........: __GRM_CallBack($hWnd, $iMsg, $wParam, $lParam)
; Parameters ....: $hWnd                - A handle value.
;                  $iMsg                - An integer value.
;                  $wParam              - An unknown value.
;                  $lParam              - An unknown value.
; Return values .: None
; Author ........: JScript
; Modified ......: SmOke_N - autoitscript.com/forum/topic/144041-guiregistermsgex-udf-like-native-but-for-controls/#entry1016135
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func __GRM_CallBack($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $wParam, $lParam

	Local $iIndex = __GRM_GetHWndIndex($hWnd)
	Local $iIndex2 = __GRM_GetMsgIndex($iMsg, $iIndex)
	If Not $iIndex Or Not $iIndex2 Then
		Return _WinAPI_CallWindowProc($avGRM_MSGIDS[$iIndex][2], $hWnd, $iMsg, $wParam, $lParam)
	EndIf

	Local $asSubArray = $avGRM_MSGIDS[$iIndex][3]
	Local $vRet = Call($asSubArray[$iIndex2][1], $hWnd, $iMsg, $wParam, $lParam)
	If @error = 0xDEAD Or (IsString($vRet) And $vRet = 'GUI_RUNDEFMSG') Then
		; Pass the unhandled messages to default WindowProc
		Return _WinAPI_CallWindowProc($avGRM_MSGIDS[$iIndex][2], $hWnd, $iMsg, $wParam, $lParam)
	EndIf

	Return $vRet
EndFunc   ;==>__GRM_CallBack

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name ..........: __GRM_ShutDown
; Description ...: Function to be called when AutoIt exits.
; Syntax ........: __GRM_ShutDown()
; Parameters ....:
; Return values .: None
; Author ........: JScript
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func __GRM_ShutDown()
	;----> Frees handles created with DllCallbackRegister.
	If $avGRM_MSGIDS[0][0] Then
		For $iIndex = 1 To $avGRM_MSGIDS[0][0]
			_WinAPI_SetWindowLong($avGRM_MSGIDS[$iIndex][0], $GWL_WNDPROC, $avGRM_MSGIDS[$iIndex][2])
			DllCallbackFree($avGRM_MSGIDS[$iIndex][1])
		Next
	EndIf
	;<----
EndFunc   ;==>__GRM_ShutDown