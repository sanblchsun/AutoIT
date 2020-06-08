#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiListView.au3>

Opt("GUIOnEventMode", 1)
Global $aElement[2], $hActive, $iInput
Global $iListView, $hListView, $dummy1, $dummy2

$hGUI = GUICreate('Двойной клик на элементе', 450, 360)
GUISetOnEvent(-3, '_Exit')
$iInput = GUICtrlCreateInput("", 0, 0, 0, 0)
GUICtrlSetState(-1, $GUI_HIDE)
$iListView = GUICtrlCreateListView('колонка 1|колонка 2', 5, 5, 440, 330, BitOR($GUI_SS_DEFAULT_LISTVIEW, $LVS_REPORT, $LVS_SHOWSELALWAYS))
$hListView = GUICtrlGetHandle(-1)
; _GUICtrlListView_SetExtendedListViewStyle ($hListView, $LVS_EX_GRIDLINES)

For $i = 1 To 20
	$item1 = Random(10, 99, 1)
	$item2 = ''
	For $j = 1 To 9
		$item2 &= Chr(Random(192, 255, 1))
	Next
	GUICtrlCreateListViewItem($item1 & '|' & $item2, $iListView) ; создаём пункты
Next

GUICtrlCreateButton('Button', 10, 340, 70, 25)

$dummy1 = GUICtrlCreateDummy()
GUICtrlSetOnEvent(-1, "_Exit")
$dummy2 = GUICtrlCreateDummy()
GUICtrlSetOnEvent(-1, "_SaveChange")
Global $AccelKeys[2][2] = [["{ESC}", $dummy1],["{ENTER}", $dummy2]]
GUISetAccelerators($AccelKeys)
GUISetState()
GUIRegisterMsg(0x4E, "_WM_NOTIFY")
GUIRegisterMsg($WM_COMMAND, "WM_COMMAND") ; для скрытия поля ввода при потере фокуса.

While 1
	Sleep(100000)
WEnd

; Выводит элемент Input на передний план
Func _GUICtrlListView_EditItem($hWnd, $iIndex, $iSubItem)
	;funkey 19.02.2010
	If $iIndex < 0 Then Return
	Local $aPos, $aRect, $iSum = 0
	Local $x, $y, $w, $h
	For $i = 0 To $iSubItem - 1
		$iSum += _GUICtrlListView_GetColumnWidth($hWnd, $i)
	Next
	$aRect = _GUICtrlListView_GetItemRect($hWnd, $iIndex)
	$aPos = ControlGetPos($hGUI, "", $hWnd)
	$x = $iSum + $aPos[0] + $aRect[0]
	$y = $aPos[1] + $aRect[1]
	$w = _GUICtrlListView_GetColumnWidth($hWnd, $iSubItem)
	$h = $aRect[3] - $aRect[1]
	GUICtrlSetPos($iInput, $x - 1, $y + 1, $w + 1, $h + 1)
	GUICtrlSetData($iInput, _GUICtrlListView_GetItemText($hWnd, $iIndex, $iSubItem))
	GUICtrlSetState($iInput, $GUI_SHOW)
	GUICtrlSetState($iInput, $GUI_FOCUS)
	$aElement[0] = $iIndex
	$aElement[1] = $iSubItem
EndFunc

; Сохранить изменения редактирования пункта
Func _SaveChange()
	Local $sText = GUICtrlRead($iInput)
	If StringInStr($sText, @CR) Or StringInStr($sText, @LF) Then
		If StringLeft($sText, 1) <> '"' And StringInStr(StringMid($sText, 2, StringLen($sText) - 2), '"') Then $sText = StringReplace($sText, '"', "'")
		$sText = '"' & StringReplace($sText, '"', '') & '"'
	EndIf
	_GUICtrlListView_BeginUpdate($hActive)
	_GUICtrlListView_SetItemText($hActive, $aElement[0], $sText, $aElement[1])
	GUICtrlSetState($iInput, $GUI_HIDE)
	_GUICtrlListView_SetColumnWidth($hListView, $aElement[1], -2) ;$LVSCW_AUTOSIZE_USEHEADER
	_GUICtrlListView_EndUpdate($hActive)
	Return $sText ; возвращаем текст, если требуется его использовать после применения
EndFunc

Func _WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
	Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR
	$tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	$iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
	$iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hWndFrom
		Case $hListView
			Switch $iCode
				Case $NM_DBLCLK ; двойной клик - редактируем пункт ListView
					Local $tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					_GUICtrlListView_EditItem($hListView, DllStructGetData($tInfo, "Index"), DllStructGetData($tInfo, "SubItem"))
					$hActive = $hListView
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc

Func WM_COMMAND($hWnd, $iMsg, $iwParam, $ilParam)
	#forceref $hWnd, $iMsg
	Local $iIDFrom, $iCode
	$iIDFrom = BitAND($iwParam, 0xFFFF) ; младшее слово
	$iCode = BitShift($iwParam, 16) ; старшее слово
	Switch $iIDFrom
		Case $iInput
			Switch $iCode
				Case $EN_KILLFOCUS
					GUICtrlSetState($iInput, $GUI_HIDE)
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc

Func _Exit()
	Exit
EndFunc