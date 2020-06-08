#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <SendMessage.au3>

$SC_DRAGMOVE = 0xF012

$HWND = GUICreate("", 300, 130, -1, -1, $WS_POPUP)
GUISetBkColor(0x4f4f4f)
$label = GUICtrlCreateLabel("Нажми и тащи!", 0, 0, 300, 130, 0x0200+0x1)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetFont(-1, 16, 700, 'Arial')
GUICtrlSetColor(-1, 0xffd7d7)
GUICtrlSetCursor(-1, 0)

; контекстное меню
$contextMenu = GUICtrlCreateContextMenu($label)
$closeitem = GUICtrlCreateMenuItem("Закрыть", $contextMenu)

GUISetState()

While 1
	$msg = GUIGetMsg()
	Switch $msg
		Case $GUI_EVENT_PRIMARYDOWN ; событие нажатия мыши
			_SendMessage($HWND, $WM_SYSCOMMAND, $SC_DRAGMOVE, 0) ; для перемещения окна за само окно
		Case $closeitem
			Exit
	EndSwitch
WEnd