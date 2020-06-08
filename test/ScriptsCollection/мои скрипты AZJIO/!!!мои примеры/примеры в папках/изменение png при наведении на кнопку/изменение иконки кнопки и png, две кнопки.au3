#include <GDIPlus.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiButton.au3>
#include <GuiImageList.au3>

$Gui=GUICreate('пример', 300, 220, -1, -1, BitOr($WS_BORDER, $WS_POPUP, $WS_SYSMENU))
; GUICreate('пример', 300, 220)

; =====================================
$hImage1 = _GUIImageList_Create(16, 16, 5, 3)
_GUIImageList_AddIcon($hImage1, "shell32.dll", 27)
_GUIImageList_AddIcon($hImage1, "shell32.dll", 112)
_GUIImageList_AddIcon($hImage1, "shell32.dll", 25)
_GUIImageList_AddIcon($hImage1, "shell32.dll", 25)
_GUIImageList_AddIcon($hImage1, "shell32.dll", 27)

$Button = GUICtrlCreateButton("", 300-27, 2, 25, 25)
_GUICtrlButton_SetImageList(-1, $hImage1, 1, 4)
; =====================================
$hImageList = _GUIImageList_Create(176, 21, 5) ; установите размер рисунка в параметрах
_GDIPlus_Startup() ; Инициализировать и выгружать GDIPlus можно реже, только при старте и по завершению использования
_Image($hImageList, @ScriptDir & '\yellow.png')
_Image($hImageList, @ScriptDir & '\green.png')
_Image($hImageList, @ScriptDir & '\blue.png')
_Image($hImageList, @ScriptDir & '\yellow.png')
_Image($hImageList, @ScriptDir & '\yellow.png')
_GDIPlus_Shutdown()
; =====================================
$Button1 = GUICtrlCreateButton("", 10, 50, 190, 30)
_GUICtrlButton_SetImageList(-1, $hImageList, 1)

; =====================================
$hImageList1 = _GUIImageList_Create(176, 21, 5) ; установите размер рисунка в параметрах
_GDIPlus_Startup()
_Image($hImageList1, @ScriptDir & '\yellow.png')
_Image($hImageList1, @ScriptDir & '\green.png')
_Image($hImageList1, @ScriptDir & '\blue.png')
_Image($hImageList1, @ScriptDir & '\yellow.png')
_Image($hImageList1, @ScriptDir & '\yellow.png')
_GDIPlus_Shutdown()
; =====================================
$Button2 = GUICtrlCreateButton("", 10, 90, 190, 30)
_GUICtrlButton_SetImageList(-1, $hImageList1, 1)

$StatusBar=GUICtrlCreateLabel('Строка состояния', 3, 220-20, 150, 17, 0xC)

GUISetState()

While 1
	Switch GUIGetMsg()
		Case $Button1
			GUICtrlSetData($StatusBar,'Button1')
		Case $Button2
			GUICtrlSetData($StatusBar,'Button2')
		Case $GUI_EVENT_CLOSE, $Button
			ExitLoop
	EndSwitch
WEnd

Func _Image($hImageList, $Path)
	$h_Image = _GDIPlus_BitmapCreateFromFile($Path)
	$h_Bitmap =_GDIPlus_BitmapCreateHBITMAPFromBitmap($h_Image)
	_GUIImageList_Add($hImageList, $h_Bitmap)
	_GDIPlus_ImageDispose($h_Image)
	_WinAPI_DeleteObject($h_Bitmap)
EndFunc