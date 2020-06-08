#include-once

If Not IsDeclared("WM_USER") Then Assign("WM_USER", 0x0400, 1)

Global $vINTERACT_Msg           = -1
Global $aMAIN_FUNCTIONS         = -1
Global $h_MAIN_INTERACT_GUI     = 0
Global $ah_INTERACT_TIMER[2]    = [-1, -1]

Func OnAutoItExit()
    If $ah_INTERACT_TIMER[0] <> -1 Then _TimerStop($ah_INTERACT_TIMER[0], $ah_INTERACT_TIMER[1])
EndFunc

Func _Interaction_Handler($hWnd, $MsgID, $WParam, $LParam)
    If $vINTERACT_Msg = -1 Then Return

    For $i = 0 To UBound($aMAIN_FUNCTIONS)-1
        If $aMAIN_FUNCTIONS[$i][0] = $vINTERACT_Msg Then
            $vINTERACT_Msg = -1

            Call($aMAIN_FUNCTIONS[$i][1], $aMAIN_FUNCTIONS[$i][2])
            If @error Then Call($aMAIN_FUNCTIONS[$i][1])

            ExitLoop
        EndIf
    Next

    $vINTERACT_Msg = -1
EndFunc

Func _AutoItSetInteraction($hWnd=0, $MsgID=0, $WParam=0, $LParam=0)
    If Not IsHWnd($hWnd) Then
        If Not IsArray($MsgID) Then
            GUIRegisterMsg($WM_USER, "")
            If IsHWnd($h_MAIN_INTERACT_GUI) Then GUIDelete($h_MAIN_INTERACT_GUI)

            _TimerStop($ah_INTERACT_TIMER[0], $ah_INTERACT_TIMER[1])

            Return
        EndIf

        $ah_INTERACT_TIMER = _TimerStart("_Interaction_Handler", 10)
        $aMAIN_FUNCTIONS = $MsgID

        $h_MAIN_INTERACT_GUI = GUICreate($hWnd)
        GUIRegisterMsg($WM_USER, "_AutoItSetInteraction")

        Return
    EndIf

    $vINTERACT_Msg = BitAND($LParam, 0xFFFF)
EndFunc

Func _TimerStart($sFunction, $iTime=250)
    Local $hCallBack = DllCallbackRegister($sFunction, "none", "hwnd;int;int;dword")

    Local $aDll = DllCall("user32.dll", "int", "SetTimer", _
        "hwnd", 0, _
        "int", TimerInit(), _
        "int", $iTime, _
        "ptr", DllCallbackGetPtr($hCallBack))

    Local $aRet[2] = [$hCallBack, $aDll[0]]
    Return $aRet
EndFunc

Func _TimerStop($hCallBack, $hTimer)
    DllCallBackFree($hCallBack)
    Local $aRet = DllCall("user32.dll", "int", "KillTimer", "hwnd", 0, "int", $hTimer)
    Return $aRet[0]
EndFunc