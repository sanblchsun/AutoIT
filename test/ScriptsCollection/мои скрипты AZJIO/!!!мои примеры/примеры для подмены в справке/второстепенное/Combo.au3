#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <ComboConstants.au3>

$Gui = GUICreate('Combo',  420, 250, 11, 30)
$Combo = GUICtrlCreateCombo('', 10, 10,  120, 90, $CBS_SIMPLE)
GUICtrlSetData(-1,'$CBS_SIMPLE|0x0001|раскрытый', '$CBS_SIMPLE')
$Combo = GUICtrlCreateCombo('', 140, 10, 140, -1, $CBS_DROPDOWN+$WS_VSCROLL)
GUICtrlSetData(-1,'ввод ограничен|111|222', 'ввод ограничен')
$Combo = GUICtrlCreateCombo('', 140, 40, 140, -1, $CBS_DROPDOWNLIST)
GUICtrlSetData(-1,'$CBS_DROPDOWNLIST|0x0003|статический', '$CBS_DROPDOWNLIST')
$Combo = GUICtrlCreateCombo('', 140, 70, 140, -1, $GUI_SS_DEFAULT_COMBO+$CBS_DISABLENOSCROLL)
GUICtrlSetData(-1,'$CBS_DISABLENOSCROLL|0x0800|прокрутка', '$CBS_DISABLENOSCROLL')
$Combo = GUICtrlCreateCombo('', 140, 100, 140, -1, $GUI_SS_DEFAULT_COMBO+$CBS_LOWERCASE)
GUICtrlSetData(-1,'$CBS_LOWERCASE|0x4000|ВСЁ СТРОЧНОЕ', '$CBS_LOWERCASE')
$Combo = GUICtrlCreateCombo('', 140, 130, 140, -1, $GUI_SS_DEFAULT_COMBO+$CBS_UPPERCASE)
GUICtrlSetData(-1,'$cbs_uppercase|0x4000|всё заглавное', '$cbs_uppercase')

$t=''
For $i = 1 to 50
	$t&='|'&$i
Next
$Combo = GUICtrlCreateCombo('', 140, 160,  140, 120, $GUI_SS_DEFAULT_COMBO+$CBS_NOINTEGRALHEIGHT)
GUICtrlSetData(-1,'$CBS_NOINTEGRALHEIGHT|учесть высоту списка'&$t, '$CBS_NOINTEGRALHEIGHT')




GUISetState ()
Do
Until GUIGetMsg()=-3
