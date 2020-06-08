#include <GDIP.au3>
#include <ScreenCapture.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hInst, $hIcon, $hBitmap
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	$hInst = _WinAPI_GetModuleHandle("user32.dll")
	$hIcon = _WinAPI_LoadIcon($hInst, 104)
	
	$hBitmap = _GDIPlus_BitmapCreateFromHICON($hIcon)
	
	; Save icon image to file
	_GDIPlus_ImageSaveToFile($hBitmap, @MyDocumentsDir & "\Information.jpg")
	
	; Clean up
	_GDIPlus_ImageDispose($hBitmap)
	_WinAPI_DestroyIcon($hIcon)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
	
	ShellExecute(@MyDocumentsDir & "\Information.jpg")
EndFunc