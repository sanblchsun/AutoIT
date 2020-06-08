; http://forum.ru-board.com/topic.cgi?&forum=5&topic=33902&start=780#16
; осуществил реализацию ViSiToR, добавил восстановление стартовой раскладки AZJIO
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>

$hGUI = GUICreate("Fix for hotkey/Accelerators assign problem", 300, 200)
$nEdit = GUICtrlCreateEdit("", 20, 40, 260, 120)

$nDummy = GUICtrlCreateDummy()
Dim $aAccelKeys[1][2] = [["^a", $nDummy]]

; если раскладка не совпадает с англ. яз. то временно переключаем в неё, чтобы зарегистрировать горячие клавиши
$tmp=0
$KeyLayout = RegRead("HKCU\Keyboard Layout\Preload", 1)
If Not @error And $KeyLayout <> 00000409 Then
	_WinAPI_LoadKeyboardLayout(0x0409)
	$tmp=1
EndIf

HotKeySet("^+e", "_Quit")
GUISetAccelerators($aAccelKeys)
If $tmp=1 Then _WinAPI_LoadKeyboardLayout(Dec($KeyLayout)) ; восстанавливаем раскладку по умолчанию

GUISetState(@SW_SHOW, $hGUI)

While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            Exit
        Case $nDummy
            GUICtrlSendMsg($nEdit, $EM_SETSEL, 0, -1)
    EndSwitch
WEnd

Func _Quit()
    Exit
EndFunc

Func _WinAPI_LoadKeyboardLayout($sLayoutID, $hWnd = 0)
    Local Const $WM_INPUTLANGCHANGEREQUEST = 0x50
    Local $aRet = DllCall("user32.dll", "long", "LoadKeyboardLayoutW", "wstr", Hex($sLayoutID, 8), "int", 0)

    If Not @error And $aRet[0] Then
        If $hWnd = 0 Then
            $hWnd = WinGetHandle(AutoItWinGetTitle())
        EndIf

        DllCall("user32.dll", "ptr", "SendMessage", "hwnd", $hWnd, "int", $WM_INPUTLANGCHANGEREQUEST, "int", 1, "int", $aRet[0])
        Return 1
    EndIf

    Return SetError(1)
EndFunc