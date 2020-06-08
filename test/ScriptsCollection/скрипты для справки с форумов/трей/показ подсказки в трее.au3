#region: - Option  
Opt('GUIOnEventMode', 1)  
Opt('MustDeclareVars', 1)  
Opt('TrayIconDebug', 0)  
Opt('TrayIconHide', 0)  
Opt('TrayMenuMode', 1)  
Opt('TrayOnEventMode', 1)  
#endregion  
 
#region: - Include  
#include <GuiComboBox.au3>  
#include <GUIConstantsEx.au3>  
#include <StaticConstants.au3>  
#Include <Timers.au3>  
#include <WindowsConstants.au3>  
#endregion  
 
#region: - Global  
HotKeySet('{ESC}', '_Pro_Exit')  
AutoItWinSetTitle(@AutoItPID)  
 
Global $hAutoItWin = WinGetHandle(@AutoItPID)  
Global $hToolTipTimerID, $hTrayTipTimerID  
#endregion  
 
#region: - Main Win Global, Functions  
Global $hMainWin, $hToolTipTimeShow, $hTrayTipTimeShow  
Global $hMainWinToolTipTimerInfo, $hMainWinTrayTipTimerInfo  
Global $hMainWinToolTipTimerInfoID, $hMainWinTrayTipTimerInfoID  
 
Func _MainWin_Create()  
Local $i, $sTimeShowString  
For $i=1 To 25  
$sTimeShowString &= $i & ' sec'  
If $i < 25 Then $sTimeShowString &= '|'  
Next  
 
$hMainWin = GUICreate('Sample: Tool and tray tip with my time show', 330, 185, -1, -1)  
GUISetOnEvent($GUI_EVENT_CLOSE, '_Pro_Exit')  
 
; ToolTip  
GUICtrlCreateGroup(' Tool Tip ', 10, 10, 150, 130)  
GUICtrlSetFont(-1, 10, 700)  
 
GUICtrlCreateLabel('Show time:', 20, 35, 150-20, 14)  
$hToolTipTimeShow = GUICtrlCreateCombo('', 20, 50, 150-20, 25, $CBS_DROPDOWNLIST)  
GUICtrlSetData(-1, $sTimeShowString, '3 sec')  
 
$hMainWinToolTipTimerInfo = GUICtrlCreateLabel('', 20+75, 35, 50, 14, $SS_RIGHT)  
 
GUICtrlCreateButton('Show', 20, 77, 150-20, 23)  
GUICtrlSetOnEvent(-1, '_MainWin_ToolTip_Create')  
 
GUICtrlCreateButton('Close', 20, 77+25, 150-20, 23)  
GUICtrlSetOnEvent(-1, '_MainWin_ToolTip_Close')  
 
; TrayTip  
GUICtrlCreateGroup(' Tray Tip ', 10+150+10, 10, 150, 130)  
GUICtrlSetFont(-1, 10, 700)  
 
GUICtrlCreateLabel('Show time:', 10+150+20, 35, 150-20, 14)  
$hTrayTipTimeShow = GUICtrlCreateCombo('', 10+150+20, 50, 150-20, 25, $CBS_DROPDOWNLIST)  
GUICtrlSetData(-1, $sTimeShowString, '3 sec')  
 
$hMainWinTrayTipTimerInfo = GUICtrlCreateLabel('', 10+150+20+75, 35, 50, 14, $SS_RIGHT)  
 
GUICtrlCreateButton('Show', 10+150+20, 77, 150-20, 23)  
GUICtrlSetOnEvent(-1, '_MainWin_TrayTip_Create')  
 
GUICtrlCreateButton('Close', 10+150+20, 77+25, 150-20, 23)  
GUICtrlSetOnEvent(-1, '_MainWin_TrayTip_Close')  
 
; Exit  
GUICtrlCreateButton('Exit', 330-100-10, 130+10+10, 100, 23)  
GUICtrlSetOnEvent(-1, '_Pro_Exit')  
EndFunc  
 
Func _MainWin_ToolTip_Create()  
Local $iTimeShow = StringReplace(GUICtrlRead($hToolTipTimeShow), ' sec', '')  
_ToolTip($iTimeShow, 'Время показа: ' & $iTimeShow & ' sec', 10, 70, 'Tool Tip', 1)  
GUICtrlSetData($hMainWinToolTipTimerInfo, $iTimeShow & ' sec')  
If $hMainWinToolTipTimerInfoID <> '' Then _Timer_KillTimer($hAutoItWin, $hMainWinToolTipTimerInfoID)  
$hMainWinToolTipTimerInfoID = _Timer_SetTimer($hAutoItWin, 1000, '_MainWin_ToolTip_TrayTip_Timer_Info')  
EndFunc  
Func _MainWin_ToolTip_Close()  
_ToolTip_TrayTip_Close('', '', $hToolTipTimerID, '')  
EndFunc  
 
Func _MainWin_TrayTip_Create()  
Local $iTimeShow = StringReplace(GUICtrlRead($hTrayTipTimeShow), ' sec', '')  
_TrayTip($iTimeShow, 'Tray Tip', 'Время показа: ' & $iTimeShow & ' sec', 1)  
GUICtrlSetData($hMainWinTrayTipTimerInfo, $iTimeShow & ' sec')  
If $hMainWinTrayTipTimerInfoID <> '' Then _Timer_KillTimer($hAutoItWin, $hMainWinTrayTipTimerInfoID)  
$hMainWinTrayTipTimerInfoID = _Timer_SetTimer($hAutoItWin, 1000, '_MainWin_ToolTip_TrayTip_Timer_Info')  
EndFunc  
Func _MainWin_TrayTip_Close()  
_ToolTip_TrayTip_Close('', '', $hTrayTipTimerID, '')  
EndFunc  
 
Func _MainWin_ToolTip_TrayTip_Timer_Info($hWnd, $Msg, $iIDTimer, $dwTime)  
Switch $iIDTimer  
Case $hMainWinToolTipTimerInfoID  
Local $iTimeShow = StringReplace(GUICtrlRead($hMainWinToolTipTimerInfo), ' sec', '')  
GUICtrlSetData($hMainWinToolTipTimerInfo, $iTimeShow-1 & ' sec')  
 
Case $hMainWinTrayTipTimerInfoID  
Local $iTimeShow = StringReplace(GUICtrlRead($hMainWinTrayTipTimerInfo), ' sec', '')  
GUICtrlSetData($hMainWinTrayTipTimerInfo, $iTimeShow-1 & ' sec')  
 
EndSwitch  
EndFunc  
#endregion  
 
#region: - Main Tray Global, Functions  
Global $hMainTray  
 
Func _MainTray_Crate()  
TraySetClick(1+8)  
 
TrayCreateItem('Exit')  
TrayItemSetOnEvent(-1, '_Pro_Exit')  
EndFunc  
#endregion  
 
#region: - After creating all GUI  
_MainWin_Create()  
_MainTray_Crate()  
 
GUISetState(@SW_SHOW, $hMainWin)  
TraySetState(1)  
#endregion  
 
#region: - Sleep, Exit  
While 1  
Sleep(10)  
WEnd  
 
Func _Pro_Exit()  
Exit  
EndFunc  
#endregion  
 
#region: - ToolTip and TrayTip  
Func _ToolTip($iTimeShow, $sText, $iX=Default, $iY=Default, $sTitle=Default, $iIcon=Default, $iOptions=Default)  
If $hToolTipTimerID <> '' Then _Timer_KillTimer($hAutoItWin, $hToolTipTimerID)  
ToolTip($sText, $iX, $iY, $sTitle, $iIcon, $iOptions)  
$hToolTipTimerID = _Timer_SetTimer($hAutoItWin, $iTimeShow*1000, '_ToolTip_TrayTip_Close')  
EndFunc  
 
Func _TrayTip($iTimeShow, $sTitle, $sText, $iIcon=Default)  
If $hTrayTipTimerID <> '' Then _Timer_KillTimer($hAutoItWin, $hTrayTipTimerID)  
TrayTip($sTitle, $sText, Default, $iIcon)  
$hTrayTipTimerID = _Timer_SetTimer($hAutoItWin, $iTimeShow*1000, '_ToolTip_TrayTip_Close')  
EndFunc  
 
Func _ToolTip_TrayTip_Close($hWnd, $Msg, $iIDTimer, $dwTime)  
Switch $iIDTimer  
Case $hToolTipTimerID  
_Timer_KillTimer($hAutoItWin, $hToolTipTimerID)  
$hToolTipTimerID = ''  
ToolTip('')  
_Timer_KillTimer($hAutoItWin, $hMainWinToolTipTimerInfoID)  
$hMainWinToolTipTimerInfoID = ''  
GUICtrlSetData($hMainWinToolTipTimerInfo, '')  
 
Case $hTrayTipTimerID  
_Timer_KillTimer($hAutoItWin, $hTrayTipTimerID)  
$hTrayTipTimerID = ''  
TrayTip('', '', 1)  
_Timer_KillTimer($hAutoItWin, $hMainWinTrayTipTimerInfoID)  
$hMainWinTrayTipTimerInfoID = ''  
GUICtrlSetData($hMainWinTrayTipTimerInfo, '')  
EndSwitch  
EndFunc  
#endregion 