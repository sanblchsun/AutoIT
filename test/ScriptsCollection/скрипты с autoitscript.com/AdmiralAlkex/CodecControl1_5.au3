#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compression=4
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <Array.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>

Global $DShowEnum[1], $DShowRead1[1], $DShowRead2[1], $DShowListViewItem[999], $DisDShow = ":", $ffdshowPreset = "default", $ffdshowExist = 1
$Debug_LB = False

$Gui = GUICreate("Codec-Control 1,5", 542, 600, 100, 100, BitOr($GUI_SS_DEFAULT_GUI, $WS_SIZEBOX))
GUICtrlCreateTab(2, 2, 540, 598)
GUICtrlSetResizing(-1, $GUI_DOCKBORDERS)

GUICtrlCreateTabItem("DirectShow")
$DShowListView = GUICtrlCreateListView("", 6, 26, 325, 566, "", BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_DOUBLEBUFFER))
GUICtrlSetResizing(-1, $GUI_DOCKBORDERS)
_GUICtrlListView_AddColumn($DShowListView, "DirectShow filters", 225)
_GUICtrlListView_AddColumn($DShowListView, "Enabled", 75)
$DShowButtonReload = GUICtrlCreateButton("Reload list", 335, 26, 100, 40)
GUICtrlSetResizing(-1, $GUI_DOCKTOP+$GUI_DOCKRIGHT+$GUI_DOCKHEIGHT+$GUI_DOCKWIDTH)
$DShowButtonCodec = GUICtrlCreateButton("Enable/Disable selected codec", 335, 70, 200, 40)
GUICtrlSetResizing(-1, $GUI_DOCKTOP+$GUI_DOCKRIGHT+$GUI_DOCKHEIGHT+$GUI_DOCKWIDTH)

$ffdshowExist = _CheckIfffdshowExist()
If $ffdshowExist = 1 Then
	GUICtrlCreateTabItem("ffdshow tryouts")
	GUICtrlCreateEdit('The only setting which isn''t available through the official configuration tools is the amount of buffers used when "Queue output samples" is on and therefore thats the only setting here', 6, 26, 400, 64, BitOR ($ES_READONLY, $ES_MULTILINE))
	GUICtrlSetResizing(-1, $GUI_DOCKTOP+$GUI_DOCKLEFT+$GUI_DOCKHEIGHT+$GUI_DOCKWIDTH)
	$ffdshowLabel1 = GUICtrlCreateLabel("Press on this text for getting more information what it does and how to turn it on", 6, 100, 400, 20)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP+$GUI_DOCKLEFT+$GUI_DOCKHEIGHT+$GUI_DOCKWIDTH)
	GUICtrlSetFont(-1, Default, Default, 4)
	GUICtrlSetColor(-1, 0x0000FF)
	GUICtrlSetCursor(-1, 4)
	GUICtrlCreateLabel("Choose preset to change settings to=", 6, 200, 200)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP+$GUI_DOCKLEFT+$GUI_DOCKHEIGHT+$GUI_DOCKWIDTH)
	$ffdshowCombo = GUICtrlCreateCombo("default", 206, 200, 150)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP+$GUI_DOCKLEFT+$GUI_DOCKHEIGHT+$GUI_DOCKWIDTH)
	$ffdshowLabel2 = GUICtrlCreateLabel("Current amount of buffers choosed is?", 6, 240, 250, 20)
	GUICtrlSetFont(-1, Default, 800)
	GUICtrlSetResizing(-1, $GUI_DOCKTOP+$GUI_DOCKLEFT+$GUI_DOCKHEIGHT+$GUI_DOCKWIDTH)
	$ffdshowInput = GUICtrlCreateInput("Please write how many buffers you want to set", 6, 270, 250, Default, BitOR($GUI_SS_DEFAULT_INPUT, $ES_NUMBER))
	GUICtrlSetResizing(-1, $GUI_DOCKTOP+$GUI_DOCKLEFT+$GUI_DOCKHEIGHT+$GUI_DOCKWIDTH)
	$ffdshowButton = GUICtrlCreateButton("Set buffers", 266, 265, 75, 30)
EndIf

If $ffdshowExist = 1 Then
	_BuildPresets()
	_UpdateQueueStatus()
EndIf
_GenerateDShow()
GUICtrlCreateTabItem("")
GUISetState()

While 1
	$msg = GUIGetMsg()
	Select
		Case $msg = $GUI_EVENT_CLOSE
			Exit
		Case $msg = $DShowButtonReload
			$GetSelected = _GUICtrlListView_GetSelectedIndices($DShowListView, True)
			GUICtrlSetState($DShowButtonReload, $GUI_DISABLE)
			GUICtrlSetState($DShowButtonCodec, $GUI_DISABLE)
			_GenerateDShow()
			For $D = 1 To $GetSelected[0]
				_GUICtrlListView_SetItemSelected($DShowListView, $GetSelected[$D])
			Next
			GUICtrlSetState($DShowListView, $GUI_FOCUS)
			GUICtrlSetState($DShowButtonReload, $GUI_ENABLE)
			GUICtrlSetState($DShowButtonCodec, $GUI_ENABLE)
		Case $msg = $DShowButtonCodec
			$GetSelected = _GUICtrlListView_GetSelectedIndices($DShowListView, True)
			GUICtrlSetState($DShowButtonCodec, $GUI_DISABLE)
			GUICtrlSetState($DShowButtonReload, $GUI_DISABLE)
			For $G = 1 To $GetSelected[0]
				$DShowRead3 = RegRead("HKCR\CLSID\{083863F1-70DE-11d0-BD40-00A0C911CE86}\Instance\" & $DShowEnum[$GetSelected[$G]+1], "CLSID")
				If StringInStr($DShowRead3, ":", 2) Then
					$TrimmedString = StringTrimLeft($DShowRead3, 1)
					RegWrite("HKCR\CLSID\{083863F1-70DE-11d0-BD40-00A0C911CE86}\Instance\" & $DShowEnum[$GetSelected[$G]+1], "CLSID", "REG_SZ", $TrimmedString)
				Else
					RegWrite("HKCR\CLSID\{083863F1-70DE-11d0-BD40-00A0C911CE86}\Instance\" & $DShowEnum[$GetSelected[$G]+1], "CLSID", "REG_SZ",$DisDShow & $DShowRead3)
				EndIf
			Next
			_GenerateDShow()
			For $F = 1 To $GetSelected[0]
				_GUICtrlListView_SetItemSelected($DShowListView, $GetSelected[$F])
			Next
			GUICtrlSetState($DShowListView, $GUI_FOCUS)
			GUICtrlSetState($DShowButtonCodec, $GUI_ENABLE)
			GUICtrlSetState($DShowButtonReload, $GUI_ENABLE)
	EndSelect
	If $ffdshowExist = 1 Then
		Select
			Case $msg = $ffdshowLabel1
				ShellExecute("http://ffdshow-tryout.sourceforge.net/html/en/queue.htm")
			Case $msg = $ffdshowCombo
				$Comboread = GUICtrlRead($ffdshowCombo)
				$ffdshowPreset = $Comboread
				_UpdateQueueStatus()
			Case $msg = $ffdshowButton
				RegWrite("HKCU\Software\GNU\ffdshow\" & $ffdshowPreset, "queueCount", "REG_DWORD", GUICtrlRead($ffdshowInput))
				_UpdateQueueStatus()
		EndSelect
	EndIf
WEnd

Func _CheckIfffdshowExist()
	$ReadReg = RegRead("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ffdshow_is1", "DisplayName")
	If @error Then
		Return 0
	Else
		Return 1
	EndIf
EndFunc

Func _UpdateQueueStatus()
	$ReadReg = RegRead("HKCU\Software\GNU\ffdshow\" & $ffdshowPreset, "queueCount")
	GUICtrlSetData($ffdshowLabel2, "Current amount of buffers choosed is " & $ReadReg)
EndFunc

Func _BuildPresets()
	Local $Presets = "", $i = 2, $EnumReg, $EnumReg2
	While 1
		$EnumReg2 &= RegEnumKey("HKCU\Software\GNU\ffdshow\", $i)
		If @error <> 0 then ExitLoop
		$Presets &= "|" & $EnumReg2
		$i = $i + 1
	WEnd
	If $Presets <> "" Then GUICtrlSetData($ffdshowCombo, $Presets)
EndFunc

Func _GenerateDShow()
	Local $B = 1
	_GUICtrlListView_BeginUpdate($DShowListView)
	_GUICtrlListView_DeleteAllItems($DShowListView)
	While 1
		ReDim $DShowEnum[$B+1]
		$DShowEnum[$B] = RegEnumKey("HKCR\CLSID\{083863F1-70DE-11d0-BD40-00A0C911CE86}\Instance", $B)
		If @error <> 0 then ExitLoop
		$B = $B + 1
	WEnd
	$DShowEnum[0] = $B-1
	ReDim $DShowRead1[$B]
	ReDim $DShowRead2[$B]
	For $C = 1 To $DShowEnum[0]
		$DShowRead1[$C] = RegRead("HKCR\CLSID\{083863F1-70DE-11d0-BD40-00A0C911CE86}\Instance\" & $DShowEnum[$C], "FriendlyName")
		$DShowRead2[$C] = RegRead("HKCR\CLSID\{083863F1-70DE-11d0-BD40-00A0C911CE86}\Instance\" & $DShowEnum[$C], "CLSID")
		If StringInStr($DShowRead2[$C], ":", 2) = 0 Then
			$DShowRead2[$C] = "Yes"
		Else
			$DShowRead2[$C] = "No"
		EndIf
		$DShowListViewItem[$C] = GUICtrlCreateListViewItem($DShowRead1[$C] & "|" & $DShowRead2[$C], $DShowListView)
	Next
	_GUICtrlListView_EndUpdate($DShowListView)
EndFunc