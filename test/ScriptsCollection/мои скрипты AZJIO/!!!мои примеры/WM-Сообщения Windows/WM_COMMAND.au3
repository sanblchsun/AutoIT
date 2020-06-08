Global $k=0
Global Const $GUI_RUNDEFMSG = 'GUI_RUNDEFMSG'
$Gui = GUICreate("Жми элементы", 340, 170)
$Input=GUICtrlCreateInput("Text", 10, 10, 310, 21)
$Checkbox = GUICtrlCreateCheckbox("Checkbox", 10, 40, 90, 17)
$Radio = GUICtrlCreateRadio("Radio", 10, 60, 90, 17)
$Button = GUICtrlCreateButton("Button", 10, 85, 75, 25, 0)
GUICtrlCreateLabel('Функция WM_COMMAND срабатывает в момент клика на элементах окна. Возвращает состояние Checkbox', 100, 40, 220, 44)
GUICtrlSetBkColor(-1, 0xffd7d7)
$List=GUICtrlCreateList('', 100, 90, 220, 70)
GUICtrlSetData($List,'Text1|Text2|Text3|Text4', 'Text3')
GUISetState()

GUIRegisterMsg(0x0111, "WM_COMMAND")

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case -3
			Exit
	EndSwitch
WEnd

Func WM_COMMAND($hWnd, $MsgID, $WParam, $LParam)
    Local $iIDFrom = BitAND($wParam, 0xFFFF)
    Local $iCode = BitShift($wParam, 16)
	Dim $aRead[2] = [GUICtrlRead($iIDFrom), GUICtrlRead($iIDFrom, 1)]
	GUICtrlSetData($Input, $aRead[0]&' - '&$aRead[1])
	
	$k+=1
	$GP = MouseGetPos()
	WinSetTitle($Gui, '', 'Кликнул ' &$k& ' раз, x='&$GP[0]&', y='&$GP[1])
	
    Return $GUI_RUNDEFMSG
EndFunc