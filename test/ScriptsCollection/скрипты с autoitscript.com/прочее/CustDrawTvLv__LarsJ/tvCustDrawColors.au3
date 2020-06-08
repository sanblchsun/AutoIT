#include <GUIConstants.au3>
#include <WindowsConstants.au3>
#include <GuiTreeView.au3>
#include <WinAPI.au3>

Opt( "MustDeclareVars", 1 )

Global Const $iBorderWidth = 4

Global $iFiles = 5, $iColors = 140, $aColors[$iFiles*$iColors][2]

Global $hGui, $hTV, $hTopItem0, $hTopItem1, $hTopItem2, $hTopItem3, $hTopItem4

MainScript()

Func MainScript()

	; Create GUI
	$hGui = GUICreate( "Web Colors", 400, 300, 600, 300 )

	; Create TreeView control
	Local $aPos = WinGetClientSize( $hGui )
	Local $idTV = GUICtrlCreateTreeView( $iBorderWidth, $iBorderWidth, $aPos[0]-2*$iBorderWidth, $aPos[1]-2*$iBorderWidth, $GUI_SS_DEFAULT_TREEVIEW+$TVS_NOHSCROLL, $WS_EX_CLIENTEDGE )
	$hTV = ControlGetHandle( $hGui, "", $idTV )

	; Add root item
	Local $hRoot = _GUICtrlTreeView_Add( $hTV, 0, "Reading data ... Please wait" )

	; Show GUI
	GUISetState( @SW_SHOW, $hGui )

	; Add web colors from files
	$hTopItem0 = AddWebColorsFromFile( "Web Colors by Name", "CustDrawColorsName.txt", $hRoot )
	$hTopItem1 = AddWebColorsFromFile( "Web Colors by Hue", "CustDrawColorsHue.txt", $hTopItem0 )
	$hTopItem2 = AddWebColorsFromFile( "Web Colors by Lightness", "CustDrawColorsLightness.txt", $hTopItem1 )
	$hTopItem3 = AddWebColorsFromFile( "Web Colors by Saturation", "CustDrawColorsSaturation.txt", $hTopItem2 )
	$hTopItem4 = AddWebColorsFromFile( "Web Colors by Value", "CustDrawColorsValue.txt", $hTopItem3, 0 )

	_GUICtrlTreeView_SelectItem( $hTV, $hTopItem0 )
	_GUICtrlTreeView_Delete( $hTV, $hRoot )

	; Functions for Windows Messages
	GUIRegisterMsg( $WM_NOTIFY, "WM_NOTIFY" )

	; Message loop
	While 1

		Local $aMsg = GUIGetMsg(1)

		Switch $aMsg[1]

			; Events for the main GUI
			Case $hGui

				Switch $aMsg[0]

					Case $GUI_EVENT_CLOSE
						ExitLoop

				EndSwitch

		EndSwitch

	WEnd

	GUIDelete( $hGui )
	Exit

EndFunc


#cs###################################
#   Functions for Windows Messages   #
#ce###################################

Func WM_NOTIFY($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $wParam
	Local $tNMHDR, $hWndFrom, $iCode
	$tNMHDR = DllStructCreate($tagNMHDR, $lParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	$iCode = DllStructGetData($tNMHDR, "Code")

	Switch $hWndFrom

		Case $hTV

			Switch $iCode

				Case $NM_CUSTOMDRAW
					Local $tNMTVCUSTOMDRAW = DllStructCreate($tagNMTVCUSTOMDRAW, $lParam)
					Local $dwDrawStage = DllStructGetData($tNMTVCUSTOMDRAW, "DrawStage")

					Switch $dwDrawStage												; Holds a value that specifies the drawing stage

						Case $CDDS_PREPAINT
							; Before the paint cycle begins
							Return BitOr( $CDRF_NOTIFYITEMDRAW, _	; Notify the parent window of any item-related drawing operations
														$CDRF_NOTIFYPOSTPAINT )	; Notify the parent window after item-related drawing operations

						Case $CDDS_ITEMPREPAINT
							; Before painting an item
							Local $hItemSpec  = DllStructGetData($tNMTVCUSTOMDRAW, "ItemSpec")			; $hItemSpec = $hItem
							Local $iItemState = DllStructGetData($tNMTVCUSTOMDRAW, "ItemState")
							Local $iItemParam = DllStructGetData($tNMTVCUSTOMDRAW, "ItemParam")			; ItemParam = index in array
							Switch $hItemSpec
								Case $hTopItem0, $hTopItem1, $hTopItem2, $hTopItem3, $hTopItem4
								Case Else
									If Not BitAnd( $iItemState, $CDIS_FOCUS ) Then _
										DllStructSetData( $tNMTVCUSTOMDRAW, "ClrText", $aColors[$iItemParam][1] )			; Forecolor of item text
										;DllStructSetData( $tNMTVCUSTOMDRAW, "clrTextBk", $aColors[$iItemParam][1] )	; Backcolor of item text
							EndSwitch
							Return BitOr( $CDRF_NEWFONT, _				; $CDRF_NEWFONT must be returned after changing font or colors
														$CDRF_NOTIFYPOSTPAINT )	; Notify the parent window after item-related drawing operations

						Case $CDDS_ITEMPOSTPAINT
							; After painting an item
							Local $hItemSpec = DllStructGetData($tNMTVCUSTOMDRAW, "ItemSpec")				; $hItemSpec = $hItem
							Switch $hItemSpec
								Case $hTopItem0, $hTopItem1, $hTopItem2, $hTopItem3, $hTopItem4
								Case Else
									Local $iItemState = DllStructGetData($tNMTVCUSTOMDRAW, "ItemState")
									Local $iItemParam = DllStructGetData($tNMTVCUSTOMDRAW, "ItemParam")	; ItemParam = index in array
									Local $hDC        = DllStructGetData($tNMTVCUSTOMDRAW, "HDC")				; Handle to the item's device context
									Local $tRECT = DllStructCreate( $tagRECT )													; To define 2 rectangles at the right side of the item
									DllStructSetData( $tRECT, "Top", DllStructGetData($tNMTVCUSTOMDRAW, "Top") )				; Top of the item text rectangle
									DllStructSetData( $tRECT, "Bottom", DllStructGetData($tNMTVCUSTOMDRAW, "Bottom") )	; Bottom
									Local $left = 180, $txtWidth = 50
									If $iItemParam >= $iColors * 4 Then
										$left = 120
										$txtWidth = 120
									EndIf
									If BitAnd( $iItemState, $CDIS_FOCUS ) Then
										; The TreeView item with the focus
										Local $hBrush = _WinAPI_CreateSolidBrush( $aColors[$iItemParam][1] )	; Create a brush with the item color
										DllStructSetData( $tRECT, "Left", $left )
										DllStructSetData( $tRECT, "Right", $left+100 )												; Rectangle 1 at the right side of the item
										_WinAPI_FillRect( $hDC, $tRECT, $hBrush )															; Fill the rectangle with the color
										DllStructSetData( $tRECT, "Left", $left+110 )													; Rectangle 2 at the right side of the item
										DllStructSetData( $tRECT, "Right", $left+110+$txtWidth )							; Draw the color name with the font, text color,
										_WinAPI_DrawText( $hDC, $aColors[$iItemParam][0], $tRECT, $DT_LEFT )	; and background color of the device context.
										_WinAPI_DeleteObject( $hBrush )																				; Delete the brush
									Else
										; The TreeView item that previously had focus
										Local $hBrush = _WinAPI_CreateSolidBrush( 0xFFFFFF )									; Clear the entire rectangle (1 and 2) 
										DllStructSetData( $tRECT, "Left", $left )															; by filling it with a white color.
										DllStructSetData( $tRECT, "Right", $left+110+$txtWidth )
										_WinAPI_FillRect( $hDC, $tRECT, $hBrush )
										_WinAPI_DeleteObject( $hBrush )
									EndIf
									Return $CDRF_DODEFAULT	; The control draws itself without any additional NM_CUSTOMDRAW messages for this paint cycle
							EndSwitch

					EndSwitch

			EndSwitch

	EndSwitch

	Return $GUI_RUNDEFMSG
EndFunc


#cs######################
#   Utility functions   #
#ce######################

Func AddWebColorsFromFile( $sTxt, $sFileName, $hOldTop, $iNameField = 1 )

	Static $iFileNo = 0

	; Read file in one big bite for speed
	Local $file = FileOpen( $sFileName, 16 )
	Local $data = BinaryToString( FileRead( $file ) )
	FileClose( $file )

	; Fill array and TreeView
	Local $hNewTop = _GUICtrlTreeView_Add( $hTV, $hOldTop, $sTxt )
	Local $offset = $iColors * $iFileNo, $aFields, $item, $j, $iValueField = 0
	Local $aLines = StringSplit( $data, @CRLF, 3 ), $aFields
	If $iNameField = 0 Then $iValueField = 1
	_GUICtrlTreeView_BeginUpdate( $hTV )
	For $i = 0 To $iColors - 1
		$j = $i + $offset
		$aFields = StringSplit( $aLines[$i], " ", 2 )
		$aColors[$j][0] = $aFields[$iValueField]																		; RGB value
		$aColors[$j][1] = ColorConvert( $aFields[0] )																; BGR value
		$item = _GUICtrlTreeView_AddChild( $hTV, $hNewTop, $aFields[$iNameField] )	; Color name
		_GUICtrlTreeView_SetState( $hTV, $item, $TVIS_BOLD )
		_GUICtrlTreeView_SetItemParam( $hTV, $item, $j )														; Set ItemParam to index in array.
	Next																																					; Remark that native TreeView items
	_GUICtrlTreeView_EndUpdate( $hTV )																						; uses ItemParam to hold ControlId.
																																								; Don't set ItemParam for native items.
	$iFileNo += 1

	Return $hNewTop

EndFunc

;RGB to BGR or BGR to RGB
Func ColorConvert($iColor)
	Return BitOR(BitAND($iColor, 0x00FF00), BitShift(BitAND($iColor, 0x0000FF), -16), BitShift(BitAND($iColor, 0xFF0000), 16))
EndFunc
