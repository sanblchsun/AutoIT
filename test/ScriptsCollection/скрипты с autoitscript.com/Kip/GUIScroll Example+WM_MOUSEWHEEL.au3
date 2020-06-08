#include<WindowsConstants.au3>
#include<GuiconstantsEx.au3>
#include <WinAPI.au3>
#include "GUIScroll.au3"

If Not IsDeclared('WM_MOUSEWHEEL') Then $WM_MOUSEWHEEL = 0x020A
Global Const $iStep = 20

$GUI = GUICreate("Test",400,300); The visible part of the window is 300 pixels high
    
    
For $i = 1 To 20
    For $j = 1 To 20
        GUICtrlCreateButton(($i-1)*20+$j, 10+85*($i-1), 10+30*($j-1), 75, 25)
    Next
Next

Scrollbar_Create($GUI, $SB_HORZ, 85*19+75)
Scrollbar_Step($iStep, $GUI, $SB_HORZ)
Scrollbar_Create($GUI, $SB_VERT, 30*19+25)
Scrollbar_Step($iStep, $GUI, $SB_VERT)

GUISetState()
GUIRegisterMsg($WM_MOUSEWHEEL, 'WM_MOUSEWHEEL')



While 1
    
    $iScrollPos = Scrollbar_GetPos($GUI, $SB_VERT)
    
 ; MaxScrollPos = ActualWindowHeight - VisibleWindowHeight
    
 ; So in this case that would be:
 ; MaxScrollPos = 700 - 300
    
 ; $iScrollPos can only be a value between 0 and 400 (this is just in this script)
    
    If GUIGetMsg() = $GUI_EVENT_CLOSE Then Exit
WEnd

Func WM_MOUSEWHEEL($hWnd, $iMsg, $iwParam, $ilParam)
    Local $iDelta = BitShift($iwParam, 16)

    If $iDelta > 0 Then
        _SendMessage($GUI, $WM_VSCROLL, $SB_LINEUP)
    Else
        _SendMessage($GUI, $WM_VSCROLL, $SB_LINEDOWN)
    EndIf
    
    Return 'GUI_RUNDEFMSG'
EndFunc