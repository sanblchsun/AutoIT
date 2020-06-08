#include <WindowsConstants.au3>
#include <WinAPI.au3>

$hScreenDC = _WinAPI_GetWindowDC(0)
$hMemDC = _WinAPI_CreateCompatibleDC($hScreenDC)
$hMemBMP = _WinAPI_CreateCompatibleBitmap($hScreenDC, @DesktopWidth * 2, @DesktopHeight)
_WinAPI_DeleteObject(_WinAPI_SelectObject($hMemDC, $hMemBMP))
_WinAPI_BitBlt($hMemDC, 0, 0, @DesktopWidth, @DesktopHeight, $hScreenDC, 0, 0, $SRCCOPY)
_WinAPI_BitBlt($hMemDC, @DesktopWidth, 0, @DesktopWidth, @DesktopHeight, $hScreenDC, 0, 0, $SRCCOPY)

For $i = @DesktopWidth To 0 Step -8
	_WinAPI_BitBlt($hScreenDC, 0, 0, @DesktopWidth, @DesktopHeight, $hMemDC, $i, 0, $SRCCOPY)
	Sleep(20)
Next

_WinAPI_RedrawWindow(_WinAPI_GetDesktopWindow(), 0, 0, $RDW_INVALIDATE + $RDW_ALLCHILDREN)
_WinAPI_ReleaseDC(0, $hScreenDC)
_WinAPI_DeleteObject($hMemBMP)
_WinAPI_DeleteDC($hMemDC)

Exit

; Edited - for up/down move - Malkey

#include <WindowsConstants.au3>
#include <WinAPI.au3>

$hScreenDC = _WinAPI_GetWindowDC(0)
$hMemDC = _WinAPI_CreateCompatibleDC($hScreenDC)
$hMemBMP = _WinAPI_CreateCompatibleBitmap($hScreenDC, @DesktopWidth, @DesktopHeight * 2)
_WinAPI_DeleteObject(_WinAPI_SelectObject($hMemDC, $hMemBMP))
_WinAPI_BitBlt($hMemDC, 0, 0, @DesktopWidth, @DesktopHeight, $hScreenDC, 0, 0, $SRCCOPY)
_WinAPI_BitBlt($hMemDC, 0, @DesktopHeight, @DesktopWidth, @DesktopHeight, $hScreenDC, 0, 0, $SRCCOPY)

For $i = 0 To @DesktopHeight Step 8 ;scroll Up
	;For $i = @DesktopHeight To 0 Step -8 ;scroll Down
	_WinAPI_BitBlt($hScreenDC, 0, 0, @DesktopWidth, @DesktopHeight, $hMemDC, 0, $i, $SRCCOPY)
	Sleep(20)
Next

_WinAPI_RedrawWindow(_WinAPI_GetDesktopWindow(), 0, 0, $RDW_INVALIDATE + $RDW_ALLCHILDREN)
_WinAPI_ReleaseDC(0, $hScreenDC)
_WinAPI_DeleteObject($hMemBMP)
_WinAPI_DeleteDC($hMemDC)

Exit