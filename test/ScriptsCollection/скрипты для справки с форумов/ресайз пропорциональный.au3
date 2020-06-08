#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiListView.au3>
#include <GuiImageList.au3>
#include <winapi.au3>
#include <FontConstants.au3>

; Global Const $WS_EX_COMPOSITED = 0x2000000
Global Const $WMSZ_BOTTOM = 6
Global Const $WMSZ_BOTTOMLEFT = 7
Global Const $WMSZ_BOTTOMRIGHT = 8
Global Const $WMSZ_LEFT = 1
Global Const $WMSZ_RIGHT = 2
Global Const $WMSZ_TOP = 3
Global Const $WMSZ_TOPLEFT = 4
Global Const $WMSZ_TOPRIGHT = 5

Global $hFont = _WinAPI_CreateFont(12, 6, 0, 0, $FW_NORMAL, False, False, False, $DEFAULT_CHARSET, $OUT_DEFAULT_PRECIS, $CLIP_DEFAULT_PRECIS, $DEFAULT_QUALITY, 0, 'Arial')


Opt("GUIResizeMode", $GUI_DOCKAUTO)
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Form1", 422, 437, 193, 125, BitOR($WS_MINIMIZEBOX, $WS_SIZEBOX, $WS_THICKFRAME, $WS_SYSMENU, $WS_CAPTION, $WS_POPUP, $WS_POPUPWINDOW, $WS_GROUP, $WS_BORDER, $WS_CLIPSIBLINGS));, $WS_EX_COMPOSITED)
$Edit1 = GUICtrlCreateEdit("Line 1" & @CRLF & "line 2", 56, 24, 345, 145)
$Button1 = GUICtrlCreateButton("Button1", 112, 200, 75, 25, 0)
$startBtnFontSize = 8
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

$hListView = _GUICtrlListView_Create($Form1, "", 12, 250, 394, 168)
_GUICtrlListView_SetExtendedListViewStyle($hListView, BitOR($LVS_EX_GRIDLINES, $LVS_EX_FULLROWSELECT, $LVS_EX_SUBITEMIMAGES))
;GUISetState()
_WinAPI_SetFont($hListView, $hFont, True)
;GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

; Add columns
_GUICtrlListView_InsertColumn($hListView, 0, "Column 1", 100)
_GUICtrlListView_InsertColumn($hListView, 1, "Column 2", 100)
_GUICtrlListView_InsertColumn($hListView, 2, "Column 3", 100)

; Add items
_GUICtrlListView_AddItem($hListView, "Row 1: Col 1", 0)
_GUICtrlListView_AddSubItem($hListView, 0, "Row 1: Col 2", 1)
_GUICtrlListView_AddSubItem($hListView, 0, "Row 1: Col 3", 2)
_GUICtrlListView_AddItem($hListView, "Row 2: Col 1", 1)
_GUICtrlListView_AddSubItem($hListView, 1, "Row 2: Col 2", 1)
_GUICtrlListView_AddItem($hListView, "Row 3: Col 1", 2)




$gp = WinGetPos($Form1)
Global $HtoW = $gp[3] / $gp[2]
$stGui = WinGetClientSize($Form1)
GUIRegisterMsg($WM_SIZE, "SetFontSizes")
GUIRegisterMsg($WM_SIZING, "SetAspect")

While 1
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case $GUI_EVENT_CLOSE
            Exit
    EndSwitch
WEnd


Func SetFontSizes();might be better to register this for wm_exitsizemove
    $newgui = WinGetClientSize($Form1)
    GUICtrlSetFont($Button1, $startBtnFontSize * $newgui[1] / $stGui[1])
    GUICtrlSetFont($Edit1, $startBtnFontSize * $newgui[1] / $stGui[1])
    
    
;adjust the listview?
    $newLVwid = 394 * $newgui[1] / $stGui[1]
    
    $newLVht = 168 * $newgui[1] / $stGui[1]
    _WinAPI_DeleteObject($hFont)
    $hFont = _WinAPI_CreateFont(12 * $newgui[1] / $stGui[1], 6* $newgui[1] / $stGui[1], 0, 0, $FW_NORMAL, False, False, False, $DEFAULT_CHARSET, $OUT_DEFAULT_PRECIS, $CLIP_DEFAULT_PRECIS, $DEFAULT_QUALITY, 0, 'Arial')
  ;adjust the col widths
    _GUICtrlListView_SetColumnWidth($hListView,0,100 * $newgui[1] / $stGui[1])
    _GUICtrlListView_SetColumnWidth($hListView,1,100 * $newgui[1] / $stGui[1])
    _GUICtrlListView_SetColumnWidth($hListView,2,100 * $newgui[1] / $stGui[1])
    
    
   ;_WinAPI_SetFont($hListView, $hFont, True)
    _GUICtrlListView_SetFont($hListView, $hFont)
    ControlMove($Form1, "", "[CLASS:SysListView32;INSTANCE:1]", 12, (418 * $newgui[1] / $stGui[1]) - $newLVht, $newLVwid, $newLVht)
    
EndFunc ;==>SetFontSizes

Func SetAspect($hWnd, $iMsg, $wparam, $lparam)
    Local $sRect = DllStructCreate("Int[4]", $lparam)
    Local $left = DllStructGetData($sRect, 1, 1)
    Local $top = DllStructGetData($sRect, 1, 2)
    Local $Right = DllStructGetData($sRect, 1, 3)
    Local $bottom = DllStructGetData($sRect, 1, 4)

    Switch $wparam;drag side or corner


        Case $WMSZ_LEFT, $WMSZ_RIGHT
            $newHt = ($Right - $left) * $HtoW
            DllStructSetData($sRect, 1, DllStructGetData($sRect, 1, 2) + $newHt, 4)
        Case Else
            $newWid = ($bottom - $top) / $HtoW
            DllStructSetData($sRect, 1, DllStructGetData($sRect, 1, 1) + $newWid, 3)
    EndSwitch

    

;Return 1
EndFunc ;==>SetAspect


; =========================================================================================
; Name...........: _GUICtrlListView_SetFont
; Description ...: Set font for a list-view controls items and header text
; Syntax.........: _GUICtrlListView_SetFont($hWnd, $hFontLV, $hFontHD = 0)
; Parameters ....: $hWnd        - Handle to the control
;                 $hFontLV   - Handle to font
;                 $hFontHD   - Handle to header font (Optional)
; Return values .: Success    - True
;                 Failure     - False
; Author ........: rover
; Remarks .......: Minimum OS Windows XP
;                 Use optional header font parameter for a different font/size of header
;                 Resizes header with font change
; =========================================================================================
Func _GUICtrlListView_SetFont($hWnd, $hFontLV, $hFontHD = 0)
    If $Debug_LV Then _GUICtrlListView_ValidateClassName($hWnd)
    If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
    Local $aReturn, $hHeader, $hDLL
    
    $hHeader = HWnd(_GUICtrlListView_GetHeader($hWnd)); get handle to header control
    
    If Not IsHWnd($hWnd) Or Not IsPtr($hFontLV) Or Not IsHWnd($hHeader) Then Return SetError(1, 0, False)
    
    _SendMessage($hWnd, $__LISTVIEWCONSTANT_WM_SETREDRAW, 0); disable listview repainting

    $hDLL = DllOpen("UxTheme.dll")
; turn off theme for header control to enable header autosizing
    $aReturn = DllCall($hDLL, "int", "SetWindowTheme", "hwnd", $hHeader, "wstr", "", "wstr", "")
    If @error Or $aReturn[0] Then
        DllClose($hDLL)
        Return SetError(2, 0, False)
    EndIf
    
    If IsPtr($hFontHD) Then; set font for items and if available separate font for header
        _SendMessage($hWnd, $__LISTVIEWCONSTANT_WM_SETFONT, $hFontLV, True, 0, "hwnd")
        _SendMessage($hHeader, $__LISTVIEWCONSTANT_WM_SETFONT, $hFontHD, True, 0, "hwnd")
    Else; set same font for header and items
    ; resizing header down to a smaller font size causes listview repaint problems, so repainting is enabled
        _SendMessage($hWnd, $__LISTVIEWCONSTANT_WM_SETREDRAW, 1); enable repainting
        _SendMessage($hWnd, $__LISTVIEWCONSTANT_WM_SETFONT, $hFontLV, True, 0, "hwnd")
    EndIf
    
; restore control theme painting
    $aReturn = DllCall($hDLL, "int", "SetWindowTheme", "hwnd", $hHeader, "ptr", 0, "ptr", 0)
    If @error Or $aReturn[0] Then
        DllClose($hDLL)
        Return SetError(3, 0, False)
    EndIf
    DllClose($hDLL)
    
    _SendMessage($hWnd, $__LISTVIEWCONSTANT_WM_SETREDRAW, 1); enable listview repainting
    _WinAPI_RedrawWindow($hWnd, 0, 0, $RDW_INVALIDATE)      ; repaint listview
    Return SetError(0, 0, $aReturn[0] <> 1)
EndFunc  ;==>_GUICtrlListView_SetFont