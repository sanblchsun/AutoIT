#include <GUIConstants.au3>
Const $ES_READONLY = 2048


Global Const $WM_WINDOWPOSCHANGING = 0x0046

Global $nRange = 20

$hGUI = GUICreate("GUI Stickable!", 280, 150)

$Stickable_CB = GUICtrlCreateCheckbox("Stickable?", 20, 30)
GUICtrlSetState(-1, $GUI_CHECKED)

$Range_Input = GUICtrlCreateInput($nRange, 20, 60, 40, 20, $ES_READONLY)
$UpDown = GUICtrlCreateUpdown(-1)
GUICtrlSetLimit(-1, 80, 5)

GUISetState()

GUICreate("Some extra window", 320, 180, 0, 0)
GUIRegisterMsg($WM_WINDOWPOSCHANGING, "WM_WINDOWPOSCHANGING")

GUISetState()

While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            ExitLoop
        Case $Stickable_CB
            If GUICtrlRead($Stickable_CB) = $GUI_CHECKED Then
                GUIRegisterMsg($WM_WINDOWPOSCHANGING, "WM_WINDOWPOSCHANGING")
            Else
                GUIRegisterMsg($WM_WINDOWPOSCHANGING, "")
            EndIf
        Case $UpDown
            $nRange = GUICtrlRead($Range_Input)
    EndSwitch
WEnd

Func WM_WINDOWPOSCHANGING($hWnd, $Msg, $wParam, $lParam)
    Local $IsSideWinStick   = True ;Set to True for sticking to all visible windows :) - but it's hangs up CPU :(

    Local $stWinPos         = DllStructCreate("uint;uint;int;int;int;int;uint", $lParam)
    Local $nLeft            = DllStructGetData($stWinPos, 3)
    Local $nTop             = DllStructGetData($stWinPos, 4)

    Local $aCurWinPos       = WinGetPos($hWnd)
    Local $aWorkArea        = _GetWorkingArea()

    ;Left
    If Abs($aWorkArea[0] - $nLeft) <= $nRange Then DllStructSetData($stWinPos, 3, $aWorkArea[0])
    ;Right
    If Abs($nLeft + $aCurWinPos[2] - $aWorkArea[2]) <= $nRange Then DllStructSetData($stWinPos, 3, $aWorkArea[2] - $aCurWinPos[2])
    ;Top
    If Abs($aWorkArea[1] - $nTop) <= $nRange Then DllStructSetData($stWinPos, 4, $aWorkArea[1])
    ;Bottom
    If Abs($nTop + $aCurWinPos[3] - $aWorkArea[3]) <= $nRange Then DllStructSetData($stWinPos, 4, $aWorkArea[3] - $aCurWinPos[3])

    If Not $IsSideWinStick Then Return 0

    Local $ahWnd = WinList()

    For $i = 1 To UBound($ahWnd) - 1
        If $ahWnd[$i][1] = $hWnd Or Not BitAND(WinGetState($ahWnd[$i][1]), 2) Or _
            BitAND(WinGetState($ahWnd[$i][1]), 32) Or BitAND(WinGetState($ahWnd[$i][1]), 16) Then ContinueLoop

        $aSideWinPos = WinGetPos($ahWnd[$i][1])

        If $aCurWinPos[1] + $aCurWinPos[3] >= $aSideWinPos[1] And $aCurWinPos[1] <= $aSideWinPos[1] + $aSideWinPos[3] Then
            ;Left
            If Abs(($aSideWinPos[0] + $aSideWinPos[2]) - $nLeft) <= $nRange Then _
                DllStructSetData($stWinPos, 3, $aSideWinPos[0] + $aSideWinPos[2])

            ;Right
            If Abs($nLeft + $aCurWinPos[2] - $aSideWinPos[0]) <= $nRange Then _
                DllStructSetData($stWinPos, 3, $aSideWinPos[0] - $aCurWinPos[2])
        EndIf

        If $aCurWinPos[0] + $aCurWinPos[2] >= $aSideWinPos[0] And $aCurWinPos[0] <= $aSideWinPos[0] + $aSideWinPos[2] Then
            ;Top
            If Abs(($aSideWinPos[1] + $aSideWinPos[3]) - $nTop) <= $nRange Then _
                DllStructSetData($stWinPos, 4, $aSideWinPos[1] + $aSideWinPos[3])

            ;Bottom
            If Abs($nTop + $aCurWinPos[3] - $aSideWinPos[1]) <= $nRange Then _
                DllStructSetData($stWinPos, 4, $aSideWinPos[1] - $aCurWinPos[3])
        EndIf
    Next

    Return 0
EndFunc

;===============================================================================
;
; Function Name:    _GetWorkingArea()
; Description:      Returns the coordinates of desktop working area rectangle
; Parameter(s):     None
; Return Value(s):  On Success - Array containing coordinates:
;                        $a[0] = left
;                        $a[1] = top
;                        $a[2] = right
;                        $a[3] = bottom
;                   On Failure - 0
;
;BOOL WINAPI SystemParametersInfo(UINT uiAction, UINT uiParam, PVOID pvParam, UINT fWinIni);
;uiAction SPI_GETWORKAREA = 48
;===============================================================================
Func _GetWorkingArea()
    Local Const $SPI_GETWORKAREA = 48
    Local $stRECT = DllStructCreate("long; long; long; long")
    Local $SPIRet = DllCall("User32.dll", "int", "SystemParametersInfo", _
                        "uint", $SPI_GETWORKAREA, "uint", 0, "ptr", DllStructGetPtr($stRECT), "uint", 0)
    If @error Then Return 0
    If $SPIRet[0] = 0 Then Return 0

    Local $sLeftArea = DllStructGetData($stRECT, 1)
    Local $sTopArea = DllStructGetData($stRECT, 2)
    Local $sRightArea = DllStructGetData($stRECT, 3)
    Local $sBottomArea = DllStructGetData($stRECT, 4)

    Local $aRet[4] = [$sLeftArea, $sTopArea, $sRightArea, $sBottomArea]
    Return $aRet
EndFunc