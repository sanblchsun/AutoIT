; Пример подготовил AZJIO
; http://autoit-script.ru/index.php/topic,12101.msg78534.html#msg78534
#NoTrayIcon
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiTreeView.au3>

Opt("GUIResizeMode", 802) ; не перемещать элементы

; En
$LngTitle = 'Context menu, TreeView'
$LngPath = 'Path'
$LngInd = 'Index'
$LngDel = 'Delete'
$LngItm = 'Item'

; Ru
; если русская локализация, то русский язык
If @OSLang = 0419 Then
	$LngTitle = 'Контекстное меню TreeView'
	$LngPath = 'Путь из имён'
	$LngInd = 'Путь из индексов'
	$LngDel = 'Удалить'
	$LngItm = 'Пункт'
EndIf

$hGui = GUICreate($LngTitle, 350, 375, -1, -1, BitOR($GUI_SS_DEFAULT_GUI, $WS_OVERLAPPEDWINDOW, $WS_CLIPCHILDREN))

$iTreeView = GUICtrlCreateTreeView(5, 5, 200, 340, -1, $WS_EX_CLIENTEDGE + $WS_EX_COMPOSITED)
GUICtrlSetResizing(-1, 256 + 64 + 32 + 2)
$hTreeView = GUICtrlGetHandle(-1)

; Создаём пункты дерева
For $i = 0 To 10
	$tmp = GUICtrlCreateTreeViewItem($LngItm & ' ' & $i, $iTreeView)
	For $x = 0 To 3
		GUICtrlCreateTreeViewItem($LngItm & ' ' & $i & '_' & $x, $tmp)
	Next
Next

$iDummy = GUICtrlCreateDummy()

$ContMenu = GUICtrlCreateContextMenu($iDummy)
$hMenu = GUICtrlGetHandle($ContMenu)
$iCM_Path = GUICtrlCreateMenuItem($LngPath & @TAB & 'Enter', $ContMenu)
$iCM_Ind = GUICtrlCreateMenuItem($LngInd & @TAB & 'Ctrl+Enter', $ContMenu)
$iCM_Del = GUICtrlCreateMenuItem($LngDel & @TAB & 'Ctrl+Del', $ContMenu)

Dim $AccelKeys[3][2] = [["{Enter}", $iDummy],["^{DEL}", $iCM_Del],["^{Enter}", $iCM_Ind]] ; установка горячих клавиш на пункты контекстного меню
GUISetAccelerators($AccelKeys)

GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

GUISetState()
While 1
	Switch GUIGetMsg()
		Case $iCM_Path
			_OpenExplorer()
		Case $iCM_Del
			$hItem = _GUICtrlTreeView_GetSelection($hTreeView)
			_GUICtrlTreeView_Delete($hTreeView, $hItem)
		Case $iCM_Ind
			MsgBox(0, 'Сообщение', ControlTreeView($hGui, '', 'SysTreeView321', 'GetSelected', 1), 0, $hGui)
		Case $iDummy ; Событие по кнопке Enter, и действие взависимости от того, какой элемент в фокусе
			; MsgBox(0, '', ControlGetFocus($hGui), 0, $hGui)
			Switch ControlGetFocus($hGui)
				; Case 'Edit1'
				; _Read()
				; Case 'Edit4', 'Edit2', 'Edit3'
				; _Add()
				; Case 'SysListView321'
				; _OpenExplorer()
				Case 'SysTreeView321'
					_OpenExplorer()
			EndSwitch
		Case $GUI_EVENT_CLOSE
			Exit
	EndSwitch
WEnd

Func _OpenExplorer()
	$ind = ControlTreeView($hGui, '', 'SysTreeView321', 'GetSelected')
	MsgBox(0, 'Сообщение', $ind, 0, $hGui)
EndFunc   ;==>_OpenExplorer

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
	Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR

	$tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	$iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
	$iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hWndFrom
		Case $hTreeView
			Switch $iCode
				Case $NM_RCLICK ; Вызов контекстного меню правой кнопкой мыши
					Local $tMPos = _WinAPI_GetMousePos(True, $hWndFrom) ; координаты относительно элемента
					Local $hItem = _GUICtrlTreeView_HitTestItem($hWndFrom, DllStructGetData($tMPos, 1), DllStructGetData($tMPos, 2)) ; получаем дескриптор пункта
					If $hItem > 0 Then ; проверка, чтобы вызов был на пункте
						$x = MouseGetPos(0)
						$y = MouseGetPos(1)
						_GUICtrlTreeView_SelectItem($hTreeView, $hItem)
						DllCall("user32.dll", "int", "TrackPopupMenuEx", "hwnd", $hMenu, "int", 0, "int", $x, "int", $y, "hwnd", $hGui, "ptr", 0) ; заставляет появится меню в указанных координатах
					EndIf
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY