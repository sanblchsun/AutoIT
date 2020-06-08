#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <ButtonConstants.au3>
#include <GUIImageList.au3>
;

Global $hImageList, $sOld_Opt_GRM = Opt("GUIResizeMode", $GUI_DOCKALL)
Global $iGUI_Width = 385
Global $iGUI_Height = 162


$Form1 = GUICreate("Form", $iGUI_Width, $iGUI_Height, 192, 186)
$Button1 = GUICtrlCreateButton(">", 370, 0, 15, 160, $WS_GROUP)

#Region Expanded controls
$ExitButton = GUICtrlCreateButton("Exit", 470, 130, 75, 25, $WS_GROUP)
GUICtrlCreateInput("Some Input", 405, 20, 121, 21)

Opt("GUIResizeMode", $sOld_Opt_GRM)
#EndRegion Expanded controls
;
GUISetState(@SW_SHOW)

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $Button1
			_Toggle_ExpandControls_Proc($Form1, $iGUI_Width, $iGUI_Width+165, $Button1, ">", "<")
		Case $GUI_EVENT_CLOSE, $ExitButton
			Exit
	EndSwitch
WEnd

Func _Toggle_ExpandControls_Proc($hWnd, $iInitWndWidth, $iExpndWidth, $iExpndCtrlID, $sExpndText="<", $sCntrctText=">")
    Local $iWidth, $sButtonText, $aSysCaptMetrics, $aSysBordMetrics

    Local Const $SM_CXFIXEDFRAME    = 7 ;Window border size

    $aSysBordMetrics = DllCall('user32.dll', 'int', 'GetSystemMetrics', 'int', $SM_CXFIXEDFRAME)

    $aGuiPos = WinGetPos($hWnd)

    If $aGuiPos[2] > $iExpndWidth Then

        $iWidth = $iInitWndWidth + ($aSysBordMetrics[0] * 2)
        $sButtonText = $sExpndText
    Else
        $iWidth= $iExpndWidth + ($aSysBordMetrics[0] * 2)
        $sButtonText = $sCntrctText
    EndIf

    GUICtrlSetData($iExpndCtrlID, $sButtonText)
    WinMove($hWnd, "", $aGuiPos[0], $aGuiPos[1], $iWidth, $aGuiPos[3])
EndFunc
