GUICreate('Спрятать вкладки',310,155)
GUISetBkColor (0xFF0000)

GUICtrlCreateTab (0,0, 270,180,0x0100+0x0002+0x0004)

$tab0=GUICtrlCreateTabitem ("tab0")
GUICtrlCreateLabel('', 0, 0, 270, 165)
GUICtrlSetState(-1, 128) 
GUICtrlSetBkColor (-1, 0xFF0000 )

$xz=GUICtrlCreateButton ("X", 285,5,21,21,0x0040)
$vk2=GUICtrlCreateButton ("vk2", 40,10,29,21,0x0040)
GUICtrlCreateButton ("vk1", 10,10,29,21)
GUICtrlSetState(-1, 128) 

$tab1=GUICtrlCreateTabitem ("tab0")
GUICtrlCreateLabel('', 0, 0, 270, 165)
GUICtrlSetState(-1, 128) 
GUICtrlSetBkColor (-1, 0x00FF00 )

$vk1=GUICtrlCreateButton ("vk1", 10,10,29,21,0x0040)
GUICtrlCreateButton ("vk2", 40,10,29,21)
GUICtrlSetState(-1, 128) 

GUICtrlCreateTabitem ("")   ; конец вкладок
GUISetState ()
While 1
	$msg = GUIGetMsg()
	Select
		Case $msg =$vk2
			GUICtrlSetState($tab1,16)
			GUISetBkColor (0x00FF00)
		Case $msg =$vk1
			GUICtrlSetState($tab0,16)
			GUISetBkColor (0xFF0000)
		Case $msg = -3 Or $msg = $xz
			ExitLoop
	EndSelect
WEnd