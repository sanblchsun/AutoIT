#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <ButtonConstants.au3>
#include <GUIImageList.au3>
;

Global $hImageList, $sOld_Opt_GRM = Opt("GUIResizeMode", $GUI_DOCKALL)
Global $iGUI_Height = 150

$Form1 = GUICreate("Form1", 550, $iGUI_Height, 192, 124)

$Button1 = GUICtrlCreateButton("Îïöèè >>", 440, 112, 105, 25, $WS_GROUP)
_GUICtrlButton_SetImageEx($hImageList, $Button1, @SystemDir & "\rasdlg.dll", 16)


GUICtrlCreateButton("Some Button", 20, 240, 80)
GUICtrlCreateButton("Other Button", 120, 20, 80)
GUICtrlCreateInput("Some Input", 20, 200, 200, 20)

Opt("GUIResizeMode", $sOld_Opt_GRM)

;

GUISetState(@SW_SHOW)

While 1
    $nMsg = GUIGetMsg()

    Switch $nMsg
        Case $Button1
            _Toggle_ExpandControls_Proc($Form1, $iGUI_Height, $iGUI_Height+150, $Button1, "Îïöèè >>", "Îïöèè <<")
        Case $GUI_EVENT_CLOSE
            Exit
    EndSwitch
WEnd

Func _Toggle_ExpandControls_Proc($hWnd,$iInitWndHeight,$iExpndHeight,$iExpndCtrlID,$sExpndText="Expand",$sCntrctText="Contract")
    Local $iHeight, $sButtonText, $aSysCaptMetrics, $aSysBordMetrics

    Local Const $SM_CYCAPTION       = 4 ;Caption (Title) heigth
    Local Const $SM_CXFIXEDFRAME    = 7 ;Window border size

    $aSysCaptMetrics = DllCall('user32.dll', 'int', 'GetSystemMetrics', 'int', $SM_CYCAPTION)
    $aSysBordMetrics = DllCall('user32.dll', 'int', 'GetSystemMetrics', 'int', $SM_CXFIXEDFRAME)

    $aGuiPos = WinGetPos($hWnd)

    If $aGuiPos[3] > $iExpndHeight + $aSysCaptMetrics[0] Then
        _GUICtrlButton_SetImageEx($hImageList, $iExpndCtrlID, @SystemDir & "\rasdlg.dll", 16)

        $iHeight = $iInitWndHeight + $aSysCaptMetrics[0] + ($aSysBordMetrics[0] * 2)
        $sButtonText = $sExpndText
    Else
        _GUICtrlButton_SetImageEx($hImageList, $iExpndCtrlID, @SystemDir & "\rasdlg.dll", 14)

        $iHeight = $iExpndHeight + $aSysCaptMetrics[0] + ($aSysBordMetrics[0] * 2)
        $sButtonText = $sCntrctText
    EndIf

    GUICtrlSetData($iExpndCtrlID, $sButtonText)
    WinMove($hWnd, "", $aGuiPos[0], $aGuiPos[1], $aGuiPos[2], $iHeight)
EndFunc

Func _GUICtrlButton_SetImageEx(ByRef $hImageList, $nCtrl, $sIconFile, $nIconID=0, $nAlign=-1)
    If $hImageList Then _GUIImageList_Destroy($hImageList)

    $hImageList = _GUIImageList_Create(16, 16, 5, 1)
    _GUIImageList_AddIcon($hImageList, $sIconFile, $nIconID)

    Local $stBIL = DllStructCreate("dword;int[4];uint")

    DllStructSetData($stBIL, 1, $hImageList)
    DllStructSetData($stBIL, 2, 1, 1)
    DllStructSetData($stBIL, 2, 1, 2)
    DllStructSetData($stBIL, 2, 1, 3)
    DllStructSetData($stBIL, 2, 1, 4)
    DllStructSetData($stBIL, 3, $nAlign)

    Return GUICtrlSendMsg($nCtrl, $BCM_SETIMAGELIST, 0, DllStructGetPtr($stBIL))
EndFunc
