; Пример меню для элементов, которые не имеют стандартного способа назначения контекстного меню
#include <GuiRichEdit.au3>
#include <GuiMenu.au3>
#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>

_Main()

Func _Main()
	Local $hGUI, $hMenu, $hRichEdit, $iContMenu, $iMenuItem1, $iMenuItem2
	$hGUI = GUICreate("Меню для RichEdit", 300, 220)
	$hRichEdit = _GUICtrlRichEdit_Create($hGUI, "", 10, 10, 200, 200, BitOR($WS_HSCROLL, $ES_AUTOVSCROLL, $ES_MULTILINE, $WS_VSCROLL))
	GUISetState()

	; Создаёт контекстное меню для пустышки
	$iContMenu = GUICtrlCreateContextMenu(GUICtrlCreateDummy())
	$hMenu = GUICtrlGetHandle($iContMenu)
	$iMenuItem1 = GUICtrlCreateMenuItem('Пункт 1', $iContMenu)
	$iMenuItem2 = GUICtrlCreateMenuItem('Пункт 2', $iContMenu)

	While 1
		Switch GUIGetMsg()
			Case $GUI_EVENT_SECONDARYUP
				_ShowMenu($hGUI, $hMenu, $hRichEdit)
			Case $iMenuItem1
				MsgBox(0, 'Сообщение', 'Событие 1')
			Case $iMenuItem2
				MsgBox(0, 'Сообщение', 'Событие 2')
			Case $GUI_EVENT_CLOSE
				_GUICtrlRichEdit_Destroy($hRichEdit)
				GUIDelete()
				ExitLoop
		EndSwitch
	WEnd
EndFunc   ;==>_Main

Func _ShowMenu($hGUI, $hMenu, $hControl)
	Local $hWnd, $tPoint, $x, $y
	$x = MouseGetPos(0)
	$y = MouseGetPos(1)
	$tPoint = DllStructCreate($tagPoint)
	DllStructSetData($tPoint, "x", $x)
	DllStructSetData($tPoint, "y", $y)
	$hWnd = _WinAPI_WindowFromPoint($tPoint)
	If Not @error And $hWnd = $hControl Then
		; DllCall("user32.dll", "int", "TrackPopupMenuEx", "hwnd", $hMenu, "int", 0, "int", $x, "int", $y, "hwnd", $hGUI, "ptr", 0)
		_GUICtrlMenu_TrackPopupMenu($hMenu, $hGUI, $x, $y, 1)
	EndIf
EndFunc   ;==>_ShowMenu