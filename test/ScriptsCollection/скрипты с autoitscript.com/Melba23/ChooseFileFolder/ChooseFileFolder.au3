
#include-once

; #INDEX# ============================================================================================================
; Title .........: ChooseFileFolder
; AutoIt Version : 3.3 +
; Language ......: English
; Description ...: Allows selection of single or multiple files/folders from within a defined path
; Remarks .......: - If the script already has a WM_NOTIFY handler then call the _CFF_WM_NOTIFY_Handler function
;                    from within it
;                  - Requires 2 other Melba23 UDFs: GUIFrame.au3 & RecFileListToArray.au3
; Author ........: Melba23
; Modified ......; Thanks to Ascend4nt and Yashied for x64 compatability code
; ====================================================================================================================

;#AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
;Opt("MustDeclareVars", 1)

; #INCLUDES# =========================================================================================================
#include <GuiTreeView.au3>
#include <GUIFrame.au3>
#include <RecFileListToArray.au3>

; #GLOBAL VARIABLES# =================================================================================================
Global $fCFF_DblClk, $aCFF_Curr_Index, $fCFF_Expand = False
Global $sCFF_Def_Folder_Path = "", $aCFF_Def_Folder_Index
Global $sCFF_Def_FileMask = "*.*", $aCFF_Def_File_Index
Global $sCFF_Def_Combo_Folder_Path = "", $sCFF_Def_Combo_FileMask = "*.*", $aCFF_Def_Combo_Index

; #CURRENT# ==========================================================================================================
; _CFF_IndexDefault:      Pre-index folders and files for speed
; _CFF_SetDefault_Folder: Sets existing array as default folder index for speed
; _CFF_SetDefault_File:   Sets existing array as default file index for speed
; _CFF_SetDefault_Combo:  Sets existing array as default folder and file index for speed
; _CFF_ClearDefault:      Clears default arrays and settings to save memory
; _CFF_Choose:            Creates a dialog to chose single or multiple files or folders within a specified path
; _CFF_RegMsg:            Register WM_NOTIFY to enable double clicks on TreeView
; ====================================================================================================================

; #INTERNAL_USE_ONLY#=================================================================================================
; _CFF_Combo_Fill:   Creates and fills a combo to allow drive selection
; _CFF_TV_Fill:      Fills a TreeView with the selected folder structure to allow folder selection
; _CFF_Strip_Array:  Removes empty folders from a file/folder array.
; _CFF_ListFiles:    Adds files to an existing folder structure to allow file selection
; _CFF_GetSel:       Retrieves selected TreeView item and if file confirms match to file mask
; _CFF_Expand_Check: Prevents rapid clicks to expand/contract the TreeView being treated as a double click selection
; ====================================================================================================================

; #FUNCTION# =========================================================================================================
; Name...........: _CFF_IndexDefault
; Description ...: Creates default folder, file or combo indexes for speed
; Syntax.........: _CFF_IndexDefault($sPath, [$sFile_Mask = "", [$fCombo = False]])
; Parameters ....: $sPath      - Default folder tree to index and store ("" = no index)
;                  $sFile_Mask - Default file mask within folder tree to index and store ("" (default) = no index)
;                  $fCombo     - If True then create single array containing both folders and files (default = False)
; Requirement(s).: v3.3 +
; Return values .: Success: 1
;                  Failure: Returns 0 and sets @error as follows:
;                      1 = Combined index error with @extended set as follows:
;                          1 = Invalid or non-existent path
;                          2 = Invalid file mask
;                          3 = Index failed
;                      2 = Folder index error with @extended set as follows:
;                          1 = Invalid or non-existent path
;                          2 = Index failed
;                      3 = File index failed
; Author ........: Melba23
; Modified ......:
; Remarks .......: The Combo array is automatically stripped of folders which do not contain files matching the mask
; Example........: Yes
;=====================================================================================================================
Func _CFF_IndexDefault($sPath, $sFile_Mask = "", $fCombo = False)

	If $fCombo Then
		; Create single default array
		If $sPath = "" Or Not FileExists($sPath) Then Return SetError(1, 1, 0)
		If StringRight($sPath, 1) <> "\" Then $sPath &= "\"
		If $sFile_Mask = "" Then Return SetError(1, 2, 0)
		$aCFF_Def_Combo_Index = _RecFileListToArray($sPath, $sFile_Mask, 0, 1, 1, 1, "", "$*;System Volume Information;RECYCLED;_Restore")
		If @error Then Return SetError(1, 3, 0)
		; Strip empty folders and check if files found
		If _CFF_Strip_Array($aCFF_Def_Combo_Index) = 0 Then Return SetError(1, 3, 0)
		$sCFF_Def_Combo_Folder_Path = $sPath
		$sCFF_Def_Combo_FileMask = $sFile_Mask
	Else
		; Create separate default arrays
		If $sPath <> "" Then
			If StringRight($sPath, 1) <> "\" Then $sPath &= "\"
			If Not FileExists($sPath) Then Return SetError(2, 1, 0)
			$aCFF_Def_Folder_Index = _RecFileListToArray($sPath, "*", 2, 1, 1, 1, "$*;System Volume Information;RECYCLED;_Restore")
			If @error Then Return SetError(2, 2, 0)
			$sCFF_Def_Folder_Path = $sPath
		EndIf
		If $sFile_Mask <> "" Then
			$aCFF_Def_File_Index = _RecFileListToArray($sPath, $sFile_Mask, 1, 1, 1)
			If @error Then Return SetError(3, 0, 0)
			$sCFF_Def_FileMask = $sFile_Mask
		EndIf
	EndIf

	Return 1

EndFunc   ;==>_CFF_IndexDefault

; #FUNCTION# =========================================================================================================
; Name...........: _CFF_SetDefault_Folder
; Description ...: Sets an existing array as default folder index for speed
; Syntax.........: _CFF_SetDefault_Folder($sPath, $aArray)
; Parameters ....: $sPath  - Path for folder tree
;                  $aArray - Existing sorted array of folder tree
; Requirement(s).: v3.3 +
; Return values .: Success: 1
;                  Failure: Returns 0 and sets @error as follows:
;                      1 = No path passed or path does not exist
;                      2 = Not used
;                      3 = No array passed
; Author ........: Melba23
; Modified ......:
; Remarks .......: Array MUST have been been created using _RecFileListToArray($sPath, "*", 2, 1, 1, 1, "User_Set_Value")
;                  where User_Set_Value can be set by the user
; Example........: Yes
;=====================================================================================================================
Func _CFF_SetDefault_Folder($sPath, $aArray)

	If $sPath = "" Or Not FileExists($sPath) Then Return SetError(1, 0, 0)
	If $aArray = "" Or Not IsArray($aArray) Then Return SetError(3, 0, 0)
	$sCFF_Def_Folder_Path = $sPath
	$aCFF_Def_Folder_Index = $aArray
	Return 1

EndFunc

; #FUNCTION# =========================================================================================================
; Name...........: _CFF_SetDefault_File
; Description ...: Sets an existing array as default file index for speed
; Syntax.........: _CFF_SetDefault_File($sFile_Mask, $aArray)
; Parameters ....: $sFile_Mask - Mask for file search
;                  $aArray     - Existing sorted array of files
; Requirement(s).: v3.3 +
; Return values .: Success: 1
;                  Failure: Returns 0 and sets @error as follows:
;                      1 = Not used
;                      2 = No file mask passed
;                      3 = No array passed
; Author ........: Melba23
; Modified ......:
; Remarks .......: Array MUST have been been created using _RecFileListToArray($sPath, $sFile_Mask, 1, 1, 1)
;                  where $sPath matches that used for the default folder array
; Example........: Yes
;=====================================================================================================================
Func _CFF_SetDefault_File($sFile_Mask, $aArray)

	If $sFile_Mask = "" Then Return SetError(2, 0, 0)
	If $aArray = "" Or Not IsArray($aArray) Then Return SetError(3, 0, 0)
	$sCFF_Def_FileMask = $sFile_Mask
	$aCFF_Def_File_Index = $aArray
	Return 1

EndFunc

; #FUNCTION# =========================================================================================================
; Name...........: _CFF_SetDefault_Combo
; Description ...: Sets an existing array as default file index for speed
; Syntax.........: _CFF_SetDefault_Combo($sPath, $sFile_Mask, $aArray)
; Parameters ....: $sPath      - Path for folder tree
;                  $sFile_Mask - Mask for file search
;                  $aArray     - Existing sorted array of files
; Requirement(s).: v3.3 +
; Return values .: Success: 1
;                  Failure: Returns 0 and sets @error as follows:
;                      1 = No path passed or path does not exist
;                      2 = No file mask passed
;                      3 = No array passed
; Author ........: Melba23
; Modified ......:
; Remarks .......: Array MUST have been been created using _RecFileListToArray($sPath, $sFile_Mask, 3, 1, 1, 1, "", "User_Set_Value")
;                  where User_Set_Value can be set by the user
; Example........: Yes
;=====================================================================================================================
Func _CFF_SetDefault_Combo($sPath, $sFile_Mask, $aArray)
	If $sPath = "" Or Not FileExists($sPath) Then Return SetError(1, 0, 0)
	If $sFile_Mask = "" Then Return SetError(3, 0, 0)
	If $aArray = "" Or Not IsArray($aArray) Then Return SetError(3, 0, 0)
	$sCFF_Def_Combo_Folder_Path = $sPath
	$sCFF_Def_Combo_FileMask = $sFile_Mask
	$aCFF_Def_Combo_Index = $aArray
	Return 1

EndFunc

; #FUNCTION# =========================================================================================================
; Name...........: _CFF_ClearDefault
; Description ...: Clears default arrays to save memory
; Syntax.........: _CFF_ClearDefault([$fFolder = True, [$fFile = True, [$fCombo = True]]])
; Parameters.....: $fFolder - True (default) clear default folder array and reset default path
;                  $fFile   - True (default) clear default file array and reset default file mask
;                  $fCombo  - True (default) clear default combo array and reset default combo path and file mask
;                  Setting any parameter to False leaves the affected variables intact
; Requirement(s).: v3.3 +
; Return values .: None
; Author ........: Melba23
; Modified ......:
; Remarks .......:
; Example........: Yes
;=====================================================================================================================
Func _CFF_ClearDefault($fFolder = True, $fFile = True, $fCombo = True)

	If $fFolder Then
		$aCFF_Def_Folder_Index = 0
		$sCFF_Def_Folder_Path = ""
	EndIf
	If $fFile Then
		$aCFF_Def_File_Index = 0
		$sCFF_Def_FileMask = "*.*"
	EndIf
	If $fCombo Then
		$aCFF_Def_Combo_Index = 0
		$sCFF_Def_Combo_Folder_Path = ""
		$sCFF_Def_Combo_FileMask = "*.*"
	EndIf

EndFunc   ;==>_CFF_ClearDefault

; #FUNCTION# =========================================================================================================
; Name...........: _CFF_RegMsg
; Description ...: Registers WM_NOTIFY to enable double clicks on TreeView
; Syntax.........: _CFF_RegMsg()
; Parameteres....: None
; Requirement(s).: v3.3 +
; Return values .: Success: 1
;                  Failure: 0
; Author ........: Melba23
; Modified ......:
; Remarks .......: If the script already has a WM_NOTIFY handler then call the _CFF_WM_NOTIFY_Handler function
;                  from within it
; Example........: Yes
;=====================================================================================================================
Func _CFF_RegMsg()

	Return GUIRegisterMsg(0x004E, "_CFF_WM_NOTIFY_Handler") ; $WM_NOTIFY

EndFunc   ;==>_CFF_RegMsg

; #FUNCTION# =========================================================================================================
; Name...........: _CFF_Choose
; Description ...: Sets default path and file mask for speed and registers WM_NOTIFY for TV doubleclicks
; Syntax.........: _CFF_Choose ($sTitle, $iW, $iH, $iX, $iY, [$sRoot = "", [$sFile_Mask = "", [$iDisplay = 0, [$fSingle_Sel = True, [$hParent = 0]]]]])
; Parameters ....: $sTitle      - Title of dialog
;                  $iW, $iH, $iX, $iY - Left, Top, Width, Height parameters for dialog
;                  $sRoot       - Path tree to display (default = "" - list all drives for selection)
;                                 Set to Default keyword = Use preset default path and array depending on $iDisplay value
;                  $sFile_Mask  - File name & ext to match (default = *.* - all files)
;                                 Set to Default keyword = Use preset default mask and array depending on $iDisplay value
;                  $iDisplay    - 0   - Display full folder tree and matching files (default)
;                                 1   - Display all matching files within the specified folder - subfolders are not displayed
;                                 2   - Display folder tree only - no files
;                                 3   - Display only folders containing matching files
;                                 + 4 - Do not display file extensions in tree (ignored if .* ext in $sFile_Mask)
;                  $fSingle_Sel - True (default) = Only 1 selection
;                                 False = Multiple selections collected in list on dialog - press "Return" when all selected
;                  $hParent     - Handle of GUI calling the dialog, (default = 0 - no parent GUI)
; Requirement(s).: v3.3 +
; Return values .: Success: String containing selected items - multiple items delimited by "|"
;                  Failure: Returns "" and sets @error as follows:
;                      1 = Path does not exist
;                      2 = Invalid $iDisplay parameter
;                      3 = Invalid $hParent parameter
;                      4 = Dialog creation failure
;                      5 = Cancel button or GUI [X] pressed
; Author ........: Melba23
; Modified ......:
; Remarks .......: If files are displayed, only files can be selected
;                  Default $sRoot and $sFileMask with $iDisplay option 3 or 7 are Combo default values
;                  Default $sRoot and $sFileMask with other $iDisplay options are single default values
; Example........: Yes
;=====================================================================================================================
Func _CFF_Choose($sTitle, $iW, $iH, $iX, $iY, $sRoot = "", $sFile_Mask = "*", $iDisplay = 0, $fSingle_Sel = True, $hParent = "")

	; Check path
	If $sRoot = Default Then
		Switch $iDisplay
			Case 3, 7
				$sRoot = $sCFF_Def_Combo_Folder_Path
			Case Else
				$sRoot = $sCFF_Def_Folder_Path
		EndSwitch
	EndIf
	If $sRoot <> "" Then
		If Not FileExists($sRoot) Then Return SetError(1, 0, "")
		If StringRight($sRoot, 1) <> "\" Then $sRoot &= "\"
	EndIf
	; Check FileMask
	If $sFile_Mask = Default Then
		Switch $iDisplay
			Case 3, 7
				$sFile_Mask = $sCFF_Def_Combo_FileMask
			Case Else
				$sFile_Mask = $sCFF_Def_FileMask
		EndSwitch
	EndIf
	If $sFile_Mask = "" Then $sFile_Mask = "*.*"

	; Check Display
	Switch $iDisplay
		Case 0 To 3
			; OK
		Case 4 To 7
			; Force file ext display if no specific exts required
			If StringInStr($sFile_Mask, ".*") Then $iDisplay -= 4
		Case Else
			Return SetError(2, 0, "")
	EndSwitch

	; Check parent
	Switch $hParent
		Case ""
		Case Else
			If Not IsHWnd($hParent) Then Return SetError(3, 0, "")
	EndSwitch

	Local $hTreeView = 9999, $hTreeView_Handle = 9999, $hTV_GUI, $hList = 9999, $hDrive_Combo = 9999, $sCurrDrive = ""
	Local $hTreeView_Label, $hTreeView_Progress, $sBase_Path, $sSelectedPath, $iFrame, $aTV_Pos, $hFF_GUI, $hWarning_Label

	; Check for width and height minima and set button size
	Local $iButton_Width
	If $fSingle_Sel Then
		If $iW < 130 Then $iW = 130
		$iButton_Width = Int(($iW - 30) / 2)
	Else
		If $iW < 190 Then $iW = 190
		$iButton_Width = Int(($iW - 40) / 3)
	EndIf
	If $iButton_Width > 80 Then $iButton_Width = 80
	If $iH < 300 Then $iH = 300

	; Create dialog
	Local $hCFF_Win = GUICreate($sTitle, $iW, $iH, $iX, $iY, 0x80C80000, -1, $hParent) ; BitOR($WS_POPUPWINDOW, $WS_CAPTION)
	If @error Then Return SetError(4, 0, "")
	GUISetBkColor(0xCECECE)

	; Create buttons
	Local $hCan_Button, $hSel_Button = 9999, $hAdd_Button = 9999, $hRet_Button = 9999
	If $fSingle_Sel Then
		$hSel_Button = GUICtrlCreateButton("Select", $iW - ($iButton_Width + 10), $iH - 40, $iButton_Width, 30)
	Else
		$hAdd_Button = GUICtrlCreateButton("Add To List", 10, $iH - 40, $iButton_Width, 30)
		$hRet_Button = GUICtrlCreateButton("Return List", $iW - ($iButton_Width + 10), $iH - 40, $iButton_Width, 30)
	EndIf
	$hCan_Button = GUICtrlCreateButton("Cancel", $iW - ($iButton_Width + 10) * 2, $iH - 40, $iButton_Width, 30)

	; Create controls
	Select
		Case $sRoot And $fSingle_Sel ; TV only
			; Create TV and hide
			$hTreeView = GUICtrlCreateTreeView(10, 10, $iW - 20, $iH - 60)
			$hTreeView_Handle = GUICtrlGetHandle($hTreeView)
			GUICtrlSetState(-1, 32) ; $GUI_HIDE
			; Create Indexing label and progress
			$hTreeView_Label = GUICtrlCreateLabel("Indexing..." & @CRLF & "Please be patient", ($iW - 150) / 2, 20, 100, 30)
			$hTreeView_Progress = GUICtrlCreateProgress(($iW - 150) / 2, 60, 150, 10, 0x00000008); $PBS_MARQUEE
			GUICtrlSendMsg(-1, 0x40A, True, 50) ; $PBM_SETMARQUEE
		Case Not $sRoot And $fSingle_Sel ; Combo and TV
			; Create and fill Combo
			$hDrive_Combo = _CFF_Combo_Fill($iW)
			; Create TV and hide
			$hTreeView = GUICtrlCreateTreeView(10, 40, $iW - 20, $iH - 90)
			$hTreeView_Handle = GUICtrlGetHandle($hTreeView)
			GUICtrlSetState(-1, 32) ; $GUI_HIDE
			; Display warning
			$hWarning_Label = GUICtrlCreateLabel("Warning:" & @CRLF & "Indexing large drives" & @CRLF & "can take some time", ($iW - 150) / 2, 50, 100, 60)
		Case $sRoot And Not $fSingle_Sel ; TV and List
			; Create Frame
			$hFF_GUI = GUICreate("", -10, -10, 10, 10)
			GUISetState()
			$iFrame = _GUIFrame_Create($hCFF_Win, 1, $iH - 160, 5, 10, 10, $iW - 20, $iH - 60)
			GUIDelete($hFF_GUI)
			$hTV_GUI = _GUIFrame_GetHandle($iFrame, 1)
			GUISetBkColor(0xCECECE, $hTV_GUI)
			_GUIFrame_Switch($iFrame, 1)
			; Create TV and hide
			$hTreeView = GUICtrlCreateTreeView(0, 0, $iW - 20, $iH - 160)
			$hTreeView_Handle = GUICtrlGetHandle($hTreeView)
			GUICtrlSetState(-1, 32) ; $GUI_HIDE
			GUICtrlSetResizing(-1, 1) ; $GUI_DOCKAUTO
			; Create Indexing label and progress
			$hTreeView_Label = GUICtrlCreateLabel("Indexing" & @CRLF & "Please be patient", ($iW - 150) / 2, 20, 100, 30)
			$hTreeView_Progress = GUICtrlCreateProgress(($iW - 150) / 2, 60, 150, 10, 0x00000008) ; $PBS_MARQUEE
			GUICtrlSendMsg(-1, 0x40A, True, 50) ; $PBM_SETMARQUEE
			_GUIFrame_Switch($iFrame, 2)
			; Create List
			$hList = GUICtrlCreateList("", 0, 0, $iW - 20, 100, 0x00A04100) ;BitOR($WS_BORDER, $WS_VSCROLL, $LBS_NOSEL, $LBS_NOINTEGRALHEIGHT))
			GUICtrlSetResizing(-1, 1) ; $GUI_DOCKAUTO
			GUISwitch($hCFF_Win)
			; Set resizing flag for all created frames
			_GUIFrame_ResizeSet(0)
		Case Not $sRoot And Not $fSingle_Sel ; Combo, TV and List
			; Create and fill Combo
			$hDrive_Combo = _CFF_Combo_Fill($iW)
			; Create Frame
			$hFF_GUI = GUICreate("", -10, -10, 10, 10)
			GUISetState()
			$iFrame = _GUIFrame_Create($hCFF_Win, 1, $iH - 190, 5, 10, 40, $iW - 20, $iH - 90)
			GUIDelete($hFF_GUI)
			$hTV_GUI = _GUIFrame_GetHandle($iFrame, 1)
			GUISetBkColor(0xCECECE, $hTV_GUI)
			_GUIFrame_Switch($iFrame, 1)
			; Create TV and hide
			$hTreeView = GUICtrlCreateTreeView(0, 0, $iW - 20, $iH - 190)
			$hTreeView_Handle = GUICtrlGetHandle($hTreeView)
			GUICtrlSetState(-1, 32) ; $GUI_HIDE
			GUICtrlSetResizing(-1, 1) ; $GUI_DOCKAUTO
			; Display warning
			$hWarning_Label = GUICtrlCreateLabel("Warning:" & @CRLF & "Indexing large drives" & @CRLF & "can take some time", ($iW - 170) / 2, 10, 100, 60)
			_GUIFrame_Switch($iFrame, 2)
			; Create List
			$hList = GUICtrlCreateList("", 0, 0, $iW - 20, 100, 0x00A04100) ; BitOR($WS_BORDER, $WS_VSCROLL, $LBS_NOSEL, $LBS_NOINTEGRALHEIGHT)
			GUICtrlSetResizing(-1, 1) ; $GUI_DOCKAUTO
			GUISwitch($hCFF_Win)
			; Set resizing flag for all created frames
			_GUIFrame_ResizeSet(0)
	EndSelect

	GUISetState()

	If $sRoot Then
		; If root folder available then fill TV
		_CFF_TV_Fill($hCFF_Win, $hTV_GUI, $hTreeView, $sRoot, $sFile_Mask, $iDisplay)
		; Show TV
		GUICtrlSetState($hTreeView, 16) ; $GUI_SHOW
		; Delete label and progress
		GUICtrlDelete($hTreeView_Label)
		GUICtrlDelete($hTreeView_Progress)
	EndIf

	; Create return string for multi-selection
	Local $sAddFile_List = ""

	; Change to MessageLoop mode
	Local $nOldOpt = Opt('GUIOnEventMode', 0)

	While 1

		Local $aMsg = GUIGetMsg(1)

		If $aMsg[1] = $hCFF_Win Then

			Switch $aMsg[0]
				Case $hSel_Button, $hAdd_Button
					; Set the path base
					$sBase_Path = $sRoot
					If $sRoot = "" Then $sBase_Path = GUICtrlRead($hDrive_Combo) & "\"
					; Get the selected path
					$sSelectedPath = _CFF_GetSel($hTreeView_Handle, $iDisplay, $sBase_Path, $sFile_Mask, _GUICtrlTreeView_GetSelection($hTreeView))
					If $sSelectedPath Then
						If $fSingle_Sel Then
							GUIDelete($hCFF_Win)
							; Restore previous mode
							Opt('GUIOnEventMode', $nOldOpt)
							; Return valid path
							Return $sBase_Path & $sSelectedPath
						Else
							GUICtrlSetState($hTreeView, 256) ; $GUI_FOCUS
							; Add to return string
							$sAddFile_List &= $sBase_Path & $sSelectedPath & "|"
							; Remove ext if required
							If BitAnd($iDisplay, 4) Then $sSelectedPath = StringRegExpReplace($sSelectedPath, "(^.*)\..*", "$1")
							; Add to onscreen list
							GUICtrlSendMsg($hList, 0x0180, 0, $sSelectedPath) ; $LB_ADDSTRING
							; Scroll to bottom of list
							GUICtrlSendMsg($hList, 0x197, GUICtrlSendMsg($hList, 0x18B, 0, 0) - 1, 0) ; $LB_SETTOPINDEX, $LB_GETCOUNT
						EndIf
					EndIf
				Case $hRet_Button
					GUIDelete($hCFF_Win)
					; Restore previous mode
					Opt('GUIOnEventMode', $nOldOpt)
					; Remove final | from return string and return
					Return StringTrimRight($sAddFile_List, 1)
				Case $hCan_Button, -3 ; $GUI_EVENT_CLOSE
					GUIDelete($hCFF_Win)
					; Restore previous mode
					Opt('GUIOnEventMode', $nOldOpt)
					Return SetError(5, 0, "")
			EndSwitch
		EndIf

		; Check if mouse has doubleclicked in TreeView
		If $fCFF_DblClk = $hTreeView_Handle Then
			; Reset flag
			$fCFF_DblClk = 0
			; Set the path base
			$sBase_Path = $sRoot
			If $sRoot = "" Then $sBase_Path = GUICtrlRead($hDrive_Combo) & "\"
			; Get the selected path
			$sSelectedPath = _CFF_GetSel($hTreeView_Handle, $iDisplay, $sBase_Path, $sFile_Mask)
			If $sSelectedPath Then
				If $fSingle_Sel Then
					GUIDelete($hCFF_Win)
					; Restore previous mode
					Opt('GUIOnEventMode', $nOldOpt)
					; Return valid path
					Return $sBase_Path & $sSelectedPath
				Else
					GUICtrlSetState($hTreeView, 256) ; $GUI_FOCUS
					; Add to return string
					$sAddFile_List &= $sBase_Path & $sSelectedPath & "|"
					; Remove ext if required
					If BitAnd($iDisplay, 4) Then $sSelectedPath = StringRegExpReplace($sSelectedPath, "(^.*)\..*", "$1")
					; Add to onscreen list
					GUICtrlSendMsg($hList, 0x0180, 0, $sSelectedPath) ; $LB_ADDSTRING
					; Scroll to bottom of list
					GUICtrlSendMsg($hList, 0x197, GUICtrlSendMsg($hList, 0x18B, 0, 0) - 1, 0) ; $LB_SETTOPINDEX, $LB_GETCOUNT
				EndIf
			EndIf
		EndIf

		; Check if a new drive has been selected
		If $sRoot = "" Then
			If GUICtrlRead($hDrive_Combo) <> $sCurrDrive Then
				; Check combo closed
				If GUICtrlSendMsg($hDrive_Combo, 0x157, 0, 0) = False Then ; $CB_GETDROPPEDSTATE
					; Hide warning
					GUICtrlSetState($hWarning_Label, 32) ; $GUI_HIDE
					; Get drive chosen
					$sCurrDrive = GUICtrlRead($hDrive_Combo)
					; Get current TV size if multisel
					If Not $fSingle_Sel Then $aTV_Pos = ControlGetPos($hTV_GUI, "", $hTreeView)
					; Delete a current combo
					GUICtrlDelete($hTreeView)
					; Switch to correct GUI
					GUISwitch($hTV_GUI)
					; Create TV and hide
					If $fSingle_Sel Then
						$hTreeView = GUICtrlCreateTreeView(10, 40, $iW - 20, $iH - 90)
					Else
						$hTreeView = GUICtrlCreateTreeView(0, 0, $iW - 20, $aTV_Pos[3])
					EndIf
					$hTreeView_Handle = GUICtrlGetHandle($hTreeView)
					GUICtrlSetState(-1, 32) ; $GUI_HIDE
					GUICtrlSetResizing(-1, 1) ; $GUI_DOCKAUTO
					; Create Indexing label and progress
					If $fSingle_Sel Then
						$hTreeView_Label = GUICtrlCreateLabel("Indexing" & @CRLF & "Please be patient", ($iW - 150) / 2, 50, 100, 30)
						$hTreeView_Progress = GUICtrlCreateProgress(($iW - 150) / 2, 90, 150, 10, 0x00000008) ; $PBS_MARQUEE
					Else
						$hTreeView_Label = GUICtrlCreateLabel("Indexing" & @CRLF & "Please be patient", ($iW - 170) / 2, 20, 100, 30)
						$hTreeView_Progress = GUICtrlCreateProgress(($iW - 170) / 2, 60, 150, 10, 0x00000008) ; $PBS_MARQUEE
					EndIf
					GUICtrlSendMsg($hTreeView_Progress, 0x40A, True, 50) ; $PBM_SETMARQUEE
					; Fill TV
					_CFF_TV_Fill($hCFF_Win, $hTV_GUI, $hTreeView, $sCurrDrive & "\", $sFile_Mask, $iDisplay)
					; Show TV
					GUICtrlSetState($hTreeView, 16) ; $GUI_SHOW
					; Delete label and progress
					GUICtrlDelete($hTreeView_Label)
					GUICtrlDelete($hTreeView_Progress)
					; Switch back to main dialog
					GUISwitch($hCFF_Win)
				EndIf
			EndIf
		EndIf

	WEnd

EndFunc   ;==>_CFF_Choose

; #FUNCTION# =========================================================================================================
; Name...........: _CFF_WM_NOTIFY_Handler
; Description ...: Windows message handler for WM_NOTIFY
; Syntax.........: _CFF_WM_NOTIFY_Handler($hWnd, $iMsg, $wParam, $lParam)
; Requirement(s).: v3.3 +
; Return values .: None
; Author ........: Melba23
; Modified ......:
; Remarks .......: If a WM_NOTIFY handler already registered, then call this function from within that handler
; Example........: Yes
;=====================================================================================================================
Func _CFF_WM_NOTIFY_Handler($hWnd, $iMsg, $wParam, $lParam)

    #forceref $hWnd, $iMsg, $wParam

    Local $tStruct = DllStructCreate("hwnd hWndFrom;uint_ptr IDFrom;int Code", $lParam)
    Switch DllStructGetData($tStruct, "Code")
		Case -3 ; $NM_DBLCLK
			If Not $fCFF_Expand Then
				; Do not react to soon after a click to expand/contract the treeview
				$fCFF_DblClk = DllStructGetData($tStruct, "hWndFrom")
			EndIf
		Case -455 ; $TVN_ITEMEXPANDEDW
			$fCFF_Expand = True
			AdlibRegister("_CFF_Expand_Check", 500)
    EndSwitch

EndFunc   ;==>_CFF_WM_NOTIFY_Handler

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: _CFF_Combo_Fill
; Description ...: Creates and fills a combo to allow drive selection.
; Author ........: Melba23
; Remarks .......:
; ===============================================================================================================================
Func _CFF_Combo_Fill($iW)

	GUICtrlCreateLabel("Select Drive:", (($iW - 150) / 2) - 65, 15, 65, 20)
	Local $hCombo = GUICtrlCreateCombo("", ($iW - 150) / 2, 10, 50, 20)
	Local $aDrives = DriveGetDrive("ALL")
	For $i = 1 To $aDrives[0]
		; Only display ready drives
		If DriveStatus($aDrives[$i] & '\') <> "NOTREADY" Then GUICtrlSetData($hCombo, StringUpper($aDrives[$i]))
	Next
	Return $hCombo

EndFunc   ;==>_CFF_Combo_Fill

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: _CFF_TV_Fill
; Description ...: Fills a TreeView with the selected folder structure to allow folder selection.
; Author ........: Melba23
; Remarks .......:
; ===============================================================================================================================
Func _CFF_TV_Fill($hCFF_Win, $hTV_GUI, $hTreeView, $sRoot, $sFile_Mask, $iDisplay)

	Local $aLevel[100], $iLevel, $aCFF_Curr_Index, $sFullFolderpath, $sFolderName, $sFileName, $fFolder, $iFile_Index

	Local $fFile_Ext = True
	If $iDisplay > 3 Then
		$fFile_Ext = False
		$iDisplay -= 4
	EndIf

	; Switch to correct GUI
	GUISwitch($hTV_GUI)
	; Set TV ControlID
	$aLevel[0] = $hTreeView

	; What display is required
	Switch $iDisplay
		Case 1 ; Only display files in Root folder
			_CFF_ListFiles($sRoot, $sFile_Mask, $hTreeView, $fFile_Ext)
		Case 2 ; Only display folders
			If $sRoot = $sCFF_Def_Folder_Path Then
				; Copy default array
				$aCFF_Curr_Index = $aCFF_Def_Folder_Index
			Else
				; Create folder array
				$aCFF_Curr_Index = _RecFileListToArray($sRoot, "*", 2, 1, 1, 1, "$*;System Volume Information;RECYCLED;_Restore")
			EndIf
			If IsArray($aCFF_Curr_Index) Then
				; Add each folder
				For $i = 1 To $aCFF_Curr_Index[0]
					$sFullFolderpath = $aCFF_Curr_Index[$i]
					; Count \
					StringReplace($sFullFolderpath, "\", "")
					$iLevel = @extended
					; Extract folder name from path
					$sFolderName = StringRegExpReplace($sFullFolderpath, "(.*\\|^)(.*)\\", "$2")
					; Add to TV and store item ControlID
					$aLevel[$iLevel] = GUICtrlCreateTreeViewItem($sFolderName, $aLevel[$iLevel - 1])
				Next
			EndIf
		Case 0 ; Folders and matching files

			; If default folder array set
			If $sRoot = $sCFF_Def_Folder_Path Then
				; Copy default array
				$aCFF_Curr_Index = $aCFF_Def_Folder_Index
			Else
				; Create folder array
				$aCFF_Curr_Index = _RecFileListToArray($sRoot, "*", 2, 1, 1, 1, "$*;System Volume Information;RECYCLED;_Restore")
			EndIf

			; If default file array set
			If IsArray($aCFF_Def_File_Index) Then
				; Add root files
				For $iFileIndex = 1 To $aCFF_Def_File_Index[0]
					; If file in subfolder then exit loop with $iFileIndex is set to first file in a subfolder
					If StringInStr($aCFF_Def_File_Index[$iFileIndex], "\") Then ExitLoop
					; Add file to TreeView
					GUICtrlCreateTreeViewItem($aCFF_Def_File_Index[$iFileIndex], $aLevel[0])
				Next
				; Add folders
				For $i = 1 To $aCFF_Curr_Index[0]
					$sFullFolderpath = $aCFF_Curr_Index[$i]
					; Count \
					StringReplace($sFullFolderpath, "\", "")
					$iLevel = @extended
					; Extract folder name from path
					$sFolderName = StringRegExpReplace($sFullFolderpath, "(.*\\|^)(.*)\\", "$2")
					; Add to TV and store item ControlID
					$aLevel[$iLevel] = GUICtrlCreateTreeViewItem($sFolderName, $aLevel[$iLevel - 1])
					; Add files within folder
					For $j = $iFile_Index To $aCFF_Def_File_Index[0]
						; Check if possible match
						$sFileName = StringReplace($aCFF_Def_File_Index[$j], $sFullFolderpath, "", 1)
						; Check all \ removed to confirm file
						If Not StringInStr($sFileName, "\") Then
							; Remove ext if required
							If Not $fFile_Ext Then $sFileName = StringRegExpReplace($sFileName, "(^.*)\..*", "$1")
							; Add to TV
							GUICtrlCreateTreeViewItem($sFileName, $aLevel[$iLevel])
							; Advance track index
							$iFile_Index = $j + 1
						Else
							; Move to next folder
							ExitLoop
						EndIf
					Next
				Next
			Else
				; Add root files
				_CFF_ListFiles($sRoot, $sFile_Mask, $aLevel[0], $fFile_Ext)
				; Add folders
				For $i = 1 To $aCFF_Curr_Index[0]
					$sFullFolderpath = $aCFF_Curr_Index[$i]
					; Count \
					StringRegExpReplace($sFullFolderpath, "\\", "")
					$iLevel = @extended
					; Extract folder name from path
					$sFolderName = StringRegExpReplace($sFullFolderpath, "(.*\\|^)(.*)\\", "$2")
					; Add to TV and store item ControlID
					$aLevel[$iLevel] = GUICtrlCreateTreeViewItem($sFolderName, $aLevel[$iLevel - 1])
					; Add files within folder
					_CFF_ListFiles($sRoot & $aCFF_Curr_Index[$i], $sFile_Mask, $aLevel[$iLevel], $fFile_Ext)
				Next
			EndIf
		Case 3 ; Only folders containing matching files

			; If default folder array set
			If IsArray($aCFF_Def_Combo_Index) Then
				; Copy default array
				$aCFF_Curr_Index = $aCFF_Def_Combo_Index
			Else
				; Create folder array
				$aCFF_Curr_Index = _RecFileListToArray($sRoot, $sFile_Mask, 0, 1, 1, 1, "", "$*;System Volume Information;RECYCLED;_Restore")
				If Not @error Then
					; Strip empty folders and delete array if no files found
					If _CFF_Strip_Array($aCFF_Curr_Index) = False Then $aCFF_Curr_Index = 0
				EndIf
			EndIf
			; Check valid array to load
			If IsArray($aCFF_Curr_Index) Then
				; Add remaining folders and files
				For $i = 1 To $aCFF_Curr_Index[0]
					; If blank then ignore
					If $aCFF_Curr_Index[$i] = "" Then ContinueLoop
					; Examine current return
					StringReplace($aCFF_Curr_Index[$i], "\", "")
					$iLevel = @extended
					$fFolder = True
					If StringRight($aCFF_Curr_Index[$i], 1) <> "\" Then
						$fFolder = False
					EndIf
					; Display current element
					If $fFolder = True Then ; Folder
						; Extract folder name from path
						$sFolderName = StringRegExpReplace($aCFF_Curr_Index[$i], "(.*\\|^)(.*)\\", "$2")
						; Add to TV and store item ControlID
						$aLevel[$iLevel] = GUICtrlCreateTreeViewItem($sFolderName, $aLevel[$iLevel - 1])
					Else ; File
						If $fFile_Ext Then
							$sFileName = StringRegExpReplace($aCFF_Curr_Index[$i], "^.*\\", "")
						Else
							; Remove ext if required
							$sFileName = StringRegExpReplace($aCFF_Curr_Index[$i], "^.*\\|\..*$", "")
						EndIf
						GUICtrlCreateTreeViewItem($sFileName, $aLevel[$iLevel])
					EndIf
				Next
			EndIf
	EndSwitch

	; Switch back to main dialog
	GUISwitch($hCFF_Win)

EndFunc   ;==>_CFF_TV_Fill

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: _CFF_Strip_Array
; Description ...: Removes empty folders from a file/folder array.
; Author ........: Melba23
; Remarks .......:
; ===============================================================================================================================
Func _CFF_Strip_Array(ByRef $aArray)

	; Strip empty folders
	Local $fFilesFound = False
	Local $fFileInFolder = False
	Local $fFileInBranch = False
	Local $iFolderLevel = 0
	StringReplace($aArray[$aArray[0]], "\", "")
	Local $iLastFolderLevel = @extended
	; Move through array and blank empty folders
	For $i = $aArray[0] To 1 Step -1
		; Check if element is a folder
		If StringRight($aArray[$i], 1) = "\" Then
			; If folder then get level
			StringReplace($aArray[$i], "\", "")
			$iFolderLevel = @extended
			; Are there files within
			If $fFileInFolder Then
				; If so then leave
				$iLastFolderLevel = $iFolderLevel
				$fFileInFolder = False
				ContinueLoop
			EndIf
			; Look at folder level
			Select
				Case $iFolderLevel < $iLastFolderLevel
					; Have files been found in this branch
					If $fFileInBranch Then
						; Leave if so
						$iLastFolderLevel = $iFolderLevel
					Else
						; Delete if not
						$aArray[$i] = ""
					EndIf
				Case $iFolderLevel = $iLastFolderLevel
					; Folder is empty and can be deleted
					$aArray[$i] = ""
				Case $iFolderLevel > $iLastFolderLevel
					; Clear branch flag
					$fFileInBranch = False
					; Check if any files in the folder
					If Not $fFileInFolder Then
						; Delete as empty folder
						$aArray[$i] = ""
					EndIf
			EndSelect
		Else
			; If file then set flags
			$fFilesFound = True
			$fFileInFolder = True
			$fFileInBranch = True
		EndIf
	Next

	Return $fFilesFound

EndFunc

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: _CFF_ListFiles
; Description ...: Adds files to an existing folder structure to allow file selection.
; Author ........: Melba23
; Remarks .......:
; ===============================================================================================================================
Func _CFF_ListFiles($sFolderPath, $sFile_Mask, $hTreeView_Parent, $fFile_Ext)

	Local $sFileName

	Local $aFileArray = _RecFileListToArray($sFolderPath, $sFile_Mask, 1, 0, 1, 0)
	If IsArray($aFileArray) Then
		For $j = 1 To $aFileArray[0]
			If $fFile_Ext Then
				$sFileName = $aFileArray[$j]
			Else
				; Remove ext if required
				$sFileName = StringRegExpReplace($aFileArray[$j], "(^.*)\..*", "$1")
			EndIf
			GUICtrlCreateTreeViewItem($sFileName, $hTreeView_Parent)
		Next
	EndIf

EndFunc   ;==>_CFF_ListFiles

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: _CFF_GetSel
; Description ...: Retrieves selected TreeView item and if file confirms match to file mask.
; Author ........: Melba23
; Remarks .......:
; ===============================================================================================================================
Func _CFF_GetSel($hTreeView_Handle, $iDisplay, $sRoot, $sFile_Mask, $hTreeView_Item = 0)

	Local $sTrialPath, $sSelected_Ext

	Local $sSelectedPath = StringReplace(_GUICtrlTreeView_GetTree($hTreeView_Handle, $hTreeView_Item), "|", "\")

	; Check for visible file exts
	Local $fFile_Ext = True
	If $iDisplay > 3 Then
		$fFile_Ext = False
		$iDisplay -= 4
	EndIf

	; Only folders displayed
	If $iDisplay = 2 Then Return $sSelectedPath

	; Files required
	If $fFile_Ext Then
		; File exts visible so check is file
		$sTrialPath = $sRoot & $sSelectedPath
		If Not StringInStr(FileGetAttrib($sTrialPath), "D") Then
			Return $sSelectedPath
		Else
			Return ""
		EndIf
	Else
		; No exts visible so check if file exists with any ext from mask
		Local $aMask_Ext = StringSplit($sFile_Mask, ";")
		For $i = 1 To $aMask_Ext[0]
			$sSelected_Ext = $sSelectedPath & StringTrimLeft($aMask_Ext[$i], 1)
			$sTrialPath = $sRoot & $sSelected_Ext
			If FileExists($sTrialPath) Then Return $sSelected_Ext
		Next
		; No match so not file
		Return ""
	EndIf

EndFunc   ;==>_CFF_GetSel

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........:_CFF_Expand_Check
; Description ...: Prevents rapid clicks to expand/contract the TreeView being treated as a double click selection.
; Author ........: Melba23
; Remarks .......:
; ===============================================================================================================================
Func _CFF_Expand_Check()
	AdlibUnRegister("_CFF_Expand_Check")
	$fCFF_Expand = False
EndFunc
