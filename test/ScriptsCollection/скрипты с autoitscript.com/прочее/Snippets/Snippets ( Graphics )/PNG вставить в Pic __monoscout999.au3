#include <GDIPlus.au3>
#include <Constants.au3>
#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
 
Global Const $SC_MOVE = 0xF010
Global Const $STM_SETIMAGE = 0x172
 
; This Is For Getting The PNG From a URL
$PngFile = @ScriptDir & "\MyPNG.png"
$Inet = InetGet("http://img26.imageshack.us/img26/7439/boton3p.png", $PngFile)
 
;Here is the GUI creation
$hGUI = GUICreate("PNG Pic by monoscout999")
GUISetBkColor(0x123456, $hGUI)
$Pic = GUICtrlCreatePic("", 10, 10, 50, 50)
_SetPNGIntoPicControl($Pic, $PngFile)
GUISetState()
 
While True
	$msg = GUIGetMsg()
	Switch $msg
		Case -3
			Exit
		Case $GUI_EVENT_PRIMARYDOWN
			_ControlMove($Pic)
	EndSwitch
WEnd
 
; Here is the function declared
Func _SetPNGIntoPicControl($iPic, $sPNGFile)
	_GDIPlus_Startup()
	Local $hImage = _GDIPlus_ImageLoadFromFile($sPNGFile)
	Local $hBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)
	_WinAPI_DeleteObject(GUICtrlSendMsg($iPic, $STM_SETIMAGE, $IMAGE_BITMAP, $hBitmap))
	_WinAPI_DeleteObject($hBitmap)
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_Shutdown()
EndFunc	;==>_SetPNGIntoPicControl
 
Func _ControlMove($cID)
	Local $aCurPos = GUIGetCursorInfo()
	If @error Then Return False
	If $aCurPos[4] = $cID Then
		GUICtrlSendMsg($cID, $WM_SYSCOMMAND, BitOR($SC_MOVE, $HTCAPTION), 0)
	EndIf
EndFunc	;==>_ControlMove