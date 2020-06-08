#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>

$hGui = GUICreate('Тест', 350, 180, -1, -1, -1, $WS_CLIPCHILDREN)
$nInput1 = GUICtrlCreateInput('', 10, 10, 150, 20)
GUICtrlSetColor(-1, 0x505050)
$nInput2 = GUICtrlCreateInput('', 10, 40, 150, 20)
GUISetState()
GUIRegisterMsg($WM_COMMAND, 'WM_COMMAND')

While 1
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case $GUI_EVENT_CLOSE
            Exit
    EndSwitch
WEnd

Func WM_COMMAND($hWnd, $imsg, $iwParam, $ilParam)
    Local $nNotifyCode, $nID, $sText
    $nNotifyCode = BitShift($iwParam, 16)
    $nID = BitAND($iwParam, 0xFFFF)
    Switch $hWnd
        Case $hGui
            Switch $nID
                Case $nInput1
                    Switch $nNotifyCode
                        Case $EN_CHANGE
                            $sText = GUICtrlRead($nInput1)
                            $sText &= '-' & $sText
                            GUICtrlSetData($nInput2, $sText)
                    EndSwitch
            EndSwitch
    EndSwitch
    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_COMMAND