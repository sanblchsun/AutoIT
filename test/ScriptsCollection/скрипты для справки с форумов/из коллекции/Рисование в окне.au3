#region: - Options
    Opt('GUIOnEventMode',       1)
    Opt('MustDeclareVars',      1)
    Opt('TrayIconDebug',        1)
    Opt('TrayIconHide',         0)
#endregion

#include <GUIConstants.au3>
#include <WindowsConstants.au3>
#Include <WinAPI.au3>

HotKeySet('{ESC}', '_Pro_Exit')
Local $iCheckSum

$iCheckSum = _PixelChecksum1(200, 200, 200, 200)
MsgBox(64, 'Пример #1', 'GUI окна в виде линий')

$iCheckSum = _PixelChecksum2(200, 200, 200, 200, 100)
MsgBox(64, 'Пример #2', 'Прозрачное GUI окно')

_Pro_Exit()

#region: - Sleep, Exit, OnAutoItExit
While 1
    Sleep(10)
WEnd

Func _Pro_Exit()
    Exit
EndFunc
#endregion

Func _PixelChecksum1($iLeft, $iTop, $iRght, $iBottom, $iTrans=255, $iStep=1)
    Local $hTop    = GUICreate('Top',    $iRght, 1,   $iLeft, $iTop, $WS_POPUP, BitOR($WS_EX_TOPMOST, $WS_EX_TOOLWINDOW))
    Local $hBottom = GUICreate('Bottom', $iRght, 1,   $iLeft, $iTop+$iBottom, $WS_POPUP, BitOR($WS_EX_TOPMOST, $WS_EX_TOOLWINDOW))
    Local $hLeft   = GUICreate('Left',   1, $iBottom, $iLeft+$iRght, $iTop, $WS_POPUP, BitOR($WS_EX_TOPMOST, $WS_EX_TOOLWINDOW))
    Local $hRight  = GUICreate('Right',  1, $iBottom, $iLeft, $iTop, $WS_POPUP, BitOR($WS_EX_TOPMOST, $WS_EX_TOOLWINDOW))

    WinSetTrans($hTop, '',      $iTrans)
    GUISetBkColor(0x000000,     $hTop)
    GUISetState(@SW_SHOW,       $hTop)

    WinSetTrans($hBottom, '',   $iTrans)
    GUISetBkColor(0x000000,     $hBottom)
    GUISetState(@SW_SHOW,       $hBottom)

    WinSetTrans($hLeft, '',     $iTrans)
    GUISetBkColor(0x000000,     $hLeft)
    GUISetState(@SW_SHOW,       $hLeft)

    WinSetTrans($hRight, '',    $iTrans)
    GUISetBkColor(0x000000,     $hRight)
    GUISetState(@SW_SHOW,       $hRight)

    Return PixelChecksum($iLeft, $iTop, $iRght, $iBottom, $iStep)
EndFunc

Func _PixelChecksum2($iLeft, $iTop, $iRght, $iBottom, $iTrans=255, $iStep=1)
    Local $hWin = GUICreate('Win', $iTop, $iBottom, $iLeft, $iBottom, $WS_POPUP, BitOR($WS_EX_TOPMOST, $WS_EX_TOOLWINDOW))

    WinSetTrans($hWin, '',      $iTrans)
    GUISetBkColor(0xffffff,     $hWin)
    GUISetState(@SW_SHOW,       $hWin)

    Return PixelChecksum($iLeft, $iTop, $iRght, $iBottom, $iStep)
EndFunc
