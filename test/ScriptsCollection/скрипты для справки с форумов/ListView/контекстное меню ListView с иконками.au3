; Пример подготовил AZJIO
#NoTrayIcon
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiListView.au3>
#include <ModernMenuRaw.au3>

Opt("GUIResizeMode", 802) ; не перемещать элементы

; En
$LngTitle = 'Context menu, ListView'
$LngPath = 'Text'
$LngInd = 'Index'
$LngDel = 'Delete'
$LngItm = 'Item'

; Ru
; если русская локализация, то русский язык
If @OSLang = 0419 Then
	$LngTitle = 'Контекстное меню ListView'
	$LngPath = 'Текст пункта'
	$LngInd = 'Индекс'
	$LngDel = 'Удалить'
	$LngItm = 'Пункт'
EndIf

$hGui = GUICreate($LngTitle, 350, 375, -1, -1, BitOR($GUI_SS_DEFAULT_GUI, $WS_OVERLAPPEDWINDOW, $WS_CLIPCHILDREN))

$iListView = GUICtrlCreateListView('Name|Command|Name Menu', 5, 5, 340, 350, -1, BitOR($LVS_EX_DOUBLEBUFFER, $LVS_EX_FULLROWSELECT, $LVS_EX_INFOTIP, $WS_EX_CLIENTEDGE))
GUICtrlSetResizing(-1, 7 + 32 + 64)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)
$hListView = GUICtrlGetHandle(-1)
GUICtrlSendMsg($iListView, $LVM_SETCOLUMNWIDTH, 0, 100)
GUICtrlSendMsg($iListView, $LVM_SETCOLUMNWIDTH, 1, 115)
GUICtrlSendMsg($iListView, $LVM_SETCOLUMNWIDTH, 2, 100)

; Создаём пункты
For $i = 0 To 10
	GUICtrlCreateListViewItem($LngItm & ' ' & $i, $iListView)
Next

$iDummy = GUICtrlCreateDummy()

$ContMenu = GUICtrlCreateContextMenu($iDummy)
$hMenu = GUICtrlGetHandle($ContMenu)
$iCM_Path	= _GUICtrlCreateODMenuItem($LngPath & @TAB & 'Enter', $ContMenu, "shell32.dll", -71)
$iCM_Ind	= _GUICtrlCreateODMenuItem($LngInd & @TAB & 'Ctrl+Enter', $ContMenu, "shell32.dll", -24)
$iCM_Del	= _GUICtrlCreateODMenuItem($LngDel & @TAB & 'Ctrl+Del', $ContMenu, "shell32.dll", -132)

Dim $AccelKeys[3][2] = [["{Enter}", $iDummy],["^{DEL}", $iCM_Del],["^{Enter}", $iCM_Ind]] ; установка горячих клавиш на пункты контекстного меню
GUISetAccelerators($AccelKeys)

GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

GUISetState()
While 1
	Switch GUIGetMsg()
		Case $iCM_Path
			_OpenExplorer()
		Case $iCM_Del
			$iIndex = ControlListView($hGui, '', 'SysListView321', 'GetSelected')
			If _GUICtrlListView_GetItemSelected($hListView, $iIndex) Then _GUICtrlListView_DeleteItem($hListView, $iIndex)
		Case $iCM_Ind
			MsgBox(0, 'Сообщение', ControlListView($hGui, '', 'SysListView321', 'GetSelected'), 0, $hGui)
		Case $iDummy ; Событие по кнопке Enter, и действие взависимости от того, какой элемент в фокусе
			; MsgBox(0, '', ControlGetFocus($hGui), 0, $hGui)
			Switch ControlGetFocus($hGui)
				; Case 'Edit1'
				; _Read()
				; Case 'Edit4', 'Edit2', 'Edit3'
				; _Add()
				Case 'SysListView321'
					_OpenExplorer()
					; Case 'SysTreeView321'
					; _OpenExplorer()
			EndSwitch
		Case $GUI_EVENT_CLOSE
			Exit
	EndSwitch
WEnd

Func _OpenExplorer()
	$ind = ControlListView($hGui, '', 'SysListView321', 'GetSelected')
	MsgBox(0, 'Сообщение', ControlListView($hGui, '', 'SysListView321', 'GetText', $ind), 0, $hGui)
EndFunc   ;==>_OpenExplorer

Func WM_NOTIFY($hWnd, $iMsg, $wParam, $lParam)
	Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR, $tInfo

	$tNMHDR = DllStructCreate($tagNMHDR, $lParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	$iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
	$iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hWndFrom
		Case $hListView
			Switch $iCode
				Case $NM_DBLCLK ; левый двойной клик мышкой по пункту
					_OpenExplorer()

				Case $NM_RCLICK ; правый клик мышкой по пункту
					$tInfo = DllStructCreate($tagNMITEMACTIVATE, $lParam)
					Local $aSel = DllStructGetData($tInfo, "Index")
					If $aSel <> -1 Then
						$x = MouseGetPos(0)
						$y = MouseGetPos(1)
						DllCall("user32.dll", "int", "TrackPopupMenuEx", "hwnd", $hMenu, "int", 0, "int", $x, "int", $y, "hwnd", $hGui, "ptr", 0)
					EndIf
			EndSwitch
	EndSwitch

	$tNMHDR = 0
	$tInfo = 0
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY