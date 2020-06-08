#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiListView.au3>
$hGui=GUICreate('My Program', 500, 340)
$iListView = GUICtrlCreateListView('колонка 1|колонка 2', 5, 5, 440, 330, BitOR($GUI_SS_DEFAULT_LISTVIEW, $LVS_REPORT, $LVS_SHOWSELALWAYS))
$hListView = GUICtrlGetHandle(-1)
For $i = 1 To 20
	$item1 = Random(10, 99, 1)
	$item2 = ''
	For $j = 1 To 9
		$item2 &= Chr(Random(192, 255, 1))
	Next
	GUICtrlCreateListViewItem($item1 & '|' & $item2, $iListView) ; создаём пункты
Next
GUISetState()
GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
While 1
	Switch GUIGetMsg()
		Case -3
			 Exit
	EndSwitch
WEnd

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
	Local $hWndFrom, $iCode, $tNMHDR, $iIDFrom, $itemText
	$tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	$iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
	$iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hWndFrom
		Case $hListView
			Switch $iCode
				Case $NM_DBLCLK ; двойной клик - редактируем пункт ListView
					Local $tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					$itemText=_GUICtrlListView_GetItemText($hListView, DllStructGetData($tInfo, "Index"), DllStructGetData($tInfo, "SubItem"))
					ClipPut($itemText)
					WinSetTitle($hGui, '', 'Текст "'&$itemText&'" скопирован в буфер обмена')
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc