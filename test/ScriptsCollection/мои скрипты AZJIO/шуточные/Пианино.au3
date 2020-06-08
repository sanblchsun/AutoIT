#include <GUIConstants.au3>
AutoItSetOption("TrayIconHide", 1) ;скрыть в системной панели индикатор AutoIt

GUICreate("Фортепиано",230,60) ; размер окна
GUISetFont(9, 300)
$tab=GUICtrlCreateTab (10,10, 210,40) ; размер вкладки


$tabBut001=GUICtrlCreateButton ("до", 20,20,20,20)
GUICtrlSetTip(-1, "до")
$tabBut002=GUICtrlCreateButton ("ре", 45,20,20,20)
GUICtrlSetTip(-1, "после")
$tabBut003=GUICtrlCreateButton ("ми", 70,20,20,20)
GUICtrlSetTip(-1, "ми")
$tabBut004=GUICtrlCreateButton ("фа", 95,20,20,20)
GUICtrlSetTip(-1, "фа")
$tabBut005=GUICtrlCreateButton ("соль", 120,20,40,20)
GUICtrlSetTip(-1, "соль")
$tabBut006=GUICtrlCreateButton ("ля", 165,20,20,20)
GUICtrlSetTip(-1, "сахар")
$tabBut007=GUICtrlCreateButton ("си", 190,20,20,20)
GUICtrlSetTip(-1, "си")

GUICtrlCreateTabitem ("")   ; конец вкладок

GUISetState ()

	While 1
		$msg = GUIGetMsg()
		Select
			Case $msg = $tabBut001
				Beep(2092, 500)
            Case $msg = $tabBut002
				Beep(2349, 500)
            Case $msg = $tabBut003
				Beep(2637, 500)
            Case $msg = $tabBut004
				Beep(2793, 500)
            Case $msg = $tabBut005
				Beep(3135, 500)
            Case $msg = $tabBut006
				Beep(3520, 500)
            Case $msg = $tabBut007
				Beep(3951, 500)
			Case $msg = $GUI_EVENT_CLOSE
				ExitLoop
		EndSelect
	WEnd