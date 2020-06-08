#include "RecFileListToArray.au3" ; External UDF by Melba
#include <WindowsConstants.au3>
#include <ButtonConstants.au3>
#include <StaticConstants.au3>
#include <GUIConstantsEx.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <Array.au3>

$hGUI_Parent = GUICreate("RecFileListToArray_GUI", 284, 507, -1, -1)

GUICtrlCreateLabel("Initial path used to generate filelist", 8, 8, 163, 17)
GUICtrlCreateLabel("Files/Folders to include (default ' * ' = [all])", 8, 56, 212, 17)
GUICtrlCreateLabel("Files/Folders to exclude (default ' ' = [none])", 8, 104, 212, 17)
GUICtrlCreateLabel("Optional: specifies whether to return files, folders or both", 8, 201, 267, 17)
GUICtrlCreateLabel("Hidden files and folders", 24, 250, 114, 17)
GUICtrlCreateLabel("System files and folders", 160, 250, 114, 17)
GUICtrlCreateLabel("Link/junction folders", 24, 268, 100, 17)
GUICtrlCreateLabel("Optional: search recursively in subfolders", 8, 297, 208, 17)
GUICtrlCreateLabel("Optional: sort ordered in alphabetical and depth order", 8, 352, 254, 17)
GUICtrlCreateLabel("Optional: specifies displayed path of results", 8, 407, 206, 17)
GUICtrlCreateLabel("Path exclude folder (default = ' ' [none])", 8, 153, 212, 17)
GUICtrlCreateLabel("Depth", 228, 297, 33, 17)
$InputPath = GUICtrlCreateInput("", 8, 24, 193, 21)
GUICtrlSetTip(-1, "Select the path used to generate filelist")
$InputTypeInclude = GUICtrlCreateInput("*", 8, 73, 265, 21)
GUICtrlSetTip(-1, "Separate entries by semicolon. Example: *.ini;*.txt")
$InputTypeExclude = GUICtrlCreateInput("", 8, 120, 265, 21)
GUICtrlSetTip(-1, "Separate entries by semicolon. Example: *.ini;*.txt")
$InputPathExclude = GUICtrlCreateInput("", 8, 168, 193, 21)
GUICtrlSetTip(-1, "Exclude folders matching the filter")
$InputDepth = GUICtrlCreateInput("", 216, 314, 57, 20, $ES_CENTER)
GUICtrlSetTip(-1, "Specific depth that you want to search")
GUICtrlSetState(-1, $GUI_DISABLE)
$ComboFileFolder = GUICtrlCreateCombo("Return both files and folders (Default)", 8, 218, 265, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "Return files only|Return folder only")
$ComboSearchRec = GUICtrlCreateCombo("Do not search in subfolders (Default)", 8, 314, 200, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "Search in all subfolders (unlimited)|Search subfolders to specified depth")
$ComboSorted = GUICtrlCreateCombo("Not sorted (Default)", 8, 368, 265, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "Sorted|Sorted with faster algorithm ( requires NTFS drive)")
$ComboPathLen = GUICtrlCreateCombo("Relative to initial path (Default)", 8, 425, 265, 25, BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "File/folder name only|Full path included")
$CheckboxHiddenFiles_Folder = GUICtrlCreateCheckbox("", 8, 248, 17, 17)
$CheckboxSystemFiles_Folder = GUICtrlCreateCheckbox("", 144, 248, 17, 17)
$CheckboxLinkJuction_Folder = GUICtrlCreateCheckbox("", 8, 266, 17, 17)
$Button_InputPath = GUICtrlCreateButton("Browse", 208, 22, 65, 25)
$Button_InputPathExclude = GUICtrlCreateButton("Browse", 208, 166, 65, 25)
$Button_Generate = GUICtrlCreateButton("Generate", 8, 472, 265, 25)
GUISetState(@SW_SHOW)

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $Button_InputPath
			_Select_Folder($InputPath)
		Case $Button_InputPathExclude
			_Select_Folder($InputPathExclude, GUICtrlRead($InputPath), 1)
		Case $Button_Generate
			_Generate_RecFileListToArray()
	EndSwitch
	If GUICtrlRead($ComboSearchRec) = "Search subfolders to specified depth" Then
		If BitAND(GUICtrlGetState($InputDepth), $GUI_DISABLE) = $GUI_DISABLE Then
			GUICtrlSetState($InputDepth, $GUI_ENABLE)
		EndIf
	Else
		If BitAND(GUICtrlGetState($InputDepth), $GUI_ENABLE) = $GUI_ENABLE Then
			GUICtrlSetData($InputDepth, "")
			GUICtrlSetState($InputDepth, $GUI_DISABLE)
		EndIf
	EndIf
WEnd

Func _Select_Folder($FolderOutput, $StartPath = "", $FolderName = 0)
	$Dir = FileSelectFolder("", $StartPath, 2, @ScriptDir)
	If @error Then
		GUICtrlSetData($FolderOutput, "")
	Else
		Switch $FolderName
			Case 0
				GUICtrlSetData($FolderOutput, StringRegExpReplace($Dir & "\", "(\\+)", "\\"))
			Case 1
				$sName = StringRegExpReplace($Dir, "^.*\\(.*)$", "$1")
				If GUICtrlRead($FolderOutput) Then
					GUICtrlSetData($FolderOutput, GUICtrlRead($FolderOutput) & ";" & $sName)
				Else
					GUICtrlSetData($FolderOutput, $sName)
				EndIf
		EndSwitch
	EndIf
EndFunc   ;==>_Select_Folder

Func _Generate_RecFileListToArray()
	If GUICtrlRead($InputPath) = "" Then
		MsgBox(16, "Error", "Input file is empty")
		_Select_Folder($InputPath)
		Return
	Else
		$Path = GUICtrlRead($InputPath)
	EndIf
	If GUICtrlRead($InputPathExclude) = "" Then
		$ExcludeFolder = ""
	Else
		If GUICtrlRead($InputTypeExclude) = "" Then
			$ExcludeFolder = '||' & GUICtrlRead($InputPathExclude)
		Else
			$ExcludeFolder = '|' & GUICtrlRead($InputPathExclude)
		EndIf
	EndIf
	If GUICtrlRead($InputTypeInclude) = "" Then
		MsgBox(16, "Error", "Input type is empty")
		GUICtrlSetData($InputTypeInclude, "*")
		Return
	Else
		$TypeInclude = GUICtrlRead($InputTypeInclude)
	EndIf
	If GUICtrlRead($InputTypeExclude) = "" Then
		$TypeExclude = ""
	Else
		$TypeExclude = '|' & GUICtrlRead($InputTypeExclude)
	EndIf
	If GUICtrlRead($ComboFileFolder) = "Return both files and folders (Default)" Then
		$FileFolder = "0"
	ElseIf GUICtrlRead($ComboFileFolder) = "Return files only" Then
		$FileFolder = "1"
	Else
		$FileFolder = "2"
	EndIf
	Local $HiddenFiles_Folder, $SystemFiles_Folder, $LinkJuction_Folder
	If GUICtrlRead($CheckboxHiddenFiles_Folder) = $GUI_CHECKED Then
		$HiddenFiles_Folder = " + 4"
	EndIf
	If GUICtrlRead($CheckboxSystemFiles_Folder) = $GUI_CHECKED Then
		$SystemFiles_Folder = " + 8"
	EndIf
	If GUICtrlRead($CheckboxLinkJuction_Folder) = $GUI_CHECKED Then
		$LinkJuction_Folder = " + 16"
	EndIf
	$FileFolder &= $HiddenFiles_Folder & $SystemFiles_Folder & $LinkJuction_Folder
	If GUICtrlRead($ComboSearchRec) = "Do not search in subfolders (Default)" Then
		$SearchSubfolder = "0"
	ElseIf GUICtrlRead($ComboSearchRec) = "Search in all subfolders (unlimited)" Then
		$SearchSubfolder = "1"
	Else
		If GUICtrlRead($InputDepth) <> "" Then
			$SearchSubfolder = "-" & GUICtrlRead($InputDepth)
		Else
			MsgBox(16, "Error", "Depth value is empty")
			Return
		EndIf
	EndIf
	If GUICtrlRead($ComboSorted) = "Not sorted (Default)" Then
		$Sorted = "0"
	ElseIf GUICtrlRead($ComboSorted) = "Sorted" Then
		$Sorted = "1"
	Else
		$Sorted = "2"
	EndIf
	If GUICtrlRead($ComboPathLen) = "Relative to initial path (Default)" Then
		$PathLen = "1"
	ElseIf GUICtrlRead($ComboPathLen) = "File/folder name only" Then
		$PathLen = "0"
	Else
		$PathLen = "2"
	EndIf
	$FinalOutput = '_RecFileListToArray("' & $Path & '", "' & $TypeInclude & $TypeExclude & $ExcludeFolder & '", ' & $FileFolder & ', ' & $SearchSubfolder & ', ' & $Sorted & ', ' & $PathLen & ')' & @CRLF

	$hGUI_Child = GUICreate("Output", 410, 144, -1, -1)
	GUICtrlCreateLabel("Display speed result", 24, 81, 123, 17)
	$Edit = GUICtrlCreateEdit("", 8, 16, 393, 57, BitOR($ES_READONLY, $WS_HSCROLL))
	GUICtrlSetData(-1, "")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$Button_TestCode = GUICtrlCreateButton("Test _RecFileListToArray", 8, 104, 145, 33)
	$Button_Clipboard = GUICtrlCreateButton("Save to the Clipboard", 249, 104, 153, 33)
	$Checkbox_Timer = GUICtrlCreateCheckbox("", 8, 80, 16, 16)
	GUISetState(@SW_SHOW)
	GUISetState(@SW_DISABLE, $hGUI_Parent)
	GUICtrlSetData($Edit, $FinalOutput)
	ConsoleWrite($FinalOutput)

	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				ClipPut($FinalOutput)
				GUISetState(@SW_ENABLE, $hGUI_Parent)
				GUIDelete($hGUI_Child)
				ExitLoop
			Case $Button_Clipboard
				ClipPut($FinalOutput)
				GUISetState(@SW_ENABLE, $hGUI_Parent)
				GUIDelete($hGUI_Child)
				ExitLoop
			Case $Button_TestCode
				If GUICtrlRead($Checkbox_Timer) = $GUI_CHECKED Then
					Local $begin = TimerInit()
				EndIf
				$aArray = _RecFileListToArray($Path, $TypeInclude & $TypeExclude & $ExcludeFolder, Number($FileFolder), Number($SearchSubfolder), Number($Sorted), Number($PathLen))
				If @error Then
					MsgBox(16, "Error", "Failure - Extended: " & @extended & @CRLF & _
							"1 = Path not found or invalid" & @CRLF & _
							"2 = Invalid $sInclude_List" & @CRLF & _
							"3 = Invalid $iReturn" & @CRLF & _
							"4 = Invalid $iRecur" & @CRLF & _
							"5 = Invalid $iSort" & @CRLF & _
							"6 = Invalid $iReturnPath" & @CRLF & _
							"7 = Invalid $sExclude_List" & @CRLF & _
							"8 = Invalid $sExclude_List_Folder" & @CRLF & _
							"9 = No files/folders found")
				Else
					If GUICtrlRead($Checkbox_Timer) = $GUI_CHECKED Then
						Local $dif = TimerDiff($begin)
						MsgBox(64, "Result", "Speed result is:" & @CRLF & $dif & @CRLF & "Informations are copied to the clipboard")
						ClipPut($FinalOutput & "Speed result: " & $dif)
					EndIf
					_ArrayDisplay($aArray, "")
				EndIf
		EndSwitch
	WEnd
EndFunc   ;==>_Generate_RecFileListToArray