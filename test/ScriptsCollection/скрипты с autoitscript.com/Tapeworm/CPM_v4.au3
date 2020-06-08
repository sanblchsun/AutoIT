#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.0.0
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#include <GUIConstants.au3>
#include <Array.au3>
#include <EditConstants.au3>
#include <WindowsConstants.au3>
#Include <Clipboard.au3>
#include <Constants.au3>
#include <GUIComboBox.au3>
#include <ComboConstants.au3>



Opt("GUIOnEventMode", 1)
Opt("TrayOnEventMode",1)
Opt("TrayMenuMode",1)

Dim $historyLimit = 10 ;max amount of clips that will be stored.
Dim $clipsStored = 0
Dim $currentClip = "Hello there"
Dim $clipStore[$historyLimit]
Dim $currentSlot = "Hello there"
Dim $show = False
Dim $currentClipSlot = 0

TraySetClick(8)
TraySetOnEvent($TRAY_EVENT_PRIMARYDOWN, "_setState" )

HotKeySet("{F11}","_setState")  ;hotkeys
HotKeySet("!{F2}","_up")
HotKeySet("!{F1}","_down")

$exit = TrayCreateItem("Exit")
TrayItemSetOnEvent(-1,"kill")

$CP = GUICreate("CP Manager",400,250)
GUISetOnEvent($GUI_EVENT_CLOSE, "_setState")

$combo = GUICtrlCreateCombo("",10,220,380,20,BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL, $WS_VSCROLL, $CBS_DROPDOWNLIST))

$edit = GUICtrlCreateEdit("",10,10,380,200,BitOR($ES_AUTOVSCROLL,$ES_READONLY,$WS_VSCROLL))

Dim $getClip
Dim $GUIRead

While 1
	$getClip = ClipGet()
	If $currentClip <> $getClip Then
		_addClip($getClip)
		_updateGUI()
	EndIf
	Sleep(25)

	$GUIRead = GUICtrlRead($combo)
	If $currentSlot <> $GUIRead Then
		$currentSlot = $GUIRead
		_copy()
	EndIf
	Sleep(25)
WEnd

Func kill()
	Exit
EndFunc

Func _addClip($c)
	Dim $temp = _clipExists($c)
	If $temp = false Then
		_ArrayPush($clipStore,$c,1)
		If $clipsStored < 10 Then
			$clipsStored += 1
		EndIf
	Else
		Dim $j = $temp
		While $j > 0
			_ArraySwap($clipStore[$j],$clipStore[$j-1])
			$j -= 1
		WEnd
	EndIf
	$currentClip = $c
EndFunc

Func _updateGUI()
	GUICtrlSetData($combo, "")
	Dim $i = 0
	While $i < $clipsStored
		GUICtrlSetData($combo, $clipStore[$i])
		$i += 1
	WEnd
	$currentSlot = $currentClip
	GUICtrlSetData($edit, $currentSlot)
	GUICtrlSetData($combo, $currentSlot)
	$currentClipSlot = 0

EndFunc

Func _copy()
	GUICtrlSetData($edit,$currentSlot)
	ClipPut($currentSlot)
	$currentClip = $currentSlot
	$currentClipSlot = _findSlot($currentClip)
EndFunc

Func _setState()
	If $show Then
		GUISetState(@SW_HIDE)
		$show = False
	Else
		GUISetState(@SW_SHOW)
		$show = True
	EndIf
EndFunc

Func _up()
	If $currentClipSlot = 0 Then
		$currentClipSlot = $clipsStored - 1
	Else
		$currentClipSlot -= 1
	EndIf
	$currentSlot = $clipStore[$currentClipSlot]
	GUICtrlSetData($combo, $currentSlot)
	GUICtrlSetData($edit,$currentSlot)
	ClipPut($currentSlot)
	$currentClip = $currentSlot
EndFunc

Func _down()
	If $currentClipSlot = $clipsStored - 1 Then
		$currentClipSlot = 0
	Else
		$currentClipSlot += 1
	EndIf
	$currentSlot = $clipStore[$currentClipSlot]
	GUICtrlSetData($combo, $currentSlot)
	GUICtrlSetData($edit,$currentSlot)
	ClipPut($currentSlot)
	$currentClip = $currentSlot
EndFunc

Func _findSlot($clip)
	Dim $i = 0
	Dim $ret
	While $i < $clipsStored
		If $clipStore[$i] = $clip Then
			$ret = $i
			$i = 11
		EndIf
		$i += 1
	WEnd
	Return $ret
EndFunc

Func _clipExists($clip)
	Dim $i = 0
	Dim $ret = false
	While $i < $clipsStored
		If $clipStore[$i] = $clip Then
			$ret = $i
		EndIf
		$i += 1
	WEnd
	Return $ret
EndFunc
