Exit

Func RegReplace($sKey) 
;$sKey - �������� ����� 
    Local $i, $sTemp, $sValuename, $sValue, $sValuetype 
    $i = 0 
    While 1 
        $i += 1 
        $sValuename = RegEnumVal($sKey, $i) 
        If @error Then ExitLoop 
        $sValue = RegRead($sKey, $sValuename) 
        $sValuetype = @extended 
;����� ���� ����������� ������� 
        Switch $sValuetype 
            Case 1, 2, 7 
            Case 4 
            Case 3 
            Case Else 
        EndSwitch 
    WEnd 
;�������� 
    $i = 0 
    While 1 
        $i += 1 
        $sTemp = RegEnumKey($sKey, $i) 
        If @error Then ExitLoop 
        RegReplace($sKey & '\' & $sTemp) 
    WEnd 
    Return 
EndFunc  
