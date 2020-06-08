#include <StaticConstants.au3>
#include <GDIPlus.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiButton.au3>
#include <GuiImageList.au3>

$Gui=GUICreate('пример', 300, 220, -1, -1, BitOr($WS_BORDER, $WS_POPUP, $WS_SYSMENU))
; GUICtrlCreateLabel(' Таскать можно', 0, 0, 277, 22, $SS_CENTERIMAGE, $GUI_WS_EX_PARENTDRAG)
; GUICtrlSetBkColor(-1, 0xa3c3ff)
$n = GUICtrlCreatePic(@ScriptDir&"\Frame.gif", 0, 0, 277, 22, -1, $GUI_WS_EX_PARENTDRAG)

; =====================================
$hImageList = _GUIImageList_Create(176, 21, 5)
_GDIPlus_Startup()
_Image(@ScriptDir & '\yellow.png')
_Image(@ScriptDir & '\green.png')
_Image(@ScriptDir & '\blue.png')
_Image(@ScriptDir & '\yellow.png')
_Image(@ScriptDir & '\yellow.png')
_GDIPlus_Shutdown()
; =====================================
$hBtn1 = _GUICtrlButton_Create($Gui, "", 10, 50, 22, 23)
_GUICtrlButton_SetImageList($hBtn1, $hImageList, 0, -10*16)

$Button1 = GUICtrlCreateButton("", 40, 50, 22, 23)
_GUICtrlButton_SetImageList(-1, $hImageList, 0, -4*16)

$Button1 = GUICtrlCreateButton("", 70, 50, 22, 23)
_GUICtrlButton_SetImageList(-1, $hImageList, 0, -2*16)

$Button = GUICtrlCreateButton("", 300-23, 0, 23, 23)
_GUICtrlButton_SetImageList(-1, $hImageList, 0, -1)

GUISetState()

While 1
	Switch GUIGetMsg()
		Case $Button1
			MsgBox(0, 'Сообщение', 'е')
		Case $GUI_EVENT_CLOSE, $Button
			ExitLoop
	EndSwitch
WEnd


Func _Image($Path)
	$h_Image = _GDIPlus_BitmapCreateFromFile($Path)
	$h_Bitmap =_GDIPlus_BitmapCreateHBITMAPFromBitmap($h_Image)
	_GUIImageList_Add($hImageList, $h_Bitmap)
	_GDIPlus_ImageDispose($h_Image)
	_WinAPI_DeleteObject($h_Bitmap)
EndFunc