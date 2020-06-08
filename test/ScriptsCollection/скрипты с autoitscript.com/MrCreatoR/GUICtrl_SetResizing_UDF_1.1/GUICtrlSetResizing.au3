#include-once

AdlibRegister("__GUICtrl_SetResizing_Handler", 50)

Global $iGCSOR_CurIsSet 			= False
Global $iGCSOR_CtrEdgeSize 			= 5
Global $iGCSOR_DefCtrlMinSize 		= 20

Global Const $iGCSOR_LEFT_EDGE		= 3
Global Const $iGCSOR_RIGHT_EDGE		= 6
Global Const $iGCSOR_TOP_EDGE		= 12
Global Const $iGCSOR_BOTTOM_EDGE	= 24

Global $aGCSOR_Array[1][1]

;Function to set resizing for specific control
Func _GUICtrl_SetOnResize($hWnd, $nCtrlID = -1, $iWait = 10, $iCtrlMinSize = $iGCSOR_DefCtrlMinSize, $iResizeEdgeFlags = -1)
	If $nCtrlID = -1 Then $nCtrlID = __GUIGetLastCtrlID()
	
	If Not IsHWnd($hWnd) Then
		Local $aTmpSetResArr[1][1]
		
		For $i = 1 To $aGCSOR_Array[0][0]
			If $nCtrlID <> $aGCSOR_Array[$i][1] Then
				$aTmpSetResArr[0][0] += 1
				ReDim $aTmpSetResArr[$aTmpSetResArr[0][0]+1][5]
				$aTmpSetResArr[$aTmpSetResArr[0][0]][0] = $aGCSOR_Array[$i][0]
				$aTmpSetResArr[$aTmpSetResArr[0][0]][1] = $aGCSOR_Array[$i][1]
				$aTmpSetResArr[$aTmpSetResArr[0][0]][2] = $aGCSOR_Array[$i][2]
				$aTmpSetResArr[$aTmpSetResArr[0][0]][3] = $aGCSOR_Array[$i][3]
				$aTmpSetResArr[$aTmpSetResArr[0][0]][4] = $aGCSOR_Array[$i][4]
			EndIf
		Next
		
		GUICtrlSetCursor($nCtrlID, -1)
		$aGCSOR_Array = $aTmpSetResArr
		
		Return 1
	EndIf
	
	$aGCSOR_Array[0][0] += 1
	ReDim $aGCSOR_Array[$aGCSOR_Array[0][0]+1][5]
	$aGCSOR_Array[$aGCSOR_Array[0][0]][0] = $hWnd
	$aGCSOR_Array[$aGCSOR_Array[0][0]][1] = $nCtrlID
	$aGCSOR_Array[$aGCSOR_Array[0][0]][2] = $iWait
	$aGCSOR_Array[$aGCSOR_Array[0][0]][3] = $iCtrlMinSize
	$aGCSOR_Array[$aGCSOR_Array[0][0]][4] = $iResizeEdgeFlags
EndFunc

;Handler to call the set functions (for all controls that _GUICtrl_SetOnResize() is set)
Func __GUICtrl_SetResizing_Handler()
	If $aGCSOR_Array[0][0] = 0 Then
		Return
	EndIf
	
	For $i = 1 To $aGCSOR_Array[0][0]
		__GUICtrl_Resizing_Proc($aGCSOR_Array[$i][0], $aGCSOR_Array[$i][1], $aGCSOR_Array[$i][2], $aGCSOR_Array[$i][3], $aGCSOR_Array[$i][4])
	Next
EndFunc

;Main Resizing Control Function
Func __GUICtrl_Resizing_Proc($hWnd, $nCtrlID, $iWait=10, $iCtrlMinSize=$iGCSOR_DefCtrlMinSize, $iResizeEdgeFlags=-1)
	Local $aCurInfo = GUIGetCursorInfo($hWnd)
	If @error Then Return
	
	Local $aCtrlInfo = ControlGetPos($hWnd, "", $nCtrlID)
	If @error Then Return
	
	If $iResizeEdgeFlags = -1 Then _
		$iResizeEdgeFlags = BitOR($iGCSOR_LEFT_EDGE, $iGCSOR_TOP_EDGE, $iGCSOR_RIGHT_EDGE, $iGCSOR_BOTTOM_EDGE)
	
	Local $iCursorID
	Local $iCheckFlag = -1
	Local $nOld_Opt_GOEM = Opt("GUIOnEventMode", 0)
	
	If ($aCurInfo[0] > $aCtrlInfo[0] - $iGCSOR_CtrEdgeSize And $aCurInfo[0] < $aCtrlInfo[0] + $iGCSOR_CtrEdgeSize) And _
		($aCurInfo[1] >= $aCtrlInfo[1] And $aCurInfo[1] <= $aCtrlInfo[1]+$aCtrlInfo[3]) And _
		BitAND($iResizeEdgeFlags, $iGCSOR_LEFT_EDGE) = $iGCSOR_LEFT_EDGE Then 								;Left
		
		$iCheckFlag = 1
		$iCursorID = 13
	EndIf
	
	If ($aCurInfo[0] > ($aCtrlInfo[0]+$aCtrlInfo[2]) - $iGCSOR_CtrEdgeSize And _
		$aCurInfo[0] < ($aCtrlInfo[0]+$aCtrlInfo[2]) + $iGCSOR_CtrEdgeSize) And _
		($aCurInfo[1] >= $aCtrlInfo[1] And $aCurInfo[1] <= $aCtrlInfo[1]+$aCtrlInfo[3]) And _
		BitAND($iResizeEdgeFlags, $iGCSOR_RIGHT_EDGE) = $iGCSOR_RIGHT_EDGE Then 							;Right
		
		$iCheckFlag = 2
		$iCursorID = 13
	EndIf
	
	If ($aCurInfo[1] > $aCtrlInfo[1] - $iGCSOR_CtrEdgeSize And $aCurInfo[1] < $aCtrlInfo[1] + $iGCSOR_CtrEdgeSize) And _
		($aCurInfo[0] >= $aCtrlInfo[0] And $aCurInfo[0] <= $aCtrlInfo[0]+$aCtrlInfo[2]) And _
		BitAND($iResizeEdgeFlags, $iGCSOR_TOP_EDGE) = $iGCSOR_TOP_EDGE Then 								;Top
		
		If $iCheckFlag = 1 Then 		;Left+Top
			$iCheckFlag = 5
			$iCursorID = 12
		ElseIf $iCheckFlag = 2 Then 	;Right+Top
			$iCheckFlag = 7
			$iCursorID = 10
		Else 							;Just Top
			$iCheckFlag = 3
			$iCursorID = 11
		EndIf
	EndIf
	
	If ($aCurInfo[1] > ($aCtrlInfo[1]+$aCtrlInfo[3]) - $iGCSOR_CtrEdgeSize And _
		$aCurInfo[1] < ($aCtrlInfo[1]+$aCtrlInfo[3]) + $iGCSOR_CtrEdgeSize) And _
		($aCurInfo[0] >= $aCtrlInfo[0] And $aCurInfo[0] <= $aCtrlInfo[0]+$aCtrlInfo[2]) And _
		BitAND($iResizeEdgeFlags, $iGCSOR_BOTTOM_EDGE) = $iGCSOR_BOTTOM_EDGE Then 							;Bottom
		
		If $iCheckFlag = 1 Then 		;Left+Bottom
			$iCheckFlag = 6
			$iCursorID = 10
		ElseIf $iCheckFlag = 2 Then 	;Right+Bottom
			$iCheckFlag = 8
			$iCursorID = 12
		Else 							;Just Bottom
			$iCheckFlag = 4
			$iCursorID = 11
		EndIf
	EndIf
	
	If $iCheckFlag = -1 Then
		If ($aCurInfo[4] = 0 Or $aCurInfo[4] = $nCtrlID) And Not $iGCSOR_CurIsSet Then
			If $aCurInfo[4] = $nCtrlID Then $iGCSOR_CurIsSet = True
			GUISetCursor(-1, 0, $hWnd)
			GUICtrlSetCursor($nCtrlID, -1)
		EndIf
		
		Return
	Else
		$iGCSOR_CurIsSet = False
		GUICtrlSetCursor($nCtrlID, $iCursorID)
		GUISetCursor($iCursorID, 0, $hWnd)
	EndIf
	
	While $aCurInfo[2] = 1
		;This loop is to prevent control movement while the mouse is not moving
		While GUIGetMsg() <> -11 ;$GUI_EVENT_MOUSEMOVE
			Sleep(10)
		WEnd
		
		$aCurInfo = GUIGetCursorInfo($hWnd)
		If @error Then ExitLoop
		
		$aCtrlInfo = ControlGetPos($hWnd, "", $nCtrlID)
		If @error Then ExitLoop
		
		; $iCheckFlag Values:
		;1 = Left
		;2 = Right
		;3 = Top
		;4 = Bottom
		;5 = Left + Top
		;6 = Left + Bottom
		;7 = Right + Top
		;8 = Right + Bottom
		
		If $iCheckFlag = 1 Or $iCheckFlag = 5 Or $iCheckFlag = 6 Then
			If $aCtrlInfo[2] - ($aCurInfo[0]-$aCtrlInfo[0]) > $iCtrlMinSize Then 					;Move from Left
				$aCtrlInfo[2] = $aCtrlInfo[2]-($aCurInfo[0]-$aCtrlInfo[0])
				$aCtrlInfo[0] = $aCurInfo[0]
				ControlMove($hWnd, "", $nCtrlID, $aCtrlInfo[0], $aCtrlInfo[1], $aCtrlInfo[2])
			EndIf
		EndIf
		
		If $iCheckFlag = 2 Or $iCheckFlag = 7 Or $iCheckFlag = 8 Then
			If $aCurInfo[0] - $aCtrlInfo[0] > $iCtrlMinSize Then 									;Move from Right
				$aCtrlInfo[2] = $aCurInfo[0]-$aCtrlInfo[0]
				ControlMove($hWnd, "", $nCtrlID, $aCtrlInfo[0], $aCtrlInfo[1], $aCtrlInfo[2])
			EndIf
		EndIf
		
		If $iCheckFlag = 3 Or $iCheckFlag = 5 Or $iCheckFlag = 7 Then
			If $aCtrlInfo[3] - ($aCurInfo[1]-$aCtrlInfo[1]) > $iCtrlMinSize Then 					;Move from Top
				$aCtrlInfo[3] = $aCtrlInfo[3]-($aCurInfo[1]-$aCtrlInfo[1])
				$aCtrlInfo[1] = $aCurInfo[1]
				ControlMove($hWnd, "", $nCtrlID, $aCtrlInfo[0], $aCtrlInfo[1], $aCtrlInfo[2], $aCtrlInfo[3])
			EndIf
		EndIf
		
		If $iCheckFlag = 4 Or $iCheckFlag = 6 Or $iCheckFlag = 8 Then
			If $aCurInfo[1] - $aCtrlInfo[1] > $iCtrlMinSize Then 									;Move from Bottom
				$aCtrlInfo[3] = $aCurInfo[1]-$aCtrlInfo[1]
				ControlMove($hWnd, "", $nCtrlID, $aCtrlInfo[0], $aCtrlInfo[1], $aCtrlInfo[2], $aCtrlInfo[3])
			EndIf
		EndIf
		
		Sleep($iWait)
	WEnd
	
	Opt("GUIOnEventMode", $nOld_Opt_GOEM)
EndFunc

;Function to get last CtrlID (in case that user will pass -1 as $iCtrlID)
Func __GUIGetLastCtrlID()
	Local $aRet = DllCall("user32.dll", "int", "GetDlgCtrlID", "hwnd", GUICtrlGetHandle(-1))
	
	If @error Then
		Return SetError(1)
	EndIf
	
	Return $aRet[0]
EndFunc
