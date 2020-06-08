#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

#include "GUICtrlOnHover.au3"

Global $sBtn_Image = @Systemdir & "\oobe\images\wpakey.jpg"
Global $sLbl_Image = @Systemdir & "\oobe\images\merlin.gif"

If Not FileExists($sBtn_Image) Or Not FileExists($sLbl_Image) Then
    $sBtn_Image = @TempDir & "\wpakey.jpg"
    $sLbl_Image = @TempDir & "\merlin.gif"
    
    InetGet("http://creator-lab.ucoz.ru/Images/wpakey.jpg", $sBtn_Image)
    InetGet("http://creator-lab.ucoz.ru/Images/merlin.gif", $sLbl_Image)
EndIf

$hGUI = GUICreate("Control ToolTip OnHover Example",500,400)

$nButton = GUICtrlCreateButton("Button", 100, 100, 50, 50)
_GUICtrl_OnHoverRegister(-1, "_ShowToolTip_Proc", "_ShowToolTip_Proc")

$nLabel = GUICtrlCreateLabel("Label", 300, 100, -1, 15)
_GUICtrl_OnHoverRegister(-1, "_ShowToolTip_Proc", "_ShowToolTip_Proc")

GUISetState(@SW_SHOW, $hGUI)

$hButton_ToolTip = _GUIToolTipCreate("My Button ToolTip", "Some Info", $sBtn_Image, 0x4E6FD6)
$hLabel_ToolTip = _GUIToolTipCreate("My Label ToolTip", "Some Info", $sLbl_Image, 0xFFFFFF)

While 1
    $nMsg = GUIGetMsg()
    
    Switch $nMsg
        Case $GUI_EVENT_CLOSE
            ExitLoop
    EndSwitch
WEnd

Func _GUIToolTipCreate($sTitle, $sText, $sImage = '', $nBkColor = 0xECEC00)
    Local $hToolTip = GUICreate($sTitle, 300, 200, -1, -1, BitOR($WS_POPUP, $WS_BORDER), $WS_EX_TOPMOST, $hGUI)
    GUISetBkColor($nBkColor, $hToolTip)
    GUICtrlCreatePic($sImage, 10, 10, 80, 80, $WS_BORDER)
    GUICtrlCreateLabel($sTitle, 100, 10, 180, 20)
    GUICtrlSetFont(-1, 10, 800)
    GUICtrlCreateLabel($sText, 100, 50, 180, 120)
    Return $hToolTip
EndFunc

Func _ShowToolTip_Proc($iCtrlID, $iHoverMode)
    Local $hToolTip
    
    Switch $iCtrlID
        Case $nButton
            $hToolTip = $hButton_ToolTip
        Case $nLabel
            $hToolTip = $hLabel_ToolTip
    EndSwitch
    
    Switch $iHoverMode
        Case 1 ;Hover proc
            $aMousePos = MouseGetPos()
            WinMove($hToolTip, "", $aMousePos[0]+10, $aMousePos[1]+10)
            GUISetState(@SW_SHOWNOACTIVATE, $hToolTip)
        Case 2 ;Leave hover proc
            GUISetState(@SW_HIDE, $hToolTip)
    EndSwitch
EndFunc