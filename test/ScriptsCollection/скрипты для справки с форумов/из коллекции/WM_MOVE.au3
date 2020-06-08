#NoTrayIcon
#region: - Option
    Opt('GUIOnEventMode',       1)
    Opt('MustDeclareVars',      1)
    Opt('TrayIconDebug',        0)
    Opt('TrayIconHide',         1)
#endregion

#region: - Include
    #include <GUIConstantsEx.au3>
    #include <WinAPI.au3>
    #include <WindowsConstants.au3>
#endregion

#region: - Global
; Main Win
    Global  $hMainWin
    Global  $iMainWinWidth      = 350
    Global  $iMainWinHeight     = 345
    Global  $iMainWinX          = -1
    Global  $iMainWinY          = -1

    Global  $iMainWinApiX, $iMainWinApiY
#endregion

#region: - Main Win
Func _MainWin_Create()
    $hMainWin = GUICreate('Test', $iMainWinWidth, $iMainWinHeight, $iMainWinX, $iMainWinY)
        GUISetState(@SW_SHOW, $hMainWin)
            GUISetOnEvent($GUI_EVENT_CLOSE, '_Pro_Exit')
EndFunc
#endregion

#region: - После создания всех GUI
    HotKeySet('{ESC}', '_Pro_Exit')
    GUIRegisterMsg($WM_MOVE, 'WM_MOVE')
    _MainWin_Create()
#endregion

#region: - Sleep, Exit
While 1
    Sleep(10)
WEnd

Func _Pro_Exit()
    Exit
EndFunc
#endregion


Func WM_MOVE($hWnd, $Msg, $wParam, $lParam)
    Local $aWinPos = WinGetPos($hWnd)
    Local $aWinClientSize = WinGetClientSize($hWnd)

    Local $iBorder_Size = ($aWinPos[2] - $aWinClientSize[0]) / 2
    Local $iCaption_Size = ($aWinPos[3] - $aWinClientSize[1]) - $iBorder_Size

    $iMainWinX  = $aWinPos[0]
    $iMainWinY  = $aWinPos[1]

    $iMainWinApiX  = _WinAPI_LoWord($lParam) - $iBorder_Size
    $iMainWinApiY  = _WinAPI_HiWord($lParam) - $iCaption_Size

    ToolTip('WinGetPos' & @CRLF & 'X = ' & $iMainWinX & @CRLF & 'Y = ' & $iMainWinY & @CRLF  & @CRLF & _
        'WinAPI' & @CRLF & 'X = ' & $iMainWinApiX & @CRLF & 'Y = ' & $iMainWinApiY, 10, 70)
		ConsoleWrite($iMainWinApiX & @CRLF)
EndFunc
#endregion
