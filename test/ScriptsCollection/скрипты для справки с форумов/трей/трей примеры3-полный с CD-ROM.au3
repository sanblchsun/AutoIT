;~ #NoTrayIcon 

#region: - Include 
#include <ComboConstants.au3> 
#include <GuiButton.au3> 
#include <GUIComboBox.au3> 
#include <GUIConstantsEx.au3> 
#include <WinAPI.au3> 
#include <WindowsConstants.au3> 
#endregion 

#region: - Option 
AutoItSetOption ('GUIOnEventMode', 1) 
AutoItSetOption ('MustDeclareVars', 1) 
AutoItSetOption ('TrayIconDebug', 0) 
AutoItSetOption ('TrayIconHide', 0) 
AutoItSetOption ('TrayMenuMode', 1) 
AutoItSetOption ('TrayOnEventMode', 1) 
AutoItSetOption ('WinDetectHiddenText', 1) 
#endregion 

; #VARIABLES# =================================================================================================================== 
Global Const $HKM_SETHOTKEY = $WM_USER + 1 
Global Const $HKM_GETHOTKEY = $WM_USER + 2 
Global Const $HKM_SETRULES = $WM_USER + 3 

Global Const $HOTKEYF_SHIFT = 0x01 
Global Const $HOTKEYF_CONTROL = 0x02 
Global Const $HOTKEYF_ALT = 0x04 
;Global Const $HOTKEYF_EXT = 0x80 

Global Const $MOD_ALT = 0x1 
Global Const $MOD_CONTROL = 0x2 
Global Const $MOD_SHIFT = 0x4 

Global Const $WM_HOTKEY = 0x312 

Global $i, $n, $win_main, $cdrom_combo, $cdrom_get, $cdrom_string, $cdrom_key_input[30], $cdrom_key_id[30], $cdrom_key_button[30], $cdrom_open_close[30], $cdrom_button_open_close[30], $tray_current[30] 
$cdrom_string = '' 
; =============================================================================================================================== 

$n = 1 
For $i = 1 to 29 
$cdrom_key_id[$i] = $n 
$n += 1 
Next 

$win_main = GUICreate('CD Eject', 300, 300, -1, -1, $WS_SIZEBOX, $WS_EX_CONTEXTHELP) 
GUISetIcon('Main.ico') 
GUIRegisterMsg($WM_HOTKEY, "WM_HOTKEY") 
GUISetOnEvent($GUI_EVENT_CLOSE, '_Exit_pro') 

GUICtrlCreateLabel('Выбор привода:', 10, 10, 85, 15) 
GUICtrlCreateLabel('Горячие клавиши:', 10, 40, 95, 15) 

$cdrom_combo = GUICtrlCreateCombo('', 105, 7, 100, 20, $CBS_DROPDOWNLIST) 
GUICtrlSetOnEvent(-1, '_Select_input_key') 

TrayCreateItem('Настройки') 
TrayItemSetOnEvent(-1, '_Show_main_win') 
TrayCreateItem('') 

$cdrom_get = DriveGetDrive('CDROM') 
If NOT @error Then 
For $i = 1 to $cdrom_get[0] 
$cdrom_string &= $cdrom_get[$i] & '\' 
If $i < ($cdrom_get[0]) Then $cdrom_string &= '|' 

$cdrom_key_input[$i] = _GuiCtrlHotKey_Create($win_main, 105, 37, 100, 20) 
_GuiCtrlHotKey_SetHotkey($cdrom_key_input[$i], 48+$i, $HOTKEYF_CONTROL) 

$cdrom_key_button[$i] = GUICtrlCreateButton('Назначить', 105, 37+25, 100, 23) 
GUICtrlSetOnEvent(-1, '_Register_unregister_key') 

$cdrom_open_close[$i] = 'close' 

$cdrom_button_open_close[$i] = GUICtrlCreateButton('Открыть: ' & $cdrom_get[$i] & '\', 10, 241, 80, 28) 
GUICtrlSetOnEvent(-1, '_Open_close_cdrom') 

$tray_current[$i] = TrayCreateItem('Открыть: ' & $cdrom_get[$i] & '\') 
TrayItemSetOnEvent(-1, '_Open_close_cdrom_Tray') 
Next 
GUICtrlSetData($cdrom_combo, $cdrom_string, $cdrom_get[1] & '\') 
_Select_input_key() 
EndIf 

TrayCreateItem('') 
TrayCreateItem('Выход') 
TrayItemSetOnEvent(-1, '_Exit_pro') 

TraySetIcon('Main.ico') 

GUICtrlCreateButton('Скрыть', 100, 241, 80, 28) 
GUICtrlSetOnEvent(-1, '_Hide_main_win') 
GUICtrlCreateButton('Выход', 190, 241, 80, 28) 
GUICtrlSetOnEvent(-1, '_Exit_pro') 

GUISetState() 
While 1 
Sleep(100) 
WEnd 

Func _Exit_pro() 
Exit 
EndFunc 

Func _Show_hide_main_win() 
If WinGetState('CD Eject', 'Горячие клавиши:') == 5 Then 
GUISetState(@SW_SHOW, $win_main) 
WinActivate('CD Eject', 'Горячие клавиши:') 
Else 
GUISetState(@SW_HIDE, $win_main) 
EndIf 
EndFunc 

Func _Show_main_win() 
GUISetState(@SW_SHOW, $win_main) 
WinActivate('CD Eject', 'Горячие клавиши:') 
EndFunc 

Func _Hide_main_win() 
GUISetState(@SW_HIDE, $win_main) 
EndFunc 

Func WM_HOTKEY($hWnd, $Msg, $wParam, $lParam) 
Local $iKeyID = BitAND($wParam, 0x0000FFFF) 

;~ MsgBox(0, 'Нажата горячая клавиша CD-ROM', '$iKeyID=' & $iKeyID & @CRLF & '$cdrom_open_close['& $iKeyID & '](текущее состояние данного CD-ROM)=' & $cdrom_open_close[$iKeyID] & @CRLF & '$cdrom_get['& $iKeyID & ']=' & $cdrom_get[$iKeyID]) 
If $cdrom_open_close[$iKeyID] == 'close' Then 
CDTray($cdrom_get[$iKeyID], 'open') 
$cdrom_open_close[$iKeyID] = 'open' 
GUICtrlSetData($cdrom_button_open_close[$iKeyID], 'Закрыть: ' & $cdrom_get[$iKeyID] & '\') 
TrayItemSetText($tray_current[$iKeyID], 'Закрыть: ' & $cdrom_get[$iKeyID] & '\') 
ElseIf $cdrom_open_close[$iKeyID] == 'open' Then 
CDTray($cdrom_get[$iKeyID], 'close') 
$cdrom_open_close[$iKeyID] = 'close' 
GUICtrlSetData($cdrom_button_open_close[$iKeyID], 'Открыть: ' & $cdrom_get[$iKeyID] & '\') 
TrayItemSetText($tray_current[$iKeyID], 'Открыть: ' & $cdrom_get[$iKeyID] & '\') 
EndIf 

Return $GUI_RUNDEFMSG 
EndFunc 

Func _Open_close_cdrom_Tray() 
_Open_close_cdrom(@TRAY_ID-8) 
EndFunc 

Func _Open_close_cdrom($what_cdrom='') 
If IsDeclared('what_cdrom') == 0 Then 
$n = _GUICtrlComboBox_GetCurSel($cdrom_combo) + 1 
Else 
$n = $what_cdrom 
EndIf 

If $cdrom_open_close[$n] == 'close' Then 
CDTray($cdrom_get[$n], 'open') 
$cdrom_open_close[$n] = 'open' 
GUICtrlSetData($cdrom_button_open_close[$n], 'Закрыть: ' & $cdrom_get[$n] & '\') 
TrayItemSetText($tray_current[$n], 'Закрыть: ' & $cdrom_get[$n] & '\') 
ElseIf $cdrom_open_close[$n] == 'open' Then 
CDTray($cdrom_get[$n], 'close') 
$cdrom_open_close[$n] = 'close' 
GUICtrlSetData($cdrom_button_open_close[$n], 'Открыть: ' & $cdrom_get[$n] & '\') 
TrayItemSetText($tray_current[$n], 'Открыть: ' & $cdrom_get[$n] & '\') 
EndIf 
EndFunc 

Func _Select_input_key() 
$n = _GUICtrlComboBox_GetCurSel($cdrom_combo) + 1 
For $i = 1 to $cdrom_get[0] 
If $i <> $n Then 
_GuiCtrlHotKey_SetVisible($cdrom_key_input[$i], 0) 
GUICtrlSetState($cdrom_key_button[$i], $GUI_HIDE) 
GUICtrlSetState($cdrom_button_open_close[$i], $GUI_HIDE) 
Else 
_GuiCtrlHotKey_SetVisible($cdrom_key_input[$i], 1) 
GUICtrlSetState($cdrom_key_button[$i], $GUI_SHOW) 
GUICtrlSetState($cdrom_button_open_close[$i], $GUI_SHOW) 
EndIf 
Next 
EndFunc 

Func _Register_unregister_key() 
Local $get_key 
$n = _GUICtrlComboBox_GetCurSel($cdrom_combo)+1 
$get_key = _GuiCtrlHotKey_GetHotkey($cdrom_key_input[$n]) 
If GUICtrlRead($cdrom_key_button[$n]) == 'Назначить' Then 
If IsArray($get_key) Then _GuiCtrlHotKey_RegisterHotkey($win_main, $cdrom_key_id[$n], $get_key[0], $get_key[1]) 
GUICtrlSetData($cdrom_key_button[$n], 'Снять') 
ElseIf GUICtrlRead($cdrom_key_button[$n]) == 'Снять' Then 
_GuiCtrlHotKey_UnregisterHotkey($win_main, $cdrom_key_id[$n]) 
GUICtrlSetData($cdrom_key_button[$n], 'Назначить') 
EndIf 
EndFunc 

Func _GuiCtrlHotKey_SetVisible($hWnd, $sState = 5) 
_WinAPI_ShowWindow($hWnd, $sState) 
EndFunc 

; #FUNCTION# ==================================================================================================================== 
; Name...........: _GuiCtrlHotKey_Create 
; Description ...: Create a HotKey control 
; Syntax.........: _GuiCtrlHotKey_Create($hWnd, $sX, $sY[, $sWidth = 100[, $sHeight = 20[, $sStyle = 0]]]) 
; Parameters ....: $hWnd - Handle to parent or owner window 
; $iX - Horizontal position of the control 
; $iY - Vertical position of the control 
; $iWidth - Control width 
; $iHeight - Control height 
; $iStyle - Control styles 
; Return values .: Success - Handle to the HotKey control 
; Failure - 0 
; Author ........: R. Gilman (rasim) 
; =============================================================================================================================== 
Func _GuiCtrlHotKey_Create($hWnd, $sX, $sY, $sWidth = 100, $sHeight = 20, $sStyle = 0) 
$sStyle = BitOR($sStyle, $WS_CHILD, $WS_VISIBLE, $WS_TABSTOP) 

Local $hHotkey = _WinAPI_CreateWindowEx(0, "msctls_hotkey32", "", $sStyle, $sX, $sY, $sWidth, $sHeight, $hWnd) 
_SendMessage($hHotkey, $WM_SETFONT, _WinAPI_GetStockObject($DEFAULT_GUI_FONT), True) 

Return $hHotkey 
EndFunc ;==>_GuiCtrlHotKey_Create 

; #FUNCTION# ==================================================================================================================== 
; Name...........: _GuiCtrlHotKey_Destroy 
; Description ...: Delete the HotKey control 
; Syntax.........: _GuiCtrlHotKey_Destroy($hWnd) 
; Parameters ....: $hWnd - Handle to the control 
; Return values .: Success - True 
; Failure - False 
; Author ........: R. Gilman (rasim) 
; =============================================================================================================================== 
Func _GuiCtrlHotKey_Destroy($hWnd) 
Return _WinAPI_DestroyWindow($hWnd) 
EndFunc ;==>_GuiCtrlHotKey_Destroy 

; #FUNCTION# ==================================================================================================================== 
; Name...........: _GuiCtrlHotKey_GetHotkey 
; Description ...: Retrieve the virtual key code and modifier flags of a hot key from a HotKey control 
; Syntax.........: _GuiCtrlHotKey_GetHotkey($hWnd) 
; Parameters ....: $hWnd - Handle to the control 
; Return values .: Success - Array with the following format: 
; |[0] - virtual key code 
; |[1] - modifier flags 
; Failure - False 
; Author ........: R. Gilman (rasim) 
; =============================================================================================================================== 
Func _GuiCtrlHotKey_GetHotkey($hWnd) 
Local $iVal = _SendMessage($hWnd, $HKM_GETHOTKEY, 0, 0) 

If $iVal = 0 Then Return False 

Local $aRet[2] 
$aRet[0] = BitAND($iVal, 0x000000FF) ;The LOBYTE of the LOWORD is the virtual key code of the hot key 
$aRet[1] = BitShift($iVal, 8) ;The HIBYTE of the LOWORD is the key modifier that specifies the keys that _ 
;define a hot key combination 

Return $aRet 
EndFunc ;==>_GuiCtrlHotKey_GetHotkey 

; #FUNCTION# ==================================================================================================================== 
; Name...........: _GuiCtrlHotKey_SetHotkey 
; Description ...: Set the virtual key code and modifier flags of an HotKey control 
; Syntax.........: _GuiCtrlHotKey_SetHotkey($hWnd, $sVirtKey[, $sModKey]) 
; Parameters ....: $hWnd - Handle to the control 
; Return values .: Always returns zero 
; Author ........: R. Gilman (rasim) 
; =============================================================================================================================== 
Func _GuiCtrlHotKey_SetHotkey($hWnd, $sVirtKey, $sModKey = 0) 
_SendMessage($hWnd, $HKM_SETHOTKEY, _MakeWord($sVirtKey, $sModKey), 0) 
EndFunc ;==>_GuiCtrlHotKey_SetHotkey 

; #FUNCTION# ==================================================================================================================== 
; Name...........: _GuiCtrlHotKey_RegisterHotkey 
; Description ...: Defines a system-wide hot key 
; Syntax.........: _GuiCtrlHotKey_RegisterHotkey($hWnd, $sID, $sVirtKey, $sModKey) 
; Parameters ....: $hWnd - Handle to the main window that will receive messages generated by the hot key 
; $sID - The identifier of the hot key 
; $sVirtKey - The virtual-key code of the hot key 
; $sModKey - The modifier flags 
; Return values .: Success - 1 
; Failure - 0 
; Author ........: R. Gilman (rasim) 
; =============================================================================================================================== 
Func _GuiCtrlHotKey_RegisterHotkey($hWnd, $sID, $sVirtKey, $sModKey) 
Local $iModKey = 0, $aRet 

If BitAND($sModKey, $HOTKEYF_SHIFT) Then $iModKey = BitOR($iModKey, $MOD_SHIFT) 
If BitAND($sModKey, $HOTKEYF_CONTROL) Then $iModKey = BitOR($iModKey, $HOTKEYF_CONTROL) 
If BitAND($sModKey, $HOTKEYF_ALT) Then $iModKey = BitOR($iModKey, $MOD_ALT) 

$aRet = DllCall("user32.dll", "int", "RegisterHotKey", _ 
"hwnd", $hWnd, _ 
"int", $sID, _ 
"int", $iModKey, _ 
"int", "0x" & Hex($sVirtKey, 2)) 

If $aRet[0] <> 0 Then Return 1 
EndFunc ;==>_GuiCtrlHotKey_RegisterHotkey 

; #FUNCTION# ==================================================================================================================== 
; Name...........: _GuiCtrlHotKey_UnregisterHotkey 
; Description ...: Frees a hot key previously registered by the calling thread 
; Syntax.........: _GuiCtrlHotKey_UnregisterHotkey($hWnd, $sID) 
; Parameters ....: $hWnd - Handle to the main window that will receive messages generated by the hot key 
; $sID - The identifier of the hot key 
; Return values .: Success - 1 
; Failure - 0 
; Author ........: R. Gilman (rasim) 
; =============================================================================================================================== 
Func _GuiCtrlHotKey_UnregisterHotkey($hWnd, $sID) 
Local $aRet 
$aRet = DllCall("user32.dll", "int", "UnregisterHotKey", _ 
"hwnd", $hWnd, _ 
"int", $sID) 

If $aRet[0] <> 0 Then Return 1 
EndFunc ;==>_GuiCtrlHotKey_UnregisterHotkey 

; #FUNCTION# ==================================================================================================================== 
; Name...........: _MakeWord 
; Description ...: Creates a WORD value by concatenating the specified values 
; Syntax.........: _MakeWord($sLoBite, $sHiByte) 
; Parameters ....: $hWnd - Handle to the control 
; $sID - The identifier of the hot key 
; Return values .: The WORD value 
; Author ........: R. Gilman (rasim) 
; Remarks .......: Internal use only 
; =============================================================================================================================== 
Func _MakeWord($sLoBite, $sHiByte) 
Return BitOR($sLoBite, $sHiByte * 0x100) 
EndFunc ;==>_MakeWord 