;Displays a save prompt
Func SavePrompt()
	Local $Data
	If $G_CurrentFile = "" Then Return 1
	$Data = Sci_GetLines($SciControl)
	If StringRight($Data, 1) = Chr(0) Then $Data = StringTrimRight($Data, 1)
	If $Data == $G_FileText Then Return 1
	If MsgBox(4, "Warning", "save changes to the open item?",Default,$FormMain) <> 6 Then Return 1
	Return SaveData($Data)
EndFunc   ;==>SavePrompt

;Used by event functions to change the storage location
Func ChangeStore($sPath)
	If Not _IsDir($sPath) Then DirCreate($sPath)
	If Not _IsDir($sPath) Then
		MsgBox(0, "Error", "Failed to change storage location.")
		Return
	EndIf
	Global $Opt_StorageDir = $sPath
	IniWrite("Au3DB.ini", "Settings", "StorageDir", $Opt_StorageDir)
	PopulateTree()
	Return
EndFunc   ;==>ChangeStore

;Used to read a file,assign global data,and populate the Scintilla control
Func LoadFile($sPath)
	Global $G_FileText = FileRead($sPath)
	Sci_DelLines($SciControl)
	Sci_AddLines($SciControl, $G_FileText, 0)
	Global $G_CurrentFile = $sPath
	ControlEnable($FormMain, "", $SciControl)
EndFunc   ;==>LoadFile

;Saves specified data to the current opened file
Func SaveData($Data)
	Local $Handle = FileOpen($G_CurrentFile, 2)
	If Not FileWrite($Handle, $Data) Then
		FileClose($Handle)
		MsgBox(0, "Error", "Save Failed.", Default, $FormMain)
		Return 0
	EndIf
	FileClose($Handle)
	Return 1
EndFunc   ;==>SaveData

;Closes the current file,and clears/disabes Scintilla control
Func CloseCurrentFile()
	Sci_DelLines($SciControl)
	Global $G_CurrentFile = ""
	ControlDisable($FormMain, "", $SciControl)
EndFunc   ;==>CloseCurrentFile

Func PopulateTree()
	Global $G_CMenuArray[1][4]
	Local $X, $List = _FileListToArray($Opt_StorageDir, "*", 2)
	If @error Then Return
	_GUICtrlTreeView_DeleteAll($TreeView)
	For $X = 1 To $List[0]
		ScanFolder($Opt_StorageDir & "\" & $List[$X])
	Next
EndFunc   ;==>PopulateTree

;Scans a folder and populates it with items
Func ScanFolder($sDir)
	Local $TVI, $Context, $Delete, $Rename, $New, $List, $X
	$TVI = GUICtrlCreateTreeViewItem(StringTrimLeft($sDir, StringInStr($sDir, "\", 0, -1)), $TreeView)
	$Context = GUICtrlCreateContextMenu($TVI)
	$Delete = GUICtrlCreateMenuItem("Delete...", $Context)
	GUICtrlSetOnEvent($Delete, "GUI_Event_DeleteCategory")
	$Rename = GUICtrlCreateMenuItem("Rename...", $Context)
	GUICtrlSetOnEvent($Rename, "GUI_Event_RenameCategory")
	$New = GUICtrlCreateMenuItem("New Item...", $Context)
	GUICtrlSetOnEvent($New, "GUI_Event_NewItem")
	GUICtrlSetImage($TVI, "Shell32.dll", -5)
	CMArrayAdd($TVI, $Delete, $Rename, $New)
	$List = _FileListToArray($sDir, "*", 1)
	If @error Then Return 0
	For $X = 1 To $List[0]
		CreateItem($TVI, $sDir & "\" & $List[$X])
	Next

EndFunc   ;==>ScanFolder

;Creates an item in the treeview
Func CreateItem($id, $Path)
	Local $Name, $TVI, $Context, $Delete, $Rename
	$Name = StringTrimLeft($Path, StringInStr($Path, "\", 0, -1))
	$TVI = GUICtrlCreateTreeViewItem($Name, $id)
	GUICtrlSetOnEvent(-1, "GUI_EVENT_TVIClick")
	GUICtrlSetImage(-1,@AutoItExe,-5)
	$Context = GUICtrlCreateContextMenu($TVI)
	$Delete = GUICtrlCreateMenuItem("Delete...", $Context)
	GUICtrlSetOnEvent($Delete, "GUI_Event_DeleteItem")
	$Rename = GUICtrlCreateMenuItem("Rename...", $Context)
	GUICtrlSetOnEvent($Rename, "GUI_Event_RenameItem")
	CMArrayAdd($TVI, $Delete, $Rename)

EndFunc   ;==>CreateItem

;Adds an item to the global array of items/categorys
Func CMArrayAdd($hTVI, $hDelete, $hRename, $hNew = "")
	Local $iUBound = UBound($G_CMenuArray) + 1
	ReDim $G_CMenuArray[$iUBound][4]
	$G_CMenuArray[$iUBound - 1][0] = $hTVI
	$G_CMenuArray[$iUBound - 1][1] = $hDelete
	$G_CMenuArray[$iUBound - 1][2] = $hRename
	$G_CMenuArray[$iUBound - 1][3] = $hNew
EndFunc   ;==>CMArrayAdd

;1=$sPath is a dir|0=$sPath is not a dir
Func _IsDir($sPath)
	If Not StringInStr(FileGetAttrib($sPath), "D") Then Return False
	Return True
EndFunc   ;==>_IsDir

;Gets the path of a treeview item
Func _TVIPath($hTVI)
	Local $FileName, $Category
	$FileName = GUICtrlRead($hTVI, 1)
	$Category = _GUICtrlTreeView_GetText($TreeView, _GUICtrlTreeView_GetParentHandle($TreeView, $hTVI))
	Return $Opt_StorageDir & "\" & $Category & "\" & $FileName
EndFunc   ;==>_TVIPath

