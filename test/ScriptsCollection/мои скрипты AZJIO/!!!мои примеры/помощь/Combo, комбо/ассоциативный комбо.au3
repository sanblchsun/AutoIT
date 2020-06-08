#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiComboBoxEx.au3>

Global $a[11][3] = [ _
		[10, 12, 10], _
		[1, 'текст 1', 1234], _
		[2, 'Привет', 390], _
		[3, 'ага', 879], _
		[4, 'второе', 45678], _
		[5, 'вчера', 8], _
		[6, 'код', 3], _
		[7, 'автоит', 6787], _
		[8, 'пример', 0365], _
		[9, 'асоцир', 3262], _
		[10, 'конец', 6554]]

$hGUI = GUICreate("Ассоциативный комбо", 300, 200)
$hCombo = _GUICtrlComboBoxEx_Create($hGUI, "", 42, 42, 90, 300)

For $i = 1 To $a[0][0]
	_GUICtrlComboBoxEx_AddString($hCombo, $a[$i][1])
	_GUICtrlComboBoxEx_SetItemParam($hCombo, $i - 1, $i)
Next
; _GUICtrlComboBoxEx_SetCurSel($hCombo, 0)

$StatusBar = GUICtrlCreateLabel('', 5, 5, 190, 17)

GUISetState()
GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")

While 1
	$msg = GUIGetMsg()
	Switch $msg
		Case -3
			Exit
	EndSwitch
WEnd

Func WM_COMMAND($hWnd, $iMsg, $iwParam, $ilParam)
	#forceref $hWnd, $iMsg
	Local $hWndFrom, $iIDFrom, $iCode
	$hWndFrom = $ilParam
	$iIDFrom = BitAND($iwParam, 0xFFFF) ; Low Word
	$iCode = BitShift($iwParam, 16) ; Hi Word
	Switch $hWndFrom
		Case $hCombo
			Switch $iCode
				Case $CBN_SELCHANGE
					$ind = _GUICtrlComboBoxEx_GetCurSel($hCombo)
					If $ind <> -1 Then
						$indAr = _GUICtrlComboBoxEx_GetItemParam($hCombo, $ind)
						GUICtrlSetData($StatusBar, $a[$indAr][0] & ', ' & $a[$indAr][1] & ', ' & $a[$indAr][2])
					EndIf
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_COMMAND