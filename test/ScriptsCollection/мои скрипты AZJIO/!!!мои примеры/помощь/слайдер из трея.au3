#include <SliderConstants.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <Constants.au3>
Opt("TrayMenuMode",3)
Opt("TrayOnEventMode",1)
TraySetToolTip("Мой слайдер")
$Gui=GUICreate('My Program', 70, 220, @DesktopWidth-100,@DesktopHeight-260,$WS_POPUP+$WS_BORDER, $WS_EX_TOOLWINDOW+$WS_EX_CONTROLPARENT)
GUISetBkColor(0xFFFFAA)
$Button1=GUICtrlCreateButton('X', 70-24, 2, 22, 22)
$Slider=GUICtrlCreateSlider(10, 24, 50, 180, $TBS_VERT+$TBS_LEFT+$TBS_AUTOTICKS)
GUICtrlSetLimit(-1, 200)
$Label1=GUICtrlCreateLabel('   Тащи', 2, 2, 44, 22,-1, $GUI_WS_EX_PARENTDRAG)
GUICtrlSetBkColor(-1, 0xACCDEF)
$Label2=GUICtrlCreateLabel('   Тащи', 2, 200, 66, 19,-1, $GUI_WS_EX_PARENTDRAG)
GUICtrlSetBkColor(-1, 0xACCDEF)
TraySetOnEvent($TRAY_EVENT_PRIMARYDOUBLE,"_MUTE")
TraySetIcon("Shell32.dll",11)

While 1
	$msg = GUIGetMsg()
	Switch $msg
		Case $Slider
			MsgBox(0, 'Величина слайдера', GUICtrlRead($Slider))
		Case $Button1
			 Exit
	EndSwitch
WEnd

Func _MUTE()
	$state = WinGetState($Gui)
	If BitAnd($state, 2) Then
		GUISetState(@SW_HIDE,$Gui)
		TraySetIcon("Shell32.dll",11)
	Else
		GUISetState(@SW_SHOW,$Gui)
		TraySetIcon("Shell32.dll",10)
	EndIf
EndFunc