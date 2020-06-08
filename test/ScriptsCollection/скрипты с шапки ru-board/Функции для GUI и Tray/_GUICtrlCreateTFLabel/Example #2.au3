#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

#include "GUICtrlCreateTFLabel.au3"

$hGUI = GUICreate("_GUICtrlCreateTFLabel Example #2", 300, 200)

$a3DfaceColor = DllCall("User32.dll", "int", "GetSysColor", "int", 15) ;$COLOR_3DFACE
$n3DfaceColor = BitAND(BitShift(String(Binary($a3DfaceColor[0])), 8), 0xFFFFFF) ;RGB2BGR

$sLabel_Data = _
	'<font color="blue" bkcolor="' & $n3DfaceColor & '" size="9" weight="800">My </font>' & _
	'<font color="red" bkcolor="' & $n3DfaceColor & '" size="9" weight="800">Button</font>'

$aLabel_Ctrls = _GUICtrlCreateTFLabel($sLabel_Data, 20, 50)

$nButton = GUICtrlCreateButton("", 12, 45, 70, 25, $WS_CLIPSIBLINGS)
GUICtrlSetBkColor(-1, $n3DfaceColor)

GUISetState(@SW_SHOW, $hGUI)

While 1
	$nMsg = GUIGetMsg()
	
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $aLabel_Ctrls[1] To $aLabel_Ctrls[$aLabel_Ctrls[0]]
			$aCurInfo = GUIGetCursorInfo($hGUI)
			
			While $aCurInfo[2] = 1
				Sleep(10)
				$aCurInfo = GUIGetCursorInfo($hGUI)
			WEnd
			
			If $aCurInfo[4] = $nMsg Then ControlClick($hGUI, "", $nButton)
		Case $nButton
			MsgBox(64, 'Title', 'Button pressed')
	EndSwitch
WEnd