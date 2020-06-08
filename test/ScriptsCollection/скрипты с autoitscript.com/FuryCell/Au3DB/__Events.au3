
Func GUI_Event_Close()
	If Not SavePrompt() Then Return
	Exit
EndFunc   ;==>GUI_Event_Close

Func GUI_Event_TVIClick()
	Local $Path
	$Path = _TVIPath(@GUI_CtrlId)
	LoadFile($Path)
EndFunc   ;==>GUI_Event_TVIClick

Func GUI_Event_DeleteItem()
	Local $TVI, $Path
	$TVI = $G_CMenuArray[_ArraySearch($G_CMenuArray, @GUI_CtrlId, 1, 0, 0, 0, 1, 1)][0]
	$Path = _TVIPath($TVI)

	If MsgBox(4, "Warning", "Are you sure you want to delete the selected item?", Default, $FormMain) <> 6 Then Return
	If $G_CurrentFile = $Path Then CloseCurrentFile()
	If Not FileDelete($Path) Then
		MsgBox(0, "Error", "Failed to delete the item.", Default, $FormMain)
		Return
	EndIf
	GUICtrlDelete($TVI)
EndFunc   ;==>GUI_Event_DeleteItem

Func GUI_Event_RenameItem()
	Local $TVI, $Path, $Input, $NewPath
	$TVI = $G_CMenuArray[_ArraySearch($G_CMenuArray, @GUI_CtrlId, 1, 0, 0, 0, 1, 2)][0]
	$Path = _TVIPath($TVI)
	$Input = InputBox("Au3DB", "Please enter the new name for the Item.", "", "", 200, 140, Default, Default, Default, $FormMain)
	If @error Then Return
	If $G_CurrentFile = $Path Then
		If Not SavePrompt() Then Return
		CloseCurrentFile()
	EndIf
	$NewPath = StringLeft($Path, StringInStr($Path, "\", 0, -1)) & $Input
	If Not FileMove($Path, $NewPath) Then
		MsgBox(0, "Error", "Failed to rename file.",Default,$FormMain)
	EndIf
	GUICtrlSetData($TVI, $Input)
EndFunc   ;==>GUI_Event_RenameItem

Func GUI_Event_DeleteCategory()
	Local $TVI, $Path
	$TVI = $G_CMenuArray[_ArraySearch($G_CMenuArray, @GUI_CtrlId, 1, 0, 0, 0, 1, 1)][0]
	$Path = $Opt_StorageDir & "\" & GUICtrlRead($TVI, 1)
	If MsgBox(4, "Au3DB", "Are you sure you want to delete the selected category and all items in it?", Default, $FormMain) <> 6 Then Return
	If StringLeft($G_CurrentFile, StringLen($Path)) = $Path Then CloseCurrentFile()
	If Not DirRemove($Path, 1) Then
		MsgBox(0, "Error", "Failed to delete the category.", Default, $FormMain)
		Return
	EndIf
	GUICtrlDelete($TVI)
EndFunc   ;==>GUI_Event_DeleteCategory

Func GUI_Event_RenameCategory()
	Local $TVI, $Path, $Input, $NewPath
	$TVI = $G_CMenuArray[_ArraySearch($G_CMenuArray, @GUI_CtrlId, 1, 0, 0, 0, 1, 2)][0]
	$Path = $Opt_StorageDir & "\" & GUICtrlRead($TVI, 1)
	$Input = InputBox("Au3DB", "Please enter the new name for the category.", "", "", 200, 140, Default, Default, Default, $FormMain)
	If @error Then Return
	If StringLeft($G_CurrentFile, StringLen($Path)) = $Path Then
		If Not SavePrompt() Then Return
		CloseCurrentFile()
	EndIf
	Local $NewPath = $Opt_StorageDir & "\" & $Input
	If Not DirMove($Path, $NewPath) Then
		MsgBox(0, "Error", "Failed to rename category.",Default,$FormMain)
	EndIf
	GUICtrlSetData($TVI, $Input)
EndFunc   ;==>GUI_Event_RenameCategory

Func GUI_Event_NewCategory()
	Local $Input
	$Input = InputBox("Name?", "Please enter the name for the new category.", "", "", 200, 140, Default, Default, Default, $FormMain)
	If @error Then Return
	If Not DirCreate($Opt_StorageDir & "\" & $Input) Then
		MsgBox(0, "Error", "Failed to create new category.", Default, $FormMain)
		Return
	EndIf
	PopulateTree()
EndFunc   ;==>GUI_Event_NewCategory

Func GUI_Event_NewItem()
	Local $TVI = $G_CMenuArray[_ArraySearch($G_CMenuArray, @GUI_CtrlId, 1, 0, 0, 0, 1, 3)][0]
	Local $Input = InputBox("Name?", "Please enter the name for the new item.", "", "", 200, 140, Default, Default, Default, $FormMain)
	If @error Then Return
	If Not _FileCreate($Opt_StorageDir & "\" & GUICtrlRead($TVI, 1) & "\" & $Input) Then
		MsgBox(0, "Error", "Failed to create new Item.", Default, $FormMain)
		Return
	EndIf
	PopulateTree()
EndFunc   ;==>GUI_Event_NewItem

Func GUI_Event_Save()
	Local $Data = Sci_GetLines($SciControl)
	SaveData($Data)
EndFunc   ;==>GUI_Event_Save

Func GUI_Event_ChangeStore()
	Local $Input = InputBox("Au3DB", "Please enter the storage location.", $Opt_StorageDir, "", 200, 140, Default, Default, Default, $FormMain)
	If @error Then Return
	ChangeStore($Input)
EndFunc   ;==>GUI_Event_ChangeStore

Func GUI_Event_DefaultStore()
	If MsgBox(4, "Au3DB", 'Restore default storage location? (".\Data")', Default, $FormMain) <> 6 Then Return
	ChangeStore(".\Data")
EndFunc   ;==>GUI_Event_DefaultStore

Func GUI_Event_About()
	If Not SavePrompt() Then Return
	$Text = '$Program="Au3DB"/n$Version="$VER$"/n$Author="Michael Michta"/n/n#Include <_SciLexer.au3> ;Thanks to Kip'
	$Text = StringReplace($Text, "/n", @CRLF)
	$Text= StringReplace($Text,"$VER$",$Const_Version)
	CloseCurrentFile()
	Sci_AddLines($SciControl, $Text, 0)
EndFunc   ;==>GUI_Event_About