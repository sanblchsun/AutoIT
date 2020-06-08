; Achilles
; http://www.autoitscript.com/forum/topic/107358-another-binary-clock
#noTrayIcon
#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>

Opt('GUIOnEventMode', 1)

Global Const $WIDTH = @DesktopWidth, $HEIGHT = @DesktopHeight + 30
Global Const $X_CONST = $WIDTH / 10, $Y_CONST = $HEIGHT / 6, $SIZE = $X_CONST * .85
;~ Global Const $bkColor = 0x000000, $active = 0x00FF00, $inactive = 0x000F00
;~ Global Const $bkColor = 0x000000, $active = 0xFF0000, $inactive = 0x0F0000
Global Const $bkColor = 0x000000, $active = 0x0000FF, $inactive = 0x000000F
Global $ctrls[4][6]

_CreateGUI()

_SetClock()
AdlibRegister('_SetClock', 200) 

While 1 
    Sleep(200)
WEnd

Func _CreateGUI()
    $mainGUI = GUICreate('', $WIDTH, $HEIGHT, -1, -1, $WS_POPUPWINDOW, BitOR($WS_EX_TOPMOST, $WS_EX_TOOLWINDOW))
        GUISetOnEvent($GUI_EVENT_CLOSE, '_Exit')
        GUISetBkColor($bkColor) 

    Local $colIndices[6] = [1, 2, 4, 5, 7, 8]
    Local $rowLimits[6] = [3, 1, 2, 1, 2, 1]

    For $i = 0 to 5
        For $j = $rowLimits[$i] to 4 
            $ctrls[$j - 1][$i] = GUICtrlCreateLabel('', $X_CONST * $colIndices[$i], $Y_CONST * $j, $SIZE, $SIZE) 
        Next 
    Next    
    GUISetState()
EndFunc 

Func _SetClock()  
    $time = StringSplit(@HOUR & @MIN & @SEC, '') 
    For $i = 0 to 5
        $temp = _GetResult(Int($time[$i + 1]))
        For $j = 0 to 3
            If $temp[$j] = 1 then 
                GUICtrlSetBkColor($ctrls[$j][$i], $active)
            Else 
                GUICtrlSetBkColor($ctrls[$j][$i], $inactive)
            EndIf 
        Next 
    Next 
EndFunc 

Func _GetResult($n) ; n is between 0 and 9
    Local $ret[4] = [0, 0, 0, 0] ; 0 is 8, 1, 4..
    If BitAND($n, 8) then $ret[0] = 1  
    If BitAnd($n, 4) then $ret[1] = 1 
    If BitAND($n, 2) then $ret[2] = 1
    If BitAND($n, 1) then $ret[3] = 1
    Return $ret 
EndFunc 

Func _Exit()
    Exit 
EndFunc