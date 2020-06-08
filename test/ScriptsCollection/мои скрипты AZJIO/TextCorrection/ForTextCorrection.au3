#include <WindowsConstants.au3>
#include <WinAPI.au3>

; Глобальные для _Tray_SetHIcon
Global Const $tagNOTIFYICONDATA = "dword Size;" & _
        "hwnd Wnd;" & _
        "uint ID;" & _
        "uint Flags;" & _
        "uint CallbackMessage;" & _
        "ptr Icon;" & _
        "wchar Tip[128];" & _
        "dword State;" & _
        "dword StateMask;" & _
        "wchar Info[256];" & _
        "uint Timeout;" & _
        "wchar InfoTitle[64];" & _
        "dword InfoFlags;" & _
        "dword Data1;word Data2;word Data3;byte Data4[8];" & _
        "ptr BalloonIcon"
Global Const $NIM_MODIFY = 1
Global Const $NIF_MESSAGE = 1
Global Const $NIF_ICON = 2
Global Const $AUT_WM_NOTIFYICON = $WM_USER + 1 ; Application.h
Global Const $AUT_NOTIFY_ICON_ID = 1 ; Application.h
AutoItWinSetTitle("Text_Correction_AZJIO")
Global $TRAY_ICON_GUI = WinGetHandle(AutoItWinGetTitle()) ; Internal AutoIt GUI

; Mat
; http://www.autoitscript.com/forum/topic/115222-set-the-tray-icon-as-a-hicon
Func _Tray_SetHIcon($hIcon)
    Local $tNOTIFY = DllStructCreate($tagNOTIFYICONDATA)
    DllStructSetData($tNOTIFY, "Size", DllStructGetSize($tNOTIFY))
    DllStructSetData($tNOTIFY, "Wnd", $TRAY_ICON_GUI)
    DllStructSetData($tNOTIFY, "ID", $AUT_NOTIFY_ICON_ID)
    DllStructSetData($tNOTIFY, "Icon", $hIcon)
    DllStructSetData($tNOTIFY, "Flags", BitOR($NIF_ICON, $NIF_MESSAGE))
    DllStructSetData($tNOTIFY, "CallbackMessage", $AUT_WM_NOTIFYICON)

    Local $aRet = DllCall("shell32.dll", "int", "Shell_NotifyIconW", "dword", $NIM_MODIFY, "ptr", DllStructGetPtr($tNOTIFY))
    If @error Then Return SetError(1, 0, 0)

    Return $aRet[0] <> 0
EndFunc   ;==>_Tray_SetHIcon

; _GUIImageList_ReplaceIcon
Func ExtractIcon($sFile, $iIndex = 0)
    Local $pIcon, $tIcon, $hIcon

    $tIcon = DllStructCreate("int Icon")
    $pIcon = DllStructGetPtr($tIcon)
    _WinAPI_ExtractIconEx($sFile, $iIndex, 0, $pIcon, 1)
    $hIcon = DllStructGetData($tIcon, "Icon")
	Return $hIcon
    ; _WinAPI_DestroyIcon($hIcon)
EndFunc

; http://www.autoitscript.com/forum/topic/103195-get-active-keyboard-layout/page__view__findpost__p__731367
; #FUNCTION# ====================================================================================================================
; Name...........: GetActiveKeyboardLayout() Function
; Description ...: Get Active keyboard layout

; Author ........: Fredj A. Jad (DCCD)
; MSDN  .........: GetWindowThreadProcessId Function  ,http://msdn.microsoft.com/en-us/library/ms633522(VS.85).aspx
; MSDN  .........: GetKeyboardLayout Function         ,http://msdn.microsoft.com/en-us/library/ms646296(VS.85).aspx
; ===============================================================================================================================
Func GetActiveKeyboardLayout($hWnd)
    Local $aRet = DllCall('user32.dll', 'long', 'GetWindowThreadProcessId', 'hwnd', $hWnd, 'ptr', 0)
    $aRet = DllCall('user32.dll', 'long', 'GetKeyboardLayout', 'long', $aRet[0])
    Return '0000' & Hex($aRet[0], 4)
EndFunc   ;==>GetActiveKeyboardLayout

; переключение раскладки клавиатуры
Func _SetKeyboardLayout($sLayoutID, $hWnd)
	Local $ret = DllCall("user32.dll", "long", "LoadKeyboardLayout", "str", $sLayoutID, "int", 0)
	DllCall("user32.dll", "int", "SendMessage", "hwnd", $hWnd, "int", 0x50, "int", 1, "int", $ret[0])
EndFunc   ;==>_SetKeyboardLayout

; Получает сочетание горячей клавиши из кода
Func _GetKey($HotkeyCode)
	Local $HiW, $Key
	$HiW = _WinAPI_HiWord($HotkeyCode)

	If BitAND($HiW, $HOTKEYF_CONTROL) Then $Key &= ' + Ctrl'
	If BitAND($HiW, $HOTKEYF_SHIFT) Then $Key &= ' + Shift'
	If BitAND($HiW, $HOTKEYF_ALT) Then $Key &= ' + Alt'

	$Key &= ' + ' & Chr(_WinAPI_LoWord($HotkeyCode))
	$Key = StringTrimLeft($Key, 3)

	Return $Key
EndFunc