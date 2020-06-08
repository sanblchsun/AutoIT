#include <GUIConstantsEx.au3>

$hGUI = GUICreate("_GUICtrlEdit_TogglePassChars - Demo", 300, 80)

$nInput = GUICtrlCreateInput("My Pass", 20, 20, 190, 20)
$nButton = GUICtrlCreateButton("Toggle Pass", 220, 20, 70, 20)

GUISetState()

While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            Exit
        Case $nButton
            $aChars = StringSplit("*|#|x|9679", "|")
            _GUICtrlEdit_TogglePassChars($hGUI, $nInput, -1, $aChars[Random(1, $aChars[0], 1)])
    EndSwitch
WEnd

Func _GUICtrlEdit_TogglePassChars($hWnd, $hCtrl, $iToggleState = -1, $sPassChar = -1)
    If Not IsHWnd($hWnd) Then
        $hWnd = WinGetHandle($hWnd)
    EndIf
   
    If Not IsHWnd($hCtrl) Then
        $hCtrl = ControlGetHandle($hWnd, "", $hCtrl)
    EndIf
   
    Local Const $EM_SETPASSWORDCHAR = 0xCC
    Local Const $EM_GETPASSWORDCHAR = 0xD2
   
    Local $iGet_Pass_Char, $iSet_Pass_Char, $iDef_Pass_Char = 9679
    Local $aRet = DllCall("user32.dll", "long", "SendMessageW", "hwnd", $hCtrl, "int", $EM_GETPASSWORDCHAR, "int", 0, "int", 0)
   
    If Not @error And $aRet[0] Then
        $iGet_Pass_Char = $aRet[0]
    EndIf
   
    If $sPassChar = -1 Then
        $iSet_Pass_Char = $iGet_Pass_Char
    Else
        If StringLen($sPassChar) = 1 And IsString($sPassChar) Then
            $iSet_Pass_Char = Asc($sPassChar)
        Else
            $iSet_Pass_Char = Number($sPassChar)
        EndIf
       
        $iDef_Pass_Char = $iSet_Pass_Char
    EndIf
   
    If $iToggleState = -1 Then
        If $iGet_Pass_Char <> 0 Then
            $iSet_Pass_Char = 0
        Else
            $iSet_Pass_Char = $iDef_Pass_Char
        EndIf
    ElseIf $iToggleState = 0 Then
        $iSet_Pass_Char = 0
    ElseIf $iToggleState = 1 Then
        $iSet_Pass_Char = $iDef_Pass_Char
    EndIf
   
    DllCall("user32.dll", "none", "SendMessageW", "hwnd", $hCtrl, "int", $EM_SETPASSWORDCHAR, "int", $iSet_Pass_Char, "int", 0)
    DllCall("user32.dll", "none", "InvalidateRect", "hwnd", $hCtrl, "ptr", 0, "int", 1)
EndFunc