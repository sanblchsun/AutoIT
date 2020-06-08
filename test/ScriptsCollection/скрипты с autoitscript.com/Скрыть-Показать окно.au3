; http://www.autoitscript.com/forum/topic/94403-winhide/

#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=ICON.ico
#AutoIt3Wrapper_Res_LegalCopyright=Cody Barrett
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Misc.au3>
#include <ButtonConstants.au3>
#include <StaticConstants.au3>
Opt ('GUIoneventmode',1)

Global $LastLabel = 0, $LastHoveredControl = -1, $hDLL = DllOpen('user32.dll'), $bOn = False

$GUI = GUICreate (@ScriptName, 300, 100, -1, -1, -2138570616)
GUISetBkColor (0x000000, $GUI)
GUISetOnEvent ($GUI_EVENT_CLOSE, '_Exit_' )
GUICtrlCreateLabel (@ScriptName, 20, 0, 280, 20, $SS_CENTER )
GUICtrlSetBkColor (-1, 0x2e2e2e)
GUICtrlSetColor (-1, 0xFFFFA6)
GUICtrlSetFont (-1, 10, 700, '', 'Trebuchet MS')
GUICtrlSetOnEvent (-1, '_Win_Move_')
$bExit = GUICtrlCreateLabel ('', 0, 0, 20, 20)
GUICtrlSetBkColor (-1, 0x2e2e2e)
GUICtrlSetState (-1, $GUI_DISABLE)
$Exit = GUICtrlCreateLabel ('x', 1, 1, 18, 18, $SS_CENTER )
GUICtrlSetOnEvent (-1, '_Exit_')
GUICtrlSetBkColor (-1, 0x2e2e2e)
GUICtrlSetColor (-1, 0xFFFFA6)
GUICtrlSetFont (-1, 10, 700, '', 'Trebuchet MS')
$Input = GUICtrlCreateInput ('Win title...', 10, 30, 200, 20)
GUICtrlSetFont (-1, 10, 700, '', 'Trebuchet MS')
$Toggle = GUICtrlCreateLabel ('CTRL - [OFF]', 220, 30, 70, 20)
GUICtrlSetColor (-1, 0xFFFFA6)
GUICtrlSetFont (-1, 8, 700, '', 'Trebuchet MS')
$bHide = GUICtrlCreateLabel ('', 10, 60, 135, 20, $SS_CENTER )
GUICtrlSetBkColor (-1, 0x2e2e2e)
GUICtrlSetState (-1, $GUI_DISABLE)
$Hide = GUICtrlCreateLabel ('Hide Window', 11, 61, 133, 18, $SS_CENTER )
GUICtrlSetBkColor (-1, 0x2e2e2e)
GUICtrlSetColor (-1, 0xFFFFA6)
GUICtrlSetFont (-1, 10, 700, '', 'Trebuchet MS')
GUICtrlSetOnEvent (-1, '_Hide_')
$bUnHide = GUICtrlCreateLabel ('', 150, 60, 135, 20, $SS_CENTER )
GUICtrlSetBkColor (-1, 0x2e2e2e)
GUICtrlSetState (-1, $GUI_DISABLE)
$UnHide = GUICtrlCreateLabel ('UnHide Window', 151, 61, 133, 18, $SS_CENTER )
GUICtrlSetBkColor (-1, 0x2e2e2e)
GUICtrlSetColor (-1, 0xFFFFA6)
GUICtrlSetFont (-1, 10, 700, '', 'Trebuchet MS')
GUICtrlSetOnEvent (-1, '_UnHide_')
WinSetOnTop ($GUI,'', 1)
GUISetState ()
$Status = 'Visible'

While 1
    $m = GUIGetCursorInfo ($GUI)
    If $m[4] <> $LastHoveredControl Then
        $LastHoveredControl = $m[4]
        If $m[4] = $Exit Then
            If $LastLabel Then GUICtrlSetBkColor ($LastLabel, 0x2e2e2e)
            GUICtrlSetBkColor ($bExit, 0xFFFFA6)
            $LastLabel = $bExit
            $bOn = True
        ElseIf $m[4] = $Hide Then
            If $LastLabel Then GUICtrlSetBkColor ($LastLabel, 0x2e2e2e)
            GUICtrlSetBkColor ($bhide, 0xFFFFA6)
            $LastLabel = $bHide
            $bOn = True
        ElseIf $m[4] = $UnHide Then
            If $LastLabel Then GUICtrlSetBkColor ($LastLabel, 0x2e2e2e)
            GUICtrlSetBkColor ($bUnhide, 0xFFFFA6)
            $LastLabel = $bUnHide
            $bOn = True
        ElseIf $bOn Then
            If $LastLabel Then GUICtrlSetBkColor ($LastLabel, 0x2e2e2e)
            $LastLabel = 0
            $bOn = False
        EndIf
    EndIf
    If _IsPressed ('11', $hDLL) Then
        If GUICtrlRead ($Toggle) = 'CTRL - [OFF]' Then GUICtrlSetData ($Toggle, 'CTRL - [ON]')
        If $Status <> 'Hidden' Then
            While _IsPressed('11', $hDLL)
                $m = WinGetTitle ('[active]')
                If $m <> GUICtrlRead($Input) Then GUICtrlSetData ($Input, $m)
                Sleep (100)
            WEnd
        EndIf
        If GUICtrlRead ($Toggle) = 'CTRL - [ON]' Then GUICtrlSetData ($Toggle, 'CTRL - [OFF]')
    EndIf
    Sleep (100)
WEnd

Func _Hide_ ()
    $Input1 = GUICtrlRead ($Input)
    If $Input1 <> @ScriptName And $Input1 <> '' Then
        WinSetState ($Input1, '', @SW_HIDE)
        GUICtrlSetState ($Input, $GUI_DISABLE)
        GUICtrlSetState ($Hide, $GUI_DISABLE)
        $Status = 'Hidden'
    Else
        MsgBox (48, 'ERROR', 'CANNOT HIDE ' & @ScriptName & '.', '', $GUI)
    EndIf
EndFunc

Func _UnHide_ ()
    $Input1 = GUICtrlRead ($Input)
    WinSetState ($Input1, '', @SW_SHOW)
    GUICtrlSetState ($Input, $GUI_ENABLE)
    GUICtrlSetState ($Hide, $GUI_ENABLE)
    $Status = 'Visible'
EndFunc

Func _Win_Move_ ()
    $MouseXY = MouseGetPos ()
    $WinXY = WinGetPos ($GUI)
    $xOff = $MouseXY[0] - $WinXY[0]
    $yOFF = $MouseXY[1] - $WinXY[1]
    While _IsPressed ('01')
        WinMove ($GUI, '',MouseGetPos (0) - $xOff ,MouseGetPos (1) - $yOFF)
        Sleep (10)
    WEnd
EndFunc

Func _Exit_ ()
    If $Status = 'Hidden' Then WinSetState (GUICtrlRead ($Input), '', @SW_SHOW)
    DllClose($hDLL)
    Exit
EndFunc