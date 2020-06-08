Exit

Func RegReplace($sKey) 
;$sKey - исходная ветка 
    Local $i, $sTemp, $sValuename, $sValue, $sValuetype 
    $i = 0 
    While 1 
        $i += 1 
        $sValuename = RegEnumVal($sKey, $i) 
        If @error Then ExitLoop 
        $sValue = RegRead($sKey, $sValuename) 
        $sValuetype = @extended 
;здесь идет модификация реестра 
        Switch $sValuetype 
            Case 1, 2, 7 
            Case 4 
            Case 3 
            Case Else 
        EndSwitch 
    WEnd 
;рекурсия 
    $i = 0 
    While 1 
        $i += 1 
        $sTemp = RegEnumKey($sKey, $i) 
        If @error Then ExitLoop 
        RegReplace($sKey & '\' & $sTemp) 
    WEnd 
    Return 
EndFunc  
