#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>

#include "GUICtrlCreateTFLabel.au3"

$hGUI = GUICreate("_GUICtrlCreateTFLabel Example #1", 300, 200)

$sLabel1_Data = _
	'some simple data and... <font color="red" size="8.5" weight="800" attrib="italic">My </font>' & _
	'<font color="blue" size="9" weight="800">Colored </font>' & _
	'<font color="darkgreen" attrib="underlined" size="8.5" name="Tahoma" cursor="POINTING">Label</font> data.'

$sLabel2_Data = _
	'<font top="1">and</font> ' & _
	'<font color="brown" size="9" weight="800">Few</font> ' & _
	'<font color="darkorange" size="9" weight="800" style="' & BitOr($GUI_SS_DEFAULT_LABEL, $SS_NOPREFIX) & '">&more&</font> ' & _
	'<font color="navy" size="12" weight="800" top="-2.5" name="Georgia">strings</font> <font top="1">data</font>.'

$nLabel1 = _GUICtrlCreateTFLabel($sLabel1_Data, 20, 20)
$nLabel2 = _GUICtrlCreateTFLabel($sLabel2_Data, 20, 50)

GUISetState(@SW_SHOW, $hGUI)

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			Exit
		Case $nLabel1[5]
			MsgBox(64, 'Hyperlink', GUICtrlRead($nLabel1[5]) & ' clicked.')
	EndSwitch
WEnd
