#include <Array.au3>
#include <GUIConstants.au3>
#include <GUIScrollbars.au3>
HotKeySet("{F5}", "Act")
Opt("GUIOnEventMode", 1)

$hGUI = GUICreate("DesktopEx", @DesktopWidth, @DesktopHeight, 0, 0, $WS_POPUP)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
$hLabel = GUICtrlCreatelabel("I'm a Label", 0, 0, 1800, 25, $ES_CENTER)
_GUIScrollBars_Init($hGUI)
_GUIScrollBars_EnableScrollBar($hGUI, $SB_VERT, $ESB_ENABLE_BOTH)

GUISetState(@SW_SHOW)

While 1
	sleep(10000)
WEnd

Func Act()
	$Windows = GetWindows()
EndFunc

Func GetWindows()
	Local $hWinlist[0]
	Local $hWindows[0]
	$hWinlist = WinList()
	for $i = 0 to UBound ($hWinlist)-1 step +1
		If BitAND(WinGetState($hWinlist[$i][1]), 2) and $hWinlist[$i][0] <> "" Then
			_ArrayAdd($hWindows, $hWinlist[$i][0])
		EndIf
	Next
	return $hWindows
EndFunc

Func _Exit()
	Exit
EndFunc