#include <GUIConstantsEx.au3>
#include <EditConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Timers.au3>
;

Global $iScroll_Pos = -160
Global $iScroll_Speed = 1
Global $iStereo_Effect_On = False
Global $iWinMove_Effect_On = False

$sScrollText = 'A long time ago in a galaxy' & @CRLF & _
'far, far away...' & @CRLF & @CRLF & _
'It is a period of civil war.' & @CRLF & _
'Rebel spaceships, striking' & @CRLF & _
'from a hidden base, have won' & @CRLF & _
'their first victory against' & @CRLF & _
'the evil Galactic Empire.' & @CRLF & @CRLF & _
'During the battle, Rebel' & @CRLF & _
'spies managed to steal secret' & @CRLF & _
'plans to the Empire''s' & @CRLF & _
'ultimate weapon, the DEATH' & @CRLF & _
'STAR, an armored space' & @CRLF & _
'station with enough power to' & @CRLF & _
'destroy an entire planet.' & @CRLF & @CRLF & _
'Pursued by the Empire''s' & @CRLF & _
'sinister agents, Princess' & @CRLF & _
'Leia races home aboard her' & @CRLF & _
'starship, custodian of the' & @CRLF & _
'stolen plans that can save her' & @CRLF & _
'people and restore' & @CRLF & _
'freedom to the galaxy...'

#Region Parent GUI
$hParent_GUI = GUICreate('Scrolling label', 290, 250)

$nStereoEffect_CheckBox = GUICtrlCreateCheckbox("Enable Stereo Effect", 20, 5, -1, 15)
$nWinMoveEffect_CheckBox = GUICtrlCreateCheckbox("Enable WinMove Effect", 20, 25, -1, 15)

GUICtrlCreateLabel("Scroll Speed:", 20, 45)
$nScrollSpeed_Input = GUICtrlCreateInput("1", 95, 44, 40, 18, BitOR($ES_LEFT, $ES_AUTOHSCROLL, $ES_READONLY))
$nScrollSpeed_UpDown = GUICtrlCreateUpdown(-1)
GUICtrlSetLimit(-1, 10, 1)

GUICtrlCreateLabel('Scrolling label example:', 90, 65, -1, 15)

GUISetState(@SW_SHOW, $hParent_GUI)
#EndRegion Parent GUI
;

#Region Child GUI
$hChild_GUI = GUICreate('', 250, 160, 20, 80, $WS_CHILD, $WS_EX_CLIENTEDGE, $hParent_GUI)
GUISetBkColor(0)

$nLabel = GUICtrlCreateLabel($sScrollText, 0, 160, 250, 510, $SS_CENTER)
GUICtrlSetFont(-1, 11, 800)
GUICtrlSetColor(-1, 0xFFD800)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

GUISetState(@SW_SHOW, $hChild_GUI)
#EndRegion Child GUI
;

$iTimerID = _Timer_SetTimer($hParent_GUI, 40, "_ScrollText_Proc")

While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            _Timer_KillTimer($hParent_GUI, $iTimerID)
            Exit
        Case $nStereoEffect_CheckBox
            $iStereo_Effect_On = (GUICtrlRead($nStereoEffect_CheckBox) = $GUI_CHECKED)
        Case $nWinMoveEffect_CheckBox
            $iWinMove_Effect_On = (GUICtrlRead($nWinMoveEffect_CheckBox) = $GUI_CHECKED)
        Case $nScrollSpeed_UpDown
            $iScroll_Speed = GUICtrlRead($nScrollSpeed_Input)
    EndSwitch
WEnd

Func _ScrollText_Proc($hWnd, $uiMsg, $idEvent, $dwTime)
    Local $aParent_Pos = WinGetPos($hParent_GUI)
    
    $iScroll_Pos += $iScroll_Speed
    ControlMove($hChild_GUI, "", $nLabel, 0, -$iScroll_Pos)
    
    If $iStereo_Effect_On Then
        WinMove($hParent_GUI, "", $aParent_Pos[0]-1, $aParent_Pos[1]+1)
        WinMove($hParent_GUI, "", $aParent_Pos[0], $aParent_Pos[1])
    EndIf
    
    If $iWinMove_Effect_On Then WinMove($hParent_GUI, "", $aParent_Pos[0], $aParent_Pos[1]+$iScroll_Speed)
    
    If $iScroll_Pos > 480 Then $iScroll_Pos = -160
EndFunc
 