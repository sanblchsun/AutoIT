; ========================================================================
; Keyboard MouseMover
; Build version 1.3
; Created by: Monamo
; Questions or comments can be directed to me on the AutoIt support forums
; ========================================================================


#include<Misc.au3>
HotKeySet("{INS}", "_ShowInfo")
HotKeySet("+{UP}", "_UpArrow")
HotKeySet("{UP}", "_UpArrow")
HotKeySet("+{DOWN}", "_DownArrow")
HotKeySet("{DOWN}", "_DownArrow")
HotKeySet("+{LEFT}", "_LeftArrow")
HotKeySet("{LEFT}", "_LeftArrow")
HotKeySet("+{RIGHT}", "_RightArrow")
HotKeySet("{RIGHT}", "_RightArrow")
HotKeySet("{F10}", "_Exit")

$MouseModifier = 1
$PressedTime = 1

While 1
    If (_IsPressed(25) + _IsPressed(26) + _IsPressed(27) + _IsPressed(28)) = 0 Then
        _ResetSpeed()
    EndIf
    Sleep(100)
WEnd

Func _ShowInfo()
    Local $MousePos = MouseGetPos()
    $PixColor = PixelGetColor($MousePos[0], $MousePos[1])
    MsgBox(0, "Color Information", "Color information at selected mouse position(x,y): " & $MousePos[0] & "," & $MousePos[1] & @CR & @CR & "Hex color value: " & "0x" & Hex($PixColor, 6))
EndFunc   ;==>_ShowInfo

Func _UpArrow()
    Local $MousePos = MouseGetPos()
    If _IsPressed(10) Then
        $i = 10
    Else
        $i = 1
    EndIf
    
    If $MousePos[1] > 0 Then
        _BoostMouseSpeed()
        MouseMove($MousePos[0], $MousePos[1] - ($MouseModifier * $i), 1)
    EndIf
EndFunc   ;==>_UpArrow

Func _DownArrow()
    If _IsPressed(10) Then
        $i = 10
    Else
        $i = 1
    EndIf

    Local $MousePos = MouseGetPos()
    If $MousePos[1] < @DesktopHeight Then
        _BoostMouseSpeed()
        MouseMove($MousePos[0], $MousePos[1] + ($MouseModifier * $i),1)
    EndIf
EndFunc   ;==>_DownArrow

Func _LeftArrow()
    If _IsPressed(10) Then
        $i = 10
    Else
        $i = 1
    EndIf

    Local $MousePos = MouseGetPos()
    If $MousePos[0] > 0 Then
        _BoostMouseSpeed()
        MouseMove($MousePos[0] - ($MouseModifier * $i), $MousePos[1],1)
    EndIf
EndFunc   ;==>_LeftArrow

Func _RightArrow()
    If _IsPressed(10) Then
        $i = 10
    Else
        $i = 1
    EndIf

    Local $MousePos = MouseGetPos()
    If $MousePos[0] < @DesktopWidth Then
        _BoostMouseSpeed()
        MouseMove($MousePos[0] + ($MouseModifier * $i), $MousePos[1],1)
    EndIf
EndFunc   ;==>_RightArrow

Func _BoostMouseSpeed()
        If IsInt($PressedTime / 10) Then
            $MouseModifier = $MouseModifier + 1
            $PressedTime = $PressedTime + 1
        Else
            $PressedTime = $PressedTime + 1
        EndIf
EndFunc

Func _ResetSpeed()
    $MouseModifier = 1
    $PressedTime = 1
EndFunc   ;==>_ResetSpeed

Func _Exit()
    Exit
EndFunc   ;==>_Exit
