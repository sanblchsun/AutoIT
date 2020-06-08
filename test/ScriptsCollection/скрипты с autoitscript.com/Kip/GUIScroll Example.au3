;http://www.autoitscript.com/forum/index.php?showtopic=79684

#include<WindowsConstants.au3>
#include<GuiconstantsEx.au3>
#Include <GUIScroll.au3>

$GUI = GUICreate("Test",400,300, -1, -1, _
BitOR($WS_MAXIMIZEBOX, $WS_SIZEBOX, $WS_THICKFRAME, $WS_OVERLAPPEDWINDOW, $WS_TILEDWINDOW), _
$WS_EX_ACCEPTFILES); The visible part of the window is 300 pixels high
    
    Scrollbar_Create($GUI, $SB_VERT, 700); But the actual window is 700 pixels high
    
    Scrollbar_Step(20, $GUI, $SB_VERT); Scrolls per 20 pixels. If not set the default is 1 (smooth scrolling)
    
    GUICtrlCreateButton("hello",50,200,120,23)
    
GUISetState()



While 1
    
    $iScrollPos = Scrollbar_GetPos($GUI, $SB_VERT)
    
; MaxScrollPos = ActualWindowHeight - VisibleWindowHeight
    
; So in this case that would be:
; MaxScrollPos = 700 - 300
    
; $iScrollPos can only be a value between 0 and 400 (this is just in this script)
    
    ConsoleWrite($iScrollPos&@CRLF)
    
    If GUIGetMsg() = $GUI_EVENT_CLOSE Then Exit
WEnd