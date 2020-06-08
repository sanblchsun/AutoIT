#include-once
#Include <GUIConstantsEx.au3>
#Include <StaticConstants.au3>
#Include <WindowsConstants.au3>
#Include <GUIMenu.au3>

#Region MsgBox Constants

Global Const $MB_ABORTRETRYIGNORE = 0x2
Global Const $MB_APPLMODAL = 0x0
Global Const $MB_CANCELTRYCONTINUE = 0x6
;~ Global Const $MB_COMPOSITE = 0x2
Global Const $MB_DEFAULT_DESKTOP_ONLY = 0x20000
Global Const $MB_DEFBUTTON1 = 0x0
Global Const $MB_DEFBUTTON2 = 0x100
Global Const $MB_DEFBUTTON3 = 0x200
Global Const $MB_DEFBUTTON4 = 0x300
Global Const $MB_DEFMASK = 0xF00
Global Const $MB_ERR_INVALID_CHARS = 0x8
Global Const $MB_FUNC = 0x4000
Global Const $MB_HELP = 0x4000
Global Const $MB_ICONASTERISK = 0x40
;~ Global Const $MB_ICONERROR = $MB_ICONHAND
Global Const $MB_ICONEXCLAMATION = 0x30
Global Const $MB_ICONHAND = 0x10
Global Const $MB_ICONINFORMATION = $MB_ICONASTERISK
Global Const $MB_ICONMASK = 0xF0
Global Const $MB_ICONQUESTION = 0x20
Global Const $MB_ICONSTOP = $MB_ICONHAND
Global Const $MB_ICONWARNING = $MB_ICONEXCLAMATION
Global Const $MB_MISCMASK = 0xC000
Global Const $MB_MODEMASK = 0x3000
Global Const $MB_NOFOCUS = 0x8000
Global Const $MB_OK = 0x0
Global Const $MB_OKCANCEL = 0x1
;~ Global Const $MB_PRECOMPOSED = 0x1
Global Const $MB_RETRYCANCEL = 0x5
Global Const $MB_RIGHT = 0x80000
Global Const $MB_RTLREADING = 0x100000
Global Const $MB_SERVICE_NOTIFICATION = 0x40000
Global Const $MB_SERVICE_NOTIFICATION_NT3X = 0x40000
Global Const $MB_SETFOREGROUND = 0x10000
Global Const $MB_SYSTEMMODAL = 0x1000
Global Const $MB_TASKMODAL = 0x2000
Global Const $MB_TOPMOST = 0x40000
Global Const $MB_TYPEMASK = 0xF
;~ Global Const $MB_USEGLYPHCHARS = 0x4
Global Const $MB_USERICON = 0x80
Global Const $MB_YESNO = 0x4
Global Const $MB_YESNOCANCEL = 0x3

#EndRegion MsgBox Constants

#Region User Options

Global $MB_OK_MSG 			= "OK"
Global $MB_CANCEL_MSG 		= "Cancel"
Global $MB_ABORT_MSG 		= "Abort"
Global $MB_RETRY_MSG 		= "Retry"
Global $MB_IGNORE_MSG 		= "Ignore"
Global $MB_YES_MSG 			= "Yes"
Global $MB_NO_MSG 			= "No"
Global $MB_TRY_AGAIN_MSG	= "Try Again"
Global $MB_CONTINUE_MSG 	= "Continue"

Global $MB_MESSAGEBEEP 		= 1
Global $MB_TIMEOUTCOUNT 	= 1

#EndRegion User Options

; #FUNCTION# ====================================================================================================
; Name...........:	_MsgBoxEx
; Description....:	Alternative to original MsgBox. Uses GUI, which allows more flexible tuning of the function.
; Syntax.........:	_MsgBoxEx($iFlag, $sTitle, $sText, $iTimeOut = -1, $hWnd = 0)
; Parameters.....:	$iFlag    - The flag indicates the type of message box and the possible button combinations. See remarks in original MsgBox, but with few exceptions:
;                                                                                           1) 8192 (task modal) ignored
;                                                                                           1) 524288 (title and text are right-justified) does not justifies title.
;					$sTitle   - The title of the message box.
;					$sText    - The text of the message box.
;					$iTimeOut - [Optional] Timeout in seconds. After the timeout has elapsed the message box will be automatically closed.
;                                          The default is 0, which is no timeout.
;					$hWnd     - [Optional] The window handle to use as the parent for this dialog.
;					
; Return values..:	Success   - Returns the ID of the button pressed.
;					Failure   - Returns the ID of default button and set @exteded to 1 if the message box timed out.
;
; Author.........:	G.Sandler (MrCreatoR), www.creator-lab.ucoz.ru, www.autoit-script.ru
; Modified.......:	
; Remarks........:	* Tested on Win XP (rus) SP3, AutoIt 3.2.8.1+.
;                   * Use the following variables to set few options of this UDF:
;                         $MB_MESSAGEBEEP = 1 ;Will call a MessageBeep WinAPI function accordingly to icon selected in $iFlag.
;                         $MB_TIMEOUTCOUNT = 1 ;If this is set to 1, then on default button a counter will be displayed.
; Related........:	
; Link...........:	
; Example........:	Yes.
; ===============================================================================================================
Func _MsgBoxEx($iFlag, $sTitle, $sText, $iTimeOut = -1, $hWnd = 0)
	Local $hMsgBox_GUI, $hMenu, $nMsg, $sClicked_Button_Text
	Local $iWidth = 260, $iHeight = 100, $iTop = -1, $n_Button1 = -1, $n_Button2 = -1, $n_Button3 = -1
	Local $s_Button1_Txt = "", $s_Button2_Txt = "", $s_Button3_Txt = "", $i_Buttons_Num = 1
	Local $iButtonW = 70, $iLabel_Left = 60, $iLabel_MaxLen = @DesktopWidth / 1.8
	Local $aFont_Data = __MB_GetDefaultFont("Caption")
	Local $iLabel_Len = __MB_GetTextLen(__MB_StringGetBiggestLine($sText), 0) + 100
	Local $iTitle_Len = __MB_GetTextLen($sTitle, 0, $aFont_Data[0], $aFont_Data[1])
	Local $nStyle = BitOR($WS_CAPTION, $WS_POPUP, $WS_SYSMENU), $nExStyle = $WS_EX_DLGMODALFRAME
	Local $nLabelStyle = $SS_NOPREFIX
	Local $iExtended = 0, $iReturnVal = -1, $iIcon_Id = "", $iMessage_Beep = -1, $n_DefButton = -1, $sDefButtonText = "", $iCounter = $iTimeOut, $i_Timer = 0
	
	Local $iOld_Opt_GOEM = Opt('GUIOnEventMode', 0), $iOld_Opt_GCOE = Opt('GUICloseOnESC', 0)
	
	If $iLabel_Len > $iWidth And $iLabel_Len < $iLabel_MaxLen Then
		$iWidth = $iLabel_Len + $iLabel_Left
		$iHeight += (10 * ($iLabel_Len / $iLabel_MaxLen))
	ElseIf $iLabel_Len > $iWidth Then
		$iWidth = $iLabel_MaxLen
		$iHeight += (10 * ($iLabel_Len / $iLabel_MaxLen))
	EndIf
	
	;It's not a system modal dialog, so we set the width of msgbox to fit the title lenght
	If BitAND($iFlag, $MB_SYSTEMMODAL) <> $MB_SYSTEMMODAL And $iWidth < $iTitle_Len + 40 Then
		$iWidth = $iTitle_Len + 100
	EndIf
	
	StringReplace($sText, @LF, "")
	
	If @extended > 1 Then
		$iHeight += (13 * @extended) + 10
	EndIf
	
	If $iHeight > @DesktopHeight-100 Then
		$iTop = 0
	EndIf
	
	If $sTitle = Default Then
		$sTitle = @ScriptName
	EndIf
	
	;Miscellaneous-related Result
	If BitAND($iFlag, $MB_TOPMOST) = $MB_TOPMOST Then
		$nExStyle = BitOR($nExStyle, $WS_EX_TOPMOST)
	EndIf
	
	;Text are right-justified
	If BitAND($iFlag, $MB_RIGHT) = $MB_RIGHT Then
		$nLabelStyle = BitOR($nLabelStyle, $SS_RIGHT)
		$iLabel_MaxLen = $iLabel_Len + 65
	EndIf
	
	If IsHWnd($hWnd) Then
		WinSetState($hWnd, "", @SW_DISABLE)
	EndIf
	
	$hMsgBox_GUI = GUICreate($sTitle, $iWidth, $iHeight, -1, $iTop, $nStyle, $nExStyle, $hWnd)
	
	;Button-related Result
	Select
		Case BitAND($iFlag, $MB_CANCELTRYCONTINUE) = $MB_CANCELTRYCONTINUE
			If @OSType = "WIN32_NT" Then
				$i_Buttons_Num = 3
				$s_Button1_Txt = $MB_CANCEL_MSG
				$s_Button2_Txt = $MB_TRY_AGAIN_MSG
				$s_Button3_Txt = $MB_CONTINUE_MSG
			Else
				$i_Buttons_Num = 1
				$s_Button1_Txt = $MB_OK_MSG
			EndIf
		Case BitAND($iFlag, $MB_RETRYCANCEL) = $MB_RETRYCANCEL
			$i_Buttons_Num = 2
			$s_Button1_Txt = $MB_RETRY_MSG
			$s_Button2_Txt = $MB_CANCEL_MSG
		Case BitAND($iFlag, $MB_YESNO) = $MB_YESNO
			$i_Buttons_Num = 2
			$s_Button1_Txt = $MB_YES_MSG
			$s_Button2_Txt = $MB_NO_MSG
			
			__MB_GUIDisableCloseOption($hMsgBox_GUI)
		Case BitAND($iFlag, $MB_YESNOCANCEL) = $MB_YESNOCANCEL
			$i_Buttons_Num = 3
			$s_Button1_Txt = $MB_YES_MSG
			$s_Button2_Txt = $MB_NO_MSG
			$s_Button3_Txt = $MB_CANCEL_MSG
		Case BitAND($iFlag, $MB_ABORTRETRYIGNORE) = $MB_ABORTRETRYIGNORE
			$i_Buttons_Num = 3
			$s_Button1_Txt = $MB_ABORT_MSG
			$s_Button2_Txt = $MB_RETRY_MSG
			$s_Button3_Txt = $MB_IGNORE_MSG
			
			__MB_GUIDisableCloseOption($hMsgBox_GUI)
		Case BitAND($iFlag, $MB_OKCANCEL) = $MB_OKCANCEL
			$i_Buttons_Num = 2
			$s_Button1_Txt = $MB_OK_MSG
			$s_Button2_Txt = $MB_CANCEL_MSG
		Case Else
			$i_Buttons_Num = 1
			$s_Button1_Txt = $MB_OK_MSG
	EndSelect
	
	Switch $i_Buttons_Num
		Case 1
			$n_Button1 = GUICtrlCreateButton($s_Button1_Txt, ($iWidth/2)-($iButtonW/2), $iHeight-($iButtonW/2), $iButtonW, 23)
		Case 2
			$n_Button1 = GUICtrlCreateButton($s_Button1_Txt, ($iWidth/2)-($iButtonW+5), $iHeight-($iButtonW/2), $iButtonW, 23)
			$n_Button2 = GUICtrlCreateButton($s_Button2_Txt, ($iWidth/2)+5, $iHeight-($iButtonW/2), $iButtonW, 23)
		Case 3
			$n_Button1 = GUICtrlCreateButton($s_Button1_Txt, ($iWidth/2)-($iButtonW/2)-($iButtonW+5), $iHeight-($iButtonW/2), $iButtonW, 23)
			$n_Button2 = GUICtrlCreateButton($s_Button2_Txt, ($iWidth/2)-($iButtonW/2), $iHeight-($iButtonW/2), $iButtonW, 23)
			$n_Button3 = GUICtrlCreateButton($s_Button3_Txt, ($iWidth/2)+($iButtonW/2)+5, $iHeight-($iButtonW/2), $iButtonW, 23)
	EndSwitch
	
	;Icon-related Result
	Select
		Case BitAND($iFlag, $MB_ICONASTERISK) = $MB_ICONASTERISK
			$iIcon_Id = 104
			$iMessage_Beep = $MB_ICONASTERISK
		Case BitAND($iFlag, $MB_ICONEXCLAMATION) = $MB_ICONEXCLAMATION
			$iIcon_Id = 101
			$iMessage_Beep = $MB_ICONEXCLAMATION
		Case BitAND($iFlag, $MB_ICONQUESTION) = $MB_ICONQUESTION
			$iIcon_Id = 102
			$iMessage_Beep = $MB_ICONQUESTION
		Case BitAND($iFlag, $MB_ICONHAND) = $MB_ICONHAND
			$iIcon_Id = 103
			$iMessage_Beep = $MB_ICONHAND
	EndSelect
	
	If $iIcon_Id <> "" Then
		GUICtrlCreateIcon('user32.dll', $iIcon_Id, 10, 10)
	Else
		$iLabel_Left = 20
	EndIf
	
	;Remove menu items
	$hMenu = _GUICtrlMenu_GetSystemMenu($hMsgBox_GUI)
	_GUICtrlMenu_DeleteMenu($hMenu, 0, False) ; Seperator
	_GUICtrlMenu_DeleteMenu($hMenu, 0xF000, False) ; $SC_SIZE
	_GUICtrlMenu_DeleteMenu($hMenu, 0xF020, False) ; $SC_MINIMIZE
	_GUICtrlMenu_DeleteMenu($hMenu, 0xF030, False) ; $SC_MAXIMIZE
	_GUICtrlMenu_DeleteMenu($hMenu, 0xF120, False) ; $SC_RESTORE
	
	;Modality-related Result
	Select
		Case BitAND($iFlag, $MB_SYSTEMMODAL) = $MB_SYSTEMMODAL ;Modal dialog
			GUISetIcon('user32.dll', 0, $hMsgBox_GUI)
		Case Else ;Remove system icon
			DllCall("user32.dll", "int", "SetClassLong", "hwnd", $hMsgBox_GUI, "int", -14, "long", 0) ; $GCL_HICON
			DllCall("user32.dll", "int", "SetClassLong", "hwnd", $hMsgBox_GUI, "int", -34, "long", 0) ; $GCL_HICONSM
			;GUISetIcon('setupapi.dll', -24, $hMsgBox_GUI)
	EndSelect
	
	;Default-related Result
	Select 
		Case BitAND($iFlag, $MB_DEFBUTTON3) = $MB_DEFBUTTON3
			GUICtrlSetState($n_Button3, BitOR($GUI_FOCUS, $GUI_DEFBUTTON))
			$n_DefButton = $n_Button3
		Case BitAND($iFlag, $MB_DEFBUTTON2) = $MB_DEFBUTTON2
			GUICtrlSetState($n_Button2, BitOR($GUI_FOCUS, $GUI_DEFBUTTON))
			$n_DefButton = $n_Button2
	EndSelect
	
	GUICtrlCreateLabel($sText, $iLabel_Left, 15, $iLabel_MaxLen-65, $iHeight-60, $nLabelStyle)
	GUICtrlSetFont(-1, 8.5, 0, 0, "Tahoma")
	GUICtrlSetTip(-1, "") ;Prevet the bug that make me build this UDF in the first place :(
	
	;TimeOut Option
	If $iTimeOut > 0 Then
		$i_Timer = TimerInit()
	EndIf
	
	If $n_DefButton = -1 Then
		GUICtrlSetState($n_Button1, BitOR($GUI_FOCUS, $GUI_DEFBUTTON))
		$n_DefButton = $n_Button1
	EndIf
	
	$sDefButtonText = GUICtrlRead($n_DefButton, 1)
	
	GUISetState(@SW_SHOW, $hMsgBox_GUI)
	
	If $MB_MESSAGEBEEP Then
		DllCall("user32.dll", "int", "MessageBeep", "int", $iMessage_Beep)
	EndIf
	
	If $MB_TIMEOUTCOUNT And $iTimeOut > 0 Then
		$i_Timer = TimerInit()
		GUICtrlSetData($n_DefButton, $sDefButtonText & ' (' & $iCounter & ')')
	EndIf
	
	While 1
		$nMsg = GUIGetMsg()
		
		If $iTimeOut > 0 And TimerDiff($i_Timer) >= 1000 Then
			$i_Timer = TimerInit()
			$iCounter -= 1
			
			If $MB_TIMEOUTCOUNT Then
				GUICtrlSetData($n_DefButton, $sDefButtonText & ' (' & $iCounter & ')')
			EndIf
			
			If $iCounter <= 0 Then
				$iExtended = 1
				$nMsg = $n_DefButton
			EndIf
		EndIf
		
		Switch $nMsg
			Case $n_Button1, $n_Button2, $n_Button3
				$sClicked_Button_Text = StringRegExpReplace(GUICtrlRead($nMsg), ' \(' & $iCounter & '\)$', '')
				
				Switch $sClicked_Button_Text
					Case $MB_OK_MSG
						$iReturnVal = 1
					Case $MB_CANCEL_MSG
						$iReturnVal = 2
					Case $MB_ABORT_MSG
						$iReturnVal = 3
					Case $MB_RETRY_MSG
						$iReturnVal = 4
					Case $MB_IGNORE_MSG
						$iReturnVal = 5
					Case $MB_YES_MSG
						$iReturnVal = 6
					Case $MB_NO_MSG
						$iReturnVal = 7
					Case $MB_TRY_AGAIN_MSG
						$iReturnVal = 10
					Case $MB_CONTINUE_MSG
						$iReturnVal = 11
				EndSwitch
				
				ExitLoop
			Case $GUI_EVENT_CLOSE
				$iReturnVal = 2
				
				If $i_Buttons_Num = 1 Then
					$iReturnVal = 1
				EndIf
				
				ExitLoop
		EndSwitch
	Wend
	
	If IsHWnd($hWnd) Then
		WinSetState($hWnd, "", @SW_ENABLE)
	EndIf
	
	GUIDelete($hMsgBox_GUI)
	
	If IsHWnd($hWnd) Then
		GUISwitch($hWnd)
	EndIf
	
	Opt('GUIOnEventMode', $iOld_Opt_GOEM)
	Opt('GUICloseOnESC', $iOld_Opt_GCOE)
	
	Return SetExtended($iExtended, $iReturnVal)
EndFunc

Func __MB_GUIDisableCloseOption($hWnd)
	Local $hMenu = _GUICtrlMenu_GetSystemMenu($hWnd)
    _GUICtrlMenu_DeleteMenu($hMenu, 0xF060, False) ;$SC_CLOSE = 0xF060
	
	Local $aAccelKeys[1][2] = [["!{F4}", GUICtrlCreateDummy()]]
	GUISetAccelerators($aAccelKeys, $hWnd)
EndFunc

Func __MB_StringGetBiggestLine($sString)
	If Not StringInStr($sString, @LF) Then
		Return $sString
	EndIf
	
	Local $iBiggestLen = 0, $sRetLine = "", $iCurrentLineLen
	Local $aStrSplit = StringSplit($sString, @LF)
	
	For $i = 1 To UBound($aStrSplit)-1
		$iCurrentLineLen = StringLen($aStrSplit[$i])
		
		If $iCurrentLineLen > $iBiggestLen Then
			$iBiggestLen = $iCurrentLineLen
			$sRetLine = $aStrSplit[$i]
		EndIf
	Next
	
	Return $sRetLine
EndFunc

Func __MB_GetTextLen($s_Data, $iElmnt = -1, $sFontName = -1, $iFontSize = -1)
	Local Const $WM_GETFONT = 0x31
	Local $hWnd, $hText, $hDC, $hFont, $hOld, $iStruct_Size, $a_RetLen[2]
	
	$hWnd = GUICreate("__TextLenght_Handler__")
	
	If IsString($sFontName) Or $iFontSize > -1 Then
		GUISetFont($iFontSize, Default, Default, $sFontName, $hWnd)
	EndIf
	
	$hText = GUICtrlGetHandle(GUICtrlCreateLabel($s_Data, 0, 0))
	$hDC = DLLCall("user32.dll", "int", "GetDC", "hwnd", $hText)
	$hFont = DllCall("user32.dll", "ptr", "SendMessage", "hwnd", $hText, "int", $WM_GETFONT, "int", 0, "int", 0)
	$hOld = DllCall("gdi32.dll", "Hwnd", "SelectObject", "int", $hDC[0], "ptr", $hFont[0])
	$iStruct_Size = DllStructCreate("int;int")
	DllCall("gdi32.dll", "int", "GetTextExtentPoint32", "int", $hDC[0], "str", $s_Data, "long", StringLen($s_Data), "ptr", DllStructGetPtr($iStruct_Size))
	$hOld = DllCall("gdi32.dll", "Hwnd", "SelectObject", "int", $hDC[0], "ptr", $hOld)
	
	$a_RetLen[0] = DllStructGetData($iStruct_Size, 1)
	$a_RetLen[1] = DllStructGetData($iStruct_Size, 2)
	
	DLLCall("user32.dll","int", "ReleaseDC", "hwnd", $hText, "int", $hDC[0])
	GUIDelete($hWnd)
	
	If $iElmnt > -1 And $iElmnt < 2 Then
		Return $a_RetLen[$iElmnt]
	EndIf
	
	Return $a_RetLen
EndFunc

Func __MB_GetDefaultFont($sUsage = "")
	Switch $sUsage
		Case "Caption"
			$iParam = 7
		Case "Small Caption"
			$iParam = 10
		Case "Menu"
			$iParam = 13
		Case "Status"
			$iParam = 14
		Case Else ; Default setting will give "Message Box"
			$iParam = 15
	EndSwitch
	
	; Get default system font data
	Local $stNONCLIENTMETRICS = DllStructCreate("uint;int;int;int;int;int;byte[60];int;int;byte[60];int;int;byte[60];byte[60];byte[60]")
	DLLStructSetData($stNONCLIENTMETRICS, 1, DllStructGetSize($stNONCLIENTMETRICS))
	DLLCall("user32.dll", "int", "SystemParametersInfo", "int", 41, "int", DllStructGetSize($stNONCLIENTMETRICS), "ptr", DllStructGetPtr($stNONCLIENTMETRICS), "int", 0)
	
	Local $aFontData[2]
	; Read font data for required font
	Local $dLogFont = DllStructCreate("long;long;long;long;long;byte;byte;byte;byte;byte;byte;byte;byte;char[32]", DLLStructGetPtr($stNONCLIENTMETRICS, $iParam))
	$aFontData[0] = DllStructGetData($dLogFont, 14) ; font name
	$aFontData[1] = Abs(DllStructGetData($dLogFont, 1)) * .75 ; font size
	
	Return $aFontData
EndFunc
