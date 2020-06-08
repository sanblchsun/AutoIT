#include-once

; #INDEX# ============================================================================================================
; Title .........: GUIListViewEx
; AutoIt Version : 3.3 +
; Language ......: English
; Description ...: Permits insertion, deletion, moving, dragging, sorting and editing of items within activated ListViews
; Remarks .......: - It is important to use _GUIListViewEx_Close when a enabled ListView is deleted to free the memory used
;                    by the $aGLVEx_Data array which shadows the ListView contents.
;                  - Windows message handlers required:
;                     - Dragging: WM_NOTIFY, WM_MOUSEMOVE and WM_LBUTTONUP
;                     - Sorting and editing: WM_NOTIFY only
;                     - Insert, delete and move: None
;                  - If the script already has WM_NOTIFY, WM_MOUSEMOVE or WM_LBUTTONUP handlers then only set
;                    unregistered messages in _GUIListViewEx_MsgRegister and call the relevant _GUIListViewEx_WM_#####_Handler
;                    from within the existing handler
;                  - Uses 2 undocumented functions within GUIListView UDF to set and colour insert mark (thanks rover)
;                  - If ListView is editable, Opt("GUICloseOnESC") set to 0 as ESC = edit cancel.  Do not reset Opt in script
; Author ........: Melba23
; Credits .......: martin (basic drag code), Array.au3 authors (array functions), KaFu and ProgAndy (font function)
; ====================================================================================================================

; #AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w- 4 -w 5 -w 6 -w- 7

; #INCLUDES# =========================================================================================================
#include <GuiListView.au3>
#include <GUIImageList.au3>

; #GLOBAL VARIABLES# =================================================================================================
; Array to hold registered ListView data
Global $aGLVEx_Data[1][8] = [[0, 0]]
; [0][0] = Count			[n][0] = ListView handle
; [0][1] = Active Index		[n][1] = Native ListView ControlID / 0
;		 					[n][2] = Shadow array
; 							[n][3] = Count in [0] element of shadow array
;                           [n][4] = Edit/Sort status
;                           [n][5] = Drag image flag
; 							[n][6] = Checkbox array flag
;                           [n][7] = Editable columns range
; Variables for all UDF functions
Global $hGLVEx_Handle, $hGLVEx_CID, $aGLVEx_Array
; Variables for UDF dragging handlers
Global $iGLVEx_Dragging = 0, $iGLVEx_DraggedIndex, $hGLVEx_DraggedImage = 0, $iGLVEx_InsertIndex = -1
Global $iGLVEx_LastY, $fGLVEx_BarUnder, $fGLVEx_MultipleDrag, $aGLVEx_DragCheckArray
; Variables for UDF edit
Global $hGLVEx_Editing, $cGLVEx_EditID = 9999, $fGLVEx_EditClickFlag = False

; #CURRENT# ==========================================================================================================
; _GUIListViewEx_Init:                 Enables UDF functions for the ListView and sets various flags
; _GUIListViewEx_Close:                Disables all UDF functions for the specified ListView and clears all memory used
; _GUIListViewEx_SetActive:            Set specified ListView as active for UDF functions
; _GUIListViewEx_GetActive:            Get index number of ListView active for UDF functions
; _GUIListViewEx_ReadToArray:          Creates an array from the current ListView content
; _GUIListViewEx_ReturnArray:          Returns an array reflecting the current content of the ListView
; _GUIListViewEx_Insert:               Inserts data just below selected item in active ListView
; _GUIListViewEx_Delete:               Deletes selected item in active ListView
; _GUIListViewEx_Up:                   Moves selected item in active ListView up 1 place
; _GUIListViewEx_Down:                 Moves selected item in active ListView down 1 place
; _GUIListViewEx_EditOnClick:          Edit ListView items in user-defined columns when doubleclicked
; _GUIListViewEx_EditItem:             Edit ListView items programatically
; _GUIListViewEx_MsgRegister:          Registers Windows messages for listed ListViews
; _GUIListViewEx_WM_NOTIFY_Handler:    Windows message handler for WM_NOTIFY - needed for sort, drag and edit
; _GUIListViewEx_WM_MOUSEMOVE_Handler: Windows message handler for WM_MOUSEMOVE - needed for drag
; _GUIListViewEx_WM_LBUTTONUP_Handler: Windows message handler for WM_LBUTTONUP - needed for drag
; ====================================================================================================================

; #INTERNAL_USE_ONLY#=================================================================================================
; _GUIListViewEx_ExpandCols:   Expands column ranges to list each column separately
; _GUIListViewEx_HighLight:    Highlights specified ListView item and ensures it is visible
; _GUIListViewEx_DataChange:   Resets ListView items within a defined range to the current values in the stored array
; _GUIListViewEx_EditProcess:  Runs ListView editing process
; _GUIListViewEx_GetLVFont:    Gets font details for ListView to be edited
; _GUIListViewEx_EditCoords:   Ensures item in view then locates and sizes edit control
; _GUIListViewEx_Array_Add:    Adds a specified value at the end of an array
; _GUIListViewEx_Array_Insert: Adds a value at the specified index of an array
; _GUIListViewEx_Array_Delete: Deletes a specified index from an array
; _GUIListViewEx_Array_Swap:   Swaps specified elements within an array
; ====================================================================================================================

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_Init
; Description ...: Enables UDF functions for the ListView and sets various flags
; Syntax.........: _GUIListViewEx_Init($hLV, [$aArray = ""[, $iStart = 0[, $iColour[, $fImage[, $iAdded[, $sCols]]]]]])
; Parameters ....: $hLV     - Handle or ControlID of ListView
;                  $aArray  - Name of array used to fill ListView.  "" = empty ListView
;                  $iStart  - 0 = ListView data starts in [0] element of array (default)
;                             1 = Count in [0] element
;                  $iColour - RGB colour for insert mark (default = black)
;                  $fImage  - True  = Shadow image of dragged item when dragging
;                             False = No shadow image (default)
;                  $iAdded  - 0   - No added features (default).  To get added features add the following
;                             + 1 - Sortable by clicking on column headers
;                             + 2 - Editable by double clicking on a subitem in user-defined columns
;                             + 4 - Edit moveable within same ListView by triple mouse-click (only if ListView editable)
;                  $sCols   - Editable columns - only used if Editable flag set in $iAdded
;                                 All columns: "*" (default)
;                                 Limit columns: example "1;2;5-6;8-9;10" - ranges expanded automatically
; Requirement(s).: v3.3 +
; Return values .: Index number of ListView for use in other GUIListViewEx functions
; Author ........: Melba23
; Modified ......:
; Remarks .......: - If the ListView is the only one enabled, it is automatically set as active
;                  - If no array is passed a shadow array is created automatically - if the ListView has more than
;                  1 column this array is 2D with the second dimension set to the number of columns
;                  - The shadow array has a count in element [0] added if it does not exist. However, if the $iStart
;                  parameter is set to 0 this count element will not be returned by other GUIListViewEx functions
;                  - The _GUIListViewEx_ReadToArray function will read an existing ListView into an array
;                  - Only first item of a multiple selection is shadow imaged when dragging (API limitation)
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_Init($hLV, $aArray = "", $iStart = 0, $iColour = 0, $fImage = False, $iAdded = 0, $sCols = "*")

	Local $iIndex = 0

	; See if there is a blank line available in the array
	For $i = 1 To $aGLVEx_Data[0][0]
		If $aGLVEx_Data[$i][0] = 0 Then
			$iIndex = $i
			ExitLoop
		EndIf
	Next
	; If no blank line found then increase array size
	If $iIndex = 0 Then
		$aGLVEx_Data[0][0] += 1
		ReDim $aGLVEx_Data[$aGLVEx_Data[0][0] + 1][8]
		$iIndex = $aGLVEx_Data[0][0]
	EndIf

	; Store ListView handle and ControlID
	If IsHWnd($hLV) Then
		$aGLVEx_Data[$iIndex][0] = $hLV
		$aGLVEx_Data[$iIndex][1] = 0
	Else
		$aGLVEx_Data[$iIndex][0] = GUICtrlGetHandle($hLV)
		$aGLVEx_Data[$iIndex][1] = $hLV
	EndIf

	; Create a shadow array if needed
	If $aArray = "" Then
		Local $iCols = _GUICtrlListView_GetColumnCount($aGLVEx_Data[$iIndex][0])
		Switch $iCols
			Case 1
				Local $aReplacement[1] = [0]
			Case Else
				Local $aReplacement[1][$iCols] = [[0]]
		EndSwitch
		$aArray = $aReplacement
	Else
		; Add count element to shadow array if required
		If $iStart = 0 Then _GUIListViewEx_Array_Insert($aArray, 0, UBound($aArray))
	EndIf
	; Store array
	$aGLVEx_Data[$iIndex][2] = $aArray

	; Store [0] = count data
	$aGLVEx_Data[$iIndex][3] = $iStart

	; Set insert mark colour after conversion to BGR
	_GUICtrlListView_SetInsertMarkColor($hLV, BitOR(BitShift(BitAND($iColour, 0x000000FF), -16), BitAND($iColour, 0x0000FF00), BitShift(BitAND($iColour, 0x00FF0000), 16)))
	; If image required
	If $fImage Then
		$aGLVEx_Data[$iIndex][5] = 1
	EndIf

	; If sortable, store sort array
	If BitAND($iAdded, 1) Then
		Local $aLVSortState[_GUICtrlListView_GetColumnCount($hLV)]
		$aGLVEx_Data[$iIndex][4] = $aLVSortState
	Else
		$aGLVEx_Data[$iIndex][4] = 0
	EndIf
	; If editable
	If BitAND($iAdded, 2) Then
		$aGLVEx_Data[$iIndex][7] = _GUIListViewEx_ExpandCols($sCols)
		; Limit ESC to edit cancel
		Opt("GUICloseOnESC", 0)
		; If move edit by click add flag to valid col list
		If BitAnd($iAdded, 4) Then
			$aGLVEx_Data[$iIndex][7] &= ";#"
		EndIf
	Else
		$aGLVEx_Data[$iIndex][7] = ""
	EndIf
	;  If checkbox extended style
	If BitAND(_GUICtrlListView_GetExtendedListViewStyle($hLV), 4) Then ; $LVS_EX_CHECKBOXES
		$aGLVEx_Data[$iIndex][6] = 1
	EndIf

	; If only 1 current ListView then activate
	Local $iListView_Count = 0
	For $i = 1 To $iIndex
		If $aGLVEx_Data[$i][0] Then $iListView_Count += 1
	Next
	If $iListView_Count = 1 Then _GUIListViewEx_SetActive($iIndex)

	; Return ListView index
	Return $iIndex

EndFunc   ;==>_GUIListViewEx_Init

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_Close
; Description ...: Disables all UDF functions for the specified ListView and clears all memory used
; Syntax.........: _GUIListViewEx_Close($iIndex)
; Parameters ....: $iIndex - Index number of ListView to close as returned by _GUIListViewEx_Init
;                            0 (default) = Closes all ListViews
; Requirement(s).: v3.3 +
; Return values .: Success: 1
;                  Failure: 0 and @error set to 1 - Invalid index number
; Author ........: Melba23
; Modified ......:
; Remarks .......:
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_Close($iIndex = 0)

	; Check valid index
	If $iIndex < 0 Or $iIndex > $aGLVEx_Data[0][0] Then Return SetError(1, 0, 0)

	If $iIndex = 0 Then
		; Remove all ListView data
		Global $aGLVEx_Data[1][8] = [[0, 0]]
	Else
		; Reset all data for ListView
		For $i = 0 To 6
			$aGLVEx_Data[$iIndex][$i] = 0
		Next

		; Cancel active index if set to this ListView
		If $aGLVEx_Data[0][1] = $iIndex Then $aGLVEx_Data[0][1] = 0
	EndIf

	Return 1

EndFunc   ;==>_GUIListViewEx_Close

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_SetActive
; Description ...: Set specified ListView as active for UDF functions
; Syntax.........: _GUIListViewEx_SetActive($iIndex)
; Parameters ....: $iIndex - Index number of ListView as returned by _GUIListViewEx_Init
;                  An index of 0 clears any current setting
; Requirement(s).: v3.3 +
; Return values .: Success: Returns previous active index number, 0 = no previously active ListView
;                  Failure: -1 and @error set to 1 - Invalid index number
; Author ........: Melba23
; Modified ......:
; Remarks .......: ListViews can also be activated by clicking on them
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_SetActive($iIndex)

	; Check valid index
	If $iIndex < 0 Or $iIndex > $aGLVEx_Data[0][0] Then Return SetError(1, 0, -1)

	Local $iCurr_Index = $aGLVEx_Data[0][1]

	If $iIndex Then
		; Store index of specified ListView
		$aGLVEx_Data[0][1] = $iIndex
		; Set values for specified ListView
		$hGLVEx_Handle = $aGLVEx_Data[$iIndex][0]
		$hGLVEx_CID = $aGLVEx_Data[$iIndex][1]
	Else
		; Clear active index
		$aGLVEx_Data[0][1] = 0
	EndIf

	Return $iCurr_Index

EndFunc   ;==>_GUIListViewEx_SetActive

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_GetActive
; Description ...: Get index number of ListView active for UDF functions
; Syntax.........: _GUIListViewEx_GetActive()
; Parameters ....: None
; Requirement(s).: v3.3 +
; Return values .: Success: Index number as returned by _GUIListViewEx_Init, 0 = no active ListView
; Author ........: Melba23
; Modified ......:
; Remarks .......:
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_GetActive()

	Return $aGLVEx_Data[0][1]

EndFunc   ;==>_GUIListViewEx_GetActive

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_ReadToArray
; Description ...: Creates an array from the current ListView content
; Syntax.........: _GUIListViewEx_ReadToArray($hLV[, $iCount = 0])
; Parameters ....: $hLV    - ControlID or handle of ListView
;                  $iCount - 0 (default) = ListView data starts in [0] element of array, 1 = Count in [0] element
; Requirement(s).: v3.3 +
; Return values .: Success: Array of current ListView content
;                  Failure: Returns null string and sets @error as follows:
;                           1 = Invalid ListView ID
; Author ........: Melba23
; Modified ......:
; Remarks .......: If the returned array is used in GUIListViewEx_Init the $iStart parameters must match in the 2 functions
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_ReadToArray($hLV, $iStart = 0)

	Local $aRow

	; Use the ListView handle
	If Not IsHWnd($hLV) Then
		$hLV = GUICtrlGetHandle($hLV)
		If Not IsHWnd($hLV) Then
			Return SetError(1, 0, "")
		EndIf
	EndIf
	; Get size of ListView
	Local $iRows = _GUICtrlListView_GetItemCount($hLV)
	Local $iCols = _GUICtrlListView_GetColumnCount($hLV)
	; Create array to hold ListView content and add count - count overwritten if not needed
	Local $aLVArray[$iRows + $iStart][$iCols] = [[0]]
	; Read ListView content into array
	For $i = 0 To $iRows - 1
		; Read the row content
		$aRow = _GUICtrlListView_GetItemTextArray($hLV, $i)
		For $j = 1 To $aRow[0]
			; Add to the ListView content array
			$aLVArray[$i + $iStart][$j - 1] = $aRow[$j]
		Next
	Next
	; Return array
	Return $aLVArray

EndFunc   ;==>_GUIListViewEx_ReadToArray

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_ReturnArray
; Description ...: Returns an array reflecting the current content of an activated ListView
; Syntax.........: _GUIListViewEx_ReturnArray($iIndex[, $iCheck])
; Parameters ....: $iIndex - Index number of ListView as returned by _GUIListViewEx_Init
;                  $iCheck - If non-zero then the state of the checkboxes is returned (Default = 0)
; Requirement(s).: v3.3 +
; Return values .: Success: Array of current ListView - presence of count in [0] element determined by _GUIListViewEx_Init
;                  Failure: Empty array returns null string and sets @error as follows:
;                           1 = Invalid index number
;                           2 = Empty array (no items in ListView)
;                           3 = $iCheck set to True but ListView does not have checkbox style
; Author ........: Melba23
; Modified ......:
; Remarks .......: The $iStart parameter in GUIListViewEx_Init determines whether the [0] element is a count
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_ReturnArray($iIndex, $iCheck = 0)

	; Check valid index
	If $iIndex < 1 Or $iIndex > $aGLVEx_Data[0][0] Then Return SetError(1, 0, "")

	; Copy current array
	Local $aRetArray = $aGLVEx_Data[$iIndex][2]

	; Check if checkbox array
	If $iCheck Then
		If $aGLVEx_Data[$iIndex][6] Then
			Local $aCheck_Array[UBound($aRetArray)]
			For $i = 1 To UBound($aRetArray) - 1
				$aCheck_Array[$i] = _GUICtrlListView_GetItemChecked($aGLVEx_Data[$iIndex][0], $i - 1)
			Next
			; Remove count element if required
			If $aGLVEx_Data[$iIndex][3] = 0 Then
				; Check at least one entry in 1D/2D array
				Switch UBound($aRetArray, 0)
					Case 1
						If $aRetArray[0] = 0 Then Return SetError(2, 0, "")
					Case 2
						If $aRetArray[0][0] = 0 Then Return SetError(2, 0, "")
				EndSwitch
				; Delete count element
				_GUIListViewEx_Array_Delete($aCheck_Array, 0)
			EndIf
			Return $aCheck_Array
		Else
			Return SetError(3, 0, "")
		EndIf
	EndIf

	; Remove count element of array if required
	If $aGLVEx_Data[$iIndex][3] = 0 Then
		; Check at least one entry in 1D/2D array
		Switch UBound($aRetArray, 0)
			Case 1
				If $aRetArray[0] = 0 Then Return SetError(2, 0, "")
			Case 2
				If $aRetArray[0][0] = 0 Then Return SetError(2, 0, "")
		EndSwitch
		; Delete count element
		_GUIListViewEx_Array_Delete($aRetArray, 0)
	EndIf

	; Return array
	Return $aRetArray

EndFunc   ;==>_GUIListViewEx_ReturnArray

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_Insert
; Description ...: Inserts data just below selected item in active ListView - if no selection, data added at end
; Syntax.........: _GUIListViewEx_Insert($vData)
; Parameters ....: $vData - Data to insert, can be in array or delimited string format
; Requirement(s).: v3.3 +
; Return values .: Success: Array of current ListView with count in [0] element
;                  Failure: If no ListView active then returns "" and sets @error to 1
; Author ........: Melba23
; Modified ......:
; Remarks .......: - New data is inserted after the selected item.  If no item is selected then the data is added at
;                  the end of the ListView.  If multiple items are selected, the data is inserted after the first
;                  - $vData can be passed in string or array format - it is automatically transformed if required
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_Insert($vData)

	Local $vInsert

	; Set data for active ListView
	Local $iArray_Index = $aGLVEx_Data[0][1]
	; If no ListView active then return
	If $iArray_Index = 0 Then Return SetError(1, 0, "")

	; Load active ListView details
	$hGLVEx_Handle = $aGLVEx_Data[$iArray_Index][0]
	$hGLVEx_CID = $aGLVEx_Data[$iArray_Index][1]

	; Get selected item in ListView
	Local $iIndex = _GUICtrlListView_GetSelectedIndices($hGLVEx_Handle)
	Local $iInsert_Index = $iIndex
	; If no selection
	If $iIndex = "" Then $iInsert_Index = -1
	; Check for multiple selections
	If StringInStr($iIndex, "|") Then
		Local $aIndex = StringSplit($iIndex, "|")
		; Use first selection
		$iIndex = $aIndex[1]
		; Cancel all other selections
		For $i = 2 To $aIndex[0]
			_GUICtrlListView_SetItemSelected($hGLVEx_Handle, $aIndex[$i], False)
		Next
	EndIf

	; Copy array for manipulation
	$aGLVEx_Array = $aGLVEx_Data[$iArray_Index][2]

	; Create Local array for checkboxes if required
	If $aGLVEx_Data[$iArray_Index][6] Then
		Local $aCheck_Array[UBound($aGLVEx_Array)]
		For $i = 1 To UBound($aCheck_Array) - 1
			$aCheck_Array[$i] = _GUICtrlListView_GetItemChecked($hGLVEx_Handle, $i - 1)
		Next
	EndIf

	; Check if 1D/2D array
	Switch UBound($aGLVEx_Array, 0)
		Case 1
			; If empty array insert at 0
			If $aGLVEx_Array[0] = 0 Then $iInsert_Index = 0
			; Get data into string format for insert
			If IsArray($vData) Then
				$vInsert = ""
				For $i = 0 To UBound($vData) - 1
					$vInsert &= $vData[$i] & "|"
				Next
				$vInsert = StringTrimRight($vInsert, 1)
			Else
				$vInsert = $vData
			EndIf
			; Increase count
			$aGLVEx_Array[0] += 1
		Case 2
			; If empty array insert at 0
			If $aGLVEx_Array[0][0] = 0 Then $iInsert_Index = 0
			; Get data into array format for insert
			If IsArray($vData) Then
				$vInsert = $vData
			Else
				Local $aData = StringSplit($vData, "|")
				Switch $aData[0]
					Case 1
						$vInsert = $aData[1]
					Case Else
						Local $vInsert[$aData[0]]
						For $i = 0 To $aData[0] - 1
							$vInsert[$i] = $aData[$i + 1]
						Next
				EndSwitch
			EndIf
			; Increase count
			$aGLVEx_Array[0][0] += 1
	EndSwitch

	; Insert data into array
	If $iIndex = "" Then
		_GUIListViewEx_Array_Add($aGLVEx_Array, $vInsert)
	Else
		_GUIListViewEx_Array_Insert($aGLVEx_Array, $iInsert_Index + 2, $vInsert)
		If $aGLVEx_Data[$iArray_Index][6] Then
			_GUIListViewEx_Array_Insert($aCheck_Array, $iInsert_Index + 2, False)
			; Reset all checkboxes
			For $i = 1 To UBound($aCheck_Array) - 1
				_GUICtrlListView_SetItemChecked($hGLVEx_Handle, $i - 1, $aCheck_Array[$i])
			Next
		EndIf
	EndIf

	; Check if Native or UDF
	If $hGLVEx_CID Then
		; Add new item at ListView end
		If IsArray($vInsert) Then
			If IsArray($vData) Then
				$vInsert = ""
				For $i = 0 To UBound($vData) - 1
					$vInsert &= $vData[$i] & "|"
				Next
				$vInsert = StringTrimRight($vInsert, 1)
				GUICtrlCreateListViewItem($vInsert, $hGLVEx_CID)
			Else
				GUICtrlCreateListViewItem($vData, $hGLVEx_CID)
			EndIf
		Else
			GUICtrlCreateListViewItem($vInsert, $hGLVEx_CID)
		EndIf
	Else
		; Add new item at ListView end
		Local $iNewItem
		If IsArray($vInsert) Then
			$iNewItem = _GUICtrlListView_AddItem($hGLVEx_Handle, $vInsert[0])
			; Add new subitems
			For $i = 1 To UBound($vInsert) - 1
				_GUICtrlListView_AddSubItem($hGLVEx_Handle, $iNewItem, $vInsert[$i], $i)
			Next
		Else
			$iNewItem = _GUICtrlListView_AddItem($hGLVEx_Handle, $vInsert)
		EndIf
	EndIf
	; Check where item was to be inserted
	If $iIndex = "" Then
		_GUIListViewEx_DataChange($iInsert_Index, $iInsert_Index)
		; No moves required so set highlight
		_GUIListViewEx_Highlight(_GUICtrlListView_GetItemCount($hGLVEx_Handle) - 1)
	Else
		; Reset item contents below insert position
		_GUIListViewEx_DataChange($iInsert_Index, _GUICtrlListView_GetItemCount($hGLVEx_Handle) - 1)
		; Set highlight
		_GUIListViewEx_Highlight($iInsert_Index + 1, $iInsert_Index)
	EndIf

	; Store amended array
	$aGLVEx_Data[$iArray_Index][2] = $aGLVEx_Array
	; Delete copied array
	$aGLVEx_Array = 0
	; Return amended array
	Return _GUIListViewEx_ReturnArray($iArray_Index)

EndFunc   ;==>_GUIListViewEx_Insert

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_Delete
; Description ...: Deletes selected item(s) in active ListView
; Syntax.........: _GUIListViewEx_Delete()
; Parameters ....: None
; Requirement(s).: v3.3 +
; Return values .: Success: Array of active ListView with count in [0] element
;                  Failure: Returns "" and sets @error as follows:
;                      1 = No ListView active
;                      2 = No item selected
;                      3 = No items to delete
; Author ........: Melba23
; Modified ......:
; Remarks .......: If multiple items are selected, all are deleted
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_Delete()

	; Set data for active ListView
	Local $iArray_Index = $aGLVEx_Data[0][1]
	; If no ListView active then return
	If $iArray_Index = 0 Then Return SetError(1, 0, "")

	; Load active ListView details
	$hGLVEx_Handle = $aGLVEx_Data[$iArray_Index][0]
	$hGLVEx_CID = $aGLVEx_Data[$iArray_Index][1]

	; Check for selected items
	Local $iIndex = _GUICtrlListView_GetSelectedIndices($hGLVEx_Handle)
	If $iIndex = "" Then Return SetError(2, 0, "")

	; Copy array for manipulation
	$aGLVEx_Array = $aGLVEx_Data[$iArray_Index][2]

	; Determine final item
	Local $iLast = UBound($aGLVEx_Array) - 2

	; Check if item is part of a multiple selection
	If StringInStr($iIndex, "|") Then
		; Extract all selected items
		Local $aIndex = StringSplit($iIndex, "|")
		For $i = 1 To $aIndex[0]
			; Remove highlighting from items
			_GUICtrlListView_SetItemSelected($hGLVEx_Handle, $i, False)
		Next

		; Check if 1D/2D array
		Switch UBound($aGLVEx_Array, 0)
			Case 1
				; Decrease count
				$aGLVEx_Array[0] -= $aIndex[0]
			Case 2
				; Decrease count
				$aGLVEx_Array[0][0] -= $aIndex[0]
		EndSwitch

		; Delete elements from array - start from bottom
		For $i = $aIndex[0] To 1 Step -1
			_GUIListViewEx_Array_Delete($aGLVEx_Array, $aIndex[$i] + 1)
		Next

		; Delete items from ListView - again start from bottom
		For $i = $aIndex[0] To 1 Step -1
			_GUICtrlListView_DeleteItem($hGLVEx_Handle, $aIndex[$i])
		Next

	Else
		; Check if 1D/2D array
		Switch UBound($aGLVEx_Array, 0)
			Case 1
				; Decrease count
				$aGLVEx_Array[0] -= 1
			Case 2
				; Decrease count
				$aGLVEx_Array[0][0] -= 1
		EndSwitch
		; Delete element from array
		_GUIListViewEx_Array_Delete($aGLVEx_Array, $iIndex + 1)

		; Delete item from ListView
		_GUICtrlListView_DeleteItem($hGLVEx_Handle, $iIndex)
		; Set highlight - up one if bottom deleted
		If $iIndex = $iLast Then
			_GUIListViewEx_Highlight($iIndex - 1)
		Else
			_GUIListViewEx_Highlight($iIndex)
		EndIf
	EndIf

	; Store amended array
	$aGLVEx_Data[$iArray_Index][2] = $aGLVEx_Array
	; Delete copied array
	$aGLVEx_Array = 0
	; Return amended array
	Return _GUIListViewEx_ReturnArray($iArray_Index)

EndFunc   ;==>_GUIListViewEx_Delete

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_Up
; Description ...: Moves selected item(s) in active ListView up 1 place
; Syntax.........: _GUIListViewEx_Up()
; Parameters ....: None
; Requirement(s).: v3.3 +
; Return values .: Success: Array of active ListView with count in [0] element
;                  Failure: Returns "" and sets @error as follows:
;                      1 = No ListView active
;                      2 = No item selected
;                      3 = Item already at top
; Author ........: Melba23
; Modified ......:
; Remarks .......: If multiple items are selected, only the top consecutive block is moved
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_Up()

	Local $iGLVExMove_Index, $iGLVEx_Moving = 0

	; Set data for active ListView
	Local $iArray_Index = $aGLVEx_Data[0][1]
	; If no ListView active then return
	If $iArray_Index = 0 Then Return SetError(1, 0, 0)

	; Load active ListView details
	$hGLVEx_Handle = $aGLVEx_Data[$iArray_Index][0]
	$hGLVEx_CID = $aGLVEx_Data[$iArray_Index][1]

	; Check for selected items
	Local $iIndex = _GUICtrlListView_GetSelectedIndices($hGLVEx_Handle)
	Local $aIndex = StringSplit($iIndex, "|")
	$iGLVExMove_Index = $aIndex[1]
	; Check if item is part of a multiple selection
	If $aIndex[0] > 1 Then
		; Check for consecutive items
		For $i = 1 To $aIndex[0] - 1
			If $aIndex[$i + 1] = $aIndex[1] + $i Then
				$iGLVEx_Moving += 1
			Else
				ExitLoop
			EndIf
		Next
	Else
		$iGLVExMove_Index = $aIndex[1]
	EndIf

	; Remove all highlighting
	_GUICtrlListView_SetItemSelected($hGLVEx_Handle, -1, False)

	; Check not top item
	If $iGLVExMove_Index = "0" Then Return SetError(3, 0, "")

	; Copy array for manipulation
	$aGLVEx_Array = $aGLVEx_Data[$iArray_Index][2]

	; Move consecutive items
	For $iIndex = $iGLVExMove_Index To $iGLVExMove_Index + $iGLVEx_Moving

		; Swap array elements
		_GUIListViewEx_Array_Swap($aGLVEx_Array, $iIndex, $iIndex + 1)

		; Swap checkboxes if required
		If $aGLVEx_Data[$iArray_Index][6] Then
			Local $fTemp = _GUICtrlListView_GetItemChecked($hGLVEx_Handle, $iIndex)
			_GUICtrlListView_SetItemChecked($hGLVEx_Handle, $iIndex, _GUICtrlListView_GetItemChecked($hGLVEx_Handle, $iIndex - 1))
			_GUICtrlListView_SetItemChecked($hGLVEx_Handle, $iIndex - 1, $fTemp)
		EndIf

		; Change data in affected items
		_GUIListViewEx_DataChange($iIndex - 1, $iIndex);, $aGLVEx_Array)
		; Set highlight and cancel existing one (needed for multiple selection ListViews)
		_GUIListViewEx_Highlight($iIndex - 1, $iIndex)
	Next

	; Store amended array
	$aGLVEx_Data[$iArray_Index][2] = $aGLVEx_Array
	; Delete copied array
	$aGLVEx_Array = 0
	; Return amended array
	Return _GUIListViewEx_ReturnArray($iArray_Index)

EndFunc   ;==>_GUIListViewEx_Up

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_Down
; Description ...: Moves selected item(s) in active ListView down 1 place
; Syntax.........: _GUIListViewEx_Down()
; Parameters ....: None
; Requirement(s).: v3.3 +
; Return values .: Success: Array of active ListView with count in [0] element
;                  Failure: Returns "" and sets @error as follows:
;                      1 = No ListView active
;                      2 = No item selected
;                      3 = Item already at bottom
; Author ........: Melba23
; Modified ......:
; Remarks .......: If multiple items are selected, only the bottom consecutive block is moved
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_Down()

	Local $iGLVExMove_Index, $iGLVEx_Moving = 0

	; Set data for active ListView
	Local $iArray_Index = $aGLVEx_Data[0][1]
	; If no ListView active then return
	If $iArray_Index = 0 Then Return SetError(1, 0, 0)

	; Load active ListView details
	$hGLVEx_Handle = $aGLVEx_Data[$iArray_Index][0]
	$hGLVEx_CID = $aGLVEx_Data[$iArray_Index][1]

	; Check for selected items
	Local $iIndex = _GUICtrlListView_GetSelectedIndices($hGLVEx_Handle)
	Local $aIndex = StringSplit($iIndex, "|")
	; Check if item is part of a multiple selection
	If $aIndex[0] > 1 Then
		$iGLVExMove_Index = $aIndex[$aIndex[0]]
		; Check for consecutive items
		For $i = 1 To $aIndex[0] - 1
			If $aIndex[$aIndex[0] - $i] = $aIndex[$aIndex[0]] - $i Then
				$iGLVEx_Moving += 1
			Else
				ExitLoop
			EndIf
		Next
	Else
		$iGLVExMove_Index = $aIndex[1]
	EndIf

	; Remove all highlighting
	_GUICtrlListView_SetItemSelected($hGLVEx_Handle, -1, False)

	; Check not last item
	If $iGLVExMove_Index = _GUICtrlListView_GetItemCount($hGLVEx_Handle) - 1 Then
		_GUIListViewEx_Highlight($iIndex)
		Return
	EndIf

	; Copy array for manipulation
	$aGLVEx_Array = $aGLVEx_Data[$iArray_Index][2]

	; Move consecutive items
	For $iIndex = $iGLVExMove_Index To $iGLVExMove_Index - $iGLVEx_Moving Step -1

		; Swap array elements
		_GUIListViewEx_Array_Swap($aGLVEx_Array, $iIndex + 1, $iIndex + 2)

		; Swap checkboxes if required
		If $aGLVEx_Data[$iArray_Index][6] Then
			Local $fTemp = _GUICtrlListView_GetItemChecked($hGLVEx_Handle, $iIndex)
			_GUICtrlListView_SetItemChecked($hGLVEx_Handle, $iIndex, _GUICtrlListView_GetItemChecked($hGLVEx_Handle, $iIndex + 1))
			_GUICtrlListView_SetItemChecked($hGLVEx_Handle, $iIndex + 1, $fTemp)
		EndIf

		; Change data in affected items
		_GUIListViewEx_DataChange($iIndex, $iIndex + 1)
		; Set highlight and cancel existing one (needed for multiple selection ListViews)
		_GUIListViewEx_Highlight($iIndex + 1, $iIndex)

	Next

	; Store amended array
	$aGLVEx_Data[$iArray_Index][2] = $aGLVEx_Array
	; Delete copied array
	$aGLVEx_Array = 0
	; Return amended array
	Return _GUIListViewEx_ReturnArray($iArray_Index)

EndFunc   ;==>_GUIListViewEx_Down

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_EditOnClick
; Description ...: Edit ListView items in user-defined columns when doubleclicked
; Syntax.........: _GUIListViewEx_Edit([$iEditMode = 0[, $iDelta_X = 0[, $iDelta_Y = 0]]])
; Parameters ....: $iEditMode - Return after single edit - 0 (default)
;                              	{TAB} and arrow keys move to next item - 2-digit code (row mode/column mode)
;                                   1 = Reaching edge terminates edit process
;                                   2 = Reaching edge remains in place
;                                   3 = Reaching edge loops to opposite edge
;                               	Positive value = ESC abandons current edit only, previous edits remain
;                                   Negative value = ESC resets all edits in current session
;                  $iDelta_X  - Permits fine adjustment of edit control in X axis if needed
;                  $iDelta_Y  - Permits fine adjustment of edit control in Y axis if needed
; Requirement(s).: v3.3 +
; Return values .: Success: 2D array of zero-based [row][column] items edited - total number of edits in [0][0] element
;                  Failure: Sets @error as follows:
;                           1 - ListView not editable
;                           2 - Empty ListView
;                           3 - Column not editable
; Author ........: Melba23
; Modified ......:
; Remarks .......: This function must be placed within the script idle loop. Once edit started, all other script
;                  activity is suspended until following occurs:
;                      {ENTER}  = Current edit confirmed and editing ended
;                      {ESCAPE} or click on other control = Current edit cancelled and editing ended
;                      If $iEditMode non-zero then {TAB} and arrow keys = Current edit confirmed continue editing
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_EditOnClick($iEditMode = 0, $iDelta_X = 0, $iDelta_Y = 0)

	; If an item was double clicked
	If $fGLVEx_EditClickFlag Then

		; Clear flag
		$fGLVEx_EditClickFlag = False

		; Declare array to hold edited item data - note the arry has second dimension of 3 but only 2 of these are returned
		Local $aEdited[1][3] = [[0]] ; [Number of edited items][blank][blank]

		; Check Type parameter
		Switch Abs($iEditMode)
			Case 0, 11, 12, 13, 21, 22, 23, 31, 32, 33 ; Single edit or both axes set to valid parameter
				; Allow
			Case Else
				Return SetError(1, 0, $aEdited)
		EndSwitch

		; Set data for active ListView
		Local $iLV_Index = $aGLVEx_Data[0][1]
		; If no ListView active then return
		If $iLV_Index = 0 Then
			Return SetError(2, 0, $aEdited)
		EndIf
		; Get clicked item info
		Local $aLocation = _GUICtrlListView_SubItemHitTest($hGLVEx_Handle)
		; Check valid row
		If $aLocation[0] = -1 Then
			Return SetError(3, 0, $aEdited)
		EndIf
		; Get valid column string
		Local $sCols = $aGLVEx_Data[$iLV_Index][7]
		; And validate selected column
		If Not StringInStr($sCols, "*") Then
			If Not StringInStr(";" & $sCols, ";" & $aLocation[1]) Then
				Return SetError(1, 0, $aEdited)
			EndIf
		EndIf
		; Start edit
		_GUIListViewEx_EditProcess($aEdited, $iLV_Index, $aLocation, $sCols, $iDelta_X, $iDelta_Y, $iEditMode)
		; Return result array
		Return $aEdited

	EndIf

EndFunc   ;==>_GUIListViewEx_EditOnClick

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_EditItem
; Description ...: Edit ListView items programatically
; Syntax.........: _GUIListViewEx_EditItem($iLV_Index, $iRow, $iCol[, $iEditMode = 0[, $iDelta_X = 0[, $iDelta_Y = 0]]])
; Parameters ....: $iLV_Index - Index number of ListView as returned by _GUIListViewEx_Init
;                  $iRow      - Zero-based row of item to edit
;                  $iCol      - Zero-based column of item to edit
; Parameters ....: $iEditMode - Return after single edit - 0 (default)
;                              	{TAB} and arrow keys move to next item - 2-digit code (row mode/column mode)
;                                   1 = Reaching edge terminates edit process
;                                   2 = Reaching edge remains in place
;                                   3 = Reaching edge loops to opposite edge
;                               	Positive value = ESC abandons current edit only, previous edits remain
;                                   Negative value = ESC resets all edits in current session
;                  $iDelta_X  - Permits fine adjustment of edit control in X axis if needed
;                  $iDelta_Y  - Permits fine adjustment of edit control in Y axis if needed
; Requirement(s).: v3.3 +
; Return values .: Success: 2D array of zero-based [row][column] items edited - total number of edits in [0][0] element
;                  Failure: Sets @error as follows:
;                           1 - Invalid ListView Index
;                           2 - ListView not editable
;                           3 - Invalid row
;                           4 - Invalid column
;                           5 - Invalid edit mode
; Author ........: Melba23
; Modified ......:
; Remarks .......: Once edit started, all other script activity is suspended until following occurs:
;                      {ENTER}  = Current edit confirmed and editing ended
;                      {ESCAPE} or click on other control = Current edit cancelled and editing ended
;                      If $iEditMode non-zero then {TAB} and arrow keys = Current edit confirmed continue editing
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_EditItem($iLV_Index, $iRow, $iCol, $iEditMode = 0, $iDelta_X = 0, $iDelta_Y = 0)

	; Declare array to hold edited item data - note the arry has second dimension of 3 but only 2 of these are returned
	Local $aEdited[1][3] = [[0]] ; [Number of edited items][blank][blank]

	; Activate the ListView
	_GUIListViewEx_SetActive($iLV_Index)
	If @error Then
		Return SetError(1, 0, $aEdited)
	EndIf
	; Check ListView is editable
	If $aGLVEx_Data[$iLV_Index][7] = "" Then
		Return SetError(2, 0, $aEdited)
	EndIf
	; Check row and col values
	Local $iMax = _GUICtrlListView_GetItemCount($hGLVEx_Handle)
	If $iRow < 0 Or $iRow > $iMax - 1 Then
		Return SetError(3, 0, $aEdited)
	EndIf
	$iMax = _GUICtrlListView_GetColumnCount($hGLVEx_Handle)
	If $iCol < 0 Or $iCol > $iMax - 1 Then
		Return SetError(4, 0, $aEdited)
	EndIf
	; Check edit mode parameter
	Switch Abs($iEditMode)
		Case 0, 11, 12, 13, 21, 22, 23, 31, 32, 33 ; Single edit or both axes set to valid parameter
			; Allow
		Case Else
			Return SetError(5, 0, $aEdited)
	EndSwitch

	; Declare location array
	Local $aLocation[2] = [$iRow, $iCol]
	; Load valid column string
	Local $sValidCols = $aGLVEx_Data[$iLV_Index][7]
	; Start edit
	_GUIListViewEx_EditProcess($aEdited, $iLV_Index, $aLocation, $sValidCols, $iDelta_X, $iDelta_Y, $iEditMode)
	; Return result array
	Return $aEdited

EndFunc   ;==>_GUIListViewEx_EditItem

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_MsgRegister
; Description ...: Registers Windows messages needed for the UDF
; Syntax.........: _GUIListViewEx_MsgRegister([$fNOTIFY = True, [$fMOUSEMOVE = True, [$fLBUTTONUP = True]]])
; Parameters ....: $fNOTIFY    - True = Register WM_NOTIFY message
;                  $fMOUSEMOVE - True = Register WM_MOUSEMOVE message
;                  $fLBUTTONUP - True = Register WM_LBUTTONUP message
; Requirement(s).: v3.3 +
; Return values .: None
; Author ........: Melba23
; Modified ......:
; Remarks .......: If other handlers already registered, then call the relevant handler function from within that handler
;                  If no dragging is required, only the WM_NOTIFY handler needs to be registered
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_MsgRegister($fNOTIFY = True, $fMOUSEMOVE = True, $fLBUTTONUP = True)

	; Register required messages
	If $fNOTIFY Then GUIRegisterMsg(0x004E, "_GUIListViewEx_WM_NOTIFY_Handler") ; $WM_NOTIFY
	If $fMOUSEMOVE Then GUIRegisterMsg(0x0200, "_GUIListViewEx_WM_MOUSEMOVE_Handler") ; $WM_MOUSEMOVE
	If $fLBUTTONUP Then GUIRegisterMsg(0x0202, "_GUIListViewEx_WM_LBUTTONUP_Handler") ; $WM_LBUTTONUP

EndFunc   ;==>_GUIListViewEx_MsgRegister

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_WM_NOTIFY_Handler
; Description ...: Windows message handler for WM_NOTIFY
; Syntax.........: _GUIListViewEx_WM_NOTIFY_Handler()
; Requirement(s).: v3.3 +
; Return values .: None
; Author ........: Melba23
; Modified ......:
; Remarks .......: If a WM_NOTIFY handler already registered, then call this function from within that handler
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_WM_NOTIFY_Handler($hWnd, $iMsg, $wParam, $lParam)

	#forceref $hWnd, $iMsg, $wParam

	; Struct = $tagNMHDR and "int Item;int SubItem" from $tagNMLISTVIEW
	Local $tStruct = DllStructCreate("hwnd;uint_ptr;int_ptr;int;int", $lParam)
	If @error Then Return

	; Check if enabled ListView
	For $iLVIndex = 1 To $aGLVEx_Data[0][0]
		If DllStructGetData($tStruct, 1) = $aGLVEx_Data[$iLVIndex][0] Then
			ExitLoop
		EndIf
	Next
	If $iLVIndex > $aGLVEx_Data[0][0] Then Return ; Not enabled

	Local $iCode = BitAND(DllStructGetData($tStruct, 3), 0xFFFFFFFF)
	Switch $iCode
		Case $LVN_COLUMNCLICK, -2 ; $NM_CLICK

			; Set values for active ListView
			$aGLVEx_Data[0][1] = $iLVIndex
			$hGLVEx_Handle = $aGLVEx_Data[$iLVIndex][0]
			$hGLVEx_CID = $aGLVEx_Data[$iLVIndex][1]
			; Copy array for manipulation
			$aGLVEx_Array = $aGLVEx_Data[$iLVIndex][2]

			; Sort if a column header was clicked and ListView is sortable
			If $iCode = $LVN_COLUMNCLICK And IsArray($aGLVEx_Data[$iLVIndex][4]) Then
				; Load current ListView sort state array
				Local $aLVSortState = $aGLVEx_Data[$aGLVEx_Data[0][0]][4]
				; Sort column - get column from from struct
				_GUICtrlListView_SimpleSort($hGLVEx_Handle, $aLVSortState, DllStructGetData($tStruct, 5))
				; Store new ListView sort state array
				$aGLVEx_Data[$aGLVEx_Data[0][0]][4] = $aLVSortState
				; Reread listview items into array
				Switch UBound($aGLVEx_Array, 0) ; Check array format
					Case 1
						For $j = 1 To $aGLVEx_Array[0]
							$aGLVEx_Array[$j] = _GUICtrlListView_GetItemTextString($hGLVEx_Handle, $j - 1)
						Next
					Case 2
						Local $iDim2 = UBound($aGLVEx_Array, 2) - 1
						For $j = 1 To $aGLVEx_Array[0][0]
							For $k = 0 To $iDim2
								$aGLVEx_Array[$j][$k] = _GUICtrlListView_GetItemText($hGLVEx_Handle, $j - 1, $k)
							Next
						Next
				EndSwitch
				; Store amended array
				$aGLVEx_Data[$iLVIndex][2] = $aGLVEx_Array
			EndIf

		Case $LVN_BEGINDRAG
			; Set values for this ListView
			$aGLVEx_Data[0][1] = $iLVIndex
			$hGLVEx_Handle = $aGLVEx_Data[$iLVIndex][0]
			$hGLVEx_CID = $aGLVEx_Data[$iLVIndex][1]
			Local $fImage = $aGLVEx_Data[$iLVIndex][5]
			Local $fCheck = $aGLVEx_Data[$iLVIndex][6]
			; Copy array for manipulation
			$aGLVEx_Array = $aGLVEx_Data[$iLVIndex][2]

			; Check if Native or UDF and set focus
			If $hGLVEx_CID Then
				GUICtrlSetState($hGLVEx_CID, 256) ; $GUI_FOCUS
			Else
				_WinAPI_SetFocus($hGLVEx_Handle)
			EndIf

			; Get dragged item index
			$iGLVEx_DraggedIndex = DllStructGetData($tStruct, 4) ; Item
			; Set dragged item count
			$iGLVEx_Dragging = 1

			; Check for selected items
			Local $iIndex = _GUICtrlListView_GetSelectedIndices($hGLVEx_Handle)
			; Check if item is part of a multiple selection
			If StringInStr($iIndex, $iGLVEx_DraggedIndex) And StringInStr($iIndex, "|") Then
				; Extract all selected items
				Local $aIndex = StringSplit($iIndex, "|")
				For $i = 1 To $aIndex[0]
					If $aIndex[$i] = $iGLVEx_DraggedIndex Then ExitLoop
				Next
				; Now check for consecutive items
				If $i <> 1 Then ; Up
					For $j = $i - 1 To 1 Step -1
						; Consecutive?
						If $aIndex[$j] <> $aIndex[$j + 1] - 1 Then ExitLoop
						; Adjust dragged index to this item
						$iGLVEx_DraggedIndex -= 1
						; Increase number to drag
						$iGLVEx_Dragging += 1
					Next
				EndIf
				If $i <> $aIndex[0] Then ; Down
					For $j = $i + 1 To $aIndex[0]
						; Consecutive
						If $aIndex[$j] <> $aIndex[$j - 1] + 1 Then ExitLoop
						; Increase number to drag
						$iGLVEx_Dragging += 1
					Next
				EndIf
			Else ; Either no selection or only a single
				; Set flag
				$iGLVEx_Dragging = 1
			EndIf

			; Remove all highlighting
			_GUICtrlListView_SetItemSelected($hGLVEx_Handle, -1, False)

			; Create drag image
			If $fImage Then
				Local $aImageData = _GUICtrlListView_CreateDragImage($hGLVEx_Handle, $iGLVEx_DraggedIndex)
				$hGLVEx_DraggedImage = $aImageData[0]
				_GUIImageList_BeginDrag($hGLVEx_DraggedImage, 0, 0, 0)
			EndIf

			; Create Global array for checkboxes if required
			If $fCheck Then
				Global $aGLVEx_DragCheckArray[UBound($aGLVEx_Array)]
				For $i = 1 To UBound($aGLVEx_DragCheckArray) - 1
					$aGLVEx_DragCheckArray[$i] = _GUICtrlListView_GetItemChecked($hGLVEx_Handle, $i - 1)
				Next
			EndIf

		Case -3 ; $NM_DBLCLK
			; Only if editable
			If $aGLVEx_Data[$iLVIndex][7] <> "" Then
				; Set values for active ListView
				$aGLVEx_Data[0][1] = $iLVIndex;
				$hGLVEx_Handle = $aGLVEx_Data[$iLVIndex][0]
				; Copy array for manipulation
				$aGLVEx_Array = $aGLVEx_Data[$iLVIndex][2]
				; Set editing flag
				$fGLVEx_EditClickFlag = True
			EndIf

		Case -180 ; $LVN_BEGINSCROLL
			If $cGLVEx_EditID <> 9999 Then
				; Delete temp edit control and set placeholder
				GUICtrlDelete($cGLVEx_EditID)
				$cGLVEx_EditID = 9999
				; Reactivate ListView
				WinSetState($hGLVEx_Editing, "", @SW_ENABLE)
			EndIf

	EndSwitch

EndFunc   ;==>_GUIListViewEx_WM_NOTIFY_Handler

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_WM_MOUSEMOVE_Handler
; Description ...: Windows message handler for WM_NOTIFY
; Syntax.........: _GUIListViewEx_WM_MOUSEMOVE_Handler()
; Requirement(s).: v3.3 +
; Return values .: None
; Author ........: Melba23
; Modified ......:
; Remarks .......: If a WM_MOUSEMOVE handler already registered, then call this function from within that handler
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_WM_MOUSEMOVE_Handler($hWnd, $iMsg, $wParam, $lParam)

	#forceref $iMsg, $wParam

	If Not $iGLVEx_Dragging Then Return "GUI_RUNDEFMSG"

	Local $aLV_Pos, $tLVHITTESTINFO, $iCurr_Index

	; Get current mouse Y coord
	Local $iCurr_Y = BitShift($lParam, 16)

	; Set insert mark to correct side of items depending on sense of movement when cursor within range
	If $iGLVEx_InsertIndex <> -1 Then
		If $iGLVEx_LastY = $iCurr_Y Then
			Return "GUI_RUNDEFMSG"
		ElseIf $iGLVEx_LastY > $iCurr_Y Then
			$fGLVEx_BarUnder = False
			_GUICtrlListView_SetInsertMark($hGLVEx_Handle, $iGLVEx_InsertIndex, False)
		Else
			$fGLVEx_BarUnder = True
			_GUICtrlListView_SetInsertMark($hGLVEx_Handle, $iGLVEx_InsertIndex, True)
		EndIf
	EndIf
	; Store current Y coord
	$iGLVEx_LastY = $iCurr_Y

	; Get ListView item under mouse - depends on ListView type
	If $hGLVEx_CID Then
		$aLV_Pos = ControlGetPos($hWnd, "", $hGLVEx_CID)
		$tLVHITTESTINFO = DllStructCreate("int;int;uint;int;int;int")
		; Force response even if off side of GUI - normal X coord = BitAND($lParam, 0xFFFF) - $aLV_Pos[0]
		DllStructSetData($tLVHITTESTINFO, 1, 1)
		DllStructSetData($tLVHITTESTINFO, 2, $iCurr_Y - $aLV_Pos[1])
		; Get item under mouse
		$iCurr_Index = GUICtrlSendMsg($hGLVEx_CID, $LVM_HITTEST, 0, DllStructGetPtr($tLVHITTESTINFO))
	Else
		; Get coords of client area
		Local $tPoint = DllStructCreate("int X;int Y")
		DllStructSetData($tPoint, "X", 0)
		DllStructSetData($tPoint, "Y", 0)
		Local $pPoint = DllStructGetPtr($tPoint)
		DllCall("user32.dll", "bool", "ClientToScreen", "hwnd", $hWnd, "ptr", $pPoint)
		; Get coords of ListView
		$aLV_Pos = WinGetPos($hGLVEx_Handle)
		Local $iY = $iCurr_Y - $aLV_Pos[1] + DllStructGetData($tPoint, "Y")
		$tLVHITTESTINFO = DllStructCreate("int;int;uint;int;int;int")
		; Force response even if off side of GUI - normal X coord = BitAND($lParam, 0xFFFF) - $aLV_Pos[0] + DllStructGetData($tPoint, "X")
		DllStructSetData($tLVHITTESTINFO, 1, 1)
		DllStructSetData($tLVHITTESTINFO, 2, $iY)
		Local $pLVHITTESTINFO = DllStructGetPtr($tLVHITTESTINFO)
		; Get item under mouse
		Local $aRet = DllCall("user32.dll", "lresult", "SendMessageW", "hwnd", $hGLVEx_Handle, "uint", $LVM_HITTEST, "wparam", 0, "lparam", $pLVHITTESTINFO)
		$iCurr_Index = $aRet[0]
	EndIf

	; If mouse is above or below ListView then scroll ListView
	If $iCurr_Index = -1 Then
		If $fGLVEx_BarUnder Then
			_GUICtrlListView_Scroll($hGLVEx_Handle, 0, 10)
		Else
			_GUICtrlListView_Scroll($hGLVEx_Handle, 0, -10)
		EndIf
		Sleep(100)
	EndIf

	; Check if over same item
	If $iGLVEx_InsertIndex = $iCurr_Index Then Return "GUI_RUNDEFMSG"

	; Show insert mark on current item
	_GUICtrlListView_SetInsertMark($hGLVEx_Handle, $iCurr_Index, $fGLVEx_BarUnder)
	; Store current item
	$iGLVEx_InsertIndex = $iCurr_Index

EndFunc   ;==>_GUIListViewEx_WM_MOUSEMOVE_Handler

; #FUNCTION# =========================================================================================================
; Name...........: _GUIListViewEx_WM_LBUTTONUP_Handler
; Description ...: Windows message handler for WM_NOTIFY
; Syntax.........: _GUIListViewEx_WM_LBUTTONUP_Handler()
; Requirement(s).: v3.3 +
; Return values .: None
; Author ........: Melba23
; Modified ......:
; Remarks .......: If a WM_LBUTTONUP handler already registered, then call this function from within that handler
; Example........: Yes
;=====================================================================================================================
Func _GUIListViewEx_WM_LBUTTONUP_Handler($hWnd, $iMsg, $wParam, $lParam)

	#forceref $hWnd, $iMsg, $wParam, $lParam

	If Not $iGLVEx_Dragging Then Return "GUI_RUNDEFMSG"

	; Get item count
	Local $iMultipleItems = $iGLVEx_Dragging - 1

	; Reset flag
	$iGLVEx_Dragging = 0

	; Check mouse within ListView
	If $iGLVEx_InsertIndex = -1 Then
		; Clear insert mark
		_GUICtrlListView_SetInsertMark($hGLVEx_Handle, -1, True)
		; Reset highlight to original items
		For $i = 0 To $iMultipleItems
			_GUIListViewEx_Highlight($iGLVEx_DraggedIndex + $i)
		Next
		Return
	EndIf

	; Determine position to insert
	If $fGLVEx_BarUnder Then
		If $iGLVEx_DraggedIndex > $iGLVEx_InsertIndex Then $iGLVEx_InsertIndex += 1
	Else
		If $iGLVEx_DraggedIndex < $iGLVEx_InsertIndex Then $iGLVEx_InsertIndex -= 1
	EndIf

	; Clear insert mark
	_GUICtrlListView_SetInsertMark($hGLVEx_Handle, -1, True)

	; Clear drag image
	If $hGLVEx_DraggedImage Then
		_GUIImageList_DragLeave($hGLVEx_Handle)
		_GUIImageList_EndDrag()
		_GUIImageList_Destroy($hGLVEx_DraggedImage)
		$hGLVEx_DraggedImage = 0
	EndIf

	; Check not dropping on dragged item(s)
	Switch $iGLVEx_InsertIndex
		Case $iGLVEx_DraggedIndex To $iGLVEx_DraggedIndex + $iMultipleItems
			; Reset highlight to original items
			For $i = 0 To $iMultipleItems
				_GUIListViewEx_Highlight($iGLVEx_DraggedIndex + $i)
			Next
			Return
	EndSwitch

	; Amend array
	; Get data from dragged element(s)
	If $iMultipleItems Then
		; Multiple dragged elements
		Switch UBound($aGLVEx_Array, 0) ; Check array format
			Case 1
				Local $aInsertData[$iMultipleItems + 1]
				For $i = 0 To $iMultipleItems
					$aInsertData[$i] = $aGLVEx_Array[$iGLVEx_DraggedIndex + 1 + $i]
				Next
			Case 2
				Local $aInsertData[$iMultipleItems + 1]
				For $i = 0 To $iMultipleItems
					Local $aItemData[UBound($aGLVEx_Array, 2)]
					For $j = 0 To UBound($aGLVEx_Array, 2) - 1
						$aItemData[$j] = $aGLVEx_Array[$iGLVEx_DraggedIndex + 1][$j]
					Next
					$aInsertData[$i] = $aItemData
				Next
		EndSwitch
	Else
		; Single dragged element
		Switch UBound($aGLVEx_Array, 0) ; Check array format
			Case 1
				Local $aInsertData[1]
				$aInsertData[0] = $aGLVEx_Array[$iGLVEx_DraggedIndex + 1]
			Case 2
				Local $aInsertData[1]
				Local $aItemData[UBound($aGLVEx_Array, 2)]
				For $i = 0 To UBound($aGLVEx_Array, 2) - 1
					$aItemData[$i] = $aGLVEx_Array[$iGLVEx_DraggedIndex + 1][$i]
				Next
				$aInsertData[0] = $aItemData
		EndSwitch
	EndIf

	; Copy checkbox data from dragged elements
	If IsArray($aGLVEx_DragCheckArray) Then
		If $iMultipleItems Then
			Local $aDragged_Data[$iMultipleItems + 1]
			For $i = 0 To $iMultipleItems
				$aDragged_Data[$i] = _GUICtrlListView_GetItemChecked($hGLVEx_Handle, $iGLVEx_DraggedIndex + $i)
			Next
		Else
			Local $aDragged_Data[1]
			$aDragged_Data[0] = _GUICtrlListView_GetItemChecked($hGLVEx_Handle, $iGLVEx_DraggedIndex)
		EndIf
	EndIf

	; Delete dragged element(s) from arrays
	For $i = 0 To $iMultipleItems
		_GUIListViewEx_Array_Delete($aGLVEx_Array, $iGLVEx_DraggedIndex + 1)
		If IsArray($aGLVEx_DragCheckArray) Then
			_GUIListViewEx_Array_Delete($aGLVEx_DragCheckArray, $iGLVEx_DraggedIndex + 1)
		EndIf
	Next

	; Amend insert positon for multiple items deleted above
	If $iGLVEx_DraggedIndex < $iGLVEx_InsertIndex Then
		$iGLVEx_InsertIndex -= $iMultipleItems
	EndIf
	; Re-insert dragged element(s) into array
	For $i = $iMultipleItems To 0 Step -1
		_GUIListViewEx_Array_Insert($aGLVEx_Array, $iGLVEx_InsertIndex + 1, $aInsertData[$i])
		If IsArray($aGLVEx_DragCheckArray) Then
			_GUIListViewEx_Array_Insert($aGLVEx_DragCheckArray, $iGLVEx_InsertIndex + 1, $aDragged_Data[$i])
		EndIf
	Next

	; Amend ListView to match array
	If $iGLVEx_DraggedIndex > $iGLVEx_InsertIndex Then
		_GUIListViewEx_DataChange($iGLVEx_InsertIndex, $iGLVEx_DraggedIndex + $iMultipleItems)
	Else
		_GUIListViewEx_DataChange($iGLVEx_DraggedIndex, $iGLVEx_InsertIndex + $iMultipleItems)
	EndIf

	; Reset checkbox data
	If IsArray($aGLVEx_DragCheckArray) Then
		For $i = 1 To UBound($aGLVEx_DragCheckArray) - 1
			_GUICtrlListView_SetItemChecked($hGLVEx_Handle, $i - 1, $aGLVEx_DragCheckArray[$i])
		Next
		; Clear array
		$aGLVEx_DragCheckArray = 0
	EndIf

	; Set highlight to inserted item(s)
	For $i = 0 To $iMultipleItems
		_GUIListViewEx_Highlight($iGLVEx_InsertIndex + $i)
	Next

	; Store amended array
	$aGLVEx_Data[$aGLVEx_Data[0][1]][2] = $aGLVEx_Array
	; Delete copied array
	$aGLVEx_Array = 0

EndFunc   ;==>_GUIListViewEx_WM_LBUTTONUP_Handler

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: _GUIListViewEx_ExpandCols
; Description ...: Expands column ranges to list each column separately
; Author ........: Melba23
; Modified ......:
; ===============================================================================================================================
Func _GUIListViewEx_ExpandCols($sCols)

	Local $iNumber

	; Strip any whitespace
	$sCols = StringStripWS($sCols, 8)
	; Check if "all cols"
	If $sCols <> "*" Then
		; Check if ranges to be expanded
		If StringInStr($sCols, "-") Then
			; Parse string
			Local $aSplit_1, $aSplit_2
			; Split on ";"
			$aSplit_1 = StringSplit($sCols, ";")
			$sCols = ""
			; Check each element
			For $i = 1 To $aSplit_1[0]
				; Try and split on "-"
				$aSplit_2 = StringSplit($aSplit_1[$i], "-")
				; Add first value in all cases
				$sCols &= $aSplit_2[1] & ";"
				; If a valid range and limit values are in ascending order
				If ($aSplit_2[0]) > 1 And (Number($aSplit_2[2]) > Number($aSplit_2[1])) Then
					; Add the full range
					$iNumber = $aSplit_2[1]
					Do
						$iNumber += 1
						$sCols &= $iNumber & ";"
					Until $iNumber = $aSplit_2[2]
				EndIf
			Next
		EndIf
	EndIf
	; Return expanded string
	Return $sCols

EndFunc   ;==>_GUIListViewEx_ExpandCols

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: _GUIListViewEx_HighLight($iIndexA, $iIndexB)
; Description ...: Highlights first item and ensures visible while removing hightlight from second in multiple selection ListViews
; Author ........: Melba23
; Remarks .......:
; ===============================================================================================================================
Func _GUIListViewEx_Highlight($iIndexA, $iIndexB = -1)

	; Check if Native or UDF and set focus
	If $hGLVEx_CID Then
		GUICtrlSetState($hGLVEx_CID, 256) ; $GUI_FOCUS
	Else
		_WinAPI_SetFocus($hGLVEx_Handle)
	EndIf
	; Cancel highlight on other item - needed for multisel listviews
	If $iIndexB <> -1 Then _GUICtrlListView_SetItemSelected($hGLVEx_Handle, $iIndexB, False)
	; Set highlight to inserted item and ensure in view
	_GUICtrlListView_SetItemState($hGLVEx_Handle, $iIndexA, $LVIS_SELECTED, $LVIS_SELECTED)
	_GUICtrlListView_EnsureVisible($hGLVEx_Handle, $iIndexA)

EndFunc   ;==>_GUIListViewEx_Highlight

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: _GUIListViewEx_DataChange($iStart, $iEnd)
; Description ...: Resets ListView items within a defined range to the current values in the stored array
; Author ........: Melba23
; Remarks .......:
; ===============================================================================================================================
Func _GUIListViewEx_DataChange($iStart, $iEnd)

	Local $sBlanker, $aInsert, $iDim2

	; Check if Native or UDF
	If $hGLVEx_CID Then
		; Native ListView
		For $i = $iStart To $iEnd
			; Get CID of the item
			Local $iCID = _GUICtrlListView_GetItemParam($hGLVEx_Handle, $i)
			; Check array type
			Switch UBound($aGLVEx_Array, 0)
				Case 1
					$aInsert = StringSplit($aGLVEx_Array[$i + 1], "|", 2)
				Case 2
					$iDim2 = UBound($aGLVEx_Array, 2)
					Local $aInsert[$iDim2]
					For $j = 0 To $iDim2 - 1
						$aInsert[$j] = $aGLVEx_Array[$i + 1][$j]
					Next
			EndSwitch
			; Insert new data into each column in turn
			$sBlanker = ""
			For $j = 0 To UBound($aInsert) - 1
				GUICtrlSetData($iCID, $sBlanker & $aInsert[$j])
				$sBlanker &= "|"
			Next
		Next
	Else
		; UDF ListView
		For $i = $iStart To $iEnd
			; Check if multicolumn
			$iDim2 = UBound($aGLVEx_Array, 2)
			If @error Then
				_GUICtrlListView_SetItemText($hGLVEx_Handle, $i, $aGLVEx_Array[$i + 1])
			Else
				; For each column - or just once if not multicolumn
				For $j = 0 To $iDim2 - 1
					; Set data
					_GUICtrlListView_SetItemText($hGLVEx_Handle, $i, $aGLVEx_Array[$i + 1][$j], $j)
				Next
			EndIf
		Next
	EndIf

EndFunc   ;==>_GUIListViewEx_DataChange

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: _GUIListViewEx_GetLVFont
; Description ...: Gets font details for ListView to be edited
; Author ........: Based on _GUICtrlGetFont by KaFu & Prog@ndy
; Modified ......: Melba23
; ===============================================================================================================================
Func _GUIListViewEx_GetLVFont($hWnd)

	Local $iError = 0, $aFontDetails[2] = [Default, Default]

	; Check handle
	If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
	If Not IsHWnd($hWnd) Then
		$iError = 1
	Else
		Local $hFONT = _SendMessage($hWnd, 0x0031) ; WM_GETFONT
		If Not $hFONT Then
			$iError = 2
		Else
			Local $hDC = _WinAPI_GetDC($hWnd)
			Local $hObjOrg = _WinAPI_SelectObject($hDC, $hFONT)
			Local $tFONT = DllStructCreate($tagLOGFONT)
			Local $aRet = DllCall('gdi32.dll', 'int', 'GetObjectW', 'ptr', $hFONT, 'int', DllStructGetSize($tFONT), 'ptr', DllStructGetPtr($tFONT))
			If @error Or $aRet[0] = 0 Then
				$iError = 3
			Else
				; Get font size
				$aFontDetails[0] = Round((-1 * DllStructGetData($tFONT, 'Height')) * 72 / _WinAPI_GetDeviceCaps($hDC, 90), 1) ; $LOGPIXELSY = 90 => DPI aware
				; Now look for font name
				$aRet = DllCall("gdi32.dll", "int", "GetTextFaceW", "handle", $hDC, "int", 0, "ptr", 0)
				Local $iCount = $aRet[0]
				Local $tBuffer = DllStructCreate("wchar[" & $iCount & "]")
				Local $pBuffer = DllStructGetPtr($tBuffer)
				$aRet = DllCall("Gdi32.dll", "int", "GetTextFaceW", "handle", $hDC, "int", $iCount, "ptr", $pBuffer)
				If @error Then
					$iError = 4
				Else
					$aFontDetails[1] = DllStructGetData($tBuffer, 1) ; FontFacename
				EndIf
			EndIf
			_WinAPI_SelectObject($hDC, $hObjOrg)
			_WinAPI_ReleaseDC($hWnd, $hDC)
		EndIf
	EndIf

	Return SetError($iError, 0, $aFontDetails)

EndFunc   ;==>_GUIListViewEx_GetLVFont

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: _GUIListViewEx_EditProcess
; Description ...: Runs ListView editing process
; Author ........: Melba23
; Modified ......:
; ===============================================================================================================================
Func _GUIListViewEx_EditProcess(ByRef $aEdited, $iLV_Index, $aLocation, $sCols, $iDelta_X, $iDelta_Y, $iEditMode)

	Local $iKey_Code, $aSplit, $sInsert, $fClick_Move = False

	; Store handle of ListView concerned
	$hGLVEx_Editing = $hGLVEx_Handle

	; Valid keys to action (TAB, ENTER, ESC, 4 arrows)
	Local $aKeys[7] = [0x09, 0x0D, 0x1B, 0x25, 0x26, 0x27, 0x28]

	; Set Reset-on-ESC mode
	Local $fReset_Edits = False
	If $iEditMode < 0 Then
		$fReset_Edits = True
		$iEditMode = Abs($iEditMode)
	EndIf

	; Set row/col edit mode - default single edit
	Local $iEditRow = 0, $iEditCol = 0
	If $iEditMode Then
		; Separate axis settings
		$aSplit = StringSplit($iEditMode, "")
		$iEditRow = $aSplit[1]
		$iEditCol = $aSplit[2]
	EndIf

	; Check if edit to move on click
	If StringInStr($aGLVEx_Data[$iLV_Index][7], ";#") Then
		$fClick_Move = True
	EndIf

	; Get handle of ListView parent
	Local $aRet = DllCall("user32.dll", "hwnd", "GetParent", "hwnd", $hGLVEx_Editing)
	Local $hWnd = $aRet[0]
	; Get position of ListView within GUI client area
	Local $aLVPos = WinGetPos($hGLVEx_Editing)
	Local $tPoint = DllStructCreate("int X;int Y")
	DllStructSetData($tPoint, "X", $aLVPos[0])
	DllStructSetData($tPoint, "Y", $aLVPos[1])
	_WinAPI_ScreenToClient($hWnd, $tPoint)
	; Get ListView client area to allow for scrollbars
	Local $aLVClient = WinGetClientSize($hGLVEx_Editing)
	; Get ListView font details
	Local $aLV_FontDetails = _GUIListViewEx_GetLVFont($hGLVEx_Editing)
	; Disable ListView
	WinSetState($hGLVEx_Editing, "", @SW_DISABLE)

	; Start the edit loop
	While 1
		; Read current text of clicked item
		Local $sItemOrgText = _GUICtrlListView_GetItemText($hGLVEx_Editing, $aLocation[0], $aLocation[1])
		; Ensure item is visible and get required edit coords
		Local $aEdit_Coords = _GUIListViewEx_EditCoords($aLocation, $tPoint, $aLVClient[0] - 5, $iDelta_X, $iDelta_Y)
		; Create temporary edit - get handle, set font size, give keyboard focus and select all text
		$cGLVEx_EditID = GUICtrlCreateEdit($sItemOrgText, $aEdit_Coords[0], $aEdit_Coords[1], $aEdit_Coords[2], $aEdit_Coords[3], 0)
		Local $hTemp_Edit = GUICtrlGetHandle($cGLVEx_EditID)
		GUICtrlSetFont($cGLVEx_EditID, $aLV_FontDetails[0], Default, Default, $aLV_FontDetails[1])
		GUICtrlSetState($cGLVEx_EditID, 256) ; $GUI_FOCUS
		GUICtrlSendMsg($cGLVEx_EditID, 0xB1, 0, -1) ; $EM_SETSEL
		; Copy array for manipulation
		$aGLVEx_Array = $aGLVEx_Data[$iLV_Index][2]
		; Clear key code flag
		$iKey_Code = 0
		; Wait for a key press
		While 1
			; Check for valid key or mouse button pressed
			For $i = 0 To 6
				If _WinAPI_GetAsyncKeyState($aKeys[$i]) Then
					; Set key pressed flag
					$iKey_Code = $aKeys[$i]
					ExitLoop 2
				EndIf
			Next
			; Temp input loses focus
			If _WinAPI_GetFocus() <> $hTemp_Edit Then
				ExitLoop
			EndIf
			; If edit moveable by click then check for mouse pressed outside edit
			If $fClick_Move And _WinAPI_GetAsyncKeyState(0x01) Then
				Local $aCInfo = GUIGetCursorInfo()
				If $aCInfo[4] <> $cGLVEx_EditID Then
					$iKey_Code = 0x01
					ExitLoop
				EndIf
			EndIf
			; Save CPU
			Sleep(10)
		WEnd
		; Check if edit to be confirmed
		Switch $iKey_Code
			Case 0x09, 0x0D, 0x25, 0x26, 0x27, 0x28 ; TAB, ENTER, arrow keys
				; Read edit content
				Local $sItemNewText = GUICtrlRead($cGLVEx_EditID)
				; Check replacement required
				If $sItemNewText <> $sItemOrgText Then
					; Amend item text
					_GUICtrlListView_SetItemText($hGLVEx_Editing, $aLocation[0], $sItemNewText, $aLocation[1])
					; Amend array element - check if 1D/2D array
					Switch UBound($aGLVEx_Array, 0)
						Case 1
							$aSplit = StringSplit($aGLVEx_Array[$aLocation[0] + 1], "|")
							$aSplit[$aLocation[1] + 1] = $sItemNewText
							$sInsert = ""
							For $i = 1 To $aSplit[0]
								$sInsert &= $aSplit[$i] & "|"
							Next
							$aGLVEx_Array[$aLocation[0] + 1] = StringTrimRight($sInsert, 1)
						Case 2
							$aGLVEx_Array[$aLocation[0] + 1][$aLocation[1]] = $sItemNewText
					EndSwitch
					; Store amended array
					$aGLVEx_Data[$iLV_Index][2] = $aGLVEx_Array
					; Add item data to return array
					$aEdited[0][0] += 1
					ReDim $aEdited[$aEdited[0][0] + 1][3]
					; Save location & original content
					$aEdited[$aEdited[0][0]][0] = $aLocation[0]
					$aEdited[$aEdited[0][0]][1] = $aLocation[1]
					$aEdited[$aEdited[0][0]][2] = $sItemOrgText
				EndIf
		EndSwitch
		; Delete temporary edit and set place holder
		GUICtrlDelete($cGLVEx_EditID)
		$cGLVEx_EditID = 9999
		; Check edit mode
		If $iEditMode = 0 Then ; Single edit
			; Exit edit process
			ExitLoop
		Else
			Switch $iKey_Code
				Case 0x00, 0x01, 0x0D ; Edit lost focus or ENTER pressed   ; , 0x01 , mouse button outside edit,
					; Wait until key/button no longer pressed
					While _WinAPI_GetAsyncKeyState($iKey_Code)
						Sleep(10)
					WEnd
					; Exit Edit process
					ExitLoop
				Case 0x1B ; ESC pressed
					; Check Reset-on-ESC mode
					If $fReset_Edits Then
						; Reset previous confirmed edits starting with most recent
						For $i = $aEdited[0][0] To 1 Step -1
							_GUICtrlListView_SetItemText($hGLVEx_Editing,  $aEdited[$i][0],  $aEdited[$i][2],  $aEdited[$i][1])
							Switch UBound($aGLVEx_Array, 0)
								Case 1
									$aSplit = StringSplit($aGLVEx_Array[$aEdited[$i][0] + 1], "|")
									$aSplit[$aEdited[$i][1] + 1] = $aEdited[$i][2]
									$sInsert = ""
									For $j = 1 To $aSplit[0]
										$sInsert &= $aSplit[$j] & "|"
									Next
									$aGLVEx_Array[$aEdited[$i][0] + 1] = StringTrimRight($sInsert, 1)
								Case 2
									$aGLVEx_Array[$aEdited[$i][0] + 1][$aEdited[$i][1]] = $aEdited[$i][2]
							EndSwitch
						Next
						; Store amended array
						$aGLVEx_Data[$iLV_Index][2] = $aGLVEx_Array
						; Empty return array as no edits made
						ReDim $aEdited[1][2]
						$aEdited[0][0] = 0
					EndIf
					; Wait until key no longer pressed
					While _WinAPI_GetAsyncKeyState(0x1B)
						Sleep(10)
					WEnd
					; Exit Edit process
					ExitLoop
				Case 0x09, 0x27 ; TAB or right arrow
					While 1
						; Set next column
						$aLocation[1] += 1
						; Check column exists
						If $aLocation[1] = _GUICtrlListView_GetColumnCount($hGLVEx_Editing) Then
							; Does not exist so check required action
							Switch $iEditCol
								Case 1
									; Exit edit process
									ExitLoop 2
								Case 2
									; Stay on same location
									$aLocation[1] -= 1
									ExitLoop
								Case 3
									; Loop
									$aLocation[1] = 0
							EndSwitch
						EndIf
						; Check this column is editable
						If Not StringInStr($sCols, "*") Then
							If StringInStr(";" & $sCols, ";" & $aLocation[1]) Then
								; Editable column
								ExitLoop
							EndIf
						Else
							; Editable column
							ExitLoop
						EndIf
					WEnd
				Case 0x25 ; Left arrow
					While 1
						$aLocation[1] -= 1
						If $aLocation[1] < 0 Then
							Switch $iEditCol
								Case 1
									ExitLoop 2
								Case 2
									$aLocation[1] += 1
									ExitLoop
								Case 3
									$aLocation[1] = _GUICtrlListView_GetColumnCount($hGLVEx_Editing) - 1
							EndSwitch
						EndIf
						If Not StringInStr($sCols, "*") Then
							If StringInStr(";" & $sCols, ";" & $aLocation[1]) Then
								ExitLoop
							EndIf
						Else
							ExitLoop
						EndIf
					WEnd
				Case 0x28 ; Down key
					While 1
						; Set next row
						$aLocation[0] += 1
						; Check column exists
						If $aLocation[0] = _GUICtrlListView_GetItemCount($hGLVEx_Editing) Then
							; Does not exist so check required action
							Switch $iEditRow
								Case 1
									; Exit edit process
									ExitLoop 2
								Case 2
									; Stay on same location
									$aLocation[0] -= 1
									ExitLoop
								Case 3
									; Loop
									$aLocation[0] = -1
							EndSwitch
						Else
							; All rows editable
							ExitLoop
						EndIf
					WEnd
				Case 0x26 ; Up key
					While 1
						$aLocation[0] -= 1
						If $aLocation[0] < 0 Then
							Switch $iEditRow
								Case 1
									ExitLoop 2
								Case 2
									$aLocation[0] += 1
									ExitLoop
								Case 3
									$aLocation[0] = _GUICtrlListView_GetItemCount($hGLVEx_Editing)
							EndSwitch
						Else
							ExitLoop
						EndIf
					WEnd
			EndSwitch
			; Wait until key no longer pressed
			While _WinAPI_GetAsyncKeyState($iKey_Code)
				Sleep(10)
			WEnd
			; Continue edit loop on next item
		EndIf
	WEnd
	; Delete copied array
	$aGLVEx_Array = 0
	; Remove original text column from return array
	ReDim $aEdited[$aEdited[0][0] + 1][2]
	; Reenable ListView
	WinSetState($hGLVEx_Editing, "", @SW_ENABLE)

EndFunc   ;==>_GUIListViewEx_EditProcess

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: _GUIListViewEx_EditCoords
; Description ...: Ensures item in view then locates and sizes edit control
; Author ........: Melba23
; Modified ......:
; ===============================================================================================================================
Func _GUIListViewEx_EditCoords($aLocation, $tPoint, $iLVWidth, $iDelta_X, $iDelta_Y)

	; Declare array to hold return data
	Local $aEdit_Data[4]
	; Ensure row visible
	_GUICtrlListView_EnsureVisible($hGLVEx_Handle, $aLocation[0])
	; Get size of item
	Local $aRect = _GUICtrlListView_GetSubItemRect($hGLVEx_Handle, $aLocation[0], $aLocation[1])
	; Set required edit height
	$aEdit_Data[3] = $aRect[3] - $aRect[1]
	; Set required edit width
	$aEdit_Data[2] = _GUICtrlListView_GetColumnWidth($hGLVEx_Handle, $aLocation[1])
	; Ensure column visible - scroll to left edge if all column not in view
	If $aRect[0] < 0 Or $aRect[2] > $iLVWidth Then
		_GUICtrlListView_Scroll($hGLVEx_Handle, $aRect[0], 0)
		; Redetermine item coords
		$aRect = _GUICtrlListView_GetSubItemRect($hGLVEx_Handle, $aLocation[0], $aLocation[1])
		; Check available column width and limit if required
		If $aRect[0] + $aEdit_Data[2] > $iLVWidth Then
			$aEdit_Data[2] = $iLVWidth - $aRect[0]
		EndIf
	EndIf
	; Determine screen coords for edit control
	$aEdit_Data[0] = DllStructGetData($tPoint, "X") + $aRect[0] + 5 + $iDelta_X
	$aEdit_Data[1] = DllStructGetData($tPoint, "Y") + $aRect[1] + 2 + $iDelta_Y
	; Return edit data
	Return $aEdit_Data

EndFunc   ;==>_GUIListViewEx_EditCoords

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: _GUIListViewEx_Array_Add
; Description ...: Adds a specified value at the end of an existing 1D or 2D array.
; Author ........: Melba23
; Remarks .......:
; ===============================================================================================================================
Func _GUIListViewEx_Array_Add(ByRef $avArray, $vAdd = "", $iStart = 0)

	; Get size of the Array to modify
	Local $iIndex_Max = UBound($avArray)

	; Get type of array
	Switch UBound($avArray, 0)
		Case 1

			ReDim $avArray[$iIndex_Max + 1]
			$avArray[$iIndex_Max] = $vAdd

		Case 2

			; Get size of second dimension
			Local $iDim2 = UBound($avArray, 2)

			; Redim the Array
			ReDim $avArray[$iIndex_Max + 1][$iDim2]

			; Add new elements
			If IsArray($vAdd) Then
				; Get size of Insert array
				Local $vAdd_Max = UBound($vAdd)
				For $j = 0 To $iDim2 - 1
					; If Insert array is too small to fill Array then continue with blanks
					If $j > $vAdd_Max - 1 - $iStart Then
						$avArray[$iIndex_Max][$j] = ""
					Else
						$avArray[$iIndex_Max][$j] = $vAdd[$j + $iStart]
					EndIf
				Next
			Else
				; Fill Array with variable
				For $j = 0 To $iDim2 - 1
					$avArray[$iIndex_Max][$j] = $vAdd
				Next
			EndIf

	EndSwitch

	Return $iIndex_Max

EndFunc   ;==>_GUIListViewEx_Array_Add

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: _GUIListViewEx_Array_Insert
; Description ...: Adds a value at the specified index of a 1D or 2D array.
; Author ........: Melba23
; Remarks .......:
; ===============================================================================================================================
Func _GUIListViewEx_Array_Insert(ByRef $avArray, $iIndex, $vInsert)

	; Get size of the Array to modify
	Local $iIndex_Max = UBound($avArray)

	; Get type of array
	Switch UBound($avArray, 0)
		Case 1

			; Resize array
			ReDim $avArray[$iIndex_Max + 1]

			; Move down all elements below the new index
			For $i = $iIndex_Max To $iIndex + 1 Step -1
				$avArray[$i] = $avArray[$i - 1]
			Next

			; Add the value in the specified element
			$avArray[$iIndex] = $vInsert
			Return $iIndex_Max

		Case 2

			; If at end of array
			If $iIndex > $iIndex_Max - 1 Then Return $iIndex_Max = _GUIListViewEx_Array_Add($avArray, $vInsert)

			; Get size of second dimension
			Local $iDim2 = UBound($avArray, 2)

			; Redim the Array
			ReDim $avArray[$iIndex_Max + 1][$iDim2]

			; Move down all elements below the new index
			For $i = $iIndex_Max To $iIndex + 1 Step -1
				For $j = 0 To $iDim2 - 1
					$avArray[$i][$j] = $avArray[$i - 1][$j]
				Next
			Next

			; Insert new elements
			If IsArray($vInsert) Then
				; Get size of Insert array
				Local $vInsert_Max = UBound($vInsert)
				For $j = 0 To $iDim2 - 1
					; If Insert array is too small to fill Array then continue with blanks
					If $j > $vInsert_Max - 1 Then
						$avArray[$iIndex][$j] = ""
					Else
						$avArray[$iIndex][$j] = $vInsert[$j]
					EndIf
				Next
			Else
				; Fill Array with variable
				For $j = 0 To $iDim2 - 1
					$avArray[$iIndex][$j] = $vInsert
				Next
			EndIf

	EndSwitch

	Return $iIndex_Max + 1

EndFunc   ;==>_GUIListViewEx_Array_Insert

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: _GUIListViewEx_Array_Delete
; Description ...: Deletes a specified index from an existing 1D or 2D array.
; Author ........: Melba23
; Remarks .......:
; ===============================================================================================================================
Func _GUIListViewEx_Array_Delete(ByRef $avArray, $iIndex)

	; Get size of the Array to modify
	Local $iIndex_Max = UBound($avArray)

	; Get type of array
	Switch UBound($avArray, 0)
		Case 1

			; Move up all elements below the new index
			For $i = $iIndex To $iIndex_Max - 2
				$avArray[$i] = $avArray[$i + 1]
			Next

			; Redim the Array
			ReDim $avArray[$iIndex_Max - 1]

		Case 2

			; Get size of second dimension
			Local $iDim2 = UBound($avArray, 2)

			; Move up all elements below the new index
			For $i = $iIndex To $iIndex_Max - 2
				For $j = 0 To $iDim2 - 1
					$avArray[$i][$j] = $avArray[$i + 1][$j]
				Next
			Next

			; Redim the Array
			ReDim $avArray[$iIndex_Max - 1][$iDim2]

	EndSwitch

	Return $iIndex_Max - 1

EndFunc   ;==>_GUIListViewEx_Array_Delete

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: _GUIListViewEx_Array_Swap
; Description ...: Swaps specified elements within a 1D or 2D array
; Author ........: Melba23
; Remarks .......:
; ===============================================================================================================================
Func _GUIListViewEx_Array_Swap(ByRef $avArray, $iIndex1, $iIndex2)

	Local $vTemp

	; Get type of array
	Switch UBound($avArray, 0)
		Case 1
			; Swap the elements via a temp variable
			$vTemp = $avArray[$iIndex1]
			$avArray[$iIndex1] = $avArray[$iIndex2]
			$avArray[$iIndex2] = $vTemp

		Case 2

			; Get size of second dimension
			Local $iDim2 = UBound($avArray, 2)
			; Swap the elements via a temp variable
			For $i = 0 To $iDim2 - 1
				$vTemp = $avArray[$iIndex1][$i]
				$avArray[$iIndex1][$i] = $avArray[$iIndex2][$i]
				$avArray[$iIndex2][$i] = $vTemp
			Next
	EndSwitch

	Return 0

EndFunc   ;==>_GUIListViewEx_Array_Swap

