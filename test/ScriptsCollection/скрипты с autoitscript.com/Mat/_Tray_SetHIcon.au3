; Mat
; http://www.autoitscript.com/forum/topic/115222-set-the-tray-icon-as-a-hicon
#include <WindowsConstants.au3>
#include <GDIPlus.au3>
#include <WinAPI.au3>

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

Global Const $NIM_ADD = 0
Global Const $NIM_MODIFY = 1

Global Const $NIF_MESSAGE = 1
Global Const $NIF_ICON = 2

Global Const $AUT_WM_NOTIFYICON = $WM_USER + 1 ; Application.h
Global Const $AUT_NOTIFY_ICON_ID = 1 ; Application.h

AutoItWinSetTitle("this is a test 123")
Global $TRAY_ICON_GUI = WinGetHandle(AutoItWinGetTitle()) ; Internal AutoIt GUI

;;;

_GDIPlus_Startup()

Local $hBitmap, $hImage, $hGraphic, $hIcon

$hBitmap = _WinAPI_CreateSolidBitmap(0, 0xFFFFFF, 16, 16)
$hImage = _GDIPlus_BitmapCreateFromHBITMAP($hBitmap)
$hGraphic = _GDIPlus_ImageGetGraphicsContext($hImage)

For $i = 99 To 1 Step -1
    _GDIPlus_GraphicsClear($hGraphic, 0xFFFFFFFF)
    _GDIPlus_GraphicsDrawString($hGraphic, $i, (StringLen($i) - 2) * - 3, 2, "Arial", 8)

    $hIcon = _GDIPlus_BitmapCreateHICONFromBitmap($hImage)
    _Tray_SetHIcon($hIcon)
    _WinAPI_DestroyIcon($hIcon)

    Sleep(200)
Next

_GDIPlus_ImageDispose($hImage)
_GDIPlus_GraphicsDispose($hGraphic)
_WinAPI_DeleteObject($hBitmap)

_GDIPlus_Shutdown()

;;;

Func _Tray_SetHIcon($hIcon)
    Local $tNOTIFY = DllStructCreate($tagNOTIFYICONDATA)
    DllStructSetData($tNOTIFY, "Size", DllStructGetSize($tNOTIFY))
    DllStructSetData($tNOTIFY, "Wnd", $TRAY_ICON_GUI)
    DllStructSetData($tNOTIFY, "ID", $AUT_NOTIFY_ICON_ID)
    DllStructSetData($tNOTIFY, "Icon", $hIcon)
    DllStructSetData($tNOTIFY, "Flags", BitOR($NIF_ICON, $NIF_MESSAGE))
    DllStructSetData($tNOTIFY, "CallbackMessage", $AUT_WM_NOTIFYICON)

    Local $aRet = DllCall("shell32.dll", "int", "Shell_NotifyIconW", "dword", $NIM_MODIFY, "ptr", DllStructGetPtr($tNOTIFY))
    If (@error) Then Return SetError(1, 0, 0)

    Return $aRet[0] <> 0
EndFunc   ;==>_Tray_SetHIcon

Func _GDIPlus_BitmapCreateHICONFromBitmap($hBitmap)
    Local $hIcon = DllCall($ghGDIPDll, "int", "GdipCreateHICONFromBitmap", "hwnd", $hBitmap, "int*", 0)
    If @error Or Not $hIcon[0] Then Return SetError(@error, @extended, $hIcon[2])

    Return $hIcon[2]
EndFunc   ;==>_GDIPlus_BitmapCreateHICONFromBitmap