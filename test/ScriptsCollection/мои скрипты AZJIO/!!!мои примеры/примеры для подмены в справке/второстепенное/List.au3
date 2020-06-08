#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <ListboxConstants.au3>

$Gui = GUICreate('List',  620, 250, 11, 30)
$List = GUICtrlCreateList('', 10, 10,  150, 70, $GUI_SS_DEFAULT_LIST+$LBS_DISABLENOSCROLL)
GUICtrlSetData(-1,'$LBS_DISABLENOSCROLL|0x1000|прокрутка', '$LBS_DISABLENOSCROLL')
$List = GUICtrlCreateList('', 170, 10, 120, 70, $GUI_SS_DEFAULT_LIST+$LBS_NOSEL)
GUICtrlSetData(-1,'$LBS_NOSEL|0x4000|без выбора', '$LBS_NOSEL')
$List = GUICtrlCreateList('', 300, 10, 140, 70, $LBS_SORT)
GUICtrlSetData(-1,'$LBS_SORT|0x0002|сортировка', '$LBS_SORT')
$List = GUICtrlCreateList('', 450, 10, 140, -1, $LBS_STANDARD)
GUICtrlSetData(-1,'$LBS_STANDARD|0xA00003|стандарт', '$LBS_STANDARD')
$List = GUICtrlCreateList('', 10, 100, 140, -1, $LBS_USETABSTOPS)
GUICtrlSetData(-1,'$LBS_USETABSTOPS|0x0080|Разрешить	Tab', '$LBS_USETABSTOPS')

$t=''
For $i = 1 to 50
	$t&='|х'&$i
Next
$List = GUICtrlCreateList('', 170, 100,  170, 120, $GUI_SS_DEFAULT_LIST+$LBS_NOINTEGRALHEIGHT)
GUICtrlSetData(-1,'$LBS_NOINTEGRALHEIGHT|точная высота списка'&$t, '$LBS_NOINTEGRALHEIGHT')




GUISetState ()
Do
Until GUIGetMsg()=-3
