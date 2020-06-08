Global $k=0
Global Const $GUI_RUNDEFMSG = 'GUI_RUNDEFMSG'
$Gui = GUICreate("Жми элементы", 390, 220)
$Input=GUICtrlCreateInput("Text", 10, 10, 75, 21)
$Checkbox = GUICtrlCreateCheckbox("Checkbox", 10, 40, 90, 17)
$Radio = GUICtrlCreateRadio("Radio", 10, 60, 90, 17)
$Button = GUICtrlCreateButton("Button", 10, 85, 75, 25, 0)
$Label = GUICtrlCreateEdit('Функция WM_COMMAND срабатывает в момент клика на элементах окна. Возвращает состояние Checkbox', 160, 5, 220, 210, 0x0004)
GUICtrlSetBkColor(-1, 0xffd7d7)
$List=GUICtrlCreateList('', 10, 115, 75, 55)
GUICtrlSetData($List,'Text1|Text2|Text3', 'Text3')
GUISetState()

GUIRegisterMsg(0x0111, "WM_COMMAND")

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case -3
			Exit
	EndSwitch
WEnd

Func WM_COMMAND($hWnd, $Msg, $wParam, $lParam)
    $nNotifyCode = BitShift($wParam, 16)
    $nID = BitAND($wParam, 0xFFFF)
    $hCtrl = $lParam
	
    Local $iIDFrom = BitAND($wParam, 0xFFFF)
    Local $iCode = BitShift($wParam, 16)
	Dim $aRead[2] = [GUICtrlRead($iIDFrom), GUICtrlRead($iIDFrom, 1)]

	GUICtrlSetData($Label, ' GUIHWnd' & @TAB & ':' & $hWnd & @CRLF & _
		' MsgID' & @TAB & ':' & $Msg & @CRLF & _
		' wParam' & @TAB & ':' & $wParam & @CRLF & _
		' lParam' & @TAB & ':' & $lParam & @CRLF & @CRLF & _
		' WM_COMMAND - Infos:' & @CRLF & _
		' -----------------------------' & @CRLF & _
		' Code' & @TAB & ':' & $nNotifyCode & @CRLF & _
		' CtrlID' & @TAB & ':' & $nID & @CRLF & _
		' CtrlHWnd' & @TAB & ':' & $hCtrl & @CRLF & _
		' -----------------------------' & @CRLF & _
		' '&GUICtrlRead($iIDFrom)&' - '&GUICtrlRead($iIDFrom, 1))
	$k+=1
	$GP = MouseGetPos()
	WinSetTitle($Gui, '', 'Кликнул ' &$k& ' раз, x='&$GP[0]&', y='&$GP[1])
EndFunc