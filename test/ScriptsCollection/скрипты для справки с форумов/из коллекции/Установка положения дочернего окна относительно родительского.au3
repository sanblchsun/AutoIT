#Include <WinAPI.au3>

$hParent = GUICreate('Parent', 400, 400)
GUISetState()
$hChild = GUICreate('Child', 300, 300, -1, -1, -1, -1, $hParent)
_SetChildPos($hChild, $hParent, 10, 10)
GUISetState()

Do
Until GUIGetMsg() = -3

Func _SetChildPos($hChild, $hParent, $iX = 0, $iY = 0)

    Local $tPOINT, $tRECT, $Ret, $X, $Y, $Pos, $Height

    $Pos = WinGetPos($hChild)
    If (@error) Or (Not WinExists($hParent)) Then
        Return SetError(1, 0, 0)
    EndIf
    $tPOINT = DllStructCreate($tagPOINT)
    For $i = 1 To 2
        DllStructSetData($tPOINT, $i, 0)
    Next
    _WinAPI_ClientToScreen($hParent, $tPOINT)
    If @error Then
        Return SetError(1, 0, 0)
    EndIf
    $X = DllStructGetData($tPOINT, 1) + $iX
    $Y = DllStructGetData($tPOINT, 2) + $iY
    $tRECT = DllStructCreate($tagRECT)
    $Ret = DllCall('user32.dll', 'int', 'SystemParametersInfo', 'int', 48, 'int', 0, 'ptr', DllStructGetPtr($tRECT), 'int', 0)
    If (@error) Or ($Ret[0] = 0) Then
        $Height = @DesktopHeight
    Else
        $Height = DllStructGetData($tRECT, 4)
    EndIf
    If $X < 0 Then
        $X = 0
    EndIf
    If $X > @DesktopWidth - $Pos[2] Then
        $X = @DesktopWidth - $Pos[2]
    EndIf
    If $Y < 0 Then
        $Y = 0
    EndIf
    If $Y > $Height - $Pos[3] Then
        $Y = $Height - $Pos[3]
    EndIf
    If Not WinMove($hChild, '', $X, $Y) Then
        Return SetError(1, 0, 0)
    EndIf
    Return 1
EndFunc   ;==>_SetChildPos
