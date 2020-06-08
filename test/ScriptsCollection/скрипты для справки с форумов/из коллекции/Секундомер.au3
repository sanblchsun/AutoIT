#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Misc.au3>

Opt('GUIOnEventMode', 1)
Global $sIND = 'Stop'
Global $Pause
$hParent = GUICreate('Timer', 160, 40, -1, -1, $WS_POPUP, BitOR($GUI_WS_EX_PARENTDRAG, $WS_EX_TOPMOST))
GUISetState()

$hLabel = GUICtrlCreateLabel('', 2, 2, 156, 36)
GUICtrlSetFont(-1, 20, 1000)
GUICtrlSetColor(-1, 0xc03d3a)
GUICtrlSetBkColor(-1, 0xffffff)
WinSetTrans('Timer', '', 100)

GUISetOnEvent($GUI_EVENT_CLOSE, '_Exit')
GUISetOnEvent($GUI_EVENT_PRIMARYDOWN, '_Move')
GUISetOnEvent($GUI_EVENT_PRIMARYUP, '_Move')
GUISetOnEvent($GUI_EVENT_MOUSEMOVE, '_Move')
HotKeySet('^+p', '_TogglePause'); Ctrl+Shift+P

$iStart = TimerInit()
While 1
    $iElapsed = Int(TimerDiff($iStart))
	$iHour = Int($iElapsed/(1000*60*60))
	$iMin = Int(($iElapsed - $iHour*1000*60*60)/(1000*60))
	$iSec = Int(($iElapsed - $iHour*1000*60*60 - $iMin*1000*60)/1000)
	$iMsec = Int($iElapsed - $iHour*1000*60*60 - $iMin*1000*60 - $iSec*1000)
	$sLabel = $iHour & ":" & $iMin & ":" & $iSec & "." & $iMsec
    GUICtrlSetData($hLabel, $sLabel)
    Sleep(90)
WEnd
Func _Exit()
    Exit
EndFunc

Func _Move()
    Switch @GUI_CtrlID
        Case $GUI_EVENT_PRIMARYDOWN
            Global $aWCoord_B = WinGetPos('Timer')
            Global $aMCoord_B = MouseGetPos()
            Global $ixWCoord_B = $aWCoord_B[0]
            Global $iyWCoord_B = $aWCoord_B[1]
            Global $ixMCoord_B = $aMCoord_B[0]
            Global $iyMCoord_B = $aMCoord_B[1]
            Global $ixDelta = $ixMCoord_B - $ixWCoord_B
            Global $iyDelta = $iyMCoord_B - $iyWCoord_B
            If ($ixDelta <= 170 AND $iyDelta <= 40) Then $sIND = 'Move'
        Case $GUI_EVENT_MOUSEMOVE
            If $sIND = 'Move' Then
                $aMCoord = MouseGetPos()
                $ixMCoord = $aMCoord[0]
                $iyMCoord = $aMCoord[1]
                $ixWCoord = $ixMCoord - $ixDelta
                $iyWCoord = $iyMCoord - $iyDelta
                WinMove('Timer', '', $ixWCoord, $iyWCoord)
            EndIf
        Case $GUI_EVENT_PRIMARYUP
            $sIND = 'Stop'
    EndSwitch
EndFunc

Func _TogglePause()
	$Pause = NOT $Pause
	While $Pause
		Sleep(100)
	WEnd
EndFunc
