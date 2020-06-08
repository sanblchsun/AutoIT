$sWindow = _ProcessGetWindow("Calc.exe", 1)
ConsoleWrite($sWindow & @CRLF)

Func _ProcessGetWindow($iPID, $iRet=-1)
    Local $aWinList = WinList()
    Local $aRet[2]

    If IsString($iPID) Then $iPID = ProcessExists($iPID)

    For $i = 1 To UBound($aWinList)-1
        If WinGetProcess($aWinList[$i][1]) = $iPID Then
            $aRet[0] = $aWinList[$i][0] ;Title
            $aRet[1] = $aWinList[$i][1] ;WinHandle

            If $iRet = 0 Then Return $aRet[0]
            If $iRet = 1 Then Return $aRet[1]

            Return $aRet
        EndIf
    Next

    Return SetError(1, 0, $aRet)
EndFunc