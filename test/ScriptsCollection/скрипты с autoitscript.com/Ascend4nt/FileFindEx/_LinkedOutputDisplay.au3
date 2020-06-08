#include-once
; ===============================================================================================================================
; <_LinkedOutputDisplay.au3>
;
; Displays a dialog box with linked edit 'output' box scrollable controls
;
; Function:
;	_LinkedOutputDisplay()
;
; Support Functions:
;	_WinAPI_GetScrollPos()
;
; INTERNAL DO-NOT-USE Functions:
;	_INT_*** (6 total)
;
; See also:
;	<_DisplayProgramOutput.au3>
;
; Author(s): Ascend4nt, with credit to MrCreatoR for his MouseHook UDF:
;	_MouseSetOnEvent() code (@ http://www.autoitscript.com/forum/index.php?showtopic=64738)
;		[NOTE: MouseHook code MODIFIED SPECIFICALLY FOR THIS UDF - so do NOT use for general purposes]
; ===============================================================================================================================

; KODA'S GUI INCLUDES
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
; STANDARD UDF FUNCTIONS INCLUDES
#include <GuiScrollBars.au3>	; _GUIScrollBars_GetScrollBarInfoEx [& prior use: _GUIScrollBars_GetScrollInfo(), $tagSCROLLINFO]
; MOUSE HOOK INCLUDE [reference-sake]
;#include <MouseSetOnEvent_UDF.au3>

; ===============================================================================================================================
; Func _WinAPI_GetScrollPos($hControlHandle,$iAxis)
;
; Gets current scroll position of scrollable window.
;
; $hControlHandle = HANDLE (not ID) of Control (use GUICtrlGetHandle() if don't know it)
; $iAxis = 0 for X (horizontal axis), non-zero for Y (vertical axis)
;
; Returns:
;	Success: current position
;	Failure: @error=1, -1 return
; ===============================================================================================================================

Func _WinAPI_GetScrollPos($hControlHandle,$iAxis)
	If $iAxis Then $iAxis=1
	Local $aRet=DllCall("user32.dll","int","GetScrollPos","ptr",$hControlHandle,"int",$iAxis)
	If @error Then Return SetError(1,@error,-1)
	Return $aRet[0]
#cs
; This returns the same info as above alternate call, but above call is much simpler

	Local $aRet,$stScrollInfo=DllStructCreate($tagSCROLLINFO)
	DllStructSetData($stScrollInfo,1,DllStructGetSize($stScrollInfo))
	DllStructSetData($stScrollInfo,2,0x010)	;SIF_TRACKPOS
	If Not _GUIScrollBars_GetScrollInfo($hControlHandle,$iAxis,$stScrollInfo) Then Return SetError(1,@error,-1)
	Return DllStructGetData($stScrollInfo,7)
#ce
EndFunc

; INTERNAL GLOBAL VARIABLES [FOR EVENT-COMMUNICATION]

Global $_hINT_LOD_GUI,$_INT_LOD_EDIT1,$_INT_LOD_EDIT2,$_hINT_LOD_EDIT1,$_hINT_LOD_EDIT2,$_bINT_LOD_MAKINGCHANGE=False
Global $_iINT_MOUSE_DOWN_EDIT=0,$_iINT_SCROLL_AXIS	;,$_iINT_MOUSE_PREVX,$_iINT_MOUSE_PREVY	;,$_bINT_LOD_ADLIB_CHANGE=False

; ===============================================================================================================================
; Func _INT_LOD_WM_COMMAND($hWndGUI, $MsgID, $wParam, $lParam)
;
; Registered WM_COMMAND function. Searches for & acts upon EN_VSCROLL messages (EN_HSCROLL is impossible to get right!)
;	Does NOT see click-tab-and-drag messages, and neither does main GUI/Window
;		(which means Mouse Hook functions are the way to go)
; ===============================================================================================================================

Func _INT_LOD_WM_COMMAND($hWndGUI, $MsgID, $wParam, $lParam)
	; Currently performing an operation? Skip reading message & allow regular processing of message
	If $_bINT_LOD_MAKINGCHANGE Then Return $GUI_RUNDEFMSG
	; Notify code & ID are squished into the low/high order 'word's of $wParam
    Local $nNotifyCode = BitShift($wParam, 16)
    Local $nID = BitAND($wParam, 0x0000FFFF)
	Local $hControlHandleToLink=-1,$hControlIDToLink=-1

	; Control ID match one of the Edit controls? If so, set up 'links' to appropriate adjacent Edit control
	If $nID=$_INT_LOD_EDIT1 Then
		$hControlHandleToLink=$_hINT_LOD_EDIT2
		$hControlIDToLink=$_INT_LOD_EDIT2
	Elseif $nID=$_INT_LOD_EDIT2 Then
		$hControlHandleToLink=$_hINT_LOD_EDIT1
		$hControlIDToLink=$_INT_LOD_EDIT1
	EndIf

	; Note that any scrolls via the scrollbar tab won't send any messages, not even WM_HSCROLL or WM_VSCROLL messages!
	;	Trouble is, even through Winspector, no messages get routed to the client window, so even overriding the
	;	Callback function probably won't work, since the edit controls work on their own except in the cases of EN_HSCROLL/VSCROLL
	;	For the other types of messages we need the Mouse Hook
	;	(and I've given up on EN_HSCROLL - its basically impossible to get working right)
#cs
	If $nNotifyCode=0x601 And $hControlHandleToLink<>-1 Then	; EN_HSCROLL
	; This was all for naught! Turns out that 'charfrompos' gives index from beginning of string, not from line
	;	and then obtaining the character a line starts with was a good idea until I found out 'charfrompos'
	;	bases it's offset on line #1, UNLESS you are on line #0. WTH?
	; So after all this nonsense I've decided to give up!
	; Unless there's some way to send a delta thumbtab change through Windows messages?
	; Or is there a way to make a WM_HSCROLL (and WM_VSCROLL) hook for controls?
	; (main window doesn't register these)

		; Obtain *character* scroll index positions
		;	EM_LINEINDEX = 0xBB
		$iIndex=BitAND(GUICtrlSendMsg($nID,0xD7,0,0),0xFFFF)	; EM_CHARFROMPOS (absolute from beginning of text)
		ConsoleWrite("(cur window) EM_CHARFROMPOS=" & $iIndex)
		Local $ii=_WinAPI_GetScrollPos($lParam,1)
		ConsoleWrite(", ScrollPos (vertical)=" & $ii)

		$ii=GUICtrlSendMsg($nID,0xBB,_WinAPI_GetScrollPos($lParam,1)-1,0)
		$iIndex-=$ii
		ConsoleWrite(", EM_LINEINDEX from scrollpos=" & $ii & @CRLF)

		$iLinkIndex=BitAND(GUICtrlSendMsg($hControlIDToLink,0xD7,0,0),0xFFFF)- _	; EM_CHARFROMPOS
			GUICtrlSendMsg($hControlIDToLink,0xBB,_WinAPI_GetScrollPos($hControlHandleToLink,1)-1,0)



		ConsoleWrite("$iIndex (cur win):" & $iIndex & ", $iLinkIndex:" & $iLinkIndex & ", Sending command to scroll horizontally:" & String($iIndex-$iLinkIndex) & " chars" & @CRLF)

		; Prevent WM_COMMAND's from being read by this function during the send of next message
		;	(otherwise may wind up repeatedly acting on\sending same message)
		$_bINT_LOD_MAKINGCHANGE=True
		; Send a scroll change to adjacent Edit control using a delta value
		GUICtrlSendMsg($hControlIDToLink,0x00B6,$iIndex-$iLinkIndex,0)	; EM_LINESCROLL [SEND] - Horizontal is *character* delta
		; Allow WM_COMMAND reading again
		$_bINT_LOD_MAKINGCHANGE=False
#ce
	If $nNotifyCode=0x602 And $hControlHandleToLink<>-1 Then ; EN_VSCROLL
		; Obtain scroll index positions
		$iIndex=_WinAPI_GetScrollPos($lParam,1)
		$iLinkIndex=_WinAPI_GetScrollPos($hControlHandleToLink,1)
		ConsoleWrite("$iIndex (cur win):" & $iIndex & ", $iLinkIndex:" & $iLinkIndex & ", Sending command to scroll vertically:" & String($iIndex-$iLinkIndex) & " lines" & @CRLF)

		; Prevent WM_COMMAND's from being read by this function during the send of next message
		;	(otherwise may wind up repeatedly acting on\sending same message)
		$_bINT_LOD_MAKINGCHANGE=True
		; Send a scroll change to adjacent Edit control using a delta value
		GUICtrlSendMsg($hControlIDToLink,0x00B6,0,$iIndex-$iLinkIndex)	; EM_LINESCROLL [SEND]
		; Allow WM_COMMAND reading again
		$_bINT_LOD_MAKINGCHANGE=False
	EndIf
	; Allow regular processing of message
	Return $GUI_RUNDEFMSG
EndFunc

#comments-start
; Failed to serve its purpose. Mouse-Move event hook has attempted to replace it...
; ===============================================================================================================================
; Adlib Function
;
; Purpose: If a click was performed on a scrollbar's tab and it is dragged, this function
;	will ensure both edit boxes are updated if needed.
;	(and no, WM_MOUSEMOVE events aren't seen either until the tab is released)
;
; PROBLEM: This is called ONLY when a 'release' of scrollbar tab position occurs (meaning it will
;	be moving), or a move in the opposite axis occurs (ex: for vert. scrollbar, a move in Y axis)
;	Well, and when the scrollbar tab is not being held down too.
;
;	Seeing as how a simple scrollbar tab can override ALL internal functioning, this is being
;	ditched in favor of a $MOUSE_MOVE_EVENT handler, which WILL be called no matter what
;	(This will have to be tempered with $_iINT_LOD_PREV_SCROLLX and $_iINT_LOD_PREV_SCROLLY flags)
; ===============================================================================================================================

Func _INT_LOD_ADLIB_FUNC()

	; Currently performing an operation?
	If $_bINT_LOD_ADLIB_CHANGE Then Return

	; Was there an initial click on one of the edit windows's scroll bar tabs? (specifically, vertical?)
	If $_iINT_MOUSE_DOWN_EDIT Then
		; Prevent Adlib function from executing
		$_bINT_LOD_ADLIB_CHANGE=True
		Local $iMouseX=MouseGetPos(0),$iMouseY=MouseGetPos(1)
		ConsoleWrite("Adlib called, mouse coordinates: X:" & $iMouseX & ", Y:" & $iMouseY & @CRLF)
		; Vertical Axis scrollbar? (up/down)
		If $_iINT_SCROLL_AXIS Then
			; Simulate EN_VSCROLL event call (note 1st 2 params are ignored by this program's event handler)
			If $_iINT_MOUSE_DOWN_EDIT=1 Then
				_INT_LOD_WM_COMMAND(0,0,$_INT_LOD_EDIT1+BitShift(0x602,-16),$_hINT_LOD_EDIT1)
			Else
				_INT_LOD_WM_COMMAND(0,0,$_INT_LOD_EDIT2+BitShift(0x602,-16),$_hINT_LOD_EDIT2)
			EndIf
;~ #cs
;~ 			;$iDeltaX=$iMouseX-$_iINT_MOUSE_PREVX
;~ 			;$iDeltaY=$iMouseY-$_iINT_MOUSE_PREVY
;~ 			;MouseMove($iMouseX+1,$iMouseY,1)
;~ 			; Vertical axis, now check to see if there's any discrepancies between scroll locations & adjust
;~ 			Local $iEdit1YIndex=_WinAPI_GetScrollPos($_hINT_LOD_EDIT1,1)
;~ 			Local $iEdit2YIndex=_WinAPI_GetScrollPos($_hINT_LOD_EDIT2,1)

;~ 			If $iEdit1YIndex<>$iEdit2YIndex Then
;~ 				ConsoleWrite("Discrepancy: Edit1 Y:" & $iEdit1YIndex & ", Edit 2 Y:" & $iEdit2YIndex & _
;~ 					", Prev Mouse X:" & $_iINT_MOUSE_PREVX & ", Cur X:" & $iMouseX & _
;~ 					", Prev Mouse Y:" & $_iINT_MOUSE_PREVY & ", Cur Y:" & $iMouseY & @CRLF)
;~ 				$_bINT_LOD_MAKINGCHANGE=True
;~ 				If $_iINT_MOUSE_DOWN_EDIT=1 Then
;~ 					; Send a scroll change to adjacent Edit control using a delta value
;~ 					GUICtrlSendMsg($_INT_LOD_EDIT2,0x00B6,0,$iEdit1YIndex-$iEdit2YIndex)	; EM_LINESCROLL [SEND]
;~ 				Else	; =2
;~ 					; Send a scroll change to adjacent Edit control using a delta value
;~ 					GUICtrlSendMsg($_INT_LOD_EDIT1,0x00B6,0,$iEdit2YIndex-$iEdit1YIndex)	; EM_LINESCROLL [SEND]
;~ 				EndIf
;~ 				$_bINT_LOD_MAKINGCHANGE=False
;~ 			EndIf
;~ #ce
		;Else	; - Horizontal Axis (left/right) - problems with getting proper values
		EndIf
		; Update mouse position
		$_iINT_MOUSE_PREVX=$iMouseX
		$_iINT_MOUSE_PREVY=$iMouseY
		; Allow Adlib function to resume functioning
		$_bINT_LOD_ADLIB_CHANGE=False
	EndIf
EndFunc
#comments-end
; ===============================================================================================================================
; Mouse Event Hook for Primary-Down events
;
; Purpose: catching clicks on scrollbar tabs, and telling the Mouse hook that a drag move is starting
;	(ends at Primary-Up)
;
; Note that there's a number of GetScrollBarInfo calls - these values can change constantly
;	with window moves, resizing, and scrolling - so no point in storing them. This hook is only called
;	on a mouse-down event, & calls are made only after checking that it is in window, so it's not
;	a big constant drain on system resources.
;	The compares could be set up in an external function to reduce code size..
; ===============================================================================================================================

Func _INT_MOUSE_PRIMARYDOWN_HOOK($iMouseX,$iMouseY)
	Local $aWinRect=WinGetPos($_hINT_LOD_GUI)

	; Is mouse inside window
	If $iMouseX>=$aWinRect[0] And $iMouseY>=$aWinRect[1] And _
	  $iMouseX<=($aWinRect[0]+$aWinRect[2]-1) And $iMouseY<=($aWinRect[1]+$aWinRect[3]-1) Then
		; Set up mouse coords in case one of the below checks ring true
		;	(these are used for delta change tracking - may help calculating changes..)
		;$_iINT_MOUSE_PREVX=$iMouseX
		;$_iINT_MOUSE_PREVY=$iMouseY
		; ScrollBarInfo is returned in screen coordinates. Add it to XY Thumb to get thumb bar screen coordinates
		Local $stScrollBarInfo=_GUIScrollBars_GetScrollBarInfoEx($_hINT_LOD_EDIT1,0xFFFFFFFB)	; OBJID_VSCROLL	(LONG)	0xFFFFFFFB

		;ConsoleWrite("Edit 1 scrollbar info: X1:" & DllStructGetData($stScrollBarInfo,2) & ", Y1:" & DllStructGetData($stScrollBarInfo,3) & _
		;", X2:" & DllStructGetData($stScrollBarInfo,4) & ", Y2:" & DllStructGetData($stScrollBarInfo,5) & _
		;", XY_ThumbTop:" & DllStructGetData($stScrollBarInfo,7) & ", XY_ThumbBottom:" & DllStructGetData($stScrollBarInfo,8) & @CRLF)

		; BitAnd test for 'top or right arrow button' is to make sure it's visible (1 = STATE_SYSTEM_INVISIBLE)

		; Compare location for Vertical tab bar on Edit 1
		Local $iScrollBarvY1=DllStructGetData($stScrollBarInfo,3)	; Y1
		;ConsoleWrite("Status of vertical scrollbar thumb:" & DllStructGetData($stScrollBarInfo,10,1) & ", Size:" & DllStructGetData($stScrollBarInfo,6) & @CRLF)
		If $iMouseX>=DllStructGetData($stScrollBarInfo,2) And $iMouseX<=(DllStructGetData($stScrollBarInfo,4)-1) And _
		   $iMouseY>=($iScrollBarvY1+DllStructGetData($stScrollBarInfo,7)) And _
		   $iMouseY<=($iScrollBarvY1+DllStructGetData($stScrollBarInfo,8)-1) And BitAND(DllStructGetData($stScrollBarInfo,10,1),1)<>1 Then
			$_iINT_MOUSE_DOWN_EDIT=1
			ConsoleWrite("Grabbed Vertical Tab on Edit 1" & @CRLF)
			$_iINT_SCROLL_AXIS=1
		Else
			; Try Vertical on Edit 2
			$stScrollBarInfo=_GUIScrollBars_GetScrollBarInfoEx($_hINT_LOD_EDIT2,0xFFFFFFFB)	; OBJID_VSCROLL	(LONG)	0xFFFFFFFB
			$iScrollBarvY1=DllStructGetData($stScrollBarInfo,3)
			If $iMouseX>=DllStructGetData($stScrollBarInfo,2) And $iMouseX<=(DllStructGetData($stScrollBarInfo,4)-1) And _
			   $iMouseY>=($iScrollBarvY1+DllStructGetData($stScrollBarInfo,7)) And _
			   $iMouseY<=($iScrollBarvY1+DllStructGetData($stScrollBarInfo,8)-1) And BitAND(DllStructGetData($stScrollBarInfo,10,1),1)<>1 Then
				$_iINT_MOUSE_DOWN_EDIT=2
				ConsoleWrite("Grabbed Vertical Tab on Edit 2" & @CRLF)
				$_iINT_SCROLL_AXIS=1
			Else
				; Try Horizontal Bars.. Edit 1 first
				$stScrollBarInfo=_GUIScrollBars_GetScrollBarInfoEx($_hINT_LOD_EDIT1,0xFFFFFFFA)	; OBJID_HSCROLL	(LONG)	0xFFFFFFFA
				Local $iScrollBarhX1=DllStructGetData($stScrollBarInfo,2)
				If $iMouseX>=($iScrollBarhX1+DllStructGetData($stScrollBarInfo,7)) And _
				   $iMouseX<=($iScrollBarhX1+DllStructGetData($stScrollBarInfo,8)-1) And _
				   $iMouseY>=DllStructGetData($stScrollBarInfo,3) And _
				   $iMouseY<=(DllStructGetData($stScrollBarInfo,5)-1) And BitAND(DllStructGetData($stScrollBarInfo,10,1),1)<>1 Then
					$_iINT_MOUSE_DOWN_EDIT=1
					ConsoleWrite("Grabbed Horizontal Tab on Edit 1" & @CRLF)
					$_iINT_SCROLL_AXIS=0
				Else
					; Try Horizontal on Edit 2
					$stScrollBarInfo=_GUIScrollBars_GetScrollBarInfoEx($_hINT_LOD_EDIT2,0xFFFFFFFA)	; OBJID_HSCROLL	(LONG)	0xFFFFFFFA
					$iScrollBarhX1=DllStructGetData($stScrollBarInfo,2)
					If $iMouseX>=($iScrollBarhX1+DllStructGetData($stScrollBarInfo,7)) And _
					   $iMouseX<=($iScrollBarhX1+DllStructGetData($stScrollBarInfo,8)-1) And _
					   $iMouseY>=DllStructGetData($stScrollBarInfo,3) And _
					   $iMouseY<=(DllStructGetData($stScrollBarInfo,5)-1) And BitAND(DllStructGetData($stScrollBarInfo,10,1),1)<>1 Then
						$_iINT_MOUSE_DOWN_EDIT=2
						ConsoleWrite("Grabbed Horizontal Tab on Edit 2" & @CRLF)
						$_iINT_SCROLL_AXIS=0
					EndIf
				EndIf
			EndIf
		EndIf
		; Previous 'inside control' check - here only for reference. We've evolved!
		#cs
		; Check to see if mouse was clicked inside one of the 2 edit boxes
		$aEdit1ControlPos=ControlGetPos($_hINT_LOD_GUI,"",$_INT_LOD_EDIT1)
		$aEdit2ControlPos=ControlGetPos($_hINT_LOD_GUI,"",$_INT_LOD_EDIT2)
		; Adjust mouse position to match Control coordinates
		$iMouseX-=$aWinRect[0]
		$iMouseY-=$aWinRect[1]
		; Now test coordinates of controls
		If $iMouseX>$aEdit1ControlPos[0] And $iMouseX<=($aEdit1ControlPos[0]+$aEdit1ControlPos[2]-1) And _
			$iMouseY>$aEdit1ControlPos[1] And $iMouseY<=($aEdit1ControlPos[1]+$aEdit1ControlPos[3]-1) Then
			; Flag that a click was sent to this window
			$_iINT_MOUSE_DOWN_EDIT=1
		ElseIf $iMouseX>$aEdit2ControlPos[0] And $iMouseX<=($aEdit2ControlPos[0]+$aEdit2ControlPos[2]-1) And _
			$iMouseY>$aEdit2ControlPos[1] And $iMouseY<=($aEdit2ControlPos[1]+$aEdit2ControlPos[3]-1) Then
			; Flag that a click was sent to this window
			$_iINT_MOUSE_DOWN_EDIT=2
		EndIf
		#ce
	;Else
	;	ConsoleWrite("Primary Mouse Down, but not in this window" & @CRLF)
	EndIf
	Return 0
EndFunc

; ===============================================================================================================================
; - BEGIN MOUSE-HOOK HANDLER CODE -
;
; [Modified from MrCreatoR's _MouseSetOnEvent() UDF)
; ===============================================================================================================================

; GLOBAL MOUSE-HOOK-SPECIFIC VARIABLES [*SPECIFIC to THIS UDF!*]

Global $_hINT_LOD_MOUSECALLBACK	= -1, $_hINT_LOD_MODHANDLE = -1, $_hINT_LOD_MOUSEHOOK = -1
Global $_bINT_LOD_MOUSEHOOKED=False,$_bINT_MOUSE_UP_DETECTED=False,$_bINT_LOD_MOUSEHOOK_CHANGE=False

#cs
typedef struct {
    POINT pt;
    DWORD mouseData;
    DWORD flags;
    DWORD time;
    ULONG_PTR dwExtraInfo;
} MSLLHOOKSTRUCT
#ce

; ===============================================================================================================================
; HOOK CALLBACK FUNCTION [*SPECIFIC to THIS UDF!*]
; ===============================================================================================================================

Func _INT_MOUSEHOOK_HANDLER($nCode, $wParam, $lParam)
	Local $aRet,$iRetCode
	; 1st process next hook as usual (rather than block it - also important for $nCode<0)
	$aRet=DllCall("user32.dll","long","CallNextHookEx","handle",$_hINT_LOD_MOUSEHOOK[0],"int",$nCode,"wparam",$wParam,"lparam",$lParam)
	If @error Then
		ConsoleWrite("Error calling CallNextHookEX!" & @CRLF)
		$iRetCode=0
	Else
		$iRetCode=$aRet[0]
	EndIf
	; $nCode<0 means 'do not process - send to next hook and return with hook's return'
	If $nCode<0 Then Return $iRetCode

	; Now we can process it after next hook called and any <0 events handled
	Local $iEvent = BitAND($wParam, 0xFFFF)

	; Return if the event is not in our detection range
	If $iEvent<512 Or $iEvent>514 Then Return $iRetCode

	; a pointer to the MSLLHOOKSTRUCT is passed in $lParam, which contains valuable info
	Local $stMSLLHookStruct=DllStructCreate("int;int;dword;dword;dword;ulong_ptr",$lParam)
	Local $iMouseX=DllStructGetData($stMSLLHookStruct,1),$iMouseY=DllStructGetData($stMSLLHookStruct,2)

	If ($iEvent=512) Then	; $MOUSE_MOVE_EVENT
		; Currently performing an operation?
		If Not $_bINT_LOD_MOUSEHOOK_CHANGE And Not $_bINT_MOUSE_UP_DETECTED Then

			; Was there an initial click on one of the edit windows's scroll bar tabs? (specifically, vertical?)
			If $_iINT_MOUSE_DOWN_EDIT Then
;				ConsoleWrite("MSLLHookStruct info: X:" & DllStructGetData($stMSLLHookStruct,1) & ", Y:" & DllStructGetData($stMSLLHookStruct,2) & _
;					", MouseData:" & DllStructGetData($stMSLLHookStruct,3) & ", Flags:" & DllStructGetData($stMSLLHookStruct,4) & _
;					", Time:" & DllStructGetData($stMSLLHookStruct,5) & @CRLF)
				; Prevent Mouse-Move events from executing
				$_bINT_LOD_MOUSEHOOK_CHANGE=True
				ConsoleWrite("MouseMoved, mouse coordinates: X:" & $iMouseX & ", Y:" & $iMouseY & @CRLF)
				; Vertical Axis scrollbar? (up/down)
				If $_iINT_SCROLL_AXIS Then
					; Simulate EN_VSCROLL event call (note 1st 2 params are ignored by this program's event handler)
					If $_iINT_MOUSE_DOWN_EDIT=1 Then
						_INT_LOD_WM_COMMAND(0,0,$_INT_LOD_EDIT1+BitShift(0x602,-16),$_hINT_LOD_EDIT1)
					Else
						_INT_LOD_WM_COMMAND(0,0,$_INT_LOD_EDIT2+BitShift(0x602,-16),$_hINT_LOD_EDIT2)
					EndIf
				;Else	; - Horizontal Axis (left/right) - problems with getting proper values
				EndIf
				$_bINT_LOD_MOUSEHOOK_CHANGE=False
			EndIf
		Endif
	ElseIf ($iEvent=513) Then	; $MOUSE_PRIMARYDOWN_EVENT
		_INT_MOUSE_PRIMARYDOWN_HOOK($iMouseX,$iMouseY)
	Elseif ($iEvent=514) Then	; $MOUSE_PRIMARY_UP

		If $_iINT_MOUSE_DOWN_EDIT Then
			; We signal that a mouse-up message will be sent to message loop
			;	We don't process it here because sometimes there's a mouse-move+Up event that seem
			;	 to happen simultaneously? Whatever it is - it causes occassional mismatches unless
			;	 it is handled *after* the mouse up message is processed by the system
			$_bINT_MOUSE_UP_DETECTED=True
		EndIf
#cs
			While $_bINT_LOD_MOUSEHOOK_CHANGE
				Sleep(5)
			WEnd

			; Stop mouse-move changes
			$_bINT_LOD_MOUSEHOOK_CHANGE=True
			; Was there an initial click on one of the edit windows's scroll bar tabs? (specifically, vertical?)
			If $_iINT_MOUSE_DOWN_EDIT Then
				; Prevent Mouse-Move events from executing
				$_bINT_LOD_MOUSEHOOK_CHANGE=True
				ConsoleWrite("Primary Mouse Up, mouse coordinates: X:" & $iMouseX & ", Y:" & $iMouseY & @CRLF)
				; Vertical Axis scrollbar? (up/down)
				If $_iINT_SCROLL_AXIS Then
					; Simulate EN_VSCROLL event call (note 1st 2 params are ignored by this program's event handler)
					If $_iINT_MOUSE_DOWN_EDIT=1 Then
						_INT_LOD_WM_COMMAND(0,0,$_INT_LOD_EDIT1+BitShift(0x602,-16),$_hINT_LOD_EDIT1)
					Else
						_INT_LOD_WM_COMMAND(0,0,$_INT_LOD_EDIT2+BitShift(0x602,-16),$_hINT_LOD_EDIT2)
					EndIf
				;Else	; - Horizontal Axis (left/right) - problems with getting proper values
				EndIf
				$_iINT_MOUSE_DOWN_EDIT=0
				$_bINT_LOD_MOUSEHOOK_CHANGE=False
			EndIf
		EndIf
#ce

#cs
	ElseIf $iEvent=522	Then	; WM_MOUSEWHEEL
		Local $stMSLLHookStruct=DllStructCreate("int;int;dword;dword;dword;ptr",$lParam)
		ConsoleWrite("Mouse Wheel event, delta = " & BitShift(DllStructGetData($stMSLLHookStruct,3),16) & @CRLF)
#ce
	EndIf

	Return $iRetCode	; allow regular processing to commence
EndFunc

; ===============================================================================================================================
; SET MOUSE HOOK [*SPECIFIC to THIS UDF!*]
; ===============================================================================================================================

Func _INT_MOUSE_SETHOOK()
	; Already set?
	If $_bINT_LOD_MOUSEHOOKED Then Return False

	$_hINT_LOD_MOUSECALLBACK=DllCallbackRegister("_INT_MOUSEHOOK_HANDLER", "int", "int;wparam;lparam")
	$_hINT_LOD_MODHANDLE=DllCall("kernel32.dll", "handle", "GetModuleHandle", "ptr", 0)
	If @error Then
		If IsPtr($_hINT_LOD_MOUSECALLBACK) Then DllCallbackFree($_hINT_LOD_MOUSECALLBACK)
		Return SetError(2,0,False)
	EndIf
	$_hINT_LOD_MOUSEHOOK=DllCall("user32.dll", "handle", "SetWindowsHookEx", "int", 14, _	; $WH_MOUSE_LL
		"ptr", DllCallbackGetPtr($_hINT_LOD_MOUSECALLBACK), "handle", $_hINT_LOD_MODHANDLE[0], "dword", 0)
	If @error Then
		If IsPtr($_hINT_LOD_MOUSECALLBACK) Then DllCallbackFree($_hINT_LOD_MOUSECALLBACK)
		Return SetError(2,0,False)
	EndIf
	; Success! Set function name & param
	$_bINT_LOD_MOUSEHOOKED=True
	Return True
EndFunc

; ===============================================================================================================================
; UNSET (release) MOUSE HOOK [*SPECIFIC to THIS UDF!*]
; ===============================================================================================================================

Func _INT_MOUSE_UNSETHOOK()
	; Already released or not set?
	If Not $_bINT_LOD_MOUSEHOOKED Then Return False
	; Reset global func
	$_bINT_LOD_MOUSEHOOKED=False
	; Unhook Event
	If IsArray($_hINT_LOD_MOUSEHOOK) And $_hINT_LOD_MOUSEHOOK[0] > 0 Then
		DllCall("user32.dll", "bool", "UnhookWindowsHookEx", "handle", $_hINT_LOD_MOUSEHOOK[0])
		$_hINT_LOD_MOUSEHOOK[0] = 0
	EndIf

	If IsPtr($_hINT_LOD_MOUSECALLBACK) Then
		DllCallbackFree($_hINT_LOD_MOUSECALLBACK)
		$_hINT_LOD_MOUSECALLBACK = 0
	EndIf
	Return True
EndFunc

#cs
; Also failed to serve its purpose

; GLOBAL MSGPROC VAR'S

Global $_hINT_LOD_MSGPCALLBACK,$_hINT_LOD_MSGP_MODHANDLE,$_hINT_LOD_MSGPHOOK
Global $_bINT_LOD_MSGPHOOKED=False

; ===============================================================================================================================
; MSGPROC HANDLER
; ===============================================================================================================================

Func _INT_MSGPROC_HANDLER($nCode, $wParam, $lParam)
	Local $aRet,$iRetCode
	; 1st process it as usual (rather than block it - also important for $nCode<0)
	$aRet=DllCall("user32.dll","long","CallNextHookEx","ptr",$_hINT_LOD_MSGPHOOK[0],"int",$nCode,"int",$wParam,"int",$lParam)
	If @error Or Not IsArray($aRet) Then
		ConsoleWrite("Error calling CallNextHookEX!" & @CRLF)
		$iRetCode=0
	Else
		$iRetCode=$aRet[0]
	EndIf
	; $nCode<0 means 'do not process - send to next hook and return with hook's return'
	If $nCode<0 Then Return $iRetCode

	ConsoleWrite("MSGPROC Event ID:" & $nCode & @CRLF)

	If $nCode=5 Then	; MSGF_SCROLLBAR 5
		ConsoleWrite("Scrollbar message received!" & @CRLF)
	EndIf
	Return $iRetCode
EndFunc


; ===============================================================================================================================
; SET MSGPROC HOOK
; ===============================================================================================================================

Func _INT_MSGPROC_SETHOOK()
	; Already set?
	If $_bINT_LOD_MSGPHOOKED Then Return False
	$_hINT_LOD_MSGPCALLBACK=DllCallbackRegister("_INT_MSGPROC_HANDLER","int","int;ptr;ptr")
	$_hINT_LOD_MSGP_MODHANDLE=DllCall("kernel32.dll","hwnd","GetModuleHandle","ptr",0)
	If @error Or Not IsArray($_hINT_LOD_MSGP_MODHANDLE) Then
		If IsPtr($_hINT_LOD_MSGPCALLBACK) Then DllCallbackFree($_hINT_LOD_MSGPCALLBACK)
		Return SetError(2,0,False)
	EndIf

	$_hINT_LOD_MSGPHOOK=DllCall("user32.dll","hwnd","SetWindowsHookEx","int",6, _	; WH_MSGFILTER (-1), WH_SYSMSGFILTER 6
		"ptr",DllCallbackGetPtr($_hINT_LOD_MSGPCALLBACK),"hwnd",$_hINT_LOD_MSGP_MODHANDLE[0],"dword",0)
	If @error Or Not IsArray($_hINT_LOD_MSGP_MODHANDLE) Then
		If IsPtr($_hINT_LOD_MSGPCALLBACK) Then DllCallbackFree($_hINT_LOD_MSGPCALLBACK)
		Return SetError(2,0,False)
	EndIf

	; Success! Set True
	$_bINT_LOD_MSGPHOOKED=True
	Return True
EndFunc

; ===============================================================================================================================
; UNSET MSGPROC HOOK
; ===============================================================================================================================

Func _INT_MSGPROC_UNSETHOOK()
	; Already released or not set?
	If Not $_bINT_LOD_MSGPHOOKED Then Return False
	; Reset global func
	$_bINT_LOD_MSGPHOOKED=False
	; Unhook Event
	If IsArray($_hINT_LOD_MSGPHOOK) And $_hINT_LOD_MSGPHOOK[0] > 0 Then
		DllCall("user32.dll", "int", "UnhookWindowsHookEx", "hwnd", $_hINT_LOD_MSGPHOOK[0])
		$_hINT_LOD_MSGPHOOK[0] = 0
	EndIf

	If IsPtr($_hINT_LOD_MSGPCALLBACK) Then
		DllCallbackFree($_hINT_LOD_MSGPCALLBACK)
		$_hINT_LOD_MSGPCALLBACK = 0
	EndIf
	Return True
EndFunc
#ce

#cs
; ACK, this crashed my machine HARD. I'm not sure how to do this properly, or if it can be done:

; GLOBAL CWPRPROC VAR'S

Global $_hINT_LOD_CWPRCALLBACK,$_hINT_LOD_CWPR_MODHANDLE,$_hINT_LOD_CWPRHOOK
Global $_bINT_LOD_CWPRHOOKED=False

; ===============================================================================================================================
; CALLWNDPROCRET HANDLER
; ===============================================================================================================================

Func _INT_CALLWNDPROCRET_HANDLER($nCode, $wParam, $lParam)
	Local $aRet,$iRetCode
	; 1st process it as usual (rather than block it - also important for $nCode<0)
	$aRet=DllCall("user32.dll","long","CallNextHookEx","ptr",$_hINT_LOD_CWPRHOOK[0],"int",$nCode,"int",$wParam,"int",$lParam)
	If @error Or Not IsArray($aRet) Then
		ConsoleWrite("Error calling CallNextHookEX!" & @CRLF)
		$iRetCode=0
	Else
		$iRetCode=$aRet[0]
	EndIf
	; $nCode<0 means 'do not process - send to next hook and return with hook's return'
	If $nCode<0 Then Return $iRetCode

	; a pointer to the CWPRETSTRUCT is passed in $lParam, which contains message & return info
	Local $stCWPRHookStruct=DllStructCreate("lresult;int;int;dword;ptr",$lParam)

	ConsoleWrite("CALLWNDPROCRET nCode:" & $nCode & ", CWPRETSTRUCT: Return value of proc handler:" & DllStructGetData($stCWPRHookStruct,1) & _
		", lParam value:" & DllStructGetData($stCWPRHookStruct,2) & ", wParam value:" & DllStructGetData($stCWPRHookStruct,3) & _
		", message:" & DllStructGetData($stCWPRHookStruct,4) & ",window handle:" & DllStructGetData($stCWPRHookStruct,5) & @CRLF & _
		"Current GUI handle:" & $_hINT_LOD_GUI & ", Edit 1 Handle:" & $_hINT_LOD_EDIT1 & ", Edit 2 handle:" & $_hINT_LOD_EDIT2 & @CRLF)

	; If HC_ACTION (0), this Hook must 'handle' the message. So return 1 as though we did.
	If $nCode=0 Then Return 1

	Return $iRetCode
EndFunc


; ===============================================================================================================================
; SET CALLWNDPROCRET HOOK
; ===============================================================================================================================

Func _INT_CALLWNDPROCRET_SETHOOK()
	; Already set?
	If $_bINT_LOD_CWPRHOOKED Then Return False
	$_hINT_LOD_CWPRCALLBACK=DllCallbackRegister("_INT_CALLWNDPROCRET_HANDLER","lresult","int;int;ptr")
	$_hINT_LOD_CWPR_MODHANDLE=DllCall("kernel32.dll","hwnd","GetModuleHandle","ptr",0)
	If @error Or Not IsArray($_hINT_LOD_CWPR_MODHANDLE) Then
		If IsPtr($_hINT_LOD_CWPRCALLBACK) Then DllCallbackFree($_hINT_LOD_CWPRCALLBACK)
		Return SetError(2,0,False)
	EndIf

	$_hINT_LOD_CWPRHOOK=DllCall("user32.dll","hwnd","SetWindowsHookEx","int",12, _	; WH_CALLWNDPROC 4	; WH_CALLWNDPROCRET 12
		"ptr",DllCallbackGetPtr($_hINT_LOD_CWPRCALLBACK),"hwnd",$_hINT_LOD_CWPR_MODHANDLE[0],"dword",0)
	If @error Or Not IsArray($_hINT_LOD_CWPR_MODHANDLE) Then
		If IsPtr($_hINT_LOD_CWPRCALLBACK) Then DllCallbackFree($_hINT_LOD_CWPRCALLBACK)
		Return SetError(2,0,False)
	EndIf

	; Success! Set True
	$_bINT_LOD_CWPRHOOKED=True
	Return True
EndFunc

; ===============================================================================================================================
; UNSET CALLWNDPROCRET HOOK
; ===============================================================================================================================

Func _INT_CALLWNDPROCRET_UNSETHOOK()
	; Already released or not set?
	If Not $_bINT_LOD_CWPRHOOKED Then Return False
	; Reset global func
	$_bINT_LOD_CWPRHOOKED=False
	; Unhook Event
	If IsArray($_hINT_LOD_CWPRHOOK) And $_hINT_LOD_CWPRHOOK[0] > 0 Then
		DllCall("user32.dll", "int", "UnhookWindowsHookEx", "hwnd", $_hINT_LOD_CWPRHOOK[0])
		$_hINT_LOD_CWPRHOOK[0] = 0
	EndIf

	If IsPtr($_hINT_LOD_CWPRCALLBACK) Then
		DllCallbackFree($_hINT_LOD_CWPRCALLBACK)
		$_hINT_LOD_CWPRCALLBACK = 0
	EndIf
	Return True
EndFunc
#ce

; ===============================================================================================================================
; Func _INT_LOD_FormatAndSetOutput(Const ByRef $sPane1Output,Const ByRef $sPanel2Output,$hControl1ID,$hControl2ID)
;
; This is called by _LinkedOutputDisplay() to # the lines and 'equalize' the # of lines by adding @CRLF's
; NOTE: I set the numbering to be 6 characters. This can be changed based on *actual* number of lines, or
;	whatever you feel is appropriate.
; To calculate # of lines, you'd need to do 'StringReplace($sString,@LF,@LF,0,1)',
;	pull the # of finds from @extended, then do the same for the opposite panel - and figure out which is bigger
;	and THEN convert the number to a string and get the length like: StringLen($iNumber)
;	It's another few steps that'll require passing back-and-forth extra strings..
; ===============================================================================================================================

Func _INT_LOD_FormatAndSetOutput(Const ByRef $sPane1Output,Const ByRef $sPanel2Output,$hControl1ID,$hControl2ID)
	Local $sNumberedOutput1,$sNumberedOutput2
	Local $iPrevEoL,$iEoL,$i,$i2

	; Go through and number each line - Panel 1
	$iPrevEoL=0
	$iEoL=0
	$i=1
	While 1
		$iEoL=StringInStr($sPane1Output,@LF,1,1,$iEoL+1)
		If @error Or Not $iEoL Then ExitLoop
		; Place # before next part
		$sNumberedOutput1&='['&StringRight("00000" & $i,6) & '] ' & StringMid($sPane1Output,$iPrevEoL+1,$iEoL-$iPrevEoL)
		$i+=1
		$iPrevEoL=$iEoL
	WEnd
	; There will always be one last line, or just 1
	$sNumberedOutput1&='['&StringRight("00000" & $i,6) & '] '
	; Last end-of-line not the end of text?
	If $iPrevEoL<>StringLen($sPane1Output) Then $sNumberedOutput1&=StringMid($sPane1Output,$iPrevEoL+1)

	; Go through and number each line - Panel2
	$iPrevEoL=0
	$iEoL=0
	$i2=1
	While 1
		$iEoL=StringInStr($sPanel2Output,@LF,1,1,$iEoL+1)
		If @error Or Not $iEoL Then ExitLoop
		; Place # before next part
		$sNumberedOutput2&='['&StringRight("00000" & $i2,6) & '] ' & StringMid($sPanel2Output,$iPrevEoL+1,$iEoL-$iPrevEoL)
		$i2+=1
		$iPrevEoL=$iEoL
	WEnd
	; There will always be one last line, or just 1
	$sNumberedOutput2&='['&StringRight("00000" & $i2,6) & '] '
	; Last end-of-line not the end of text?
	If $iPrevEoL<>StringLen($sPanel2Output) Then $sNumberedOutput2&=StringMid($sPanel2Output,$iPrevEoL+1)

	; Mismatch in # of lines? Add delta @CRLF's to each line so they equal up
	If ($i>$i2) Then
		For $i=$i-$i2 To 1 Step -1
			$sNumberedOutput2&=@CRLF
		Next
	Else
		For $i=$i2-$i To 1 Step -1
			$sNumberedOutput1&=@CRLF
		Next
	EndIf

	; Put the data in the edit controls
	GUICtrlSetData($hControl1ID,$sNumberedOutput1)
	GUICtrlSetData($hControl2ID,$sNumberedOutput2)
	$sNumberedOutput1=""
	$sNumberedOutput2=""
	Return
EndFunc

; ===============================================================================================================================
; Func _LinkedOutputDisplay(Const ByRef $sPane1Output, Const ByRef $sPanel2Output, _
;												$sWinTitle="Linked Output",$sLabel="Linked Output Display")
;
; Function to display and 'link' together two edit boxes.
;	Currently only works well with vertical scrolling (without drags of the thumb-tab).
;	Also, since WM_VSCROLL and WM_HSCROLL are never sent to the main GUI, it's impossible to track
;	the draggable scroll thing without Mouse-Hook functionality.
;
; $sPanel1Output, $sPanel2Output = respective strings to put in respective output panels
; $sWinTitle = title of window
; $sLabel = label at the top of the 2 outputs
;
; Returns: none
; ===============================================================================================================================

Func _LinkedOutputDisplay(Const ByRef $sPane1Output, Const ByRef $sPanel2Output,$sWinTitle="Linked Output",$sLabel="Linked Output Display")
	Local $iTimer,$nMsg

	; Create GUI. Yeah, 1039x633 is big, but bigger is better in comparing two boxes of text!

	#Region ### START Koda GUI section ###
	$_hINT_LOD_GUI = GUICreate($sWinTitle, 1039, 633, 196, 124, _
		BitOR($WS_MINIMIZEBOX,$WS_SIZEBOX,$WS_THICKFRAME,$WS_SYSMENU,$WS_CAPTION,$WS_POPUP,$WS_POPUPWINDOW,$WS_GROUP,$WS_BORDER,$WS_CLIPSIBLINGS))

	Local $Program_Output_Description = GUICtrlCreateLabel($sLabel, 13, 8, 1015, 20, $SS_CENTER)
	GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
	GUICtrlSetResizing(-1, $GUI_DOCKTOP+$GUI_DOCKHCENTER+$GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)

	$_INT_LOD_EDIT1 = GUICtrlCreateEdit("", 12, 40, 505, 537, BitOR($ES_AUTOVSCROLL,$ES_AUTOHSCROLL,$ES_READONLY,$ES_WANTRETURN,$WS_HSCROLL,$WS_VSCROLL))
	GUICtrlSetResizing(-1, $GUI_DOCKTOP+$GUI_DOCKBOTTOM)

	$_INT_LOD_EDIT2 = GUICtrlCreateEdit("", 523, 40, 505, 537, BitOR($ES_AUTOVSCROLL,$ES_AUTOHSCROLL,$ES_READONLY,$ES_WANTRETURN,$WS_HSCROLL,$WS_VSCROLL))
	GUICtrlSetResizing(-1, $GUI_DOCKTOP+$GUI_DOCKBOTTOM)

	Local $Program_Output_Close = GUICtrlCreateButton("&Close", 443, 584, 161, 41, BitOR($BS_DEFPUSHBUTTON,$BS_CENTER))
	GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
	GUICtrlSetResizing(-1, $GUI_DOCKBOTTOM+$GUI_DOCKHCENTER+$GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)

	;GUISetState(@SW_SHOW,$_hINT_LOD_GUI)	; wait until edit data
	#EndRegion ### END Koda GUI section ###

	; Get Handle to Edit controls (from Control ID's) for quicker global processing
	$_hINT_LOD_EDIT1=GUICtrlGetHandle($_INT_LOD_EDIT1)
	$_hINT_LOD_EDIT2=GUICtrlGetHandle($_INT_LOD_EDIT2)

	; Format text and Set Edit Controls
	_INT_LOD_FormatAndSetOutput($sPane1Output,$sPanel2Output,$_INT_LOD_EDIT1,$_INT_LOD_EDIT2)

	; And finally show
	GUISetState(@SW_SHOW,$_hINT_LOD_GUI)

	; Debug info
	; The scroll range is consistent *UNTIL* data is changed in edit control (resizing has no effect on range)
	Local $aScrollRange1,$aScrollRange2
	$aScrollRange1=_GUIScrollBars_GetScrollRange($_hINT_LOD_EDIT1,1)
	ConsoleWrite("Edit 1 Vertical scroll range: Min:" & $aScrollRange1[0] & ", Max:" & $aScrollRange1[1] & @CRLF)
	$aScrollRange1=_GUIScrollBars_GetScrollRange($_hINT_LOD_EDIT1,0)
	ConsoleWrite("Edit 1 Horizontal scroll range: Min:" & $aScrollRange1[0] & ", Max:" & $aScrollRange1[1] & @CRLF)
	$aScrollRange2=_GUIScrollBars_GetScrollRange($_hINT_LOD_EDIT2,1)
	ConsoleWrite("Edit 2 Vertical scroll range: Min:" & $aScrollRange2[0] & ", Max:" & $aScrollRange2[1] & @CRLF)
	$aScrollRange2=_GUIScrollBars_GetScrollRange($_hINT_LOD_EDIT2,0)
	ConsoleWrite("Edit 2 Horizontal scroll range: Min:" & $aScrollRange2[0] & ", Max:" & $aScrollRange2[1] & @CRLF)

	; Redirect WM_COMMAND messages to my function. This will process every edit control scroll msg
	;	*except* for scrollbar-tab clicks & drags. Neither are received by GuiGetMsg() either.
	GUIRegisterMsg($WM_COMMAND,"_INT_LOD_WM_COMMAND")

	; Mouse Hook (courtesy of MrCreatoR) - catch Primary mouse-down, give it 1 parameter (GUI handle), allow regular processing
	;	[Used for capturing initial click on a scrollbar tab]
	;
	; NOTE: An odd quirk: clicking on the [X] (close button) in upper-right corner of this window will freeze mouse for a while
	_INT_MOUSE_SETHOOK()
	; Original function's call:
	;_MouseSetOnEvent($MOUSE_PRIMARYDOWN_EVENT, "_INT_MOUSE_PRIMARYDOWN_HOOK",$_hINT_LOD_GUI,"",0,-1)

	;_INT_MSGPROC_SETHOOK()

	; Set Adlib function for processing mouse-drags after user clicks a scrollbar tab
;	AdlibEnable("_INT_LOD_ADLIB_FUNC",35)	; every 35ms = ~28 updates/sec.
;	AdlibRegister("_INT_LOD_ADLIB_FUNC",35)

	; NOTE: When Edit controls are scrolled by dragging the scrollbar, NO OTHER processing takes place,
	;	with the exception of 'Hooks', 'Callbacks', and 'Adlib' functions
	;	In other words, no messages are sent to the GUI until AFTER the drag is done (mouse button released)
	;	Therefore, a mouse hook is the only way to detect click, and Adlib to detect drag
	While 1
		$nMsg = GUIGetMsg(1)
		Switch $nMsg[0]
			Case $GUI_EVENT_CLOSE,$Program_Output_Close ; CLOSE Dialog (through 1 of 4 methods)
				ExitLoop
		;	Case $GUI_EVENT_PRIMARYDOWN
			; Worthless test, since	the initial click we want to capture must be on the scrollbar tab,
			;	which isn't sent to the message loop until *after* it has been released.
			;	(Other parts of the scrollbar and inside the edit controls do send messages though,
			;	 but the scrollbar tab click needs to be gotten via the Mouse hook function)
;#cs
		Case $GUI_EVENT_PRIMARYUP
			; Was there an initial click on one of the scrollbar tabs?
			If $_iINT_MOUSE_DOWN_EDIT Then

				; Prevent Adlib function from duplicating this
				;$_bINT_LOD_ADLIB_CHANGE=True
				; Vertical axis (up/down) scrollbar?
				If $_iINT_SCROLL_AXIS Then
					ConsoleWrite("Primary Mouse Up, mouse coordinates: X:" & $nMsg[3] & ", Y:" & $nMsg[4] & @CRLF)
					; Simulate EN_VSCROLL event call (note 1st 2 params are ignored by this program's event handler)
					If $_iINT_MOUSE_DOWN_EDIT=1 Then
						_INT_LOD_WM_COMMAND(0,0,$_INT_LOD_EDIT1+BitShift(0x602,-16),$_hINT_LOD_EDIT1)
					Else
						_INT_LOD_WM_COMMAND(0,0,$_INT_LOD_EDIT2+BitShift(0x602,-16),$_hINT_LOD_EDIT2)
					EndIf
					; Check to see if there's any discrepancies between scroll locations & adjust
					#cs
					Local $iEdit1YIndex=_WinAPI_GetScrollPos($_hINT_LOD_EDIT1,1)
					Local $iEdit2YIndex=_WinAPI_GetScrollPos($_hINT_LOD_EDIT2,1)
					If $iEdit1YIndex<>$iEdit2YIndex Then
						;$_bINT_LOD_MAKINGCHANGE=True
						If $_iINT_MOUSE_DOWN_EDIT=1 Then
							; Send a scroll change to adjacent Edit control using a delta value
							GUICtrlSendMsg($_INT_LOD_EDIT2,0x00B6,0,$iEdit1YIndex-$iEdit2YIndex)	; EM_LINESCROLL [SEND]
						Else	; =2
							; Send a scroll change to adjacent Edit control using a delta value
							GUICtrlSendMsg($_INT_LOD_EDIT1,0x00B6,0,$iEdit2YIndex-$iEdit1YIndex)	; EM_LINESCROLL [SEND]
						EndIf
						;$_bINT_LOD_MAKINGCHANGE=False

					EndIf
					#ce
				;Else	; - Horizontal Axis (left/right) - problems with getting proper values
				EndIf
				; Now reset the scrollbar tab-click variable
				$_iINT_MOUSE_DOWN_EDIT=0
				; Let Mouse Hook track movements again
				$_bINT_MOUSE_UP_DETECTED=False
				; Now that tab-click variable has been reset, re-enable Adlib functionality
				;$_bINT_LOD_ADLIB_CHANGE=False
			EndIf
;#ce
		;Case Else
		EndSwitch
	WEnd
	; Disable Adlib functionality
;	AdlibDisable()
;	AdlibUnRegister("_INT_LOD_ADLIB_FUNC")
	; UnHook Mouse event
	_INT_MOUSE_UNSETHOOK()
	; Original Function's call:
	;_MouseSetOnEvent($MOUSE_PRIMARYDOWN_EVENT) ; Release hook for event

	;_INT_MSGPROC_UNSETHOOK()

	; UnRegister (disable redirect of) Windows Messages
	GUIRegisterMsg($WM_COMMAND,"")
	; Delete GUI
	GUIDelete($_hINT_LOD_GUI)
	Return
EndFunc

; ===============================================================================================================================
; - TEST -
; ===============================================================================================================================
#cs
Func _FilenameFromPath($sPath)
	Return StringMid($sPath,StringInStr($sPath,'\',1,-1)+1)
EndFunc

Func _TestLinkedOutputDisplay()
	Local $sFile1,$sFile2
	While 1
		$sFile1=FileOpenDialog("Choose 1st text file to open in pane 1",@ScriptDir,"Text files (*.txt)|AutoIT Script files (*.au3)",3)
		If @error Then Return False
		If FileGetSize($sFile1)<264000 Then ExitLoop
		If MsgBox(49,"File 1 too big","Please choose a file under 64,000 bytes")<>1 Then Return False
	WEnd
	While 1
		$sFile2=FileOpenDialog("Choose 2nd text file to open in pane 2",@ScriptDir,"Text files (*.txt)|AutoIT Script files (*.au3)",3)
		If @error Then Return False
		If FileGetSize($sFile1)<264000 Then ExitLoop
		If MsgBox(49,"File 2 too big","Please choose a file under 64,000 bytes")<>1 Then Return False
	WEnd
	Local $sBuffer1,$sBuffer2
	$sBuffer1=FileRead($sFile1)
	$sBuffer2=FileRead($sFile2)
	_LinkedOutputDisplay($sBuffer1,$sBuffer2,"File Compare",_FilenameFromPath($sFile1) & " vs. " & _FilenameFromPath($sFile2))
	Return True
EndFunc

_TestLinkedOutputDisplay()
#ce