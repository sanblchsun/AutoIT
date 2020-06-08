#include <ScrollBarConstants.au3>
#include <WindowsConstants.au3>
#include <Encoding.au3>
#include <GuiEdit.au3>

GUICreate('Ping Google', 600, 200)
GUISetFont(9, 400, -1, 'Tahoma')
$Edit = GUICtrlCreateEdit('', 10, 10, 580, 180, $WS_VSCROLL + $ES_READONLY)
GUICtrlSetBkColor(-1, 0xCCCC99)
$OK = GUICtrlCreateButton('OK', 280, 350, 60, 25)
GUISetState()
$PID = Run('ping -t 74.125.232.19', @SystemDir, @SW_HIDE, 2)
$EditText = ''
While 1
	$line = StdoutRead($PID)
	If @error Then ExitLoop
	$EditText &= $line
	If $line Then
		GUICtrlSetData($Edit, _Encoding_866To1251($EditText))
		_GUICtrlEdit_Scroll($Edit, $SB_BOTTOM)
	EndIf
	$msg = GUIGetMsg()
	Switch $msg
		Case -3, $OK
			ProcessClose($PID)
			Exit
	EndSwitch
WEnd