#include <GUIConstantsEx.au3>
#include <TabConstants.au3>

$w = 270 ; ширина окна
$h = 180 ; высота окна
$wBt = 60 ; ширина кнопки
$BkCol1 = 0x83B493 ; цвет вкладок
$BkCol2 = 0xB4A663
$BkCol3 = 0x9C9C9C

$Gui1 = GUICreate(' нопки дл€ вкладок', $w, $h)
GUISetBkColor($BkCol1)
$vk1 = GUICtrlCreateButton('¬кладка 1', 0, 0, $wBt, 20)
$vk2 = GUICtrlCreateButton('¬кладка 2', 0, 20, $wBt, 20)
$vk3 = GUICtrlCreateButton('¬кладка 3', 0, 40, $wBt, 20)

GUICtrlCreateTab($wBt, 0, $w - $wBt, $h + 35, $TCS_BUTTONS + $TCS_BOTTOM)

$tab1 = GUICtrlCreateTabItem('1')
GUICtrlCreateLabel('', $wBt, 0, $w - $wBt, $h) ; подложка
GUICtrlSetBkColor(-1, $BkCol1)
GUICtrlSetState(-1, $GUI_DISABLE)

GUICtrlCreateLabel('¬кладки управл€емые кнопками', $wBt + 10, 20)
GUICtrlSetColor(-1, 0xa21a10)

$tab2 = GUICtrlCreateTabItem('2')
GUICtrlCreateLabel('', $wBt, 0, $w - $wBt, $h) ; подложка
GUICtrlSetBkColor(-1, $BkCol2)
GUICtrlSetState(-1, $GUI_DISABLE)

GUICtrlCreateEdit('', $wBt + 10, 10, $w - $wBt - 20, $h - 20)

$tab3 = GUICtrlCreateTabItem('3')
GUICtrlCreateLabel('', $wBt, 0, $w - $wBt, $h) ; подложка
GUICtrlSetBkColor(-1, $BkCol3)
GUICtrlSetState(-1, $GUI_DISABLE)

GUICtrlCreateCheckbox('CheckBox1', $wBt + 10, 10, 120, 17)

GUICtrlCreateTabItem('')

GUISetState()

While 1
	Switch GUIGetMsg()
		Case $vk1
			GUICtrlSetState($tab1, $GUI_SHOW) ; активаци€ вкладки использу€ кнопку
			GUISetBkColor($BkCol1)
		Case $vk2
			GUICtrlSetState($tab2, $GUI_SHOW)
			GUISetBkColor($BkCol2)
		Case $vk3
			GUICtrlSetState($tab3, $GUI_SHOW)
			GUISetBkColor($BkCol3)
		Case -3
			Exit
	EndSwitch
WEnd