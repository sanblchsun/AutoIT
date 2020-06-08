#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>

Opt('GUIOnEventMode', 1)

#region - Variable setup

Global $iSizerHeight = 5
Global $iSizerTopLimit = 40
Global $iSizerBottomLimit = 35 + 20

;~ NOT Constants - These need to be changeable
Global $IGNORE_WM_MOVE = False
Global $IGNORE_WM_PAINT = False
#endregion

#region - GUI construction
$gui_Main = GUICreate('', 400, 300, -1, -1, $WS_OVERLAPPEDWINDOW, $WS_EX_ACCEPTFILES)
    GUISetOnEvent($GUI_EVENT_CLOSE, '_Generic')

$lb_ContentFrame = GUICtrlCreateLabel('ContentFrame', 0, 0, 400, 180, $SS_SUNKEN)
    GUICtrlSetResizing(-1, $GUI_DOCKBORDERS)
    GUICtrlSetState(-1, $GUI_HIDE)

$lb_SizerFrame = GUICtrlCreateLabel('SizerFrame', 0, 180, 400, $iSizerHeight, $SS_SUNKEN)
    GUICtrlSetResizing(-1, $GUI_DOCKSTATEBAR+$GUI_DOCKRIGHT+$GUI_DOCKLEFT)
    GUICtrlSetState(-1, $GUI_HIDE)

$lb_ConsoleFrame = GUICtrlCreateLabel('ConsoleFrame', 0, 185, 400, 95, $SS_SUNKEN)
    GUICtrlSetResizing(-1, $GUI_DOCKSTATEBAR+$GUI_DOCKRIGHT+$GUI_DOCKLEFT)
    GUICtrlSetState(-1, $GUI_HIDE)

$lb_Status = GUICtrlCreateLabel('', 0, 280, 400, 20, BitOR($SS_CENTERIMAGE, $SS_SUNKEN))
    GUICtrlSetResizing(-1, $GUI_DOCKSTATEBAR+$GUI_DOCKRIGHT+$GUI_DOCKLEFT)
#endregion

#region - Sub Frames
$gui_Content = GUICreate('ContentFrameWin', 1, 1, 0, 0, $WS_CHILD, Default, $gui_Main)
    GUISetOnEvent($GUI_EVENT_CLOSE, '_Generic')
    GUISetOnEvent($GUI_EVENT_DROPPED, '_Generic')
    $ed_Content = GUICtrlCreateEdit('', 0, 0, 1, 1)
        GUICtrlSetResizing(-1, $GUI_DOCKBORDERS)
GUISetState()

$gui_Sizer = GUICreate('SizerFrameWin', 400, $iSizerHeight, 0, 180, $WS_CHILD, Default, $gui_Main)
    GUISetCursor(11, 1)
    GUICtrlCreateLabel('', -5, 0, 410, $iSizerHeight, Default, $GUI_WS_EX_PARENTDRAG)
        GUICtrlSetResizing(-1, $GUI_DOCKBORDERS)
GUISetState()

$gui_Console = GUICreate('ConsoleFrameWin', 400, 90, 0, 190, $WS_CHILD, Default, $gui_Main)
    GUISetOnEvent($GUI_EVENT_CLOSE, '_Generic')
    $ed_Console = GUICtrlCreateEdit('', 0, 0, 400, 90)
        GUICtrlSetResizing(-1, $GUI_DOCKBORDERS)
GUISetState()
#endregion <- Sub frames

GUIRegisterMsg($WM_SIZE, 'WM_SIZE')
GUIRegisterMsg($WM_MOVE, 'WM_MOVE')
GUIRegisterMsg($WM_PAINT, 'WM_PAINT')

GUISetState(@SW_SHOW, $gui_Main)

#region - Program idle
While 1
    Sleep(100)
WEnd
#endregion

;~ GUI Functions -=> -=> -=> -=> -=> -=> -=> -=> -=> -=> -=> -=> -=> -=> -=> -=> -=> -=> -=> -=>

Func _Generic()
    Switch @GUI_CtrlId
        Case $GUI_EVENT_CLOSE
            Exit 2
    EndSwitch
EndFunc

;~ Functions -=> -=> -=> -=> -=> -=> -=> -=> -=> -=> -=> -=> -=> -=> -=> -=> -=> -=> -=> -=>

Func _WinPosFromControl($hCtrlWnd, $iCtrl, $hMoveWnd)
    Local $aControl = ControlGetPos($hCtrlWnd, '', $iCtrl)
    WinMove($hMoveWnd, '', $aControl[0], $aControl[1], $aControl[2], $aControl[3])
EndFunc

;~ Window Message Functions -=> -=> -=> -=> -=> -=> -=> -=> -=> -=> -=> -=> -=> -=> -=> -=> -=> -=> -=> -=>

Func WM_SIZE($hWnd, $iMsg, $iWParam, $iLParam)
    If $hWnd = $gui_Main Then
        If Not BitAND(WinGetState($gui_Main), 16 + 32) Then
            $aSaveWinPos = WinGetPos($gui_Main)
        EndIf
    EndIf
    Return $GUI_RUNDEFMSG
EndFunc

Func WM_MOVE($hWnd, $iMsg, $iWParam, $iLParam)
    If $IGNORE_WM_MOVE Then Return $GUI_RUNDEFMSG

    If $hWnd = $gui_Main Then
        If Not BitAND(WinGetState($gui_Main), 16 + 32) Then
            $aSaveWinPos = WinGetPos($gui_Main)
        EndIf
    ElseIf $hWnd = $gui_Sizer Then
        $aClient = WinGetClientSize($gui_Main)
        $iYPos = BitShift($iLParam, 16)
        $iTopEdge = $iSizerTopLimit
        $iBottomEdge = $aClient[1] - $iSizerBottomLimit - 10 ; -10 to account for the height of the sizebar
        If $iYPos <= $iTopEdge Then $iYPos = $iTopEdge
        If $iYPos >= $iBottomEdge Then $iYPos = $iBottomEdge

        WinMove($gui_Sizer, '', 0, $iYPos, $aClient[0], $iSizerHeight)
        GUICtrlSetPos($lb_SizerFrame, 0, $iYPos, $aClient[0], $iSizerHeight)
        GUICtrlSetPos($lb_ContentFrame, 0, 0, $aClient[0], $iYPos)
        GUICtrlSetPos($lb_ConsoleFrame, 0, $iYPos + $iSizerHeight, $aClient[0], $aClient[1] - 20 - $iSizerHeight - $iYPos)
    EndIf
EndFunc

Func WM_PAINT($hWnd = 0, $iMsg = 0)
    If $IGNORE_WM_PAINT Then Return $GUI_RUNDEFMSG
    
    If $hWnd = $gui_Main Then
        _WinPosFromControl($gui_Main, $lb_ContentFrame, $gui_Content)
        _WinPosFromControl($gui_Main, $lb_SizerFrame, $gui_Sizer)
        _WinPosFromControl($gui_Main, $lb_ConsoleFrame, $gui_Console)
    EndIf
EndFunc
