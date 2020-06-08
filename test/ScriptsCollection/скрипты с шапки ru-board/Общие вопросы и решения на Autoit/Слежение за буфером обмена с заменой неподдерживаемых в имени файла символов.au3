HotKeySet("{ESC}", "_Quit")

$sOld_Clip_Data = ClipGet()

While 1
    Sleep(1000)

    $sCurrent_Clip_Data = ClipGet()

    If $sCurrent_Clip_Data <> $sOld_Clip_Data Then
        $sOld_Clip_Data = $sCurrent_Clip_Data

        $sCurrent_Clip_Data = _StringReplaceUnsupported($sCurrent_Clip_Data)

        If @extended > 0 Then
            If ClipPut($sCurrent_Clip_Data) Then $sOld_Clip_Data = $sCurrent_Clip_Data
        EndIf
    EndIf
WEnd

Func _StringReplaceUnsupported($sString, $sPatern='[*?\\/|:<>"]', $sReplace="_")
    If StringStripWS($sString, 8) = "" Then Return $sString

    $sString = StringRegExpReplace($sString, $sPatern, $sReplace)
    $sString = StringRegExpReplace($sString, '(' & $sReplace & '+)', $sReplace)

    Return SetExtended(@extended, $sString)
EndFunc

Func _Quit()
    Exit
EndFunc