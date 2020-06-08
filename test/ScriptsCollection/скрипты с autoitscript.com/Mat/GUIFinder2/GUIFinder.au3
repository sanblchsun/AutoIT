#include-once

#include "UDFGlobalID.au3"
#include "WinAPI.au3"
#include "Constants.au3"
#include "WindowsConstants.au3"

; #INDEX# =======================================================================================================================
; Title .........: WinFinder Control
; AutoIt Version : 3.3+
; Description ...: An easy to use implementation of a finder control
; Author(s) .....: Matt Diesel (Mat)
; Dll ...........: user32.dll, gdi32.dll
; ===============================================================================================================================

; #CONSTANTS# ===================================================================================================================
Global Const $__FINDERCONSTANT_ClassName = "WinFinder"
Global Const $__FINDERCONSTANT_SIZEOFPTR = DllStructGetSize(DllStructCreate("ptr"))

; Positions are pointers so change in length
Global Const $__FINDERCONSTANT_GWL_ICONFULL = 0
Global Const $__FINDERCONSTANT_GWL_ICONEMPTY = $__FINDERCONSTANT_SIZEOFPTR
Global Const $__FINDERCONSTANT_GWL_CURSOR = 2 * $__FINDERCONSTANT_SIZEOFPTR
Global Const $__FINDERCONSTANT_GWL_CURRENT = 3 * $__FINDERCONSTANT_SIZEOFPTR

; Notifications for WM_COMMAND
Global Const $FN_WNDCHANGED = 2
Global Const $FN_STARTUSE = 3
Global Const $FN_ENDUSE = 4
Global Const $FN_RESCHANGED = 5
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
;_GUICtrlFinder_Create
;_GUICtrlFinder_GetEmptyIcon
;_GUICtrlFinder_GetFullIcon
;_GUICtrlFinder_GetTargetCursor
;_GUICtrlFinder_GetLastWnd
;_GUICtrlFinder_IsFinding
;_GUICtrlFinder_SetEmptyIcon
;_GUICtrlFinder_SetFullIcon
;_GUICtrlFinder_SetTargetCursor
;_GUICtrlFinder_SetLastWnd
; ===============================================================================================================================

; #INTERNAL_USE_ONLY# ===========================================================================================================
;$__FINDERCONSTANT_tagWNDCLASSEX
;__GUICtrlFinder_GetWndProc
;__GUICtrlFinder_GetDefaultResources
;__GUICtrlFinder_WndProc
;__GUICtrlFinder_OnExit
; ===============================================================================================================================

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: $__FINDERCONSTANT_tagWNDCLASSEX
; Description ...: Contains window class information.
; Fields ........: Size                 - The size, in bytes, of this structure. Set this member to DllStructGetSize($tMyWC). Be
;                                         sure to set this member before using it.
;                  style                - The class style(s). This member can be any combination of the Class Styles ($CS_*).
;                  WndProc              - A pointer to the window procedure. You should use DllCallBackRegister to get this value
;                  ClsExtra             - The number of extra bytes to allocate following the window-class structure. The system
;                                         initializes the bytes to zero.
;                  WndExtra             - The number of extra bytes to allocate following the window instance. The system
;                                         initializes the bytes to zero. If an application uses WNDCLASSEX to register a dialog
;                                         box created by using the CLASS directive in the resource file, it must set this member
;                                         to DLGWINDOWEXTRA.
;                  Instance             - A handle to the instance that contains the window procedure for the class.
;                  Icon                 - A handle to the class icon. This member must be a handle to an icon resource. If this
;                                         member is 0, the system provides a default icon.
;                  Cursor               - A handle to the class cursor. This member must be a handle to a cursor resource. If
;                                         this member is 0, an application must explicitly set the cursor shape whenever the
;                                         mouse moves into the application's window.
;                  Background           - A handle to the class background brush. This member can be a handle to the physical
;                                         brush to be used for painting the background, or it can be a color value. A color value
;                                         must be one of the standard system colors COLOR_* (the value 1 must be added to the
;                                         chosen color). If a color value is given, you must convert it to one of the HBRUSH types
;                                         The system automatically deletes class background brushes when the class is
;                                         unregistered by using UnregisterClass. An application should not delete these brushes.
;                                         When this member is NULL, an application must paint its own background whenever it is
;                                         requested to paint in its client area. To determine whether the background must be
;                                         painted, an application can either process the WM_ERASEBKGND message or test the
;                                         fErase member of the PAINTSTRUCT structure filled by the _WinAPI_BeginPaint function.
;                  MenuName             - Pointer to a null-terminated character string that specifies the resource name of the
;                                         class menu, as the name appears in the resource file. If you use an integer to identify
;                                         the menu, use the MAKEINTRESOURCE macro. If this member is NULL, windows belonging to
;                                         this class have no default menu.
;                  ClassName            - A pointer to a null-terminated string or is an atom. If this parameter is an atom, it
;                                         must be a class atom created by a previous call to the RegisterClass or RegisterClassEx
;                                         function. The atom must be in the low-order word of ClassName; the high-order word must
;                                         be zero. If ClassName is a string, it specifies the window class name. The class name
;                                         can be any name registered with RegisterClass or RegisterClassEx, or any of the
;                                         predefined control-class names. The maximum length for ClassName is 256. If ClassName
;                                         is greater than the maximum length, the RegisterClassEx function will fail.
;                  IconSm               - A handle to a small icon that is associated with the window class. If this member is
;                                         NULL, the system searches the icon resource specified by the Icon member for an icon
;                                         of the appropriate size to use as the small icon.
; Author ........: Matt Diesel (Mat)
; Remarks .......:
; Related .......:
; ===============================================================================================================================
Global Const $__FINDERCONSTANT_tagWNDCLASSEX = "uint Size; " & _
		"uint style; " & _
		"ptr WndProc; " & _
		"int ClsExtra; " & _
		"int WndExtra; " & _
		"HANDLE Instance; " & _
		"HANDLE Icon; " & _
		"HANDLE Cursor; " & _
		"HANDLE Background; " & _
		"ptr MenuName; " & _
		"ptr ClassName; " & _
		"HANDLE IconSm"

; #FUNCTION# ====================================================================================================================
; Name ..........: _GUICtrlFinder_Create
; Description ...: Creates a finder control, initialising the class if necessary.
; Syntax ........: _GUICtrlFinder_Create($hWnd , $iX , $iW[, $iWidth[, $iHeight ]])
; Parameters ....: $hWnd                - The handle to the parent window.
;                  $iX                  - Horizontal position of the control
;                  $iY                  - Vertical position of the control
;                  $iWidth              - [optional] The width of the control. Default is 32.
;                  $iHeight             - [optional] The height of the control. Default is 32.
; Return values .: Success              - Handle to the created finder control
;                  Failure              - 0 and sets the @error flag:
;                                       |1 - Parent window is not valid
;                                       |2 - Unable to register OnExit function
;                                       |3 - Unable to register window procedure.
;                                       |4 - Registering the class failed. @extended contains the DllCall @error code.
;                                       |5 - Error generating the control id. @extended is set to the @error code from
;                                            __UDF_GetNextGlobalID
;                                       |6 - Creating the window failed. @extended contains the @error code from
;                                            _WinAPI_CreateWindowEx
; Author(s) .....: Matt Diesel (Mat)
; Modified ......:
; Remarks .......: This function may fail if the script is obfuscated, as it relies on function names held as strings to be
;                  valid. If you need to obfuscate the script then add the following functions to your #Obfuscator_Ignore_Funcs
;                  line:
;                  |__GUICtrlFinder_OnExit
;                  |__GUICtrlFinder_WndProc
; Related .......: _WinAPI_CreateWindowEx
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _GUICtrlFinder_Create($hWnd, $iX, $iW, $iWidth = 32, $iHeight = 32)
	Local $hRet, $nCtrlID
	Local Static $iAtom = 0

	If Not IsHWnd($hWnd) Or Not WinExists($hWnd) Then Return SetError(1, 0, 0) ; Parent window is not valid

	If Not $iAtom Then
		; Register the class
		Local $hCallback, $tClassName, $tWC, $aRes

		If Not OnAutoItExitRegister("__GUICtrlFinder_OnExit") Then Return SetError(2, 0, 0) ; Unable to register OnExit function

		$hCallback = __GUICtrlFinder_GetWndProc()
		If @error Then Return SetError(3, 0, 0) ; Unable to register window procedure. Possibly obfuscated?

		$tClassName = DllStructCreate("wchar[" & (StringLen($__FINDERCONSTANT_ClassName) + 1) & "]")
		DllStructSetData($tClassName, 1, $__FINDERCONSTANT_ClassName)

		$tWC = DllStructCreate($__FINDERCONSTANT_tagWNDCLASSEX)

		DllStructSetData($tWC, "Size", DllStructGetSize($tWC))
		DllStructSetData($tWC, "style", 3) ; BitOR($CS_HREDRAW, $CS_VREDRAW))
		DllStructSetData($tWC, "WndProc", DllCallbackGetPtr($hCallback))
		DllStructSetData($tWC, "ClsExtra", 0)
		DllStructSetData($tWC, "WndExtra", 16 * (@AutoItX64 + 1)) ; ptr IconFull, ptr IconEmpty, ptr Cursor, ptr CurrentWnd
		DllStructSetData($tWC, "Instance", _WinAPI_GetModuleHandle(0))
		DllStructSetData($tWC, "Icon", 0)
		DllStructSetData($tWC, "Cursor", _WinAPI_LoadImage(0, 32512, $IMAGE_CURSOR, 0, 0, BitOR($LR_DEFAULTCOLOR, $LR_SHARED)))
		DllStructSetData($tWC, "Background", $COLOR_BTNFACE + 1)
		DllStructSetData($tWC, "MenuName", 0)
		DllStructSetData($tWC, "ClassName", DllStructGetPtr($tClassName))
		DllStructSetData($tWC, "IconSm", 0)

		$aRes = DllCall("user32.dll", "word", "RegisterClassExW", "ptr", DllStructGetPtr($tWC))
		If @error Or Not $aRes[0] Then Return SetError(4, @error, 0) ; Registering the class failed. @extended contains the DllCall @error code.

		$iAtom = $aRes[0]
	EndIf

	$nCtrlID = __UDF_GetNextGlobalID($hWnd)
	If @error Then Return SetError(5, @error, 0)

	$hRet = _WinAPI_CreateWindowEx(0, _
			$__FINDERCONSTANT_ClassName, _
			"", _
			BitOR($__UDFGUICONSTANT_WS_CHILD, $__UDFGUICONSTANT_WS_VISIBLE), _
			$iX, _
			$iW, _
			$iWidth, _
			$iHeight, _
			$hWnd, _
			$nCtrlID)
	If Not $hRet Then Return SetError(6, @error, 0)

	Return $hRet
EndFunc   ;==>_GUICtrlFinder_Create

; #FUNCTION# ====================================================================================================================
; Name ..........: _GUICtrlFinder_GetEmptyIcon
; Description ...: Gets the handle to the icon used to draw the control when in use.
; Syntax ........: _GUICtrlFinder_GetEmptyIcon($hWnd)
; Parameters ....: $hWnd                - A handle to a finder control.
; Return values .: Success              - An HICON specifying the icon used to draw the control when in use.
;                  Failure              - -1 and sets the @error flag:
;                                       |1 - The $hWnd parameter is not a valid finder control.
; Author(s) .....: Matt Diesel (Mat)
; Modified ......:
; Remarks .......: A return value of zero IS valid. It means that the control does not have it's own defined icon, and instead
;                  will use the default one provided by the UDF.
; Related .......: _GUICtrlFinder_SetEmptyIcon
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _GUICtrlFinder_GetEmptyIcon($hWnd)
	If Not _WinAPI_IsClassName($hWnd, $__FINDERCONSTANT_ClassName) Then Return SetError(1, 0, -1) ; Invalid hWnd parameter

	Return _WinAPI_GetWindowLong($hWnd, $__FINDERCONSTANT_GWL_ICONEMPTY)
EndFunc   ;==>_GUICtrlFinder_GetEmptyIcon

; #FUNCTION# ====================================================================================================================
; Name ..........: _GUICtrlFinder_GetFullIcon
; Description ...: Gets the handle to the icon used to draw the control when not in use.
; Syntax ........: _GUICtrlFinder_GetFullIcon($hWnd)
; Parameters ....: $hWnd                - A handle to a finder control.
; Return values .: Success              - An HICON specifying the icon used to draw the control when not in use.
;                  Failure              - -1 and sets the @error flag:
;                                       |1 - The $hWnd parameter is not a valid finder control.
; Author(s) .....: Matt Diesel (Mat)
; Modified ......:
; Remarks .......: A return value of zero IS valid. It means that the control does not have it's own defined icon, and instead
;                  will use the default one provided by the UDF.
; Related .......: _GUICtrlFinder_SetFullIcon
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _GUICtrlFinder_GetFullIcon($hWnd)
	If Not _WinAPI_IsClassName($hWnd, $__FINDERCONSTANT_ClassName) Then Return SetError(1, 0, -1) ; Invalid hWnd parameter

	Return _WinAPI_GetWindowLong($hWnd, $__FINDERCONSTANT_GWL_ICONFULL)
EndFunc   ;==>_GUICtrlFinder_GetFullIcon

; #FUNCTION# ====================================================================================================================
; Name ..........: _GUICtrlFinder_GetTargetCursor
; Description ...: Gets the handle to the cursor used when the user is selecting a window.
; Syntax ........: _GUICtrlFinder_GetTargetCursor($hWnd)
; Parameters ....: $hWnd                - A handle to a finder control.
; Return values .: Success              - An HCURSOR specifying the cursor used when the user is selecting a window.
;                  Failure              - -1 and sets the @error flag:
;                                       |1 - The $hWnd parameter is not a valid finder control.
; Author(s) .....: Matt Diesel (Mat)
; Modified ......:
; Remarks .......: A return value of zero IS valid. It means that the control does not have it's own defined cursor, and instead
;                  will use the default one provided by the UDF.
; Related .......: _GUICtrlFinder_SetTargetCursor
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _GUICtrlFinder_GetTargetCursor($hWnd)
	If Not _WinAPI_IsClassName($hWnd, $__FINDERCONSTANT_ClassName) Then Return SetError(1, 0, -1) ; Invalid hWnd parameter

	Return _WinAPI_GetWindowLong($hWnd, $__FINDERCONSTANT_GWL_CURSOR)
EndFunc   ;==>_GUICtrlFinder_GetTargetCursor

; #FUNCTION# ====================================================================================================================
; Name ..........: _GUICtrlFinder_GetLastWnd
; Description ...: Returns the handle of the last user-selected window.
; Syntax ........: _GUICtrlFinder_GetLastWnd($hWnd)
; Parameters ....: $hWnd                - A handle to a finder control.
; Return values .: Success              - The handle of the last user-selected window.
;                  Failure              - -1 and sets the @error flag:
;                                       |1 - The $hWnd parameter is not a valid finder control.
; Author(s) .....: Matt Diesel (Mat)
; Modified ......:
; Remarks .......: Zero is a valid return value, that indicates the user has not made a selection, or it has been zeroed by the
;                  _GUICtrlFinder_SetLastWnd function. The validity of the return value is not guarenteed, the window may have
;                  been closed, or the property may have been set manually incorrectly.
; Related .......: _GUICtrlFinder_SetLastWnd
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _GUICtrlFinder_GetLastWnd($hWnd)
	If Not _WinAPI_IsClassName($hWnd, $__FINDERCONSTANT_ClassName) Then Return SetError(1, 0, -1) ; Invalid hWnd parameter

	Return HWnd(_WinAPI_GetWindowLong($hWnd, $__FINDERCONSTANT_GWL_CURRENT))
EndFunc   ;==>_GUICtrlFinder_GetLastWnd

; #FUNCTION# ====================================================================================================================
; Name ..........: _GUICtrlFinder_IsFinding
; Description ...: Checks if a given finder control is currently being used.
; Syntax ........: _GUICtrlFinder_IsFinding($hWnd)
; Parameters ....: $hWnd                - A handle to a finder control.
; Return values .: Success              - True if the given window is in use by the user, false otherwise
;                  Failure              - False and sets the @error flag:
;                                       |1 - The $hWnd parameter is not a valid finder control.
; Author(s) .....: Matt Diesel (Mat)
; Modified ......:
; Remarks .......: Since False is a valid return value, you should check @error instead of the functions return value.
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _GUICtrlFinder_IsFinding($hWnd)
	If Not _WinAPI_IsClassName($hWnd, $__FINDERCONSTANT_ClassName) Then Return SetError(1, 0, False) ; Invalid hWnd parameter

	Local $hCap = DllCall("User32.dll", "handle", "GetCapture")
	If @error Then Return False
	Return $hCap[0] = $hWnd
EndFunc   ;==>_GUICtrlFinder_IsFinding

; #FUNCTION# ====================================================================================================================
; Name ..........: _GUICtrlFinder_SetEmptyIcon
; Description ...: Sets the handle to the icon used to draw the control when in use.
; Syntax ........: _GUICtrlFinder_SetEmptyIcon($hWnd, $hIcon)
; Parameters ....: $hWnd                - A handle to a finder control.
;                  $hIcon               - A handle to an icon (HICON)
; Return values .: Success              - The last used value.
;                  Failure              - -1 and sets the @error flag:
;                                       |1 - The $hWnd parameter is not a valid finder control.
; Author(s) .....: Matt Diesel (Mat)
; Modified ......:
; Remarks .......: hIcon may be the Default keyword, in which case it will set the icon to the general default.
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _GUICtrlFinder_SetEmptyIcon($hWnd, $hIcon)
	Local $hRet

	If Not _WinAPI_IsClassName($hWnd, $__FINDERCONSTANT_ClassName) Then Return SetError(1, 0, -1) ; Invalid hWnd parameter

	If $hIcon = Default Then $hIcon = __GUICtrlFinder_GetDefaultResources(1)

	$hRet = _WinAPI_SetWindowLong($hWnd, $__FINDERCONSTANT_GWL_ICONEMPTY, $hIcon)
	_WinAPI_PostMessage(_WinAPI_GetParent($hWnd), $WM_COMMAND, _WinAPI_MakeLong(_WinAPI_GetDlgCtrlID($hWnd), $FN_RESCHANGED), $hWnd)
	Return $hRet
EndFunc   ;==>_GUICtrlFinder_SetEmptyIcon

; #FUNCTION# ====================================================================================================================
; Name ..........: _GUICtrlFinder_SetFullIcon
; Description ...: Sets the handle to the icon used to draw the control when not in use.
; Syntax ........: _GUICtrlFinder_SetFullIcon($hWnd, $hIcon)
; Parameters ....: $hWnd                - A handle to a finder control.
;                  $hIcon               - A handle to an icon (HICON)
; Return values .: Success              - The last used value.
;                  Failure              - -1 and sets the @error flag:
;                                       |1 - The $hWnd parameter is not a valid finder control.
; Author(s) .....: Matt Diesel (Mat)
; Modified ......:
; Remarks .......: hIcon may be the Default keyword, in which case it will set the icon to the general default.
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _GUICtrlFinder_SetFullIcon($hWnd, $hIcon)
	Local $hRet

	If Not _WinAPI_IsClassName($hWnd, $__FINDERCONSTANT_ClassName) Then Return SetError(1, 0, -1) ; Invalid hWnd parameter

	If $hIcon = Default Then $hIcon = __GUICtrlFinder_GetDefaultResources(0)

	$hRet = _WinAPI_SetWindowLong($hWnd, $__FINDERCONSTANT_GWL_ICONFULL, $hIcon)
	_WinAPI_PostMessage(_WinAPI_GetParent($hWnd), $WM_COMMAND, _WinAPI_MakeLong(_WinAPI_GetDlgCtrlID($hWnd), $FN_RESCHANGED), $hWnd)
	Return $hRet
EndFunc   ;==>_GUICtrlFinder_SetFullIcon

; #FUNCTION# ====================================================================================================================
; Name ..........: _GUICtrlFinder_SetTargetCursor
; Description ...: Sets the handle to the cursor used when the user is selecting a window.
; Syntax ........: _GUICtrlFinder_SetTargetCursor($hWnd, $hCur)
; Parameters ....: $hWnd                - A handle to a finder control.
;                  $hCur                - A handle to a cursor (HCURSOR)
; Return values .: Success              - The last used value.
;                  Failure              - -1 and sets the @error flag:
;                                       |1 - The $hWnd parameter is not a valid finder control.
; Author(s) .....: Matt Diesel (Mat)
; Modified ......:
; Remarks .......: hCur may be the Default keyword, in which case it will set the cursor to the general default.
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _GUICtrlFinder_SetTargetCursor($hWnd, $hCur)
	Local $hRet

	If Not _WinAPI_IsClassName($hWnd, $__FINDERCONSTANT_ClassName) Then Return SetError(1, 0, -1) ; Invalid hWnd parameter

	If $hCur = Default Then $hCur = __GUICtrlFinder_GetDefaultResources(2)

	$hRet = _WinAPI_SetWindowLong($hWnd, $__FINDERCONSTANT_GWL_CURSOR, $hCur)
	_WinAPI_PostMessage(_WinAPI_GetParent($hWnd), $WM_COMMAND, _WinAPI_MakeLong(_WinAPI_GetDlgCtrlID($hWnd), $FN_RESCHANGED), $hWnd)
	Return $hRet
EndFunc   ;==>_GUICtrlFinder_SetTargetCursor

; #FUNCTION# ====================================================================================================================
; Name ..........: _GUICtrlFinder_SetLastWnd
; Description ...: Sets the handle of the last user-selected window.
; Syntax ........: _GUICtrlFinder_SetLastWnd($hWnd, $hLastWnd)
; Parameters ....: $hWnd                - A handle to a finder control.
;                  $hLastWnd            - A handle to another window. This is not checked for validity.
; Return values .: Success              - The last used value.
;                  Failure              - -1 and sets the @error flag:
;                                       |1 - The $hWnd parameter is not a valid finder control.
; Author(s) .....: Matt Diesel (Mat)
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _GUICtrlFinder_SetLastWnd($hWnd, $hLastWnd)
	Local $hRet

	If Not _WinAPI_IsClassName($hWnd, $__FINDERCONSTANT_ClassName) Then Return SetError(1, 0, -1) ; Invalid hWnd parameter

	$hRet = _WinAPI_SetWindowLong($hWnd, $__FINDERCONSTANT_GWL_CURRENT, $hLastWnd)
	_WinAPI_PostMessage(_WinAPI_GetParent($hWnd), $WM_COMMAND, _WinAPI_MakeLong(_WinAPI_GetDlgCtrlID($hWnd), $FN_WNDCHANGED), $hWnd)
	Return $hRet
EndFunc   ;==>_GUICtrlFinder_SetLastWnd

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name ..........: __GUICtrlFinder_GetWndProc
; Description ...: Returns a handle to the window callback
; Syntax ........: __GUICtrlFinder_GetWndProc( [ $fClean ] )
; Parameters ....: $fClean              - [optional] If true then it frees the callback. Default is False.
; Return values .: Success              - The handle to the callback
;                  Failure              - 0 and sets the @error flag:
;                                       |1 - Function not found. Possibly obfuscated?
; Author(s) .....: Matt Diesel (Mat)
; Modified ......:
; Remarks .......: This function removes the need for a global variable, and handles the creation of the callback when it is
;                  first called.
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func __GUICtrlFinder_GetWndProc($fClean = False)
	Local Static $hCallback = 0

	If $fClean Then
		DllCallbackFree($hCallback)
		$hCallback = 0
	ElseIf $hCallback = 0 Then
		$hCallback = DllCallbackRegister("__GUICtrlFinder_WndProc", "lresult", "hwnd;uint;wparam;lparam")
		If $hCallback = 0 Then Return SetError(1, 0, 0) ; Function not found. Possibly obfuscated?
	EndIf

	Return $hCallback
EndFunc   ;==>__GUICtrlFinder_GetWndProc

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name ..........: __GUICtrlFinder_GetDefaultResources
; Description ...: Retrieves one or all of the default resources.
; Syntax ........: __GUICtrlFinder_GetDefaultResources( [ $iRes [, $fClean ]] )
; Parameters ....: $iRes                - [optional] The resource to get. This should be one of the following values:
;                                       |-1 - Returns all the default resources in an array.
;                                       |0 - The icon used when the control is not in use
;                                       |1 - The icon used when the control is in use
;                                       |2 - The target cursor
;                  $fClean              - [optional] If true then the default resources are destroyed. Default is false. All
;                                         resources are cleaned regardless of the iRes parameter.
; Return values .: Either the resource or an array dependant on the iRes parameter. If fClean = true then the return will always
;                  be zero.
; Author(s) .....: Matt Diesel (Mat)
; Modified ......:
; Remarks .......: This function removes the need for a global variable, and handles the creation of the resources when it is
;                  first called.
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func __GUICtrlFinder_GetDefaultResources($iRes = -1, $fClean = False)
	Local Static $ahRes[3] = [0, 0, 0] ; Full, Empty, Cursor

	If $fClean Then
		_WinAPI_DestroyIcon($ahRes[0])
		_WinAPI_DestroyIcon($ahRes[1])
		DllCall("user32.dll", "int", "DestroyCursor", "ptr", $ahRes[2])

		$ahRes[0] = 0
		Return 0
	ElseIf $ahRes[0] = 0 Then
		Local $bRes, $tRes, $iOffset, $tImg, $aRet

		$bRes = "0x0000010001002020100001000400E8020000160000002800000020000000400000000100040000000000000200000000000000" & _
				"000000100000001000000000000000000080000080000000808000800000008000800080800000C0C0C000808080000000FF0000FF0" & _
				"00000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000000000000000000000000000000000000000000000000000000000000000" & _
				"00FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFF00000FFFFFFFFFFFF000FFFFFFFFF" & _
				"F00FF0FF00FFFFFFFFFF000FFFFFFFFF0FF00000FF0FFFFFFFFF000FFFFFFFF0FFFFF0FFFFF0FFFFFFFF000FFFFFFF0FFFF00000FFF" & _
				"F0FFFFFFF000FFFFFFF0FFFFFF0FFFFFF0FFFFFFF000FFFFFF0F0F0FF000FF0F0F0FFFFFF000FFFFFF0F0F0F0FFF0F0F0F0FFFFFF00" & _
				"0FFFFFF0000000F0F0000000FFFFFF000FFFFFF0F0F0F0FFF0F0F0F0FFFFFF000FFFFFF0F0F0FF000FF0F0F0FFFFFF000FFFFFFF0FF" & _
				"FFFF0FFFFFF0FFFFFFF000FFFFFFF0FFFF00000FFFF0FFFFFFF000FFFFFFFF0FFFFF0FFFFF0FFFFFFFF000FFFFFFFFF0FF00000FF0F" & _
				"FFFFFFFF000FFFFFFFFFF00FF0FF00FFFFFFFFFF000FFFFFFFFFFFF00000FFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000" & _
				"FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000007770CCCCCCC" & _
				"CCCCCCCCCCCCCC07770007070CCCCCCCCCCCCCCCCCCCCC07070007770CCCCCCCCCCCCCCCCCCCCC07770000000000000000000000000" & _
				"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFF" & _
				"FFFFF800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000" & _
				"00800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008" & _
				"000000080000000FFFFFFFFFFFFFFFFFFFFFFFF"

		$tRes = DllStructCreate("byte[" & BinaryLen($bRes) & "]")
		DllStructSetData($tRes, 1, Binary($bRes))

		$iOffset = DllCall("user32.dll", "int", "LookupIconIdFromDirectory", "ptr", DllStructGetPtr($tRes), "int", 1)
		$iOffset = $iOffset[0]

		$tImg = DllStructCreate($tagBITMAPINFO, DllStructGetPtr($tRes) + $iOffset)
		$aRet = DllCall("user32.dll", "handle", "CreateIconFromResource", _
				"ptr", DllStructGetPtr($tImg), _
				"int", DllStructGetData($tImg, "Size"), _
				"int", 1, _
				"int", 0x00030000)
		$ahRes[0] = $aRet[0]

		$bRes = "0x0000010001002020100001000400E80200001600000028000000200000004000000001000400000000000002000000000000000000001000" & _
				"00001000000000000000000080000080000000808000800000008000800080800000C0C0C000808080000000FF0000FF000000FFFF00FF00" & _
				"0000FF00FF00FFFF0000FFFFFF00000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFF" & _
				"FFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FF" & _
				"FFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFF" & _
				"FFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FF" & _
				"FFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFF" & _
				"FFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FF" & _
				"FFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFF" & _
				"FFFFFFFFFFF000000000000000000000000000000000007770CCCCCCCCCCCCCCCCCCCCC07770007070CCCCCCCCCCCCCCCCCCCCC070700077" & _
				"70CCCCCCCCCCCCCCCCCCCCC07770000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
				"00000000000000000000000000000000000000000000FFFFFFFF800000008000000080000000800000008000000080000000800000008000" & _
				"0000800000008000000080000000800000008000000080000000800000008000000080000000800000008000000080000000800000008000" & _
				"0000800000008000000080000000800000008000000080000000FFFFFFFFFFFFFFFFFFFFFFFF"

		$tRes = DllStructCreate("byte[" & BinaryLen($bRes) & "]")
		DllStructSetData($tRes, 1, Binary($bRes))

		$iOffset = DllCall("user32.dll", "int", "LookupIconIdFromDirectory", "ptr", DllStructGetPtr($tRes), "int", 1)
		$iOffset = $iOffset[0]

		$tImg = DllStructCreate($tagBITMAPINFO, DllStructGetPtr($tRes) + $iOffset)
		$aRet = DllCall("user32.dll", "handle", "CreateIconFromResource", _
				"ptr", DllStructGetPtr($tImg), _
				"int", DllStructGetData($tImg, "Size"), _
				"int", 1, _
				"int", 0x00030000)
		$ahRes[1] = $aRet[0]


		$bRes = "0x000002000100202000000F0010003001000016000000280000002000000040000000010001000000000080000000000000000000000002" & _
				"0000000200000000000000FFFFFF000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
				"0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" & _
				"00000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF" & _
				"FFFFFFFFF83FFFFFE6CFFFFFD837FFFFBEFBFFFF783DFFFF7EFDFFFEAC6AFFFEABAAFFFE0280FFFEABAAFFFEAC6AFFFF7EFDFFFF783DFFFF" & _
				"BEFBFFFFD837FFFFE6CFFFFFF83FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"

		$tRes = DllStructCreate("byte[" & BinaryLen($bRes) & "]")
		DllStructSetData($tRes, 1, Binary($bRes))

		$iOffset = DllCall("user32.dll", "int", "LookupIconIdFromDirectory", "ptr", DllStructGetPtr($tRes), "int", 1)
		$iOffset = $iOffset[0]

		$tImg = DllStructCreate($tagBITMAPINFO, DllStructGetPtr($tRes) + $iOffset)
		$aRet = DllCall("user32.dll", "handle", "CreateIconFromResource", _
				"ptr", DllStructGetPtr($tImg), _
				"int", DllStructGetData($tImg, "Size"), _
				"int", 1, _
				"int", 0x00030000)
		$ahRes[2] = $aRet[0]
	EndIf

	If $iRes < 0 Then Return $ahRes
	Return $ahRes[$iRes]
EndFunc   ;==>__GUICtrlFinder_GetDefaultResources

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name ..........: __GUICtrlFinder_WndProc
; Description ...: The callback procedure for finder controls
; Syntax ........: __GUICtrlFinder_WndProc($hWnd, $iMsg, $wParam, $lParam)
; Parameters ....: $hWnd                - The handle to the finder control recieving the message
;                  $iMsg                - The message.
;                  $wParam              - Additional message information. The contents of this parameter depend on the value of
;                                         the iMsg parameter.
;                  $lParam              - Additional message information. The contents of this parameter depend on the value of
;                                         the iMsg parameter.
; Return values .: Depends on the iMsg parameter
; Author(s) .....: Matt Diesel (Mat)
; Modified ......:
; Remarks .......:
; Related .......: __GUICtrlFinder_GetWndProc
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func __GUICtrlFinder_WndProc($hWnd, $iMsg, $wParam, $lParam)
	Local Static $hBackupCursor
	Local Static $aRect
	Local Static $fIn = False
	Local $hLast, $hDC, $hPen, $hOldPen, $h

	Switch $iMsg
		Case $WM_LBUTTONDOWN
			Local $hCur = _WinAPI_GetWindowLong($hWnd, $__FINDERCONSTANT_GWL_CURSOR)
			If $hCur = 0 Then $hCur = __GUICtrlFinder_GetDefaultResources(2)

			_WinAPI_SetCapture($hWnd)
			$hBackupCursor = _WinAPI_SetCursor($hCur)

			_WinAPI_RedrawWindow($hWnd)

			_WinAPI_PostMessage(_WinAPI_GetParent($hWnd), $WM_COMMAND, _WinAPI_MakeLong(_WinAPI_GetDlgCtrlID($hWnd), $FN_STARTUSE), $hWnd)
		Case $WM_MOUSEMOVE
			If _GUICtrlFinder_IsFinding($hWnd) Then
				If $fIn Then Return 0
				$fIn = True

				Local $tPoint = _WinAPI_GetMousePos()
				$h = _WinAPI_WindowFromPoint($tPoint)
				If $h = 0 Then ContinueCase

				$hLast = _GUICtrlFinder_GetLastWnd($hWnd)
				If $h <> $hLast Then
					_GUICtrlFinder_SetLastWnd($hWnd, $h)

					If $hLast <> 0 And IsArray($aRect) Then
						$hDC = _WinAPI_GetDC($hLast)
						If Not $hDC Then ContinueCase

						DllCall("Gdi32.dll", "int", "SetROP2", "HANDLE", $hDC, "int", 10) ; $R2_NOTXORPEN

						$hPen = _WinAPI_CreatePen($PS_SOLID, 4, 0)
						$hOldPen = _WinAPI_SelectObject($hDC, $hPen)

						DllCall("Gdi32.dll", "int", "Rectangle", "HANDLE", $hDC, "int", 2, "int", 2, "int", $aRect[0] - 1, "int", $aRect[1] - 1)

						_WinAPI_SelectObject($hDC, $hOldPen)
						_WinAPI_DeleteObject($hPen)
						_WinAPI_ReleaseDC($hLast, $hDC)
					EndIf

					$aRect = WinGetClientSize($h)
					If @error Then ContinueCase

					$hDC = _WinAPI_GetDC($h)
					If Not $hDC Then ContinueCase

					DllCall("Gdi32.dll", "int", "SetROP2", "HANDLE", $hDC, "int", 10) ; $R2_NOTXORPEN

					$hPen = _WinAPI_CreatePen($PS_SOLID, 4, 0)
					$hOldPen = _WinAPI_SelectObject($hDC, $hPen)

					DllCall("Gdi32.dll", "int", "Rectangle", "HANDLE", $hDC, "int", 2, "int", 2, "int", $aRect[0] - 1, "int", $aRect[1] - 1)

					_WinAPI_SelectObject($hDC, $hOldPen)
					_WinAPI_DeleteObject($hPen)
					_WinAPI_ReleaseDC($h, $hDC)
				EndIf

				ContinueCase
			EndIf
		Case -1
			$fIn = False
			Return 0
		Case $WM_LBUTTONUP
			If _GUICtrlFinder_IsFinding($hWnd) Then
				_WinAPI_ReleaseCapture()
				_WinAPI_SetCursor($hBackupCursor)

				$hLast = _GUICtrlFinder_GetLastWnd($hWnd)
				If $hLast <> 0 And IsArray($aRect) Then
					If $fIn Then _WinAPI_PostMessage($hWnd, $iMsg, $wParam, $lParam)

					$hDC = _WinAPI_GetDC($hLast)
					If Not $hDC Then Return 0

					DllCall("Gdi32.dll", "int", "SetROP2", "HANDLE", $hDC, "int", 10) ; $R2_NOTXORPEN

					$hPen = _WinAPI_CreatePen($PS_SOLID, 4, 0)
					$hOldPen = _WinAPI_SelectObject($hDC, $hPen)

					DllCall("Gdi32.dll", "int", "Rectangle", "HANDLE", $hDC, "int", 2, "int", 2, "int", $aRect[0] - 1, "int", $aRect[1] - 1)

					_WinAPI_SelectObject($hDC, $hOldPen)
					_WinAPI_DeleteObject($hPen)
					_WinAPI_ReleaseDC($hLast, $hDC)

					$aRect = 0
				EndIf

				_WinAPI_RedrawWindow($hWnd)

				_WinAPI_PostMessage(_WinAPI_GetParent($hWnd), $WM_COMMAND, _WinAPI_MakeLong(_WinAPI_GetDlgCtrlID($hWnd), $FN_ENDUSE), $hWnd)
			EndIf
		Case $WM_PAINT
			Local $hIco, $tRect
			$hDC = _WinAPI_GetDC($hWnd)

			If _GUICtrlFinder_IsFinding($hWnd) Then
				; We have capture, so empty.
				$hIco = _WinAPI_GetWindowLong($hWnd, $__FINDERCONSTANT_GWL_ICONEMPTY)
				If $hIco = 0 Then $hIco = __GUICtrlFinder_GetDefaultResources(1)
			Else
				$hIco = _WinAPI_GetWindowLong($hWnd, $__FINDERCONSTANT_GWL_ICONFULL)
				If $hIco = 0 Then $hIco = __GUICtrlFinder_GetDefaultResources(0)
			EndIf

			$tRect = DllStructCreate($tagRECT)
			DllStructSetData($tRect, "Left", 0)
			DllStructSetData($tRect, "Top", 0)
			DllStructSetData($tRect, "Right", _WinAPI_GetWindowWidth($hWnd))
			DllStructSetData($tRect, "Bottom", _WinAPI_GetWindowHeight($hWnd))
			_WinAPI_FillRect($hDC, DllStructGetPtr($tRect), $COLOR_BTNFACE + 1)

			_WinAPI_DrawIcon($hDC, 0, 0, $hIco)

			_WinAPI_ReleaseDC($hWnd, $hDC)
			DllCall("User32.dll", "int", "ValidateRect", "HWND", $hWnd, "ptr", 0)

			Return 0
		Case $WM_DESTROY
			; Clean up resources
			$h = _WinAPI_GetWindowLong($hWnd, $__FINDERCONSTANT_GWL_ICONFULL)
			If $h <> 0 And $h <> __GUICtrlFinder_GetDefaultResources(0) Then _WinAPI_DestroyIcon($h)

			$h = _WinAPI_GetWindowLong($hWnd, $__FINDERCONSTANT_GWL_ICONEMPTY)
			If $h <> 0 And $h <> __GUICtrlFinder_GetDefaultResources(1) Then _WinAPI_DestroyIcon($h)

			$h = _WinAPI_GetWindowLong($hWnd, $__FINDERCONSTANT_GWL_CURSOR)
			If $h <> 0 And $h <> __GUICtrlFinder_GetDefaultResources(2) Then DllCall("user32.dll", "int", "DestroyCursor", "ptr", $h)

			; Destroy Window
			_WinAPI_DestroyWindow($hWnd)

			Return 0
	EndSwitch

	Return _WinAPI_DefWindowProc($hWnd, $iMsg, $wParam, $lParam)
EndFunc   ;==>__GUICtrlFinder_WndProc

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name ..........: __GUICtrlFinder_OnExit
; Description ...: Handles the exit of the application by closing all open finder controls and cleaning up resources.
; Syntax ........: __GUICtrlFinder_OnExit( )
; Parameters ....: None
; Return values .: None
; Author(s) .....: Matt Diesel (Mat)
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func __GUICtrlFinder_OnExit()
	; Close all windows
	Local $a = _WinAPI_EnumWindows()
	For $i = 1 To $a[0][0]
		If $a[$i][1] = $__FINDERCONSTANT_ClassName And WinGetProcess($a[$i][0]) = @AutoItPID Then
			_WinAPI_PostMessage($a[$i][0], $WM_CLOSE, 0, 0)
		EndIf
	Next

	__GUICtrlFinder_GetWndProc(True)
	__GUICtrlFinder_GetDefaultResources(-1, True)

	DllCall("user32.dll", "int", "UnregisterClassW", _
			"wstr", $__FINDERCONSTANT_ClassName, _
			"HANDLE", _WinAPI_GetModuleHandle(0))
EndFunc   ;==>__GUICtrlFinder_OnExit